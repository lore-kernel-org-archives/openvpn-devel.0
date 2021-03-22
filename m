From: Arne Schwabe <arne@...1227...>
Date: Mon, 22 Mar 2021 10:14:14 +0100
Message-Id: <20210322091414.7533-1-arne@...1227...>
In-Reply-To: <20210319142001.2201-3-arne@...1227...>
References: <20210319142001.2201-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3 3/5] Support fingerprint authentication
 without CA certificate
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

From: "Jason A. Donenfeld" <Jason@...2390...>

OpenVPN traditionally works around CAs. However many TLS-based protocols also
allow an alternative simpler mode in which rather than verify certificates
against CAs, the certificate itself is hashed and compared against a
pre-known set of acceptable hashes. This is usually referred to as
"fingerprint verification". It's popular across SMTP servers, IRC servers,
XMPP servers, and even in the context of HTTP with pinning.

   * Allow not specifying the --ca parameter, to specify that
     certificates should not be checked against a CA.

I've included some instructions on how to use all of this.

Server side:
============

Make self-signed cert:
$ openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -keyout serverkey.pem -out servercert.pem -nodes -sha256 -days 3650 -subj '/CN=server'

Record our fingerprint in an environment variable for the client to use later:
$ server_fingerprint="$(openssl x509 -in servercert.pem -noout -sha256 -fingerprint | sed 's/.*=//;s/\(.*\)/\1/')"

Client side:
============
Make self-signed cert:
$ openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -keyout clientkey.pem -out clientcert.pem -nodes -sha256 -days 3650 -subj '/CN=client'

Record our fingerprint in an environment variable for the server to use later:
$ client_fingerprint="$(openssl x509 -in clientcert.pem -noout -sha256 -fingerprint | sed 's/.*=//;s/\(.*\)/\1/')"

Start server/client
===================

Start openvpn with peer fingerprint verification:

$ sudo openvpn --server 10.66.0.0 255.255.255.0 --dev tun --dh none --cert servercert.pem --key serverkey.pem --peer-fingerprint "$client_fingerprint"

$ sudo openvpn --client --remote 127.0.0.1 --dev tun --cert clientcert.pem --key clientkey.pem --peer-fingerprint "$server_fingerprint" --nobind

Signed-off-by: Jason A. Donenfeld <Jason@...2390...>

Patch V2: Changes in V2 (by Arne Schwabe):
          - Only check peer certificates, not all cert levels, if you need
            multiple levels of certificate you should use a real CA
          - Use peer-fingerprint instead tls-verify on server side in example.
          - rename variable ca_file_none to verify_hash_no_ca
          - do no require --ca none but allow --ca simply
            to be absent when --peer-fingprint is present
          - adjust warnings/errors messages to also point to
            peer-fingerprint as valid verification method.
          - Fix mbed TLS version of not requiring CA
            not working

Patch v3: Fix minor style. Remove unessary check of verify_hash_no_ca in ssl.c.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c               |  1 +
 src/openvpn/options.c            | 27 +++++++++++++++++++++------
 src/openvpn/options.h            |  1 +
 src/openvpn/ssl_common.h         |  1 +
 src/openvpn/ssl_verify_mbedtls.c | 16 ++++++++++++++++
 src/openvpn/ssl_verify_openssl.c |  2 +-
 6 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 731b0cf2..c56dac87 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2928,6 +2928,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.verify_hash = options->verify_hash;
     to.verify_hash_algo = options->verify_hash_algo;
     to.verify_hash_depth = options->verify_hash_depth;
