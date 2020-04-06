From: Arne Schwabe <arne@...1227...>
Date: Mon,  6 Apr 2020 15:00:01 +0200
Message-Id: <20200406130001.6860-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Do not write extra 0 byte for --gen-key
 with auth-token/tls-crypt-v2
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

crypto_pem_encode put a nul-terminated terminated string into the
buffer. This is useful for printf but should not be written into
the file.

Also for static keys, we were missing the nul termination when priting
it to stadout but since the buffer was cleared before, there was always
a NULL byte in the right place. Make it explicit instead.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto.c    | 11 +++++++++--
 src/openvpn/tls_crypt.c | 10 ++++++++--
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 453cb20a..7af48df0 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1477,6 +1477,7 @@ write_key_file(const int nkeys, const char *filename)
     /* write key file to stdout if no filename given */
     if (!filename || strcmp(filename, "")==0)
     {
+        buf_null_terminate(&out);
         printf("%s\n", BPTR(&out));
     }
     /* write key file, now formatted in out, to file */
@@ -1888,9 +1889,15 @@ write_pem_key_file(const char *filename, const char *pem_name)
     {
         printf("%s\n", BPTR(&server_key_pem));
     }
-    else if (!buffer_write_file(filename, &server_key_pem))
+    else
     {
-        msg(M_ERR, "ERROR: could not write key file");
+        /* crypto_pem_encode null terminates the buffer, do
+         * not write this to the file */
+        buf_inc_len(&server_key_pem, -1);
+        if (!buffer_write_file(filename, &server_key_pem))
+        {
+            msg(M_ERR, "ERROR: could not write key file");
+        }
         goto cleanup;
     }
 
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index e9f9cc2a..85f2862b 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -706,9 +706,15 @@ tls_crypt_v2_write_client_key_file(const char *filename,
         client_filename = INLINE_FILE_TAG;
         client_inline = (const char *)BPTR(&client_key_pem);
     }
-    else if (!buffer_write_file(filename, &client_key_pem))
+    else
     {
-        msg(M_FATAL, "ERROR: could not write client key file");
+        /* crypto_pem_encode null terminates the buffer, do
+         * not write this to the file */
+        buf_inc_len(&client_key_pem, -1);
+        if (!buffer_write_file(filename, &client_key_pem))
+        {
+            msg(M_FATAL, "ERROR: could not write client key file");
+        }
         goto cleanup;
     }
 
-- 
2.26.0


