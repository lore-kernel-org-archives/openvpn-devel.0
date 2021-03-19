From: Arne Schwabe <arne@...1227...>
Date: Fri, 19 Mar 2021 15:19:59 +0100
Message-Id: <20210319142001.2201-2-arne@...1227...>
In-Reply-To: <20210319142001.2201-1-arne@...1227...>
References: <20210319142001.2201-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 2/5] Implement peer-fingerprint to check
 fingerprint of peer certificate
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

This option allows to pin one or more more peer certificates. It also
prepares for doing TLS authentication without a CA and just
self-signed certificates.

Patch V2: Allow peer-fingerprint to be specified multiple times
          to allow multiple peers without needing to use inline
          syntax. (e.g. on command line).

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst                       |  9 ++++++-
 doc/man-sections/inline-files.rst |  4 +--
 doc/man-sections/tls-options.rst  | 22 +++++++++++++++-
 src/openvpn/init.c                |  1 +
 src/openvpn/options.c             | 43 ++++++++++++++++++++++++-------
 src/openvpn/options.h             |  1 +
 src/openvpn/ssl_common.h          |  1 +
 src/openvpn/ssl_verify.c          | 19 ++++++++------
 8 files changed, 78 insertions(+), 22 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index d6be1050..ac32de26 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -22,13 +22,20 @@ Compatibility with OpenSSL in FIPS mode
 
 Deprecated features
 -------------------
-``inetd`` has been removed
+``inetd`` has been removed 
     This was a very limited and not-well-tested way to run OpenVPN, on TCP
     and TAP mode only.
 
 
 Overview of changes in 2.5
 ==========================
+New features in 2.5.1
+---------------------
+Certificate pinning/verify peer fingerprint
+    The ``--peer-fingerprint`` option has been introduced to give users an
+    easy to use alternative to the ``tls-verify`` for matching the
+    fingerprint of the peer. The option takes use a number of allowed
+    SHA256 certificate fingerprints.
 
 New features
 ------------
diff --git a/doc/man-sections/inline-files.rst b/doc/man-sections/inline-files.rst
index 303bb3c8..01e4a840 100644
--- a/doc/man-sections/inline-files.rst
+++ b/doc/man-sections/inline-files.rst
@@ -4,8 +4,8 @@ INLINE FILE SUPPORT
 OpenVPN allows including files in the main configuration for the ``--ca``,
 ``--cert``, ``--dh``, ``--extra-certs``, ``--key``, ``--pkcs12``,
 ``--secret``, ``--crl-verify``, ``--http-proxy-user-pass``, ``--tls-auth``,
-``--auth-gen-token-secret``, ``--tls-crypt``, ``--tls-crypt-v2`` and
-``--verify-hash`` options.
+``--auth-gen-token-secret``, ``--peer-fingerprint``, ``--tls-crypt``,
+``--tls-crypt-v2`` and ``--verify-hash`` options.
 
 Each inline file started by the line ``<option>`` and ended by the line
 ``</option>``
diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index d8f9800e..cfe1ec98 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -271,7 +271,8 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
   man-in-the-middle attack where an authorized client attempts to connect
   to another client by impersonating the server. The attack is easily
   prevented by having clients verify the server certificate using any one
-  of ``--remote-cert-tls``, ``--verify-x509-name``, or ``--tls-verify``.
+  of ``--remote-cert-tls``, ``--verify-x509-name``, ``--peer-fingerprint``
+  or ``--tls-verify``.
 
 --tls-auth args
   Add an additional layer of HMAC authentication on top of the TLS control
@@ -592,6 +593,25 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
 
 If the option is inlined, ``algo`` is always :code:`SHA256`.
 
+--peer-fingerprint args
+   Specify a SHA256 fingerprint or list of SHA256 fingerprints to verify
+   the peer certificate against. The peer certificate must match one of the
+   fingerprint or certificate verification will fail. The option can also
+   be inlined
+
+  Valid syntax:
+  ::
+
+    peer-fingerprint AD:B0:95:D8:09:...
+
+  or inline:
+  ::
+
+    <peer-fingerprint>
+    00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff
+    11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:00
+    </peer-fingerprint>
+
 --verify-x509-name args
   Accept connections only if a host's X.509 name is equal to **name.** The
   remote host must also pass all other tests of verification.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index d234729c..731b0cf2 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2927,6 +2927,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.remote_cert_eku = options->remote_cert_eku;
     to.verify_hash = options->verify_hash;
     to.verify_hash_algo = options->verify_hash_algo;
+    to.verify_hash_depth = options->verify_hash_depth;
 #ifdef ENABLE_X509ALTUSERNAME
     memcpy(to.x509_username_field, options->x509_username_field, sizeof(to.x509_username_field));
 #else
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e119e14c..6b4a2c11 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8118,25 +8118,47 @@ add_option(struct options *options,
         options->extra_certs_file = p[1];
         options->extra_certs_file_inline = is_inline;
     }