+    to.verify_hash_no_ca = options->verify_hash_no_ca;
 #ifdef ENABLE_X509ALTUSERNAME
     memcpy(to.x509_username_field, options->x509_username_field, sizeof(to.x509_username_field));
 #else
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 38ced536..4eee3a8a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2711,18 +2711,23 @@ options_postprocess_verify_ce(const struct options *options,
         else
         {
 #ifdef ENABLE_CRYPTO_MBEDTLS
-            if (!(options->ca_file))
+            if (!(options->ca_file || options->verify_hash_no_ca))
             {
-                msg(M_USAGE, "You must define CA file (--ca)");
+                msg(M_USAGE, "You must define CA file (--ca) and/or "
+                    "peer fingeprint verification "
+                    "(--peer-fingerprint)");
             }
             if (options->ca_path)
             {
                 msg(M_USAGE, "Parameter --capath cannot be used with the mbed TLS version version of OpenVPN.");
             }
 #else  /* ifdef ENABLE_CRYPTO_MBEDTLS */
-            if ((!(options->ca_file)) && (!(options->ca_path)))
+            if ((!(options->ca_file)) && (!(options->ca_path))
+                && (!(options->verify_hash_no_ca)))
             {
-                msg(M_USAGE, "You must define CA file (--ca) or CA path (--capath)");
+                msg(M_USAGE, "You must define CA file (--ca) or CA path "
+                    "(--capath) and/or peer fingeprint verification "
+                    "(--peer-fingerprint)");
             }
 #endif
             if (pull)
@@ -3205,6 +3210,13 @@ options_postprocess_mutate(struct options *o)
         options_postprocess_http_proxy_override(o);
     }
 #endif
+    if (!o->ca_file && !o->ca_path && o->verify_hash
+        && o->verify_hash_depth == 0)
+    {
+        msg(M_INFO, "Using certificate fingerprint to verify peer (no CA "
+            "option set). ");
+        o->verify_hash_no_ca = true;
+    }
 
 #if P2MP
     /*
@@ -3440,8 +3452,11 @@ options_postprocess_filechecks(struct options *options)
     errs |= check_file_access_inline(options->dh_file_inline, CHKACC_FILE,
                                      options->dh_file, R_OK, "--dh");
 
-    errs |= check_file_access_inline(options->ca_file_inline, CHKACC_FILE,
-                                     options->ca_file, R_OK, "--ca");
+    if (!options->verify_hash_no_ca)
+    {
+        errs |= check_file_access_inline(options->ca_file_inline, CHKACC_FILE,
+                                         options->ca_file, R_OK, "--ca");
+    }
 
     errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE,
                                      options->ca_path, R_OK, "--capath");
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 30ec53d6..c68e89d2 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -561,6 +561,7 @@ struct options
     struct verify_hash_list *verify_hash;
     hash_algo_type verify_hash_algo;
     int verify_hash_depth;
+    bool verify_hash_no_ca;
     unsigned int ssl_flags; /* set to SSLF_x flags from ssl.h */
 
 #ifdef ENABLE_PKCS11
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 2b1b87fb..4e1ff6c8 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -285,6 +285,7 @@ struct tls_options
     const char *remote_cert_eku;
     struct verify_hash_list *verify_hash;
     int verify_hash_depth;
+    bool verify_hash_no_ca;
     hash_algo_type verify_hash_algo;
 #ifdef ENABLE_X509ALTUSERNAME
     char *x509_username_field[MAX_PARMS];
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 93891038..ef3847bb 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -62,6 +62,22 @@ verify_callback(void *session_obj, mbedtls_x509_crt *cert, int cert_depth,
     struct buffer cert_fingerprint = x509_get_sha256_fingerprint(cert, &gc);
     cert_hash_remember(session, cert_depth, &cert_fingerprint);
 
+    if (session->opt->verify_hash_no_ca)
+    {
+        /*
+         * If we decide to verify the peer certificate based on the fingerprint
+         * we ignore wrong dates and the certificate not being trusted.
+         * Any other problem with the certificate (wrong key, bad cert,...)
+         * will still trigger an error.
+         * Clearing these flags relies on verify_cert will later rejecting a
+         * certificate that has no matching fingerprint.
+         */
+        uint32_t flags_ignore = MBEDTLS_X509_BADCERT_NOT_TRUSTED
+                                | MBEDTLS_X509_BADCERT_EXPIRED
+                                | MBEDTLS_X509_BADCERT_FUTURE;
+        *flags = *flags & ~flags_ignore;
+    }
+
     /* did peer present cert which was signed by our root cert? */
     if (*flags != 0)
     {
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index d063aeda..8b1f1969 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -67,7 +67,7 @@ verify_callback(int preverify_ok, X509_STORE_CTX *ctx)
     cert_hash_remember(session, X509_STORE_CTX_get_error_depth(ctx), &cert_hash);
 
     /* did peer present cert which was signed by our root cert? */
-    if (!preverify_ok)
+    if (!preverify_ok && !session->opt->verify_hash_no_ca)
     {
         /* get the X509 name */
         char *subject = x509_get_subject(current_cert, &gc);
-- 
2.30.1


