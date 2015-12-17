openafs-smartos-pkgsrc
```sh
pkgin -f update
pkgin -y install gcc47 git-base pkgdiff
mkdir -p /content/{distfiles,packages}
cd /content
git clone git://github.com/joyent/pkgsrc.git
cd pkgsrc
git checkout joyent/release/trunk
git submodule init
git submodule update

cat <<EOF >> /opt/local/etc/mk.conf

ALLOW_VULNERABLE_PACKAGES=  yes
EOF

grep 'http://pkgsrc.joyent.com/packages/SmartOS/' /opt/local/etc/pkgin/repositories.conf \
    | sed -e 's/All$//' \
    | awk '{print "BINPKG_SITES=              ", $1}' \
    >> /opt/local/etc/mk.conf

cat <<EOF >> /opt/local/etc/mk.conf
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

cd filesystems
git clone git://github.com/richard-burhans/openafs-smartos-pkgsrc.git openafs-smartos
```
