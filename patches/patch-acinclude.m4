$NetBSD$

--- acinclude.m4.orig	2015-10-28 13:06:44.000000000 +0000
+++ acinclude.m4
@@ -389,7 +389,15 @@ case $system in
 	        AC_PATH_PROG(SOLARISCC, [cc], ,
 		    [/opt/SUNWspro/bin:/opt/SunStudioExpress/bin:/opt/solarisstudio12.3/bin:/opt/solstudio12.2/bin:/opt/sunstudio12.1/bin])
 		if test "x$SOLARISCC" = "x" ; then
-		    AC_MSG_FAILURE(Could not find the solaris cc program.  Please define the environment variable SOLARISCC to specify the path.)
+		    dnl On illumos-based systems, allow building with gcc by default if sunwspro is not around.
+		    case "`uname -v`" in
+		    	joyent_*|oi_*)
+			    AC_MSG_NOTICE(No Solaris Studio compiler found.  Using $CC instead.)
+			    ;;
+		    	*)
+			    AC_MSG_FAILURE(Could not find the solaris cc program.  Please define the environment variable SOLARISCC to specify the path.)
+			    ;;
+		    esac
 		fi
 		SOLARIS_UFSVFS_HAS_DQRWLOCK
 		SOLARIS_FS_HAS_FS_ROLLED
