From: Gert Doering <gert@...1296...>
Date: Wed,  4 Mar 2026 15:40:21 +0100
Message-ID: <20260304144028.2459-1-gert@...1296...>
In-Reply-To: <gerrit.1769512571000.Ie8135a31b1f8f70ce0ddf63d7653f3d84a9e983f@...2715...>
References: <gerrit.1769512571000.Ie8135a31b1f8f70ce0ddf63d7653f3d84a9e983f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] ssl_openssl: Use correct return type for
 RSA_size
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

It returns int, so use that. Avoids a sign-compare
warning.

Change-Id: Ie8135a31b1f8f70ce0ddf63d7653f3d84a9e983f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1493
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1493
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index c61e4b2..d8c4587 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1491,17 +1491,11 @@
     return len;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /* sign arbitrary data */
 static int
 rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
 {
-    unsigned int len = RSA_size(rsa);
-    int ret = -1;
+    int len = RSA_size(rsa);
 
     if (padding != RSA_PKCS1_PADDING && padding != RSA_NO_PADDING)
     {
@@ -1509,15 +1503,11 @@
         return -1;
     }
 
-    ret = get_sig_from_man(from, flen, to, len, get_rsa_padding_name(padding));
+    int ret = get_sig_from_man(from, flen, to, len, get_rsa_padding_name(padding));
 
     return (ret == len) ? ret : -1;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static int
 tls_ctx_use_external_rsa_key(struct tls_root_ctx *ctx, EVP_PKEY *pkey)
 {

