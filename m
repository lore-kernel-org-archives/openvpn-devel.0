From: Arne Schwabe <arne@...1227...>
Date: Fri, 10 May 2019 14:11:09 +0200
Message-Id: <20190510121114.30468-3-arne@...1227...>
In-Reply-To: <20190510121114.30468-1-arne@...1227...>
References: <20190510121114.30468-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3 2/7] Implement --genkey type keyfile
 syntax and migrate tls-crypt-v2
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

This unifies our key generation and also migrates the generation
of the tls-crypt-v2 keys. Since tls-crypt-v2 is not included in any
released version, we remove the the old syntax without compatibility.
---
 doc/openvpn.8         | 79 +++++++++++++++++++++++--------------------
 src/openvpn/init.c    | 61 ++++++++++++++++++++-------------
 src/openvpn/options.c | 67 ++++++++++++++++++++++--------------
 src/openvpn/options.h | 11 ++++--
 4 files changed, 131 insertions(+), 87 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index ce440447..90a6be91 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5242,7 +5242,7 @@ Use client\-specific tls\-crypt keys.
 For clients,
 .B keyfile
 is a client\-specific tls\-crypt key.  Such a key can be generated using the
-.B \-\-tls\-crypt\-v2\-genkey
+.B \-\-genkey tls\-crypt\-v2\-client
 option.
 
 For servers,
@@ -5250,7 +5250,7 @@ For servers,
 is used to unwrap client\-specific keys supplied by the client during connection
 setup.  This key must be the same as the key used to generate the
 client\-specific key (see
-.B \-\-tls\-crypt\-v2\-genkey\fR).
+.B \-\-genkey tls\-crypt\-v2\-client\fR).
 
 On servers, this option can be used together with the
 .B \-\-tls\-auth
@@ -5260,36 +5260,6 @@ option.  In that case, the server will detect whether the client is using
 client\-specific keys, and automatically select the right mode.
 .\"*********************************************************
 .TP
-.B \-\-tls\-crypt\-v2\-genkey client|server keyfile [metadata]
-
-If the first parameter equals "server", generate a \-\-tls\-crypt\-v2 server
-key and store the key in
-.B keyfile\fR.
-
-
-If the first parameter equals "client", generate a \-\-tls\-crypt\-v2 client
-key, and store the key in
-.B keyfile\fR.
-
-If supplied, include the supplied
-.B metadata
-in the wrapped client key.  This metadata must be supplied in base64\-encoded
-form.  The metadata must be at most 735 bytes long (980 bytes in base64).
-
-If no metadata is supplied, OpenVPN will use a 64\-bit unix timestamp
-representing the current time in UTC, encoded in network order, as metadata for
-the generated key.
-
-A tls\-crypt\-v2 client key is wrapped using a server key.  To generate a
-client key, the user must therefore supply the server key using the
-.B \-\-tls\-crypt\-v2
-option.
-
-Servers can use
-.B \-\-tls\-crypt\-v2\-verify
-to specify a metadata verification command.
-.\"*********************************************************
-.TP
 .B \-\-tls\-crypt\-v2\-verify cmd
 
 Run command
@@ -5741,13 +5711,18 @@ Show all available elliptic curves to use with the
 .B \-\-ecdh\-curve
 option.
 .\"*********************************************************
-.SS Generate a random key:
-Used only for non\-TLS static key encryption mode.
+.SS Generating random key material:
 .\"*********************************************************
 .TP
-.B \-\-genkey file
+.B \-\-genkey keytype keyfile
 (Standalone)
-Generate a random key to be used as a shared secret, for use with the
+Generate a random key to be used of the type keytype. if keyfile is left out or empty
+the key will be output on stdout. See the following sections for the different keytypes.
+
+.\"*********************************************************
+.TP
+.B \-\-genkey secret|tls-crypt|tls-auth keyfile
+Generate a shared secret, for use with the
 .B \-\-secret
 ,
 .B \-\-tls-auth
@@ -5755,6 +5730,8 @@ or
 .B \-\-tls-crypt
 options.  Stores the key in
 .B file\fR.
+All three variants (secret, tls-crypt, and tls-auth) generate the same type of
+key. The aliases are added for convience.
 
 If using this for
 .B \-\-secret
@@ -5762,6 +5739,36 @@ If using this for
 such as
 .BR scp (1)\fR.
 .\"*********************************************************
