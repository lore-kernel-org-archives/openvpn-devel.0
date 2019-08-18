From: Matthias Andree <matthias.andree@...68...>
Date: Sun, 18 Aug 2019 13:18:11 +0200
Message-Id: <20190818111811.8853-2-matthias.andree@...68...>
In-Reply-To: <20190818111811.8853-1-matthias.andree@...68...>
References: <20190818111811.8853-1-matthias.andree@...68...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix regression, reinstate LibreSSL support.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: pizzamig@...1249..., Matthias Andree <matthias.andree@...68...>

OpenVPN 2.4.6 could be compiled with LibreSSL, 2.4.7 cannot.  This was brok=
en
since 9de7fe0a "Add support for tls-ciphersuites for TLS 1.3".

This patch avoids using TLS 1.3 directly, be it that OpenSSL was compiled
without TLS 1.3 support, or LibreSSL was used.

This patch was based on an OpenBSD patch by
Jeremie Courreges-Anglas <jca@...2273...>, see
https://cvsweb.openbsd.org/cgi-bin/cvsweb/ports/net/openvpn/patches/patch-s=
rc_openvpn_ssl_openssl_c
but was revised to be more obvious and check actual feature macros,
do not rely on current LibreSSL implementation details alone.

Franco Fichtner reports that OPNsense has been a long-time user
of LibreSSL without reported breakage, see also:
https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D238382#c10

Signed-off-by: Matthias Andree <matthias.andree@...68...>
---
 src/openvpn/ssl_openssl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index a78dae99..293bb192 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -206,7 +206,7 @@ info_callback(INFO_CALLBACK_SSL_CONST SSL *s, int where=
, int ret)
 int
 tls_version_max(void)
 {
-#if defined(TLS1_3_VERSION)
+#if defined(TLS1_3_VERSION) && !defined(OPENSSL_NO_TLS1_3)
     return TLS_VER_1_3;
 #elif defined(TLS1_2_VERSION) || defined(SSL_OP_NO_TLSv1_2)
     return TLS_VER_1_2;
@@ -233,7 +233,7 @@ openssl_tls_version(int ver)
     {
         return TLS1_2_VERSION;
     }
-#if defined(TLS1_3_VERSION)
+#if defined(TLS1_3_VERSION) && !defined(OPENSSL_NO_TLS1_3)
     else if (ver =3D=3D TLS_VER_1_3)
     {
         return TLS1_3_VERSION;
@@ -459,8 +459,8 @@ tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx=
, const char *ciphers)
         return;
     }

-#if (OPENSSL_VERSION_NUMBER < 0x1010100fL)
-        crypto_msg(M_WARN, "Not compiled with OpenSSL 1.1.1 or higher. "
+#if (OPENSSL_VERSION_NUMBER < 0x1010100fL) || !defined(TLS1_3_VERSION) || =
defined(OPENSSL_NO_TLS1_3)
+        crypto_msg(M_WARN, "Not compiled with OpenSSL 1.1.1 or higher, or =
without TLS 1.3 support. "
                        "Ignoring TLS 1.3 only tls-ciphersuites '%s' settin=
g.",
                         ciphers);
 #else
@@ -1846,7 +1846,7 @@ show_available_tls_ciphers_list(const char *cipher_li=
st,
         crypto_msg(M_FATAL, "Cannot create SSL_CTX object");
     }

-#if (OPENSSL_VERSION_NUMBER >=3D 0x1010100fL)
+#if (OPENSSL_VERSION_NUMBER >=3D 0x1010100fL) && defined(TLS1_3_VERSION) &=
& !defined(OPENSSL_NO_TLS1_3)
     if (tls13)
     {
         SSL_CTX_set_min_proto_version(tls_ctx.ctx, TLS1_3_VERSION);
--
2.21.0


