From: Arne Schwabe <arne@...1227...>
Date: Tue,  8 Sep 2020 17:41:54 +0200
Message-Id: <20200908154157.13809-2-arne@...1227...>
In-Reply-To: <20200908154157.13809-1-arne@...1227...>
References: <20200908154157.13809-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/4] Extend verify-hash to allow multiple
 hashes
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

For a new syntax introduced now it does not make much sense to support
deprecated and old hashes, so support only SHA-256.

Also give a warning about SHA1 hash being deprecated to verify certificates
as it is now "industry standard".

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/inline-files.rst |  4 +-
 doc/man-sections/tls-options.rst  | 10 ++++
 src/openvpn/options.c             | 91 +++++++++++++++++++++++++++----
 src/openvpn/options.h             | 11 +++-
 src/openvpn/ssl_common.h          |  2 +-
 src/openvpn/ssl_verify.c          | 17 +++++-
 6 files changed, 119 insertions(+), 16 deletions(-)

diff --git a/doc/man-sections/inline-files.rst b/doc/man-sections/inline-files.rst
index 819bd3c8..303bb3c8 100644
--- a/doc/man-sections/inline-files.rst
+++ b/doc/man-sections/inline-files.rst
@@ -4,8 +4,8 @@ INLINE FILE SUPPORT
 OpenVPN allows including files in the main configuration for the ``--ca``,
 ``--cert``, ``--dh``, ``--extra-certs``, ``--key``, ``--pkcs12``,
 ``--secret``, ``--crl-verify``, ``--http-proxy-user-pass``, ``--tls-auth``,
-``--auth-gen-token-secret``, ``--tls-crypt`` and ``--tls-crypt-v2``
-options.
+``--auth-gen-token-secret``, ``--tls-crypt``, ``--tls-crypt-v2`` and
+``--verify-hash`` options.
 
 Each inline file started by the line ``<option>`` and ended by the line
 ``</option>``
diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index 8c2db7cd..52d4137e 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -579,6 +579,16 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
   The ``algo`` flag can be either :code:`SHA1` or :code:`SHA256`. If not
   provided, it defaults to :code:`SHA1`.
 
+  This option can also be inlined
+  ::
+
+    <verify-hash>
+    00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff
+    11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:00
+    </verify-hash>
+
+If the option is inlined, ``algo`` is always :code:`SHA256`.
+
 --verify-x509-name args
   Accept connections only if a host's X.509 name is equal to **name.** The
   remote host must also pass all other tests of verification.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8bf82c57..068f3e75 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1082,12 +1082,24 @@ string_substitute(const char *src, int from, int to, struct gc_arena *gc)
     return ret;
 }
 
-static uint8_t *
+/**
+ * Parses a hexstring and checks if the string has the correct length. Return
+ * a verify_hash_list of the parsed string.
+ *
+ * @param   str         String to check/parse
+ * @param   nbytes      Number of bytes expected in the hexstr (e.g. 20 for SHA1)
+ * @param   msglevel    message level to use when printing warnings/errors
+ * @param   gc          The returned string will be allocated in this gc.
+ */
+static struct verify_hash_list *
 parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_arena *gc)
 {
     int i;
     const char *cp = str;
-    uint8_t *ret = (uint8_t *) gc_malloc(nbytes, true, gc);
+
+    struct verify_hash_list *ret;
+    ALLOC_OBJ_CLEAR_GC(ret, struct verify_hash_list, gc);
+
     char term = 1;
     int byte;
     char bs[3];
@@ -1106,7 +1118,7 @@ parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_aren
         {
             msg(msglevel, "format error in hash fingerprint hex byte: %s", str);
         }
-        ret[i] = (uint8_t)byte;
+        ret->hash[i] = (uint8_t)byte;
         term = *cp++;
         if (term != ':' && term != 0)
         {
@@ -1120,10 +1132,54 @@ parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_aren
     if (term != 0 || i != nbytes-1)
     {
         msg(msglevel, "hash fingerprint is different length than expected (%d bytes): %s", nbytes, str);
+        return NULL;
     }
     return ret;
 }
 
+/**
+ * Parses a string consisting of multiple lines of hexstrings and checks if each
+ * string has the correct length. Lines that are empty are ignored. Returns
+ * a verify_hash_list.
+ *
+ * @param   str         String to check/parse
+ * @param   nbytes      Number of bytes expected in the hexstr (e.g. 20 for SHA1)
+ * @param   msglevel    message level to use when printing warnings/errors
+ * @param   gc          The returned string will be allocated in this gc.
+ */
+static struct verify_hash_list *
+parse_hash_fingerprint_multiline(const char *str, int nbytes, int msglevel,
+                                 struct gc_arena *gc)
+{
+    struct gc_arena gc_temp = gc_new();
+    char *lines = string_alloc(str, &gc_temp);
+
+    struct verify_hash_list *ret = NULL;
+
+    const char *line;
+    while ((line = strsep(&lines, "\n")))
+    {
+        /* skip empty lines */
+        if (strlen(line) == 0)
+        {
+            continue;
+        }
+
+        struct verify_hash_list *hash = parse_hash_fingerprint(line, nbytes,
+                                                               msglevel, gc);
+
+        if (!hash)
+        {
+            return NULL;
+        }
+
+        hash->next = ret;
+        ret = hash;
+    }
+    gc_free(&gc_temp);
+
+    return ret;
+}
 #ifdef _WIN32
 
 #ifndef ENABLE_SMALL
@@ -8138,22 +8194,37 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "verify-hash") && p[1] && !p[3])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
+        options->verify_hash_algo = MD_SHA256;
+
+        int digest_len = SHA256_DIGEST_LENGTH;
 
         if (!p[2] || (p[2] && streq(p[2], "SHA1")))
         {
-            options->verify_hash = parse_hash_fingerprint(p[1], SHA_DIGEST_LENGTH, msglevel, &options->gc);
             options->verify_hash_algo = MD_SHA1;
+            msg(M_WARN, "DEPRECATED FEATURE: Usage of SHA1 fingerprints for "
+                "verify-hash is deprecated. You should switch to the "
+                "SHA256.");
+            options->verify_hash_algo = MD_SHA1;
+            digest_len = SHA_DIGEST_LENGTH;
         }