+.TP
+.B \-\-genkey tls\-crypt\-v2-server keyfile
+
+Generate a \-\-tls\-crypt\-v2 server key and store the key in
+.B keyfile\fR.
+
+.TP
+.B \-\-genkey tls\-crypt\-v2-client keyfile [metadata]
+
+Generate a \-\-tls\-crypt\-v2 client key, and store the key in
+.B keyfile\fR.
+
+If supplied, include the supplied
+.B metadata
+in the wrapped client key.  This metadata must be supplied in base64\-encoded
+form.  The metadata must be at most 735 bytes long (980 bytes in base64).
+
+If no metadata is supplied, OpenVPN will use a 64\-bit unix timestamp
+representing the current time in UTC, encoded in network order, as metadata for
+the generated key.
+
+A tls\-crypt\-v2 client key is wrapped using a server key.  To generate a
+client key, the user must therefore supply the server key using the
+.B \-\-tls\-crypt\-v2
+option.
+
+Servers can use
+.B \-\-tls\-crypt\-v2\-verify
+to specify a metadata verification command.
+.\"*********************************************************
 .SS TUN/TAP persistent tunnel config mode:
 Available with Linux 2.4.7+.  These options comprise a standalone mode
 of OpenVPN which can be used to create and delete persistent tunnels.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 3c449678..9260067f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1053,18 +1053,33 @@ bool
 do_genkey(const struct options *options)
 {
     /* should we disable paging? */
-    if (options->mlock && (options->genkey || options->tls_crypt_v2_genkey_file))
+    if (options->mlock && (options->genkey))
     {
         platform_mlockall(true);
     }
-    if (options->genkey)
+    if (options->genkey && options->genkey_type == GENKEY_SECRET)
     {
         int nbits_written;
 
-        notnull(options->shared_secret_file,
-                "shared secret output file (--secret)");
+        if (options->shared_secret_file && options->genkey_filename)
+        {
+            msg(M_USAGE, "You must provide a filename to either --genkey or --secret, not both");
+        }
+
+
+        const char* genkey_filename = options->genkey_filename;
 
-        nbits_written = write_key_file(2, options->shared_secret_file);
+        /*
+         * Copy filename from shared_secret_file to genkey_filenmae to support the old
+         * --genkey --secret foo.file syntax. The previous check ensure only one of them
+         * is defined.
+         */
+        if (options->shared_secret_file)
+        {
+             genkey_filename = options->shared_secret_file;
+        }
+
+        nbits_written = write_key_file(2, genkey_filename);
         if (nbits_written < 0)
         {
             msg(M_FATAL, "Failed to write key file");
@@ -1075,30 +1090,28 @@ do_genkey(const struct options *options)
             options->shared_secret_file);
         return true;
     }
-    if (options->tls_crypt_v2_genkey_type)
+    else if (options->genkey && options->genkey_type == GENKEY_TLS_CRYPTV2_SERVER)
     {
-        if (!strcmp(options->tls_crypt_v2_genkey_type, "server"))
-        {
-            tls_crypt_v2_write_server_key_file(options->tls_crypt_v2_genkey_file);
-            return true;
-        }
-        if (options->tls_crypt_v2_genkey_type
-            && !strcmp(options->tls_crypt_v2_genkey_type, "client"))
+        tls_crypt_v2_write_server_key_file(options->genkey_filename);
+        return true;
+    }
+    else if (options->genkey && options->genkey_type == GENKEY_TLS_CRYPTV2_CLIENT)
+    {
+        if (!options->tls_crypt_v2_file)
         {
-            if (!options->tls_crypt_v2_file)
-            {
-                msg(M_USAGE, "--tls-crypt-v2-genkey requires a server key to be set via --tls-crypt-v2 to create a client key");
-            }
-
-            tls_crypt_v2_write_client_key_file(options->tls_crypt_v2_genkey_file,
-                                               options->tls_crypt_v2_metadata, options->tls_crypt_v2_file,
-                                               options->tls_crypt_v2_inline);
-            return true;
+            msg(M_USAGE,
+                    "--genkey tls-crypt-v2-client requires a server key to be set via --tls-crypt-v2 to create a client key");
         }
 
-        msg(M_USAGE, "--tls-crypt-v2-genkey type should be \"client\" or \"server\"");
+        tls_crypt_v2_write_client_key_file(options->genkey_filename,
+                options->genkey_extra_data, options->tls_crypt_v2_file,
+                options->tls_crypt_v2_inline);
+        return true;
+    }
+    else
+    {
+        return false;
     }
-    return false;
 }
 
 /*
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e34b65b1..ced5e987 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -632,9 +632,11 @@ static const char usage_message[] =
     "                  For servers: use key to decrypt client-specific keys.  For\n"
     "                  key generation (--tls-crypt-v2-genkey): use key to\n"
     "                  encrypt generated client-specific key.  (See --tls-crypt.)\n"
-    "--tls-crypt-v2-genkey client|server keyfile [base64 metadata]: Generate a\n"
-    "                  fresh tls-crypt-v2 client or server key, and store to\n"
+    "--genkey tls-crypt-v2-client [keyfile] [base64 metadata]: Generate a\n"
+    "                  fresh tls-crypt-v2 client key, and store to\n"
     "                  keyfile.  If supplied, include metadata in wrapped key.\n"
+    "--genkey tls-crypt-v2-server [keyfile] [base64 metadata]: Generate a\n"
+    "                  fresh tls-crypt-v2 server key, and store to keyfile\n"
     "--tls-crypt-v2-verify cmd : Run command cmd to verify the metadata of the\n"
     "                  client-supplied tls-crypt-v2 client key\n"
     "--askpass [file]: Get PEM password from controlling tty before we daemonize.\n"
@@ -754,8 +756,9 @@ static const char usage_message[] =
     "                                 to access TAP adapter.\n"
 #endif /* ifdef _WIN32 */
     "\n"
