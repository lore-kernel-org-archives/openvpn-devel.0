Message-ID: <4B1F76B3.9010706@...1114...>
Date: Wed, 09 Dec 2009 11:06:43 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070909070706060802050901"
Subject: [Openvpn-devel] [PATCH] Hardened down-root.so plug-in with more
	context pointer checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070909070706060802050901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Make sure that the context is pointing somewhere before continuing.

Signed-off-by: David Sommerseth <dazo@...384...>
- ---
 plugin/down-root/down-root.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/plugin/down-root/down-root.c b/plugin/down-root/down-root.c
index 77497ad..000ac40 100644
- --- a/plugin/down-root/down-root.c
+++ b/plugin/down-root/down-root.c
@@ -274,6 +274,8 @@ openvpn_plugin_open_v1 (unsigned int *type_mask,
const char *argv[], const char
    * Allocate our context
    */
   context = (struct down_root_context *) calloc (1, sizeof (struct
down_root_context));
+  if (!context)
+    goto exit;
   context->foreground_fd = -1;

   /*
@@ -317,6 +319,9 @@ openvpn_plugin_func_v1 (openvpn_plugin_handle_t
handle, const int type, const ch
 {
   struct down_root_context *context = (struct down_root_context *) handle;

+  if (!context)
+    return OPENVPN_PLUGIN_FUNC_ERROR;
+
   if (type == OPENVPN_PLUGIN_UP && context->foreground_fd == -1) /*
fork off a process to hold onto root */
     {
       pid_t pid;
@@ -409,6 +414,9 @@ openvpn_plugin_close_v1 (openvpn_plugin_handle_t handle)
 {
   struct down_root_context *context = (struct down_root_context *) handle;

+  if (!context)
+    return;
+
   if (DEBUG (context->verb))
     fprintf (stderr, "DOWN-ROOT: close\n");

- -- 
1.6.2.5

(patch attached for convenience)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAksfdq4ACgkQDC186MBRfro7jgCgm3WM29OaAjIN1rnLbiFfEUm6
2pYAn3FVWu9++5Cl2lsT9FFJzvmop1T4
=Ywbn
-----END PGP SIGNATURE-----

--------------070909070706060802050901
Content-Type: text/plain;
	name="0002-Hardened-down-root.so-plug-in-with-more-context-poin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0002-Hardened-down-root.so-plug-in-with-more-context-poin.pa";
	filename*1="tch"

From c67bb0fb0afb3045b2b07873583086d6dfbad8e9 Mon Sep 17 00:00:00 2001
From: David Sommerseth <dazo@...384...>
Date: Wed, 9 Dec 2009 10:44:31 +0100
Subject: [PATCH] Hardened down-root.so plug-in with more context pointer checks

Make sure that the context is pointing somewhere before continuing.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 plugin/down-root/down-root.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/plugin/down-root/down-root.c b/plugin/down-root/down-root.c
index 77497ad..000ac40 100644
--- a/plugin/down-root/down-root.c
+++ b/plugin/down-root/down-root.c
@@ -274,6 +274,8 @@ openvpn_plugin_open_v1 (unsigned int *type_mask, const char *argv[], const char
    * Allocate our context
    */
   context = (struct down_root_context *) calloc (1, sizeof (struct down_root_context));
+  if (!context)
+    goto exit;
   context->foreground_fd = -1;
 
   /*
@@ -317,6 +319,9 @@ openvpn_plugin_func_v1 (openvpn_plugin_handle_t handle, const int type, const ch
 {
   struct down_root_context *context = (struct down_root_context *) handle;
 
+  if (!context)
+    return OPENVPN_PLUGIN_FUNC_ERROR;
+
   if (type == OPENVPN_PLUGIN_UP && context->foreground_fd == -1) /* fork off a process to hold onto root */
     {
       pid_t pid;
@@ -409,6 +414,9 @@ openvpn_plugin_close_v1 (openvpn_plugin_handle_t handle)
 {
   struct down_root_context *context = (struct down_root_context *) handle;
 
+  if (!context)
+    return;
+
   if (DEBUG (context->verb))
     fprintf (stderr, "DOWN-ROOT: close\n");
 
-- 
1.6.2.5


--------------070909070706060802050901
Content-Type: application/pgp-signature;
	name="0002-Hardened-down-root.so-plug-in-with-more-context-poin.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename*0="0002-Hardened-down-root.so-plug-in-with-more-context-poin.pa";
	filename*1="tch.sig"

iEYEABECAAYFAksfdrEACgkQDC186MBRfrqlxwCcDWenULvKv9TLSyX89sQO+DiZlbIAniD8
zfhEhE4uR2iuqM3+K5Ln/25B
--------------070909070706060802050901--

