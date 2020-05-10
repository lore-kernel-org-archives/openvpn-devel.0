From: Antonio Quartulli <a@...2181...>
Date: Sun, 10 May 2020 16:00:17 +0200
Message-Id: <20200510140017.16837-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] tls-crypt-v2: fix testing of inline key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <a@...2181...>

The inline logic was recently changed by commit
("convert *_inline attributes to bool"), however the code testing a
newly created tls-crypt-v2 client key was not adapted.

Adapt tls-crypt-v2 test routine by properly signaling when the passed
key is inlined or not.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/tls_crypt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 484d4d46..a3894d66 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -697,14 +697,14 @@ tls_crypt_v2_write_client_key_file(const char *filename,
         goto cleanup;
     }
 
-    const char *client_filename = filename;
-    const char *client_inline = NULL;
+    const char *client_file = filename;
+    bool client_inline = false;
 
     if (!filename || streq(filename, ""))
     {
         printf("%s\n", BPTR(&client_key_pem));
-        client_filename = INLINE_FILE_TAG;
-        client_inline = (const char *)BPTR(&client_key_pem);
+        client_file = (const char *)BPTR(&client_key_pem);
+        client_inline = true;
     }
     else if (!buffer_write_file(filename, &client_key_pem))
     {
@@ -717,7 +717,7 @@ tls_crypt_v2_write_client_key_file(const char *filename,
     struct buffer test_wrapped_client_key;
     msg(D_GENKEY, "Testing client-side key loading...");
     tls_crypt_v2_init_client_key(&test_client_key, &test_wrapped_client_key,
-                                 client_filename, client_inline);
+                                 client_file, client_inline);
     free_key_ctx_bi(&test_client_key);
 
     /* Sanity check: unwrap and load client key (as "server") */
-- 
2.26.2


