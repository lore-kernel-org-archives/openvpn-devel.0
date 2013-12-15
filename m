Message-ID: <52ADF633.8040003@...1856...>
Date: Sun, 15 Dec 2013 19:34:27 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070400060608000700060305"
Subject: [Openvpn-devel] [PATCH] Use RSA_generate_key_ex() instead of
	deprecated, RSA_generate_key()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070400060608000700060305
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

Attached a patch that should close issue #197. This patch moves from
using the deprecated RSA_generate_key() to the 'new'
RSA_generate_key_ex() to generate ephemeral RSA keys. This patch does
not change OpenVPN's behaviour.

One note on the implementation though; the code generates one ephemeral
RSA key that is used during the entire lifetime of an OpenVPN process.
If OpenSSL requests a new (ephemeral) key, it will keep on returning the
same (usually rather small) key. Not the best solution.

To actually run this code, I had to force usage by selecting the
TLS-RSA-EXPORT-WITH-DES40-CBC-SHA tls-cipher. That generated a 512-bit
ephemeral RSA key, and uses the outdated DES encryption protocol.

Using this mode could lead to a false sense of security. Then again, one
should be using (Ephemeral) Diffie-Hellman anyway, and OpenVPN requires
a tls-server to supply dh parameters. A user would need to deliberately
choose a weak tls-cipher like TLS-RSA-EXPORT-WITH-DES40-CBC-SHA, which
would be aligning a gun with his foot anyway. If one would decide this
implementation is not good enough anymore, I'd suggest to just strip out
support for this completely.

-Steffan

--------------070400060608000700060305
Content-Type: text/x-patch;
	name="0001-Use-RSA_generate_key_ex-instead-of-deprecated-RSA_ge.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-Use-RSA_generate_key_ex-instead-of-deprecated-RSA_ge.pa";
	filename*1="tch"

From 6d7d536ea52713fe230264f7798c509f37dd40c9 Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan@...1856...>
Date: Sun, 15 Dec 2013 17:58:04 +0100
Subject: [PATCH] Use RSA_generate_key_ex() instead of deprecated
 RSA_generate_key()

Code has been tested using the TLS-RSA-EXPORT-WITH-DES40-CBC-SHA tls-cipher
which uses this to create ephemeral RSA keys.

This should resolve ticket #197.
---
 src/openvpn/ssl_openssl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index f41bb71..271801d 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -103,8 +103,17 @@ tmp_rsa_cb (SSL * s, int is_export, int keylength)
   static RSA *rsa_tmp = NULL;
   if (rsa_tmp == NULL)
     {
+      int ret = -1;
+      BIGNUM *bn = BN_new();
+      rsa_tmp = RSA_new();
+
       msg (D_HANDSHAKE, "Generating temp (%d bit) RSA key", keylength);
-      rsa_tmp = RSA_generate_key (keylength, RSA_F4, NULL, NULL);
+
+      if(!bn || !BN_set_word(bn, RSA_F4) ||
+	  !RSA_generate_key_ex(rsa_tmp, keylength, bn, NULL))
+	msg(M_SSLERR, "Failed to generate temp RSA key");
+
+      if (bn) BN_free( bn );
     }
   return (rsa_tmp);
 }
-- 
1.8.3.2


--------------070400060608000700060305--

