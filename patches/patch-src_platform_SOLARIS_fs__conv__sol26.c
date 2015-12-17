$NetBSD$

--- src/platform/SOLARIS/fs_conv_sol26.c.orig	2015-10-28 13:06:44.000000000 +0000
+++ src/platform/SOLARIS/fs_conv_sol26.c
@@ -55,20 +55,6 @@ char *rawname(), *unrawname(), *vol_DevN
 int force = 0, verbose = 0, unconv = 0;
 
 static int
-ConvCmd(struct cmd_syndesc *as, void *arock)
-{
-    unconv = 0;
-    handleit(as);
-}
-
-static int
-UnConvCmd(struct cmd_syndesc *as, void *arock)
-{
-    unconv = 1;
-    handleit(as);
-}
-
-static int
 handleit(struct cmd_syndesc *as)
 {
     struct cmd_item *ti;
@@ -180,6 +166,19 @@ handleit(struct cmd_syndesc *as)
     }
 }
 
+static int
+ConvCmd(struct cmd_syndesc *as, void *arock)
+{
+    unconv = 0;
+    handleit(as);
+}
+
+static int
+UnConvCmd(struct cmd_syndesc *as, void *arock)
+{
+    unconv = 1;
+    handleit(as);
+}
 
 #include "AFS_component_version_number.c"
 
