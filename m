From: =?UTF-8?q?Szil=C3=A1rd=20Pfeiffer?= <coroner@...2290...>
Date: Sun, 16 Jul 2017 10:22:07 +0200
Message-Id: <20170716082207.23646-1-coroner@...2290...>
Subject: [Openvpn-devel] [PATCH] Support server cipher preference
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

---
 doc/openvpn.8             |  4 ++++
 src/openvpn/options.c     | 17 +++++++++++++++++
 src/openvpn/ssl_common.h  |  7 ++++---
 src/openvpn/ssl_openssl.c |  6 ++++++
 4 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 20bdd91b..1439d9e0 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4889,6 +4889,10 @@ when using PolarSSL or
 OpenSSL.
 .\"*********************************************************
 .TP
+.B \-\-tls\-prefer\-server\-cipher
+Prefer server ciphers over client ciphers during the TLS handshake.
+.\"*********************************************************
+.TP
 .B \-\-tls\-timeout n
 Packet retransmit timeout on TLS control channel
 if no acknowledgment from remote within
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 505c5b2e..38c079ea 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -598,6 +598,10 @@ static const char usage_message[] =
 #endif
     "--tls-cipher l  : A list l of allowable TLS ciphers separated by : (optional).\n"
     "                : Use --show-tls to see a list of supported TLS ciphers.\n"
+#ifdef SSL_OP_CIPHER_SERVER_PREFERENCE
+    "--tls-prefer-server-ciphers: Prefer server ciphers over client ciphers during\n"
+    "                  the TLS handshake.\n"
+#endif
     "--tls-timeout n : Packet retransmit timeout on TLS control channel\n"
     "                  if no ACK from remote within n seconds (default=%d).\n"
     "--reneg-bytes n : Renegotiate data chan. key after n bytes sent and recvd.\n"
@@ -2445,6 +2449,12 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         {
             msg(M_USAGE, "--opt-verify requires --mode server");
         }
+#ifdef SSL_OP_CIPHER_SERVER_PREFERENCE
+        if (options->ssl_flags & SSLF_PREFER_SERVER_CIPHERS)
+        {
+            msg(M_USAGE, "--tls-prefer-server-ciphers requires --mode server");
+        }
+#endif
         if (options->server_flags & SF_TCP_NODELAY_HELPER)
         {
             msg(M_WARN, "WARNING: setting tcp-nodelay on the client side will not "
@@ -7814,6 +7824,13 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->cipher_list = p[1];
     }
+#ifdef SSL_OP_CIPHER_SERVER_PREFERENCE
+    else if (streq(p[0], "tls-prefer-server-ciphers") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->ssl_flags |= SSLF_PREFER_SERVER_CIPHERS;
+    }
+#endif
     else if (streq(p[0], "crl-verify") && p[1] && ((p[2] && streq(p[2], "dir"))
                                                    || (p[2] && streq(p[1], INLINE_FILE_TAG) ) || !p[2]) && !p[3])
     {
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 25bffd5b..cd93f16e 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -322,10 +322,11 @@ struct tls_options
 #define SSLF_AUTH_USER_PASS_OPTIONAL  (1<<3)
 #define SSLF_OPT_VERIFY               (1<<4)
 #define SSLF_CRL_VERIFY_DIR           (1<<5)
-#define SSLF_TLS_VERSION_MIN_SHIFT    6
-#define SSLF_TLS_VERSION_MIN_MASK     0xF  /* (uses bit positions 6 to 9) */
+#define SSLF_PREFER_SERVER_CIPHERS    (1<<6)
+#define SSLF_TLS_VERSION_MIN_SHIFT    8
+#define SSLF_TLS_VERSION_MIN_MASK     0xF  /* (uses bit positions 7 to 10) */
 #define SSLF_TLS_VERSION_MAX_SHIFT    10
-#define SSLF_TLS_VERSION_MAX_MASK     0xF  /* (uses bit positions 10 to 13) */
+#define SSLF_TLS_VERSION_MAX_MASK     0xF  /* (uses bit positions 11 to 14) */
     unsigned int ssl_flags;
 
 #ifdef MANAGEMENT_DEF_AUTH
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 11f4a567..63976fcd 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -253,6 +253,12 @@ tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
             sslopt |= SSL_OP_NO_TLSv1_2;
         }
 #endif
+#ifdef SSL_OP_CIPHER_SERVER_PREFERENCE
+        if (ssl_flags & SSLF_PREFER_SERVER_CIPHERS)
+        {
+            sslopt |= SSL_OP_CIPHER_SERVER_PREFERENCE;
+        }
+#endif
         sslopt |= SSL_OP_NO_COMPRESSION;
         SSL_CTX_set_options(ctx->ctx, sslopt);
     }
-- 
2.13.3


