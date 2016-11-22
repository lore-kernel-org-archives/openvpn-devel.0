From: Steffan Karger <steffan@...1856...>
Date: Tue, 22 Nov 2016 21:09:26 +0100
Message-Id: <1479845366-15774-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] generate_key_expansion: make assumption
	explicit, use C99 features
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This function potentially allocates memory, and can therefor not be run
again on an initialized key_ctx_bi.  Make this explicit by adding an error
if someone tries do to this anyway.

While touching the function, cleanup it up a bit to make up for the added
lines of code.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 3c137d8..fe6493e 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1622,13 +1622,15 @@ generate_key_expansion (struct key_ctx_bi *key,
 			const struct session_id *server_sid,
 			bool server)
 {
-  uint8_t master[48];
-  struct key2 key2;
+  uint8_t master[48] = { 0 };
+  struct key2 key2 = { 0 };
   bool ret = false;
-  int i;
 
-  CLEAR (master);
-  CLEAR (key2);
+  if (key->initialized)
+    {
+      msg (D_TLS_ERRORS, "TLS Error: key already initialized");
+      goto exit;
+    }
 
   /* debugging print of source key material */
   key_source2_print (key_src);
@@ -1664,7 +1666,7 @@ generate_key_expansion (struct key_ctx_bi *key,
   key2_print (&key2, key_type, "Master Encrypt", "Master Decrypt");
 
   /* check for weak keys */
-  for (i = 0; i < 2; ++i)
+  for (int i = 0; i < 2; ++i)
     {
       fixup_key (&key2.keys[i], key_type);
       if (!check_key (&key2.keys[i], key_type))
-- 
2.7.4


