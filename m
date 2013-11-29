From: Arne Schwabe <arne@...1227...>
Date: Fri, 29 Nov 2013 13:32:40 +0100
Message-Id: <1385728360-32127-1-git-send-email-arne@...1227...>
In-Reply-To: <CAA1AbxJYSMkSCzbaQL5-Nb4D-uObHe_ePPqSMwEr93HF=kA0=w@...278...>
References: <CAA1AbxJYSMkSCzbaQL5-Nb4D-uObHe_ePPqSMwEr93HF=kA0=w@...278...>
Subject: [Openvpn-devel] [PATCH] Move ASSERT so external-key with OpenSSL
	works again
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

---
 src/openvpn/ssl_openssl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 120aa66..f41bb71 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -682,10 +682,11 @@ tls_ctx_use_external_private_key (struct tls_root_ctx *ctx,
   X509 *cert = NULL;
 
   ASSERT (NULL != ctx);
-  ASSERT (NULL != cert);
 
   tls_ctx_load_cert_file_and_copy (ctx, cert_file, cert_file_inline, &cert);
 
+  ASSERT (NULL != cert);
+
   /* allocate custom RSA method object */
   ALLOC_OBJ_CLEAR (rsa_meth, RSA_METHOD);
   rsa_meth->name = "OpenVPN external private key RSA Method";
-- 
1.8.3.4 (Apple Git-47)


