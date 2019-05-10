From: Arne Schwabe <arne@...1227...>
Date: Fri, 10 May 2019 14:11:08 +0200
Message-Id: <20190510121114.30468-2-arne@...1227...>
In-Reply-To: <20190510121114.30468-1-arne@...1227...>
References: <20190510121114.30468-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3 1/7] Write key to stdout if filename is
 not given
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

This change is preperation for changing the way --genkey works.
---
 src/openvpn/crypto.c    | 13 +++++++++++--
 src/openvpn/tls_crypt.c | 13 +++++++++++--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index ff9dbfdc..eb56421b 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1465,8 +1465,13 @@ write_key_file(const int nkeys, const char *filename)
 
     buf_printf(&out, "%s\n", static_key_foot);
 
+    /* write key file to stdout if no filename given */
+    if (!filename || strcmp(filename, "")==0)
+    {
+        printf("%s\n", BPTR(&out));
+    }
     /* write key file, now formatted in out, to file */
-    if (!buffer_write_file(filename, &out))
+    else if (!buffer_write_file(filename, &out))
     {
         nbits = -1;
     }
@@ -1870,7 +1875,11 @@ write_pem_key_file(const char *filename, const char *pem_name)
         goto cleanup;
     }
 
-    if (!buffer_write_file(filename, &server_key_pem))
+    if (!filename || strcmp(filename, "")==0)
+    {
+        printf("%s\n", BPTR(&server_key_pem));
+    }
+    else if (!buffer_write_file(filename, &server_key_pem))
     {
         msg(M_ERR, "ERROR: could not write key file");
         goto cleanup;
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index d6a82252..e8889e93 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -697,7 +697,16 @@ tls_crypt_v2_write_client_key_file(const char *filename,
         goto cleanup;
     }
 
-    if (!buffer_write_file(filename, &client_key_pem))
+    const char *client_filename = filename;
+    const char *client_inline = NULL;
+
+    if (!filename || streq(filename, ""))
+    {
+        printf("%s\n", BPTR(&client_key_pem));
+        client_filename = INLINE_FILE_TAG;
+        client_inline = (const char *)BPTR(&client_key_pem);
+    }
+    else if (!buffer_write_file(filename, &client_key_pem))
     {
         msg(M_FATAL, "ERROR: could not write client key file");
         goto cleanup;
@@ -708,7 +717,7 @@ tls_crypt_v2_write_client_key_file(const char *filename,
     struct buffer test_wrapped_client_key;
     msg(D_GENKEY, "Testing client-side key loading...");
     tls_crypt_v2_init_client_key(&test_client_key, &test_wrapped_client_key,
-                                 filename, NULL);
+                                 client_filename, client_inline);
     free_key_ctx_bi(&test_client_key);
 
     /* Sanity check: unwrap and load client key (as "server") */
-- 
2.21.0