-    "Generate a new key (for use with --secret, --tls-auth or --tls-crypt):\n"
-    "--genkey file   : Generate a new random key and write to file.\n"
+    "Generate a new key :\n"
+    "--genkey secret file   : Generate a new random key of type and write to file\n"
+    "                         (for use with --secret, --tls-auth or --tls-crypt)."
 #ifdef ENABLE_FEATURE_TUN_PERSIST
     "\n"
     "Tun/tap config mode (available with linux 2.4+):\n"
@@ -1526,6 +1529,7 @@ show_settings(const struct options *o)
     SHOW_BOOL(show_digests);
     SHOW_BOOL(show_engines);
     SHOW_BOOL(genkey);
+    SHOW_STR(genkey_filename);
     SHOW_STR(key_pass_file);
     SHOW_BOOL(show_tls_ciphers);
 
@@ -1746,8 +1750,6 @@ show_settings(const struct options *o)
     SHOW_BOOL(push_peer_info);
     SHOW_BOOL(tls_exit);
 
-    SHOW_STR(tls_crypt_v2_genkey_type);
-    SHOW_STR(tls_crypt_v2_genkey_file);
     SHOW_STR(tls_crypt_v2_metadata);
 
 #ifdef ENABLE_PKCS11
@@ -2689,10 +2691,6 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         {
             msg(M_USAGE, "--tls-crypt-v2, --tls-auth and --tls-crypt are mutually exclusive in client mode");
         }
-        if (options->genkey && options->tls_crypt_v2_genkey_type)
-        {
-            msg(M_USAGE, "--genkey and --tls-crypt-v2-genkey are mutually exclusive");
-        }
     }
     else
     {
@@ -3320,8 +3318,8 @@ options_postprocess_filechecks(struct options *options)
     }
 
     errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
-                              options->tls_crypt_v2_genkey_file, R_OK,
-                              "--tls-crypt-v2-genkey");
+                              options->genkey_filename, R_OK,
+                              "--genkey");
     errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
                               options->shared_secret_file, R_OK, "--secret");
 
@@ -7517,13 +7515,42 @@ add_option(struct options *options,
         }
         options->shared_secret_file = p[1];
     }
-    else if (streq(p[0], "genkey") && !p[2])
+    else if (streq(p[0], "genkey") && !p[4])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->genkey = true;
-        if (p[1])
+        if (!p[1])
+        {
+            options->genkey_type = GENKEY_SECRET;
+        }
+        else
+        {
+            if (streq(p[1], "secret") || streq(p[1], "tls-auth") ||
+                streq(p[1], "tls-crypt"))
+            {
+                options->genkey_type = GENKEY_SECRET;
+            }
+            else if (streq(p[1], "tls-crypt-v2-server"))
+            {
+                options->genkey_type = GENKEY_TLS_CRYPTV2_SERVER;
+            }
+            else if (streq(p[1], "tls-crypt-v2-client"))
+            {
+                options->genkey_type = GENKEY_TLS_CRYPTV2_CLIENT;
+                if (p[3])
+                {
+                    options->genkey_extra_data = p[3];
+                }
+            }
+            else
+            {
+                msg(msglevel, "unknown --genkey type: %s", p[1]);
+            }
+
+        }
+        if (p[2])
         {
-            options->shared_secret_file = p[1];
+            options->genkey_filename = p[2];
         }
     }
     else if (streq(p[0], "auth") && p[1] && !p[2])
@@ -8121,16 +8148,6 @@ add_option(struct options *options,
             options->ce.tls_crypt_v2_file = p[1];
         }
     }
-    else if (streq(p[0], "tls-crypt-v2-genkey") && p[2] && !p[4])
-    {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->tls_crypt_v2_genkey_type = p[1];
-        options->tls_crypt_v2_genkey_file = p[2];
-        if (p[3])
-        {
-            options->tls_crypt_v2_metadata = p[3];
-        }
-    }
     else if (streq(p[0], "tls-crypt-v2-verify") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index e2b38939..d8e7efa4 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -177,6 +177,12 @@ struct remote_host_store
     char port[RH_PORT_LEN];
 };
 
+enum genkey_type {
+    GENKEY_SECRET,
+    GENKEY_TLS_CRYPTV2_CLIENT,
+    GENKEY_TLS_CRYPTV2_SERVER,
+};
+
 /* Command line options */
 struct options
 {
@@ -207,6 +213,9 @@ struct options
     bool show_tls_ciphers;
     bool show_curves;
     bool genkey;
+    enum genkey_type genkey_type;
+    const char* genkey_filename;
+    const char* genkey_extra_data;
 
     /* Networking parms */
     int connect_retry_max;
@@ -589,8 +598,6 @@ struct options
     const char *tls_crypt_v2_file;
     const char *tls_crypt_v2_inline;
 
-    const char *tls_crypt_v2_genkey_type;
-    const char *tls_crypt_v2_genkey_file;
     const char *tls_crypt_v2_metadata;
 
     const char *tls_crypt_v2_verify_script;
-- 
2.21.0


