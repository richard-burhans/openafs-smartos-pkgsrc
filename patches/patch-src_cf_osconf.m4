$NetBSD$

--- src/cf/osconf.m4.orig	2015-10-28 13:06:44.000000000 +0000
+++ src/cf/osconf.m4
@@ -710,22 +710,30 @@ case $AFS_SYSNAME in
 		;;
 
 	sunx86_511)
-		CC=$SOLARISCC
-		CCOBJ=$SOLARISCC
-		LD="/usr/ccs/bin/ld"
-		MT_CC=$SOLARISCC
-		MT_CFLAGS='-mt -DAFS_PTHREAD_ENV ${XCFLAGS}'
-		MT_LIBS="-lpthread -lsocket"
-		PAM_CFLAGS="-KPIC"
-		PAM_LIBS="-lc -lpam -lsocket -lnsl -lm"
-		SHLIB_CFLAGS="-KPIC"
-		SHLIB_LDFLAGS="-G -Bsymbolic"
-		XCFLAGS64='${XCFLAGS} -xarch=amd64'
-		XCFLAGS="-dy -Bdynamic"
-		XLIBELFA="-lelf"
-		XLIBKVM="-lkvm"
-		XLIBS="${LIB_AFSDB} -lsocket -lnsl -lintl -ldl"
-		SHLIB_LINKER="${CC} -G -dy -Bsymbolic -z text"
+		if test "x$SOLARISCC" = "x" ; then
+		  MT_CFLAGS='-pthread -DAFS_PTHREAD_ENV ${XCFLAGS}'
+		  SHLIB_CFLAGS="-fPIC"
+		  XCFLAGS="-D_LARGEFILE64_SOURCE"
+		  XLIBS="${LIB_AFSDB} -lsocket -lnsl"
+		  SHLIB_LINKER="${CC} -shared ${XCFLAGS}"
+		else
+		  CC=$SOLARISCC
+		  CCOBJ=$SOLARISCC
+		  LD="/usr/ccs/bin/ld"
+		  MT_CC=$SOLARISCC
+		  MT_CFLAGS='-mt -DAFS_PTHREAD_ENV ${XCFLAGS}'
+		  MT_LIBS="-lpthread -lsocket"
+		  PAM_CFLAGS="-KPIC"
+		  PAM_LIBS="-lc -lpam -lsocket -lnsl -lm"
+		  SHLIB_CFLAGS="-KPIC"
+		  SHLIB_LDFLAGS="-G -Bsymbolic"
+		  XCFLAGS64='${XCFLAGS} -xarch=amd64'
+		  XCFLAGS="-dy -Bdynamic"
+		  XLIBELFA="-lelf"
+		  XLIBKVM="-lkvm"
+		  XLIBS="${LIB_AFSDB} -lsocket -lnsl -lintl -ldl"
+		  SHLIB_LINKER="${CC} -G -dy -Bsymbolic -z text"
+		fi
 		;;
 esac
 
