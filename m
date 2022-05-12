From: Arne Schwabe <arne@...1227...>
Date: Thu, 12 May 2022 14:14:28 +0200
Message-Id: <20220512121429.2096164-7-arne@...1227...>
In-Reply-To: <20220512121429.2096164-1-arne@...1227...>
References: <20220512121429.2096164-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 6/7] Fix allowing/showing unsupported
 ciphers and digests
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

This is a minimal version to hide the non-supported ciphers in these
show-cipher/show-digests listings. It also adds code to the kt_md_get/
kt_cipher_get functions to error out early instead of getting an ugly
backtrace with OpenSSL errors later when actually trying to use the ciphers.

This allows make check to work again on with OpenSSL 3.0.

The changes are kept minimal to  avoid pulling in all the other refactoring
for OpenSSL 3.0.

This commit is partly cherry-picked from ab3f32b9.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto_openssl.c | 50 +++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index beeaee4b7..ad6c9353a 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -339,7 +339,11 @@ show_available_ciphers(void)
                        || cipher_kt_mode_aead(cipher)
                        ))
         {
-            cipher_list[num_ciphers++] = cipher;
+            /* Check explicit availibility (for OpenSSL 3.0) */
+            if (cipher_kt_get(cipher_kt_name(cipher)))
+            {
+                cipher_list[num_ciphers++] = cipher;
+            }
         }
         if (num_ciphers == (sizeof(cipher_list)/sizeof(*cipher_list)))
         {
@@ -371,6 +375,13 @@ show_available_ciphers(void)
     printf("\n");
 }
 
+void
+print_digest(EVP_MD *digest, void *unused)
+{
+    printf("%s %d bit digest size\n", EVP_MD_name(digest),
+           EVP_MD_size(digest) * 8);
+}
+
 void
 show_available_digests(void)
 {
@@ -384,16 +395,22 @@ show_available_digests(void)
            "the --auth option.\n\n");
 #endif
 
+#if OPENSSL_VERSION_NUMBER >= 0x30000000L
+    EVP_MD_do_all_provided(NULL, print_digest, NULL);
+#else
     for (nid = 0; nid < 10000; ++nid)
     {
+
         const EVP_MD *digest = EVP_get_digestbynid(nid);
         if (digest)
         {
-            printf("%s %d bit digest size\n",
-                   OBJ_nid2sn(nid), EVP_MD_size(digest) * 8);
+            /* We cast the const away so we can keep the function prototype
+             * compatible with EVP_MD_do_all_provided */
+            print_digest((EVP_MD *)digest, NULL);
         }
     }
     printf("\n");
+#endif
 }
 
 void
@@ -624,6 +641,19 @@ cipher_kt_get(const char *ciphername)
     ciphername = translate_cipher_name_from_openvpn(ciphername);
     cipher = EVP_get_cipherbyname(ciphername);
 
+    /* This is a workaround for OpenSSL 3.0 to infer if the cipher is valid
+     * without doing all the refactoring that OpenVPN 2.6 has. This will
+     * not support custom algorithm from providers but at least ignore
+     * algorithms that are not available without providers (legacy) */
+#if OPENSSL_VERSION_NUMBER >= 0x30000000L
+    EVP_CIPHER *tmpcipher = EVP_CIPHER_fetch(NULL, ciphername, NULL);
+    if (!tmpcipher)
+    {
+        cipher = NULL;
+    }
+    EVP_CIPHER_free(tmpcipher);
+#endif
+
     if (NULL == cipher)
     {
         crypto_msg(D_LOW, "Cipher algorithm '%s' not found", ciphername);
@@ -924,6 +954,20 @@ md_kt_get(const char *digest)
     const EVP_MD *md = NULL;
     ASSERT(digest);
     md = EVP_get_digestbyname(digest);
+
+    /* This is a workaround for OpenSSL 3.0 to infer if the digest is valid
+     * without doing all the refactoring that OpenVPN 2.6 has. This will
+     * not support custom algorithm from providers but at least ignore
+     * algorithms that are not available without providers (legacy) */
+#if OPENSSL_VERSION_NUMBER >= 0x30000000L
+    EVP_MD *tmpmd = EVP_MD_fetch(NULL, digest, NULL);
+    if (!tmpmd)
+    {
+        md = NULL;
+    }
+    EVP_MD_free(tmpmd);
+#endif
+
     if (!md)
     {
         crypto_msg(M_FATAL, "Message hash algorithm '%s' not found", digest);
-- 
2.32.0 (Apple Git-132)