-    else if (streq(p[0], "verify-hash") && p[1] && !p[3])
+    else if ((streq(p[0], "verify-hash") && p[1] && !p[3])
+             || (streq(p[0], "peer-fingerprint") && p[1] && !p[2]))
     {
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
+
+        int verify_hash_depth = 0;
+        if (streq(p[0], "verify-hash"))
+        {
+            /* verify level 1 cert, i.e. the CA that signed the leaf cert */
+            verify_hash_depth = 1;
+        }
+
         options->verify_hash_algo = MD_SHA256;
 
         int digest_len = SHA256_DIGEST_LENGTH;
 
-        if ((!p[2] && !is_inline) || (p[2] && streq(p[2], "SHA1")))
+        if (options->verify_hash && options->verify_hash_depth != verify_hash_depth)
         {
-            options->verify_hash_algo = MD_SHA1;
-            msg(M_WARN, "DEPRECATED FEATURE: Usage of SHA1 fingerprints for "
-                "verify-hash is deprecated. You should switch to SHA256.");
-            options->verify_hash_algo = MD_SHA1;
-            digest_len = SHA_DIGEST_LENGTH;
+            msg(msglevel, "ERROR: Setting %s not allowed. Option to verify "
+                "fingerprint of certificate of peer certificate "
+                "(--verify-hash or --peer-fingerprint) already set.",
+                p[0]);
+            goto err;
         }
-        else if (p[2] && !streq(p[2], "SHA256"))
+
+        if (streq(p[0], "verify-hash"))
         {
-            msg(msglevel, "invalid or unsupported hashing algorithm: %s  (only SHA1 and SHA256 are valid)", p[2]);
-            goto err;
+            if ((!p[2] && !is_inline) || (p[2] && streq(p[2], "SHA1")))
+            {
+                options->verify_hash_algo = MD_SHA1;
+                msg(M_WARN, "DEPRECATED FEATURE: Usage of SHA1 fingerprints for "
+                    "verify-hash is deprecated. You should switch to the "
+                    "SHA256.");
+                options->verify_hash_algo = SHA_DIGEST_LENGTH;
+                digest_len = SHA_DIGEST_LENGTH;
+            }
+            else if (p[2] && !streq(p[2], "SHA256"))
+            {
+                msg(msglevel, "invalid or unsupported hashing algorithm: %s  (only SHA1 and SHA256 are valid)", p[2]);
+                goto err;
+            }
         }
 
         struct verify_hash_list *newlist;
@@ -8155,6 +8177,7 @@ add_option(struct options *options,
         if (!options->verify_hash)
         {
             options->verify_hash = newlist;
+            options->verify_hash_depth = verify_hash_depth;
         }
         else
         {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index a7b3174f..30ec53d6 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -560,6 +560,7 @@ struct options
     const char *remote_cert_eku;
     struct verify_hash_list *verify_hash;
     hash_algo_type verify_hash_algo;
+    int verify_hash_depth;
     unsigned int ssl_flags; /* set to SSLF_x flags from ssl.h */
 
 #ifdef ENABLE_PKCS11
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index f6aaae98..2b1b87fb 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -284,6 +284,7 @@ struct tls_options
     unsigned remote_cert_ku[MAX_PARMS];
     const char *remote_cert_eku;
     struct verify_hash_list *verify_hash;
+    int verify_hash_depth;
     hash_algo_type verify_hash_algo;
 #ifdef ENABLE_X509ALTUSERNAME
     char *x509_username_field[MAX_PARMS];
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 001ca82b..6066e75f 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -721,19 +721,18 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
         goto cleanup;                   /* Reject connection */
     }
 
-    /* verify level 1 cert, i.e. the CA that signed our leaf cert */
-    if (cert_depth == 1 && opt->verify_hash)
+    if (cert_depth == opt->verify_hash_depth && opt->verify_hash)
     {
-        struct buffer ca_hash = {0};
+        struct buffer cert_fp = {0};
 
         switch (opt->verify_hash_algo)
         {
             case MD_SHA1:
-                ca_hash = x509_get_sha1_fingerprint(cert, &gc);
+                cert_fp = x509_get_sha1_fingerprint(cert, &gc);
                 break;
 
             case MD_SHA256:
-                ca_hash = x509_get_sha256_fingerprint(cert, &gc);
+                cert_fp = x509_get_sha256_fingerprint(cert, &gc);
                 break;
 
             default:
@@ -752,8 +751,8 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
 
         while (current_hash)
         {
-            if (memcmp_constant_time(BPTR(&ca_hash), current_hash->hash,
-                                     BLEN(&ca_hash)) == 0)
+            if (memcmp_constant_time(BPTR(&cert_fp), current_hash->hash,
+                                     BLEN(&cert_fp)) == 0)
             {
                 hash_matched = true;
                 break;
@@ -763,7 +762,11 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
 
         if (!current_hash)
         {
-            msg(D_TLS_ERRORS, "TLS Error: --tls-verify certificate hash verification failed");
+            const char *hex_fp = format_hex_ex(BPTR(&cert_fp), BLEN(&cert_fp),
+                                               0, 1, ":", &gc);
+            msg(D_TLS_ERRORS, "TLS Error: --tls-verify/--peer-fingerprint"
+                "certificate hash verification failed. (got "
+                "fingerprint: %s", hex_fp);
             goto cleanup;
         }
     }
-- 
2.30.1


