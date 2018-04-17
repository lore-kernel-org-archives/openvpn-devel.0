Date: Tue, 17 Apr 2018 17:51:51 +0200
From: "Jason A. Donenfeld" <Jason@...2390...>
Message-ID: <20180417155149.GA20143@...2390...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Fingerprint-based Auth
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net
Cc: fkooman@...2318..., Rogier.Spoor@...321...

Hello list,

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

I wrote an extremely crufty patch for this -- which I'm sure you'll want to
rewrite -- that I thought might provide some lens as to how simple of a change
this is. I've also included some instructions on how to use all of this.

I'm busy with WireGuard and won't have time to fully develop this feature, but
the CC'd parties are very interested in having it, so hopefully someone will
step up to bring this sketch to fruition.

Regards,
Jason


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


Crufty patch:
=============

diff -ru openvpn-2.4.5/src/openvpn/init.c openvpn-2.4.5-modified/src/openvpn/init.c
--- openvpn-2.4.5/src/openvpn/init.c	2018-03-01 08:22:19.000000000 +0100
+++ openvpn-2.4.5-modified/src/openvpn/init.c	2018-04-17 17:15:09.388690819 +0200
@@ -2749,6 +2749,7 @@
     to.remote_cert_eku = options->remote_cert_eku;
     to.verify_hash = options->verify_hash;
     to.verify_hash_algo = options->verify_hash_algo;
+    to.ca_file_none = options->ca_file_none;
 #ifdef ENABLE_X509ALTUSERNAME
     to.x509_username_field = (char *) options->x509_username_field;
 #else
diff -ru openvpn-2.4.5/src/openvpn/options.c openvpn-2.4.5-modified/src/openvpn/options.c
--- openvpn-2.4.5/src/openvpn/options.c	2018-03-01 08:22:19.000000000 +0100
+++ openvpn-2.4.5-modified/src/openvpn/options.c	2018-04-17 16:54:11.523414012 +0200
@@ -3290,7 +3290,10 @@
 #ifdef ENABLE_CRYPTO
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
@@ -7700,6 +7703,10 @@
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
diff -ru openvpn-2.4.5/src/openvpn/options.h openvpn-2.4.5-modified/src/openvpn/options.h
--- openvpn-2.4.5/src/openvpn/options.h	2018-03-01 08:22:19.000000000 +0100
+++ openvpn-2.4.5-modified/src/openvpn/options.h	2018-04-17 16:51:00.962640290 +0200
@@ -495,6 +495,7 @@
     /* TLS (control channel) parms */
     bool tls_server;
     bool tls_client;
+    bool ca_file_none;
     const char *ca_file;
     const char *ca_path;
     const char *dh_file;
diff -ru openvpn-2.4.5/src/openvpn/ssl.c openvpn-2.4.5-modified/src/openvpn/ssl.c
--- openvpn-2.4.5/src/openvpn/ssl.c	2018-03-01 08:22:19.000000000 +0100
+++ openvpn-2.4.5-modified/src/openvpn/ssl.c	2018-04-17 17:14:00.563153748 +0200
@@ -695,7 +695,7 @@
         }
     }

-    if (options->ca_file || options->ca_path)
+    if ((!options->ca_file_none && options->ca_file) || options->ca_path)
     {
         tls_ctx_load_ca(new_ctx, options->ca_file, options->ca_file_inline,
                         options->ca_path, options->tls_server);
diff -ru openvpn-2.4.5/src/openvpn/ssl_common.h openvpn-2.4.5-modified/src/openvpn/ssl_common.h
--- openvpn-2.4.5/src/openvpn/ssl_common.h	2018-03-01 08:22:19.000000000 +0100
+++ openvpn-2.4.5-modified/src/openvpn/ssl_common.h	2018-04-17 17:14:41.447285597 +0200
@@ -272,6 +272,7 @@
     uint8_t *verify_hash;
     hash_algo_type verify_hash_algo;
     char *x509_username_field;
+    bool ca_file_none;

     /* allow openvpn config info to be
      * passed over control channel */
diff -ru openvpn-2.4.5/src/openvpn/ssl_verify.c openvpn-2.4.5-modified/src/openvpn/ssl_verify.c
--- openvpn-2.4.5/src/openvpn/ssl_verify.c	2018-03-01 08:22:19.000000000 +0100
+++ openvpn-2.4.5-modified/src/openvpn/ssl_verify.c	2018-04-17 17:17:55.230139543 +0200
@@ -719,7 +719,7 @@
     }

     /* verify level 1 cert, i.e. the CA that signed our leaf cert */
-    if (cert_depth == 1 && opt->verify_hash)
+    if ((opt->ca_file_none || cert_depth == 1) && opt->verify_hash)
     {
         struct buffer ca_hash = {0};

diff -ru openvpn-2.4.5/src/openvpn/ssl_verify_openssl.c openvpn-2.4.5-modified/src/openvpn/ssl_verify_openssl.c
--- openvpn-2.4.5/src/openvpn/ssl_verify_openssl.c	2018-03-01 08:22:19.000000000 +0100
+++ openvpn-2.4.5-modified/src/openvpn/ssl_verify_openssl.c	2018-04-17 17:17:30.001681856 +0200
@@ -66,7 +66,7 @@
     cert_hash_remember(session, X509_STORE_CTX_get_error_depth(ctx), &cert_hash);

     /* did peer present cert which was signed by our root cert? */
-    if (!preverify_ok)
+    if (!preverify_ok && !session->opt->ca_file_none)
     {
         /* get the X509 name */
         char *subject = x509_get_subject(current_cert, &gc);


