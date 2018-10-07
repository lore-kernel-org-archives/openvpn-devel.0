From: Steffan Karger <steffan@...1856...>
Date: Sun,  7 Oct 2018 12:00:32 +0200
Message-Id: <20181007100032.17060-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix use-after-free in
 tls_ctx_use_management_external_key
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

Commit 98bfeeb4 changed our openssl backend implementation of
tls_ctx_use_management_external_key() to no longer use
tls_ctx_load_cert_file_and_copy(), but still free'd 'cert'. Which it no
longer should do. Credits go to Arne for spotting the issue (even though
it was missed during the review).

The offending commit is only recently applied to the master branch, so was
never part of a OpenVPN release. For that reason I did not do full impact
analysis.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_openssl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index fe4db604..7532773e 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1291,7 +1291,6 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
     /* get the public key */
     EVP_PKEY *pkey = X509_get0_pubkey(cert);
     ASSERT(pkey); /* NULL before SSL_CTX_use_certificate() is called */
-    X509_free(cert);
 
     if (EVP_PKEY_id(pkey) == EVP_PKEY_RSA)
     {
-- 
2.17.1


