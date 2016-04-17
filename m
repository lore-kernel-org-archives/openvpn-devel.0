From: Steffan Karger <steffan@...1856...>
Date: Sun, 17 Apr 2016 18:22:44 +0200
Message-Id: <1460910164-7044-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH (master)] Further restrict default TLS
	cipher list
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

In the past years, the internet has been moving forward wrt deprecating
older and less secure ciphers.  Let's follow this example in OpenVPN and
further restrict the default list of negotiable TLS ciphers.

Compared to earlier, this disables the following:
 * Ciphers in the LOW and MEDIUM security cipher list of OpenSSL
   The LOW suite will be completely removed from OpenSSL in 1.1.0,
   the MEDIUM suite contains ciphers like RC4 and SEED.
 * Ciphers that do not provide forward secrecy (static DH/ECDH keys)
 * DSA private keys (rarely used, and usually restricted to 1024 bits)

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 doc/openvpn.8             |  4 +++-
 src/openvpn/ssl_openssl.c | 14 ++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 76b04f6..7d5dc5b 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4696,7 +4696,9 @@ your VPN connection.  But it is also easy to unwittingly use it to carefully
 align a gun with your foot, or just break your connection.  Use with care!
 
 The default for \-\-tls\-cipher is to use PolarSSL's default cipher list
-when using PolarSSL or "DEFAULT:!EXP:!PSK:!SRP:!kRSA" when using OpenSSL.
+when using PolarSSL or
+"DEFAULT:!EXP:!LOW:!MEDIUM:!kDH:!kECDH:!DSS:!PSK:!SRP:!kRSA" when using
+OpenSSL.
 .\"*********************************************************
 .TP
 .B \-\-tls\-timeout n
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index e390f4d..ca9b67b 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -272,8 +272,18 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 {
   if (ciphers == NULL)
     {
-      /* Use sane default (disable export, and unsupported cipher modes) */
-      if(!SSL_CTX_set_cipher_list(ctx->ctx, "DEFAULT:!EXP:!PSK:!SRP:!kRSA"))
+      /* Use sane default TLS cipher list */
+      if(!SSL_CTX_set_cipher_list(ctx->ctx,
+	  /* Use openssl's default list as a basis */
+	  "DEFAULT"
+	  /* Disable export ciphers and openssl's 'low' and 'medium' ciphers */
+	  ":!EXP:!LOW:!MEDIUM"
+	  /* Disable static (EC)DH keys (no forward secrecy) */
+	  ":!kDH:!kECDH"
+	  /* Disable DSA private keys */
+	  ":!DSS"
+	  /* Disable unsupported TLS modes */
+	  ":!PSK:!SRP:!kRSA"))
 	crypto_msg (M_FATAL, "Failed to set default TLS cipher list.");
       return;
     }
-- 
2.5.0


