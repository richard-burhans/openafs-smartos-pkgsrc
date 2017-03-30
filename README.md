openafs-smartos-pkgsrc
```sh
cat <<EOF >> /opt/local/etc/pkg_install.conf
GPG=/usr/bin/gpg
GPG_SIGN_AS=43B99F40
EOF

# check end of /opt/local/etc/mk.conf
# should be .sinclude "/opt/local/etc/mk.conf.local"
# or        .sinclude </opt/local/etc/mk.conf.local>

grep 'https://pkgsrc.joyent.com/packages/SmartOS/' /opt/local/etc/pkgin/repositories.conf \
    | sed -e 's/All$//' \
    | awk '{print "BINPKG_SITES=              ", $1}' \
    >> /opt/local/etc/mk.conf.local

cat <<EOF >> /opt/local/etc/mk.conf.local
ALLOW_VULNERABLE_PACKAGES=  yes
DEPENDS_TARGET=             bin-install
DISTDIR=                    /content/distfiles
FETCH_USING=                curl
MAKE_JOBS=                  1
PACKAGES=                   /content/packages
PKG_DEVELOPER=              yes
SIGN_PACKAGES=              gpg
SKIP_LICENSE_CHECK=         yes
WRKOBJDIR=                  /var/tmp/pkgsrc-build
EOF

pkgin -f update
pkgin -y install gcc49 git-base pkgdiff gnupg2

gpg2 --no-default-keyring --keyring /opt/local/etc/gnupg/pkgsrc.gpg --keyserver pgp.mit.edu --recv-keys D279E65CFC8EDB80B88E4BB136A3F687E36BC00B

gpg --import admin.signing.gpg-key
shred --remove admin.signing.gpg-key

mkdir -p /content/{distfiles,packages}
cd /content
git clone git://github.com/joyent/pkgsrc.git
cd pkgsrc
git checkout joyent/release/trunk
git submodule init
git submodule update
cd filesystems
git clone git://github.com/richard-burhans/openafs-smartos-pkgsrc.git openafs-smartos
cd openafs-smartos
bmake makedistinfo
bmake package

pkg_info -X /content/packages/All/openafs-1.6.18.3.tgz | gzip -9 > pkg_summary.gz

