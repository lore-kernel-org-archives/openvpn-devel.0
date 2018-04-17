From: "Jason A. Donenfeld" <Jason@...2390...>
Date: Tue, 17 Apr 2018 18:50:00 +0200
Message-Id: <20180417165000.3872-1-Jason@...2390...>
Subject: [Openvpn-devel] [PATCH] Support fingerprint authentication
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

OpenVPN traditionally works around CAs. However many TLS-based protocols also
allow an alternative simpler mode in which rather than verify certificates
against CAs, the certificate itself is hashed and compared against a
pre-known set of acceptable hashes. This is usually referred to as
"fingerprint verification". It's popular across SMTP servers, IRC servers,
XMPP servers, and even in the context of HTTP with pinning.

So, I'd like to propose an extremely simple and non-invasive way of
supporting this in OpenVPN, by re-using several features that already
basically support it. Namely, what I propose is:

   * Allow specifying 'none' to the --ca parameter, to specify that
     certificates should not be checked against a CA. Note that 'none'
     is already used in other similar options as a special placeholder.

   * When '--ca none' is in use, --verify-hash checks all depths instead
     of just level 1.

With these very simple changes, fingerprint authentication is easily achieved
via the --tls-verify script on the server and via --verify-hash on the client.

I've included some instructions on how to use all of this.

Server side:
============

Make self-signed cert:
$ openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -keyout key.pem -out cert.pem -nodes -sha256 -days 3650 -subj '/CN=server'

Record our fingerprint in an environment variable for the client to use later:
$ server_fingerprint="$(openssl x509 -in cert.pem -noout -sha256 -fingerprint | sed 's/.*=//;s/\(.*\)/\L\1/')"

Start openvpn with tls verify script:
$ sudo openvpn --server 10.66.0.0 255.255.255.0 --dev tun --dh none --ca none --cert cert.pem --key key.pem --tls-verify $(readlink -f tls-verify.sh) --script-security 2

TLS Verify Script:
==================

#!/bin/sh
[ -n "$tls_digest_sha256_0" -a -e "/tmp/allowed-openvpn-fingerprints/$tls_digest_sha256_0" ]

Client side:
============

Make self-signed cert:
$ openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -keyout key.pem -out cert.pem -nodes -sha256 -days 3650 -subj '/CN=client'

"Tell" the server about our fingerprint:
$ mkdir -p /tmp/allowed-openvpn-fingerprints; touch "/tmp/allowed-openvpn-fingerprints/$(openssl x509 -in cert.pem -noout -sha256 -fingerprint | sed 's/.*=//;s/\(.*\)/\L\1/')"

Start openvpn with server fingerprint verification:
$ sudo openvpn --client --remote 127.0.0.1 --dev tun --ca none --cert cert.pem --key key.pem --verify-hash "$server_fingerprint" SHA256 --nobind

Signed-off-by: Jason A. Donenfeld <Jason@...2390...>
---
Sorry for the double post. Somebody suggested I submit this as an actual
git patch instead of as just part of the goofy email I sent earlier. So
here's that email turned into a proper patch that you can apply. Feel
free to hack the patch to pieces or discard it and start over.

 src/openvpn/init.c               | 1 +
 src/openvpn/options.c            | 9 ++++++++-
 src/openvpn/options.h            | 1 +
 src/openvpn/ssl.c                | 2 +-
 src/openvpn/ssl_common.h         | 1 +
 src/openvpn/ssl_verify.c         | 2 +-
 src/openvpn/ssl_verify_mbedtls.c | 2 +-
 src/openvpn/ssl_verify_openssl.c | 2 +-
 8 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 36c1a4c4..4da994d8 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2722,6 +2722,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.remote_cert_eku = options->remote_cert_eku;
     to.verify_hash = options->verify_hash;
     to.verify_hash_algo = options->verify_hash_algo;
+    to.ca_file_none = options->ca_file_none;
 #ifdef ENABLE_X509ALTUSERNAME
     to.x509_username_field = (char *) options->x509_username_field;
 #else
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 426057ab..dad706d9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3259,7 +3259,10 @@ options_postprocess_filechecks(struct options *options)
 
     /* ** SSL/TLS/crypto related files ** */
     errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE, options->dh_file, R_OK, "--dh");
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE, options->ca_file, R_OK, "--ca");
+    if (!options->ca_file_none)
+    {
+        errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE, options->ca_file, R_OK, "--ca");
+    }
     errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->ca_path, R_OK, "--capath");
     errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE, options->cert_file, R_OK, "--cert");
     errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE, options->extra_certs_file, R_OK,
@@ -7638,6 +7641,10 @@ add_option(struct options *options,
         {
             options->ca_file_inline = p[2];
         }
+        else if (streq(p[1], "none"))
+        {
+            options->ca_file_none = true;
+        }
     }
 #ifndef ENABLE_CRYPTO_MBEDTLS
     else if (streq(p[0], "capath") && p[1] && !p[2])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index f7d0145a..6ccdca49 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -489,6 +489,7 @@ struct options
     /* TLS (control channel) parms */
     bool tls_server;
     bool tls_client;
+    bool ca_file_none;
     const char *ca_file;
     const char *ca_path;
     const char *dh_file;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 669f941b..0ef0f31f 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -693,7 +693,7 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx)
         }
     }
 
-    if (options->ca_file || options->ca_path)
+    if ((!options->ca_file_none && options->ca_file) || options->ca_path)
     {
         tls_ctx_load_ca(new_ctx, options->ca_file, options->ca_file_inline,
                         options->ca_path, options->tls_server);
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 08ef6ffa..e9ac5271 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -270,6 +270,7 @@ struct tls_options
     uint8_t *verify_hash;
     hash_algo_type verify_hash_algo;
     char *x509_username_field;
+    bool ca_file_none;
 
     /* allow openvpn config info to be
      * passed over control channel */
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 25395b27..61873e6f 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -720,7 +720,7 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
     }
 
     /* verify level 1 cert, i.e. the CA that signed our leaf cert */
-    if (cert_depth == 1 && opt->verify_hash)
+    if ((opt->ca_file_none || cert_depth == 1) && opt->verify_hash)
     {
         struct buffer ca_hash = {0};
 
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index fd31bbbd..147fb983 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -63,7 +63,7 @@ verify_callback(void *session_obj, mbedtls_x509_crt *cert, int cert_depth,
     cert_hash_remember(session, cert_depth, &cert_fingerprint);
 
     /* did peer present cert which was signed by our root cert? */
-    if (*flags != 0)
+    if (*flags != 0 && !session->opt->ca_file_none)
     {
         int ret = 0;
         char errstr[512] = { 0 };
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 9b984751..10d351f4 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -66,7 +66,7 @@ verify_callback(int preverify_ok, X509_STORE_CTX *ctx)
     cert_hash_remember(session, X509_STORE_CTX_get_error_depth(ctx), &cert_hash);
 
     /* did peer present cert which was signed by our root cert? */
-    if (!preverify_ok)
+    if (!preverify_ok && !session->opt->ca_file_none)
     {
         /* get the X509 name */
         char *subject = x509_get_subject(current_cert, &gc);
-- 
2.17.0


