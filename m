From: Gert Doering <gert@...1296...>
Date: Fri, 30 Jan 2026 08:11:31 +0100
Message-ID: <20260130071137.14398-1-gert@...1296...>
In-Reply-To: <gerrit.1769619521000.I740991f22b728fe2f5a48bc18d5ca4b62f56f399@...2715...>
References: <gerrit.1769619521000.I740991f22b728fe2f5a48bc18d5ca4b62f56f399@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Mbed TLS 4: Add more algorithms
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

From: Max Fillinger <maximilian.fillinger@...2918...>

Expand the tables of hash functions and elliptic curve groups, and also
check if they are compiled in.

Change-Id: I740991f22b728fe2f5a48bc18d5ca4b62f56f399
Signed-off-by: Max Fillinger <maximilian.fillinger@...2918...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1500
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1500
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 5418df9..02735cd 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -605,10 +605,36 @@
 }
 
 static const md_info_t md_info_table[] = {
-    /* TODO: Fill out table. */
+#if defined(PSA_WANT_ALG_MD5)
     { "MD5", PSA_ALG_MD5 },
+#endif
+#if defined(PSA_WANT_ALG_SHA_1)
     { "SHA1", PSA_ALG_SHA_1 },
+#endif
+#if defined(PSA_WANT_ALG_SHA_224)
+    { "SHA224", PSA_ALG_SHA_224 },
+#endif
+#if defined(PSA_WANT_ALG_SHA_256)
     { "SHA256", PSA_ALG_SHA_256 },
+#endif
+#if defined(PSA_WANT_ALG_SHA_384)
+    { "SHA384", PSA_ALG_SHA_384 },
+#endif
+#if defined(PSA_WANT_ALG_SHA_512)
+    { "SHA512", PSA_ALG_SHA_512 },
+#endif
+#if defined(PSA_WANT_ALG_SHA3_224)
+    { "SHA3-224", PSA_ALG_SHA3_224 },
+#endif
+#if defined(PSA_WANT_ALG_SHA3_256)
+    { "SHA3-256", PSA_ALG_SHA3_256 },
+#endif
+#if defined(PSA_WANT_ALG_SHA3_384)
+    { "SHA3-384", PSA_ALG_SHA3_384 },
+#endif
+#if defined(PSA_WANT_ALG_SHA3_512)
+    { "SHA3-512", PSA_ALG_SHA3_512 },
+#endif
 };
 const size_t md_info_table_entries = sizeof(md_info_table) / sizeof(md_info_t);
 
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 3e1698f..5227eb8 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -356,15 +356,54 @@
 
 #if MBEDTLS_VERSION_NUMBER >= 0x04000000
 static const mbedtls_ecp_curve_info ecp_curve_info_table[] = {
-    /* TODO: Fill out the table. */
+/* secp curves. */
+#if defined(PSA_WANT_ECC_SECP_R1_256)
     { "secp256r1", MBEDTLS_SSL_IANA_TLS_GROUP_SECP256R1 },
+#endif
+#if defined(PSA_WANT_ECC_SECP_R1_384)
     { "secp384r1", MBEDTLS_SSL_IANA_TLS_GROUP_SECP384R1 },
+#endif
+#if defined(PSA_WANT_ECC_SECP_R1_521)
+    { "secp521r1", MBEDTLS_SSL_IANA_TLS_GROUP_SECP521R1 },
+#endif
+
+/* Curve25519. */
+#if defined(PSA_WANT_ECC_MONTGOMERY_255)
     { "X25519", MBEDTLS_SSL_IANA_TLS_GROUP_X25519 },
+#endif
+
+/* Curve448. */
+#if defined(PSA_WANT_ECC_MONTGOMERY_448)
+    { "X448", MBEDTLS_SSL_IANA_TLS_GROUP_X448 },
+#endif
+
+/* Brainpool curves. */
+#if defined(PSA_WANT_ECC_BRAINPOOL_P_R1_256)
+    { "brainpoolP256r1", MBEDTLS_SSL_IANA_TLS_GROUP_BP256R1 },
+#endif
+#if defined(PSA_WANT_ECC_BRAINPOOL_P_R1_384)
+    { "brainpoolP384r1", MBEDTLS_SSL_IANA_TLS_GROUP_BP384R1 },
+#endif
+#if defined(PSA_WANT_ECC_BRAINPOOL_P_R1_512)
+    { "brainpoolP512r1", MBEDTLS_SSL_IANA_TLS_GROUP_BP512R1 },
+#endif
+
+/* Named Diffie-Hellman groups. */
+#if defined(PSA_WANT_DH_RFC7919_2048)
     { "ffdhe2048", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE2048 },
+#endif
+#if defined(PSA_WANT_DH_RFC7919_3072)
     { "ffdhe3072", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE3072 },
+#endif
+#if defined(PSA_WANT_DH_RFC7919_4096)
     { "ffdhe4096", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE4096 },
+#endif
+#if defined(PSA_WANT_DH_RFC7919_6144)
     { "ffdhe6144", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE6144 },
+#endif
+#if defined(PSA_WANT_DH_RFC7919_8192)
     { "ffdhe8192", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE8192 },
+#endif
 };
 static const size_t ecp_curve_info_table_items = sizeof(ecp_curve_info_table) / sizeof(mbedtls_ecp_curve_info);
 
@@ -1523,7 +1562,11 @@
         pcurve++;
     }
 #else
-    msg(M_FATAL, "Mbed TLS 4 has no mechanism to list supported curves.");
+    printf("Available elliptic curves:\n\n");
+    for (size_t i = 0; i < ecp_curve_info_table_items; i++)
+    {
+        printf("%s\n", ecp_curve_info_table[i].name);
+    }
 #endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
 }
 

