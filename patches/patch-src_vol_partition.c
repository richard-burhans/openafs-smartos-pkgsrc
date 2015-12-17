$NetBSD$

--- src/vol/partition.c.orig	2015-10-28 13:06:44.000000000 +0000
+++ src/vol/partition.c
@@ -65,6 +65,7 @@
 #endif /* AFS_OSF_ENV */
 #include <errno.h>
 #include <sys/stat.h>
+#include <fcntl.h>
 #include <stdio.h>
 #include <sys/file.h>
 #ifdef	AFS_AIX_ENV
