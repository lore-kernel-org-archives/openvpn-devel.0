From: Gert Doering <gert@...1296...>
Date: Mon, 22 Sep 2025 22:40:53 +0200
Message-ID: <20250922204059.23226-1-gert@...1296...>
In-Reply-To: <gerrit.1754490554000.I22b93c807f1be99fab450708f686fce4aa6d5cef@...2715...>
References: <gerrit.1754490554000.I22b93c807f1be99fab450708f686fce4aa6d5cef@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v8] Handle return type of EVP_MD_size
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

From: Frank Lichtenheld <frank@...2641...>

Return type is int, but we often use it in contexts
where we expect size_t. So just cast it. Nothing else
to do really.

Change-Id: I22b93c807f1be99fab450708f686fce4aa6d5cef
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1133
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1133
This mail reflects revision 8 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 98fe37f..75af4f5 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1273,7 +1273,7 @@
 
     /* We need to make a copy of the key since the OSSL parameters
      * only reference it */
-    memcpy(ctx->key, key, EVP_MD_size(kt));
+    memcpy(ctx->key, key, (size_t)EVP_MD_size(kt));
 
     /* Lookup/setting of parameters in OpenSSL 3.0 are string based
      *
@@ -1282,7 +1282,7 @@
      * the constness away here.
      */
     ctx->params[0] = OSSL_PARAM_construct_utf8_string("digest", (char *)EVP_MD_get0_name(kt), 0);
-    ctx->params[1] = OSSL_PARAM_construct_octet_string("key", ctx->key, EVP_MD_size(kt));
+    ctx->params[1] = OSSL_PARAM_construct_octet_string("key", ctx->key, (size_t)EVP_MD_size(kt));
     ctx->params[2] = OSSL_PARAM_construct_end();
 
     if (!EVP_MAC_init(ctx->ctx, NULL, 0, ctx->params))
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 6de7e2a..b79b09b 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -341,7 +341,7 @@
 x509_get_sha1_fingerprint(X509 *cert, struct gc_arena *gc)
 {
     const EVP_MD *sha1 = EVP_sha1();
-    struct buffer hash = alloc_buf_gc(EVP_MD_size(sha1), gc);
+    struct buffer hash = alloc_buf_gc((size_t)EVP_MD_size(sha1), gc);
     X509_digest(cert, EVP_sha1(), BPTR(&hash), NULL);
     ASSERT(buf_inc_len(&hash, EVP_MD_size(sha1)));
     return hash;
@@ -351,7 +351,7 @@
 x509_get_sha256_fingerprint(X509 *cert, struct gc_arena *gc)
 {
     const EVP_MD *sha256 = EVP_sha256();
-    struct buffer hash = alloc_buf_gc(EVP_MD_size(sha256), gc);
+    struct buffer hash = alloc_buf_gc((size_t)EVP_MD_size(sha256), gc);
     X509_digest(cert, EVP_sha256(), BPTR(&hash), NULL);
     ASSERT(buf_inc_len(&hash, EVP_MD_size(sha256)));
     return hash;
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index 3820808..9541a7c 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -351,7 +351,7 @@
         }
     }
 
-    if (tbslen != EVP_MD_size(EVP_get_digestbyname(mdname)))
+    if (tbslen != (size_t)EVP_MD_size(EVP_get_digestbyname(mdname)))
     {
         msg(M_WARN, "Error: encode_pkcs11: invalid input length <%zu>", tbslen);
         goto done;

