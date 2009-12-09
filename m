Message-ID: <4B1F6CEA.2000708@...1114...>
Date: Wed, 09 Dec 2009 10:24:58 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020509070002030303030202"
Subject: [Openvpn-devel] [PATCH] openvpn-down-root.so causes a segfault on
	premature exits
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
--------------020509070002030303030202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


If openvpn is interrupted before openvpn_plugin_open_v1() is called,
there is no context allocated which openvpn_plugin_abort_v1() can use.

Signed-off-by: David Sommerseth <dazo@...384...>

- ---
 plugin/down-root/down-root.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugin/down-root/down-root.c b/plugin/down-root/down-root.c
index 5e0c002..77497ad 100644
- --- a/plugin/down-root/down-root.c
+++ b/plugin/down-root/down-root.c
@@ -434,7 +434,7 @@ openvpn_plugin_abort_v1 (openvpn_plugin_handle_t handle)
 {
   struct down_root_context *context = (struct down_root_context *) handle;

- -  if (context->foreground_fd >= 0)
+  if (context && context->foreground_fd >= 0)
     {
       /* tell background process to exit */
       send_control (context->foreground_fd, COMMAND_EXIT);
- -- 
1.6.2.5

(patch attached in addition for convenience)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAksfbOUACgkQDC186MBRfrqSgwCeOZPg+70ryTCCyoW8D9QtLmeF
pwwAn2pWo9529hvBzlMgj8izabtG9Ioc
=o0Ym
-----END PGP SIGNATURE-----

--------------020509070002030303030202
Content-Type: text/plain;
	name="0001-openvpn-down-root.so-causes-a-segfault-on-premature.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-openvpn-down-root.so-causes-a-segfault-on-premature.pat";
	filename*1="ch"

From e7e12e33025e7b83a8a97121433b46045144ded9 Mon Sep 17 00:00:00 2001
From: David Sommerseth <dazo@...384...>
Date: Wed, 9 Dec 2009 10:18:55 +0100
Subject: [PATCH] openvpn-down-root.so causes a segfault on premature exits

If openvpn is interrupted before openvpn_plugin_open_v1() is called,
there is no context allocated which openvpn_plugin_abort_v1() can use.

Signed-off-by: David Sommerseth <dazo@...384...>

---
 plugin/down-root/down-root.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugin/down-root/down-root.c b/plugin/down-root/down-root.c
index 5e0c002..77497ad 100644
--- a/plugin/down-root/down-root.c
+++ b/plugin/down-root/down-root.c
@@ -434,7 +434,7 @@ openvpn_plugin_abort_v1 (openvpn_plugin_handle_t handle)
 {
   struct down_root_context *context = (struct down_root_context *) handle;
 
-  if (context->foreground_fd >= 0)
+  if (context && context->foreground_fd >= 0)
     {
       /* tell background process to exit */
       send_control (context->foreground_fd, COMMAND_EXIT);
-- 
1.6.2.5


--------------020509070002030303030202
Content-Type: application/pgp-signature;
	name="0001-openvpn-down-root.so-causes-a-segfault-on-premature.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename*0="0001-openvpn-down-root.so-causes-a-segfault-on-premature.pat";
	filename*1="ch.sig"

iEYEABECAAYFAksfbOgACgkQDC186MBRfro59wCfVbK9JyDobtMQ1WNL0TldlwNBFAgAniIC
2fJxrerRMNU4Ewk7dSk21iKz
--------------020509070002030303030202--

