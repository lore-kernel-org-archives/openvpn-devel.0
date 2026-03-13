From: Gert Doering <gert@...1296...>
Date: Fri, 13 Mar 2026 16:30:27 +0100
Message-ID: <20260313153034.31872-1-gert@...1296...>
In-Reply-To: <gerrit.1773243451000.I7843ff1422cc3b46870749b2daab1698646d43eb@...2715...>
References: <gerrit.1773243451000.I7843ff1422cc3b46870749b2daab1698646d43eb@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] AWS-LC: Add missing return and cast in
 ssl_tls1_PRF
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

Change-Id: I7843ff1422cc3b46870749b2daab1698646d43eb
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1567
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1567
This mail reflects revision 3 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index de3878d..b6e2106 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1412,7 +1412,8 @@
 ssl_tls1_PRF(const uint8_t *label, size_t label_len, const uint8_t *sec, size_t slen, uint8_t *out1,
              size_t olen)
 {
-    CRYPTO_tls1_prf(EVP_md5_sha1(), out1, olen, sec, slen, label, label_len, NULL, 0, NULL, 0);
+    return CRYPTO_tls1_prf(EVP_md5_sha1(), out1, olen, sec, slen,
+                           (const char *)label, label_len, NULL, 0, NULL, 0);
 }
 #elif !defined(LIBRESSL_VERSION_NUMBER) && !defined(ENABLE_CRYPTO_WOLFSSL)
 #if defined(__GNUC__) || defined(__clang__)

