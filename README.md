openafs-smartos-pkgsrc
```sh
cat <<EOF >> /opt/local/etc/pkg_install.conf
GPG=/usr/bin/gpg
GPG_SIGN_AS=C6C8BBD9A48E87A002711326139560F970B189EB
EOF

# check end of /opt/local/etc/mk.conf
# should be .sinclude "/opt/local/etc/mk.conf.local"
# or        .sinclude </opt/local/etc/mk.conf.local>

grep 'http://pkgsrc.joyent.com/packages/SmartOS/' /opt/local/etc/pkgin/repositories.conf \
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

gpg --import admin.signing.gpg-key
shred --remove admin.signing.gpg-key

pkgin -f update
pkgin -y install gcc47 git-base pkgdiff
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
```
