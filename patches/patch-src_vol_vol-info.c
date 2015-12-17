$NetBSD$

--- src/vol/vol-info.c.orig	2015-10-28 13:06:44.000000000 +0000
+++ src/vol/vol-info.c
@@ -21,6 +21,7 @@
 #include <ctype.h>
 #include <errno.h>
 #include <sys/stat.h>
+#include <fcntl.h>
 #include <stdio.h>
 #include <string.h>
 #ifdef AFS_NT40_ENV
