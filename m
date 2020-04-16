From: Arne Schwabe <arne@...1227...>
Date: Thu, 16 Apr 2020 17:26:18 +0200
Message-Id: <20200416152619.5465-1-arne@...1227...>
In-Reply-To: <4f3b6d5e-5354-558d-2e58-c8f588fbd18f@...2181...>
References: <4f3b6d5e-5354-558d-2e58-c8f588fbd18f@...2181...>
Subject: [Openvpn-devel] [PATCH v2 2/3] Refactor counting number of element
 in a : delimited list into function
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/misc.c        | 19 +++++++++++++++++++
 src/openvpn/misc.h        | 14 ++++++++++++++
 src/openvpn/ssl_mbedtls.c | 15 ++-------------
 3 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 1c17948c..a768f88d 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -765,4 +765,23 @@ output_peer_info_env(struct env_set *es, const char *peer_info)
     }
 }
 
+int
+get_num_elements(const char *string, char delimiter)
+{
+    int string_len = strlen(string);
+
+    ASSERT(0 != string_len);
+
+    int element_count = 1;
+    /* Get number of ciphers */
+    for (int i = 0; i < string_len; i++)
+    {
+        if (string[i] == delimiter)
+        {
+            element_count++;
+        }
+    }
+
+    return element_count;
+}
 #endif /* P2MP_SERVER */
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 991b7df2..2605c6d2 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -175,4 +175,18 @@ void output_peer_info_env(struct env_set *es, const char *peer_info);
 
 #endif /* P2MP_SERVER */
 
+/**
+ * Returns the occurrences of 'delimiter' in a string +1
+ * This is typically used to find out the number elements in a
+ * cipher string or similar that is separated by : like
+ *
+ *   X25519:secp256r1:X448:secp512r1:secp384r1:brainpoolP384r1
+ *
+ * @param string        the string to work on
+ * @param delimiter     the delimiter to count, typically ':'
+ * @return              occrrences of delimiter + 1
+ */
+int
+get_num_elements(const char *string, char delimiter);
+
 #endif /* ifndef MISC_H */
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 4f194ad7..51669278 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -289,33 +289,22 @@ void
 tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 {
     char *tmp_ciphers, *tmp_ciphers_orig, *token;
-    int i, cipher_count;
-    int ciphers_len;
 
     if (NULL == ciphers)
     {
         return; /* Nothing to do */
-
     }
-    ciphers_len = strlen(ciphers);
 
     ASSERT(NULL != ctx);
-    ASSERT(0 != ciphers_len);
 
     /* Get number of ciphers */
-    for (i = 0, cipher_count = 1; i < ciphers_len; i++)
-    {
-        if (ciphers[i] == ':')
-        {
-            cipher_count++;
-        }
-    }
+    int cipher_count = get_num_elements(ciphers, ':');
 
     /* Allocate an array for them */
     ALLOC_ARRAY_CLEAR(ctx->allowed_ciphers, int, cipher_count+1)
 
     /* Parse allowed ciphers, getting IDs */
-    i = 0;
+    int i = 0;
     tmp_ciphers_orig = tmp_ciphers = string_alloc(ciphers, NULL);
 
     token = strtok(tmp_ciphers, ":");
-- 
2.26.0


