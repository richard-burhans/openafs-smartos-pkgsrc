$NetBSD$

--- src/vol/vutil.c.orig	2015-10-28 13:06:44.000000000 +0000
+++ src/vol/vutil.c
@@ -31,6 +31,7 @@
 #endif
 #include <dirent.h>
 #include <sys/stat.h>
+#include <fcntl.h>
 #include <afs/afs_assert.h>
 
 #include <rx/xdr.h>
