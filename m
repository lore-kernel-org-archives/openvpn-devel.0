From: Gert Doering <gert@...1296...>
Date: Mon,  2 Mar 2026 15:20:39 +0100
Message-ID: <20260302142045.5954-1-gert@...1296...>
In-Reply-To: <gerrit.1771607942000.I53d47e4a0d33c380ee95e0e33aecad3db3197940@...2715...>
References: <gerrit.1771607942000.I53d47e4a0d33c380ee95e0e33aecad3db3197940@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Avoid unbounded allocations in
 pkcs11_mbedtls.c
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

The PKCS#11 provider can crash OpenVPN by making it try to allocate
2^64 bytes for a certificate. To avoid this, set a maximum size for
certificates. If the size is exceeded, don't try to allocate memory and
instead exit pkcs11_get_x509_cert with an error.

The chosen maximum size is 100.000 bytes which is twice the size of
a SLH-DSA (aka SPHINCS+) signature.

Found-by: ZeroPath (https://zeropath.com/)
Reported-by: Joshua Rogers <contact@...2949...>
Github: closes OpenVPN/openvpn-private-issues#42

Change-Id: I53d47e4a0d33c380ee95e0e33aecad3db3197940
Signed-off-by: Max Fillinger <maximilian.fillinger@...2918...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1549
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1549
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c
index 66aefac..bf9d953 100644
--- a/src/openvpn/pkcs11_mbedtls.c
+++ b/src/openvpn/pkcs11_mbedtls.c
@@ -42,6 +42,16 @@
 static bool
 pkcs11_get_x509_cert(pkcs11h_certificate_t pkcs11_cert, mbedtls_x509_crt *cert)
 {
+    /* We set a maximum size for certificates so that the PKCS provider cannot crash OpenVPN by
+     * making it try to allocate 2^64 bytes. The maximum of 100.000 bytes is picked as a round
+     * number that easily accomodates the currently standardized quantum-safe signature algorithms.
+     * It is twice the size of a SLH-DSA (aka SPHINCS+) signature plus public key.
+     *
+     * However, there are additional digital signature schemes currently on the NIST on-ramp
+     * (e.g., some parameter settings for LESS) that have even larger public keys or signatures, so
+     * if those ever see use on smartcards, we will need to increase this number. */
+    const size_t max_cert_size = 100000;
+
     unsigned char *cert_blob = NULL;
     size_t cert_blob_size = 0;
     bool ret = false;
@@ -52,6 +62,12 @@
         goto cleanup;
     }
 
+    if (cert_blob_size > max_cert_size)
+    {
+        msg(M_WARN, "PKCS#11: Certificate too large: %lu bytes, maximum is %lu", cert_blob_size, max_cert_size);
+        goto cleanup;
+    }
+
     check_malloc_return((cert_blob = calloc(1, cert_blob_size)));
     if (pkcs11h_certificate_getCertificateBlob(pkcs11_cert, cert_blob, &cert_blob_size) != CKR_OK)
     {

