# $NetBSD$

DISTNAME=               openafs-1.6.18-src
PKGNAME=                ${DISTNAME:C/-src//}
DISTFILES=              ${DEFAULT_DISTFILES} openafs-1.6.18-doc.tar.bz2

CATEGORIES=             filesystems net sysutils
MASTER_SITES=           http://openafs.org/dl/openafs/1.6.18/
EXTRACT_SUFX=           .tar.bz2

MAINTAINER=             burhans@bx.psu.edu
HOMEPAGE=               http://www.openafs.org/
COMMENT=                File system for sharing, scalability and transparent data migration
LICENSE=                ibm-public-license-1.0

WRKSRC=                 ${WRKDIR}/openafs-1.6.18
MAKE_JOBS_SAFE=         no

AUTOCONF_REQD=          2.60

GNU_CONFIGURE=          yes
USE_TOOLS+=             autoconf
USE_TOOLS+=             automake
USE_TOOLS+=             autoheader
USE_TOOLS+=             lex
USE_TOOLS+=             yacc
USE_TOOLS+=             perl

CONFIGURE_ARGS+=        KRB5_CONFIG=/usr/bin/krb5-config
CONFIGURE_ARGS+=        --sysconfdir=${PKG_SYSCONFDIR:Q}
CONFIGURE_ARGS+=        --localstatedir=${VARBASE}
CONFIGURE_ARGS+=        --disable-pam
CONFIGURE_ARGS+=        --enable-namei-fileserver
CONFIGURE_ARGS+=        --enable-supergroups
CONFIGURE_ARGS+=        --disable-kernel-module
#CONFIGURE_ARGS+=        --enable-debug
#CONFIGURE_ARGS+=        --enable-warnings
#CONFIGURE_ARGS+=        --enable-checking
CONFIGURE_ARGS+=        --enable-debug-lwp
CONFIGURE_ARGS+=        --disable-fuse-client
CONFIGURE_ARGS+=        --with-afs-sysname=sunx86_511

OWN_DIRS_PERMS+=        ${PKG_SYSCONFDIR}/openafs ${ROOT_USER} ${ROOT_GROUP} 0755
OWN_DIRS_PERMS+=        ${PKG_SYSCONFDIR}/openafs/server ${ROOT_USER} ${ROOT_GROUP} 0755
OWN_DIRS_PERMS+=        ${PKG_SYSCONFDIR}/libexec/openafs ${ROOT_USER} ${ROOT_GROUP} 0755
OWN_DIRS_PERMS+=        ${VARBASE}/openafs ${ROOT_USER} ${ROOT_GROUP} 0700
OWN_DIRS_PERMS+=        ${VARBASE}/openafs/backup ${ROOT_USER} ${ROOT_GROUP} 0700
OWN_DIRS_PERMS+=        ${VARBASE}/openafs/db ${ROOT_USER} ${ROOT_GROUP} 0700
OWN_DIRS_PERMS+=        ${VARBASE}/openafs/logs ${ROOT_USER} ${ROOT_GROUP} 0755

BUILD_DEFS+=            VARBASE

USE_LANGUAGES=          c c++

SMF_SRCDIR=             ${FILESDIR}
SMF_MANIFEST=           manifest.xml
SMF_MANIFEST_SRC=       ${SMF_SRCDIR}/${SMF_MANIFEST}
SMF_METHODS=            bosserver
SMF_METHOD_SRC=         ${FILESDIR}/method
SMF_METHOD_FILE=        ${SMF_METHOD_FILE.${SMF_METHODS}}
FILES_SUBST+=           SMF_METHOD_FILE=${SMF_METHOD_FILE}

OPENAFS_SBIN_FILES=     bozo/bos_util bozo/bosserver butc/read_tape        \
                        dviced/state_analyzer ptserver/pt_util             \
                        tsalvaged/dafssync-debug tsalvaged/salvsync-debug  \
                        vlserver/vldb_check vol/fssync-debug vol/volinfo   \
                        vol/volscan volser/voldump

OPENAFS_LIBEXEC_FILES=  dviced/dafileserver dvolser/davolserver            \
                        ptserver/ptserver tsalvaged/dasalvager             \
                        tsalvaged/salvageserver tviced/fileserver          \
                        tvolser/volserver update/upclient update/upserver  \
                        vlserver/vlserver vol/salvager

OPENAFS_MAN5_FILES=     BackupLog BosConfig BosLog FORCESALVAGE            \
                        FileLog KeyFile NoAuth SALVAGE.fs SalvageLog       \
                        UserList VLLog VolserLog afs_volume_header         \
                        bdb.DB0 krb.conf krb.excl prdb.DB0 salvage.lock    \
                        sysid vldb.DB0

OPENAFS_MAN8_FILES=     bos bos_addhost bos_addkey bos_adduser bos_apropos \
                        bos_create bos_delete bos_exec bos_getdate         \
                        bos_getlog bos_getrestart bos_getrestricted        \
                        bos_help bos_install bos_listhosts bos_listkeys    \
                        bos_listusers bos_prune bos_removehost             \
                        bos_removekey bos_removeuser bos_restart           \
                        bos_salvage bos_setauth bos_setcellname            \
                        bos_setrestart bos_setrestricted bos_shutdown      \
                        bos_start bos_startup bos_status bos_stop          \
                        bos_uninstall bos_util bosserver buserver          \
                        dafileserver dasalvager davolserver                \
                        fileserver fssync-debug fssync-debug_attach        \
                        fssync-debug_callback fssync-debug_detach          \
                        fssync-debug_error fssync-debug_header             \
                        fssync-debug_leaveoff fssync-debug_list            \
                        fssync-debug_mode fssync-debug_move                \
                        fssync-debug_offline fssync-debug_online           \
                        fssync-debug_query fssync-debug_stats              \
                        fssync-debug_vgcadd fssync-debug_vgcdel            \
                        fssync-debug_vgcquery fssync-debug_vgcscan         \
                        fssync-debug_vgcscanall fssync-debug_vnode         \
                        fssync-debug_volop prdb_check pt_util ptserver     \
                        read_tape salvager salvageserver state_analyzer    \
                        upclient upserver vldb_check vlserver voldump      \
                        volinfo volscan volserver

OPENAFS_DIRS=           bin libexec/openafs man/man5 man/man8 sbin

pre-configure:
	set -e; cd ${WRKSRC}; ./regen.sh

do-install:
.for directory in ${OPENAFS_DIRS}
	${INSTALL} -d ${DESTDIR}${PREFIX}/${directory}
.endfor
	${INSTALL_PROGRAM} ${WRKSRC}/src/bozo/bos \
		${DESTDIR}${PREFIX}/bin/bos 
	${INSTALL_PROGRAM} ${WRKSRC}/src/ptserver/db_verify \
		${DESTDIR}${PREFIX}/sbin/prdb_check
.for file in ${OPENAFS_SBIN_FILES}
	${INSTALL_PROGRAM} ${WRKSRC}/src/${file} ${DESTDIR}${PREFIX}/sbin
.endfor
	${INSTALL_PROGRAM} ${WRKSRC}/src/budb/budb_server \
		${DESTDIR}${PREFIX}/libexec/openafs/buserver
.for file in ${OPENAFS_LIBEXEC_FILES}
	${INSTALL_PROGRAM} ${WRKSRC}/src/${file} \
		${DESTDIR}${PREFIX}/libexec/openafs
.endfor
	chmod +x ${WRKSRC}/doc/man-pages/install-man
.for file in ${OPENAFS_MAN5_FILES}
	${WRKSRC}/doc/man-pages/install-man \
		${WRKSRC}/doc/man-pages/man5/${file}.5 \
		${DESTDIR}${PREFIX}/man/man5/${file}.5
.endfor
.for file in ${OPENAFS_MAN8_FILES}
	${WRKSRC}/doc/man-pages/install-man \
		${WRKSRC}/doc/man-pages/man8/${file}.8 \
		${DESTDIR}${PREFIX}/man/man8/${file}.8
.endfor
	test -h ${DESTDIR}${PREFIX}/man/man8/dafssync-debug.8 \
		|| ln -s fssync-debug.8 \
			${DESTDIR}${PREFIX}/man/man8/dafssync-debug.8

.include "../../mk/bsd.pkg.mk"
