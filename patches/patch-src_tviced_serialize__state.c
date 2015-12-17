$NetBSD$

--- src/tviced/serialize_state.c.orig	2015-10-28 13:06:44.000000000 +0000
+++ src/tviced/serialize_state.c
@@ -29,6 +29,7 @@
 #endif
 #include <afs/afs_assert.h>
 #include <sys/stat.h>
+#include <fcntl.h>
 
 #include <afs/stds.h>
 
