$NetBSD$

--- src/vol/ihandle.c.orig	2015-10-28 13:06:44.000000000 +0000
+++ src/vol/ihandle.c
@@ -25,6 +25,7 @@
 #include <sys/file.h>
 #include <unistd.h>
 #include <sys/stat.h>
+#include <fcntl.h>
 #if defined(AFS_SUN5_ENV) || defined(AFS_NBSD_ENV)
 #include <sys/fcntl.h>
 #include <sys/resource.h>
