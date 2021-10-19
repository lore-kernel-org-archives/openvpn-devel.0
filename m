From: Arne Schwabe <arne@...1227...>
Date: Tue, 19 Oct 2021 20:31:22 +0200
Message-Id: <20211019183127.614175-17-arne@...1227...>
In-Reply-To: <20211019183127.614175-1-arne@...1227...>
References: <20211019183127.614175-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 16/21] Add message when decoding PKCS12
 file fails.
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

Currently we never display the OpenSSL error stack when decoding a
PCKS12 file fails. With LibreSSL defaulting to RC2-40-CBC, the failure
might not be a wrong password but can actually be an unsupported
encoding, seeing the error stack is really helpful (example from OpenSSL 3.0):

error:0308010C:digital envelope routines:inner_evp_generic_fetch:unsupported:crypto/evp/evp_fetch.c:346:Global  default library context, Algorithm (RC2-40-CBC : 0), Properties ()

to pinpoint the issue

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_openssl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 8ec96e66c..d93292700 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -831,6 +831,8 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
         ca = NULL;
         if (!PKCS12_parse(p12, password, &pkey, &cert, &ca))
         {
+            crypto_msg(M_WARN, "Decoding PKCS12 failed. Probably wrong password "
+                               "or unsupported/legacy encryption");
 #ifdef ENABLE_MANAGEMENT
             if (management && (ERR_GET_REASON(ERR_peek_error()) == PKCS12_R_MAC_VERIFY_FAILURE))
             {
-- 
2.33.0


