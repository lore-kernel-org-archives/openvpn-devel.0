From: Gert Doering <gert@...1296...>
Date: Thu,  9 May 2024 00:05:40 +0200
Message-ID: <20240508220540.12554-1-gert@...1296...>
In-Reply-To: <gerrit.1715191782000.Ia08a9697d0ff41721fb0acf17ccb4cfa23cb3934@...2715...>
References: <gerrit.1715191782000.Ia08a9697d0ff41721fb0acf17ccb4cfa23cb3934@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Workaround issue in LibreSSL crashing
 when enumerating digests/ciphers
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

From: Arne Schwabe <arne@...1227...>

OpenBSD/LibreSSL reimplemented EVP_get_cipherbyname/EVP_get_digestbyname
and broke calling EVP_get_cipherbynid/EVP_get_digestbyname with an
invalid nid in the process so that it would segfault.

Workaround but doing that NULL check in OpenVPN instead of leaving it
to the library.

Change-Id: Ia08a9697d0ff41721fb0acf17ccb4cfa23cb3934
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/586
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 61c6518..1649ab7 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -387,7 +387,19 @@
 #else
     for (int nid = 0; nid < 10000; ++nid)
     {
+#if defined(LIBRESSL_VERSION_NUMBER)
+        /* OpenBSD/LibreSSL reimplemented EVP_get_cipherbyname and broke
+         * calling EVP_get_cipherbynid with an invalid nid in the process
+         * so that it would segfault. */
+        const EVP_CIPHER *cipher = NULL;
+        const char *name = OBJ_nid2sn(nid);
+        if (name)
+        {
+            cipher = EVP_get_cipherbyname(name);
+        }
+#else  /* if defined(LIBRESSL_VERSION_NUMBER) */
         const EVP_CIPHER *cipher = EVP_get_cipherbynid(nid);
+#endif
         /* We cast the const away so we can keep the function prototype
          * compatible with EVP_CIPHER_do_all_provided */
         collect_ciphers((EVP_CIPHER *) cipher, &cipher_list);
@@ -441,7 +453,19 @@
 #else
     for (int nid = 0; nid < 10000; ++nid)
     {
+        /* OpenBSD/LibreSSL reimplemented EVP_get_digestbyname and broke
+         * calling EVP_get_digestbynid with an invalid nid in the process
+         * so that it would segfault. */
+#ifdef LIBRESSL_VERSION_NUMBER
+        const EVP_MD *digest = NULL;
+        const char *name = OBJ_nid2sn(nid);
+        if (name)
+        {
+            digest = EVP_get_digestbyname(name);
+        }
+#else  /* ifdef LIBRESSL_VERSION_NUMBER */
         const EVP_MD *digest = EVP_get_digestbynid(nid);
+#endif
         if (digest)
         {
             /* We cast the const away so we can keep the function prototype
@@ -449,7 +473,7 @@
             print_digest((EVP_MD *)digest, NULL);
         }
     }
-#endif
+#endif /* if OPENSSL_VERSION_NUMBER >= 0x30000000L */
     printf("\n");
 }
 

