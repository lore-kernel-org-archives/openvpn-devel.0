From: Arne Schwabe <arne@...1227...>
Date: Tue, 19 Oct 2021 20:31:20 +0200
Message-Id: <20211019183127.614175-15-arne@...1227...>
In-Reply-To: <20211019183127.614175-1-arne@...1227...>
References: <20211019183127.614175-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 14/21] [OSSL 3.0] Use
 TYPE_do_all_provided function for listing cipher/digest
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

With OpenSSL 3.0 the use of nid values is deprecated and new algorithms
do not even have NID values anymore.

This also works nicely with providers now:

   openvpn --provider legacy:default --show-ciphers

shows more ciphers (e.g. BF-CBC) than just

   openvpn --show-ciphers

when compiled with OpenSSL 3.0

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto_openssl.c | 95 +++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 34 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 1900ccc1b..ab552efab 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -311,86 +311,113 @@ cipher_name_cmp(const void *a, const void *b)
     return strcmp(cipher_kt_name(*cipher_a), cipher_kt_name(*cipher_b));
 }
 
+struct collect_ciphers {
+    /* If we ever exceed this, we must be more selective */
+    const EVP_CIPHER *list[1000];
+    size_t num;
+};
+
+static void collect_ciphers(EVP_CIPHER *cipher, void *list)
+{
+    struct collect_ciphers* cipher_list = list;
+    if (cipher_list->num == (sizeof(cipher_list->list)/sizeof(*cipher_list->list)))
+    {
+        msg(M_WARN, "WARNING: Too many ciphers, not showing all");
+        return;
+    }
+
+    if (cipher && (cipher_kt_mode_cbc(cipher)
+#ifdef ENABLE_OFB_CFB_MODE
+        || cipher_kt_mode_ofb_cfb(cipher)
+#endif
+        || cipher_kt_mode_aead(cipher)
+    ))
+    {
+        cipher_list->list[cipher_list->num++] = cipher;
+    }
+}
+
 void
 show_available_ciphers(void)
 {
-    int nid;
-    size_t i;
+    struct collect_ciphers cipher_list = { 0 };
 
-    /* If we ever exceed this, we must be more selective */
-    const EVP_CIPHER *cipher_list[1000];
-    size_t num_ciphers = 0;
 #ifndef ENABLE_SMALL
     printf("The following ciphers and cipher modes are available for use\n"
            "with " PACKAGE_NAME ".  Each cipher shown below may be used as a\n"
            "parameter to the --data-ciphers (or --cipher) option. In static \n"
-           "key mode only CBC mode is allowed.\n\n");
+           "key mode only CBC mode is allowed.\n");
+    printf("See also openssl list -cipher-algorithms\n\n");
 #endif
 
-    for (nid = 0; nid < 10000; ++nid)
+#if OPENSSL_VERSION_NUMBER >= 0x30000000L
+    EVP_CIPHER_do_all_provided(NULL, collect_ciphers, &cipher_list);
+#else
+    for (int nid = 0; nid < 10000; ++nid)
     {
         const EVP_CIPHER *cipher = EVP_get_cipherbynid(nid);
-        if (cipher && (cipher_kt_mode_cbc(cipher)
-#ifdef ENABLE_OFB_CFB_MODE
-                       || cipher_kt_mode_ofb_cfb(cipher)
-#endif
-                       || cipher_kt_mode_aead(cipher)
-                       ))
-        {
-            cipher_list[num_ciphers++] = cipher;
-        }
-        if (num_ciphers == (sizeof(cipher_list)/sizeof(*cipher_list)))
-        {
-            msg(M_WARN, "WARNING: Too many ciphers, not showing all");
-            break;
-        }
+        /* We cast the const away so we can keep the function prototype
+         * compatible with EVP_CIPHER_do_all_provided */
+        collect_ciphers((EVP_CIPHER *)cipher, &cipher_list);
     }
+#endif
 
     /* cast to non-const to prevent warning */
-    qsort((EVP_CIPHER *)cipher_list, num_ciphers, sizeof(*cipher_list), cipher_name_cmp);
+    qsort((EVP_CIPHER *)cipher_list.list, cipher_list.num, sizeof(*cipher_list.list), cipher_name_cmp);
 
-    for (i = 0; i < num_ciphers; i++)
+    for (size_t i = 0; i < cipher_list.num; i++)
     {
-        if (!cipher_kt_insecure(cipher_list[i]))
+        if (!cipher_kt_insecure(cipher_list.list[i]))
         {
-            print_cipher(cipher_list[i]);
+            print_cipher(cipher_list.list[i]);
         }
     }
 
     printf("\nThe following ciphers have a block size of less than 128 bits, \n"
            "and are therefore deprecated.  Do not use unless you have to.\n\n");
-    for (i = 0; i < num_ciphers; i++)
+    for (int i = 0; i < cipher_list.num; i++)
     {
-        if (cipher_kt_insecure(cipher_list[i]))
+        if (cipher_kt_insecure(cipher_list.list[i]))
         {
-            print_cipher(cipher_list[i]);
+            print_cipher(cipher_list.list[i]);
         }
     }
     printf("\n");
 }
 
 void
-show_available_digests(void)
+print_digest(EVP_MD* digest, void* unused)
 {
-    int nid;
+    printf("%s %d bit digest size\n", EVP_MD_get0_name(digest),
+           EVP_MD_size(digest) * 8);
+}
 
+void
+show_available_digests(void)
+{
 #ifndef ENABLE_SMALL
     printf("The following message digests are available for use with\n"
            PACKAGE_NAME ".  A message digest is used in conjunction with\n"
            "the HMAC function, to authenticate received packets.\n"
            "You can specify a message digest as parameter to\n"
-           "the --auth option.\n\n");
+           "the --auth option.\n");
+    printf("See also openssl list -digest-algorithms\n\n");
 #endif
 
-    for (nid = 0; nid < 10000; ++nid)
+#if OPENSSL_VERSION_NUMBER >= 0x30000000L
+    EVP_MD_do_all_provided(NULL, print_digest, NULL);
+#else
+    for (int nid = 0; nid < 10000; ++nid)
     {
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
+#endif
     printf("\n");
 }
 
-- 
2.33.0