-        else if (p[2] && streq(p[2], "SHA256"))
+        else if (p[2] && !streq(p[2], "SHA256"))
         {
-            options->verify_hash = parse_hash_fingerprint(p[1], SHA256_DIGEST_LENGTH, msglevel, &options->gc);
-            options->verify_hash_algo = MD_SHA256;
+            msg(msglevel, "invalid or unsupported hashing algorithm: %s  (only SHA1 and SHA256 are valid)", p[2]);
+            goto err;
+        }
+
+        if (is_inline)
+        {
+            /* We do not have a inline flag in options struct as it is either
+             * a one line or multiline string */
+            options->verify_hash = parse_hash_fingerprint_multiline(p[1], digest_len, msglevel,
+                                                                    &options->gc);
         }
         else
         {
-            msg(msglevel, "invalid or unsupported hashing algorithm: %s  (only SHA1 and SHA256 are valid)", p[2]);
-            goto err;
+            options->verify_hash = parse_hash_fingerprint(p[1], digest_len, msglevel,
+                                                          &options->gc);
         }
     }
 #ifdef ENABLE_CRYPTOAPI
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 877e9396..c0dbbd8a 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -191,6 +191,15 @@ enum genkey_type {
     GENKEY_AUTH_TOKEN
 };
 
+struct verify_hash_list
+{
+    /* Currently we only support SHA256 for longer lists, for a one item
+     * list with SHA1 we ignore the 12 byte memory wasted */
+    uint8_t hash[32];
+    struct verify_hash_list *next;
+
+};
+
 /* Command line options */
 struct options
 {
@@ -553,7 +562,7 @@ struct options
     int ns_cert_type; /* set to 0, NS_CERT_CHECK_SERVER, or NS_CERT_CHECK_CLIENT */
     unsigned remote_cert_ku[MAX_PARMS];
     const char *remote_cert_eku;
-    uint8_t *verify_hash;
+    struct verify_hash_list *verify_hash;
     hash_algo_type verify_hash_algo;
     unsigned int ssl_flags; /* set to SSLF_x flags from ssl.h */
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 96897e48..7ccfc0f8 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -282,7 +282,7 @@ struct tls_options
     int ns_cert_type;
     unsigned remote_cert_ku[MAX_PARMS];
     const char *remote_cert_eku;
-    uint8_t *verify_hash;
+    struct verify_hash_list *verify_hash;
     hash_algo_type verify_hash_algo;
     char *x509_username_field;
 
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 97ccb93b..73d14e01 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -720,9 +720,22 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
                 goto cleanup;
         }
 
-        if (memcmp(BPTR(&ca_hash), opt->verify_hash, BLEN(&ca_hash)))
+        struct verify_hash_list *current_hash = opt->verify_hash;
+        bool hash_matched = false;
+
+        while (current_hash)
+        {
+            if (memcmp_constant_time(BPTR(&ca_hash), current_hash->hash,
+                                     BLEN(&ca_hash)) == 0)
+            {
+                hash_matched = true;
+            }
+            current_hash = current_hash->next;
+        }
+
+        if (!hash_matched)
         {
-            msg(D_TLS_ERRORS, "TLS Error: level-1 certificate hash verification failed");
+            msg(D_TLS_ERRORS, "TLS Error: --tls-verify certificate hash verification failed");
             goto cleanup;
         }
     }
-- 
2.26.2


