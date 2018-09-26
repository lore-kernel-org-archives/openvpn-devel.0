From: Arne Schwabe <arne@...1227...>
Date: Wed, 26 Sep 2018 15:44:58 +0200
Message-Id: <20180926134458.20920-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Add support for tls-ciphersuites for TLS 1.3
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

OpenSSL 1.1.1 introduces a seperate list for TLS 1.3 ciphers. As these
interfaces are meant to be user facing or not exposed at all and we
expose the tls-cipher interface, we should also expose tls-cipherlist.

Combining both settings into tls-cipher would add a lot of glue logic
that needs to be maintained and is error prone. On top of that, users
should not set either settings unless absolutely required.

OpenSSL's own s_client/s_server also expose both settings and I believe
most other software will too:

 -cipher val         Specify TLSv1.2 and below cipher list to be used
 -ciphersuites val   Specify TLSv1.3 ciphersuites to be used

For mbed TLS only the future can tell if we will see a combined or also
two seperate lists.
---
 doc/openvpn.8             |  19 ++++-
 src/openvpn/options.c     |   7 ++
 src/openvpn/options.h     |   1 +
 src/openvpn/ssl.c         |   3 +-
 src/openvpn/ssl_backend.h |  13 ++-
 src/openvpn/ssl_mbedtls.c |  12 +++
 src/openvpn/ssl_openssl.c | 167 +++++++++++++++++++++++---------------
 7 files changed, 151 insertions(+), 71 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 15a10296..0b44a29d 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5001,11 +5001,13 @@ determines the derivation of the tunnel session keys.
 .\"*********************************************************
 .TP
 .B \-\-tls\-cipher l
+.TQ
+.B \-\-tls\-ciphersuites l
 A list
 .B l
 of allowable TLS ciphers delimited by a colon (":").
 
-This setting can be used to ensure that certain cipher suites are used (or
+These setting can be used to ensure that certain cipher suites are used (or
 not used) for the TLS connection.  OpenVPN uses TLS to secure the control
 channel, over which the keys that are used to protect the actual VPN traffic
 are exchanged.
@@ -5014,13 +5016,24 @@ The supplied list of ciphers is (after potential OpenSSL/IANA name translation)
 simply supplied to the crypto library.  Please see the OpenSSL and/or mbed TLS
 documentation for details on the cipher list interpretation.
 
+For OpenSSL the
+.B \-\-tls-cipher
+is used for TLS 1.2 and below. For TLS 1.3 and up
+the
+.B \-\-tls\-ciphersuites
+setting is used. mbed TLS has no TLS 1.3 support yet and only the
+.B \-\-tls-cipher
+setting is used.
+
 Use
 .B \-\-show\-tls
 to see a list of TLS ciphers supported by your crypto library.
 
 Warning!
 .B \-\-tls\-cipher
-is an expert feature, which \- if used correcly \- can improve the security of
+and
+.B \-\-tls\-ciphersuites
+are expert features, which \- if used correcly \- can improve the security of
 your VPN connection.  But it is also easy to unwittingly use it to carefully
 align a gun with your foot, or just break your connection.  Use with care!
 
@@ -5028,6 +5041,8 @@ The default for \-\-tls\-cipher is to use mbed TLS's default cipher list
 when using mbed TLS or
 "DEFAULT:!EXP:!LOW:!MEDIUM:!kDH:!kECDH:!DSS:!PSK:!SRP:!kRSA" when using
 OpenSSL.
+
+The default for \-\-tls\-ciphersuites is to use the crypto library's default.
 .\"*********************************************************
 .TP
 .B \-\-tls\-cert\-profile profile
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 03550c1e..a574c9f9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1766,6 +1766,7 @@ show_settings(const struct options *o)
 #endif
     SHOW_STR(cipher_list);
     SHOW_STR(tls_cert_profile);
+    SHOW_STR(cipher_list_tls13);
     SHOW_STR(tls_verify);
     SHOW_STR(tls_export_cert);
     SHOW_INT(verify_x509_type);
@@ -2759,6 +2760,7 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         MUST_BE_UNDEF(pkcs12_file);
 #endif
         MUST_BE_UNDEF(cipher_list);
+        MUST_BE_UNDEF(cipher_list_tls13);
         MUST_BE_UNDEF(tls_cert_profile);
         MUST_BE_UNDEF(tls_verify);
         MUST_BE_UNDEF(tls_export_cert);
@@ -7948,6 +7950,11 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->tls_cert_profile = p[1];
     }
+    else if (streq(p[0], "tls-ciphersuites") && p[1] && !p[2])
+    {
+      VERIFY_PERMISSION(OPT_P_GENERAL);
+      options->cipher_list_tls13 = p[1];
+    }
     else if (streq(p[0], "crl-verify") && p[1] && ((p[2] && streq(p[2], "dir"))
                                                    || (p[2] && streq(p[1], INLINE_FILE_TAG) ) || !p[2]) && !p[3])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 4c3bc4fb..3e7ef4f8 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -508,6 +508,7 @@ struct options
     const char *priv_key_file;
     const char *pkcs12_file;
     const char *cipher_list;
+    const char *cipher_list_tls13;
     const char *tls_cert_profile;
     const char *ecdh_curve;
     const char *tls_verify;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e5e4aac2..616c2696 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -626,9 +626,10 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx)
     tls_ctx_set_cert_profile(new_ctx, options->tls_cert_profile);
 
     /* Allowable ciphers */
-    /* Since @SECLEVEL also influces loading of certificates, set the
+    /* Since @SECLEVEL also influences loading of certificates, set the
      * cipher restrictions before loading certificates */
     tls_ctx_restrict_ciphers(new_ctx, options->cipher_list);
+    tls_ctx_restrict_ciphers_tls13(new_ctx, options->cipher_list_tls13);
 
     if (!tls_ctx_set_options(new_ctx, options->ssl_flags))
     {
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 5023c02a..0995bb4c 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -169,7 +169,8 @@ bool tls_ctx_initialised(struct tls_root_ctx *ctx);
 bool tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags);
 
 /**
- * Restrict the list of ciphers that can be used within the TLS context.
+ * Restrict the list of ciphers that can be used within the TLS context for TLS 1.2
+ * and below
  *
  * @param ctx           TLS context to restrict, must be valid.
  * @param ciphers       String containing : delimited cipher names, or NULL to use
@@ -177,6 +178,16 @@ bool tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags);
  */
 void tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers);
 
+/**
+ * Restrict the list of ciphers that can be used within the TLS context for TLS 1.3
+ * and higher
+ *
+ * @param ctx           TLS context to restrict, must be valid.
+ * @param ciphers       String containing : delimited cipher names, or NULL to use
+ *                                      sane defaults.
+ */
+void tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers);
+
 /**
  * Set the TLS certificate profile.  The profile defines which crypto
  * algorithms may be used in the supplied certificate.
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index e4850cb6..7c578a90 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -222,6 +222,18 @@ tls_translate_cipher_name(const char *cipher_name)
     return pair->iana_name;
 }
 
+void
+tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers)
+{
+  if (ciphers == NULL)
+  {
+    /* Nothing to do, return without warning message */
+    return;
+  }
+
+  msg(M_WARN, "mbed TLS does not support setting tls-ciphersuites. Ignoring TLS 1.3 cipher list: %s", ciphers);
+}
+
 void
 tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 {
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 51bb6843..e3fb097f 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -322,6 +322,105 @@ tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
     return true;
 }
 
+void
+convert_tls_list_to_openssl(char* openssl_ciphers, size_t len,const char *ciphers)
+{
+  /* Parse supplied cipher list and pass on to OpenSSL */
+  size_t begin_of_cipher, end_of_cipher;
+
+  const char *current_cipher;
+  size_t current_cipher_len;
+
+  const tls_cipher_name_pair *cipher_pair;
+
+  size_t openssl_ciphers_len = 0;
+  openssl_ciphers[0] = '\0';
+
+  /* Translate IANA cipher suite names to OpenSSL names */
+  begin_of_cipher = end_of_cipher = 0;
+  for (; begin_of_cipher < strlen(ciphers); begin_of_cipher = end_of_cipher)
+  {
+    end_of_cipher += strcspn(&ciphers[begin_of_cipher], ":");
+    cipher_pair = tls_get_cipher_name_pair(&ciphers[begin_of_cipher], end_of_cipher - begin_of_cipher);
+
+    if (NULL == cipher_pair)
+    {
+      /* No translation found, use original */
+      current_cipher = &ciphers[begin_of_cipher];
+      current_cipher_len = end_of_cipher - begin_of_cipher;
+
+      /* Issue warning on missing translation */
+      /* %.*s format specifier expects length of type int, so guarantee */
+      /* that length is small enough and cast to int. */
+      msg(D_LOW, "No valid translation found for TLS cipher '%.*s'",
+          constrain_int(current_cipher_len, 0, 256), current_cipher);
+    }
+    else
+    {
+      /* Use OpenSSL name */
+      current_cipher = cipher_pair->openssl_name;
+      current_cipher_len = strlen(current_cipher);
+
+      if (end_of_cipher - begin_of_cipher == current_cipher_len
+          && 0 != memcmp(&ciphers[begin_of_cipher], cipher_pair->iana_name,
+                         end_of_cipher - begin_of_cipher))
+      {
+        /* Non-IANA name used, show warning */
+        msg(M_WARN, "Deprecated TLS cipher name '%s', please use IANA name '%s'", cipher_pair->openssl_name, cipher_pair->iana_name);
+      }
+    }
+
+    /* Make sure new cipher name fits in cipher string */
+    if ((SIZE_MAX - openssl_ciphers_len) < current_cipher_len
+        || (len - 1) < (openssl_ciphers_len + current_cipher_len))
+    {
+      msg(M_FATAL,
+          "Failed to set restricted TLS cipher list, too long (>%d).",
+          (int)(len - 1));
+    }
+
+    /* Concatenate cipher name to OpenSSL cipher string */
+    memcpy(&openssl_ciphers[openssl_ciphers_len], current_cipher, current_cipher_len);
+    openssl_ciphers_len += current_cipher_len;
+    openssl_ciphers[openssl_ciphers_len] = ':';
+    openssl_ciphers_len++;
+
+    end_of_cipher++;
+  }
+
+  if (openssl_ciphers_len > 0)
+  {
+    openssl_ciphers[openssl_ciphers_len-1] = '\0';
+  }
+}
+
+void
+tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers)
+{
+  if (ciphers == NULL)
+  {
+    /* default cipher list of OpenSSL 1.1.1 is sane, do not set own own
+     * default as we do with tls-cipher */
+    return;
+  }
+
+#if (OPENSSL_VERSION_NUMBER < 0x1010100fL)
+  crypto_msg(M_WARN, "Not compiled with OpenSSL 1.1.1 or higher. "
+                     "Ignoring TLS 1.3 only tls-ciphersuites '%s' setting.",
+                      ciphers);
+#else
+  ASSERT(NULL != ctx);
+
+  char openssl_ciphers[4096];
+  convert_tls_list_to_openssl(openssl_ciphers, sizeof(openssl_ciphers), ciphers);
+
+  if (!SSL_CTX_set_ciphersuites(ctx->ctx, openssl_ciphers))
+  {
+    crypto_msg(M_FATAL, "Failed to set restricted TLS 1.3 cipher list: %s", openssl_ciphers);
+  }
+#endif
+}
+
 void
 tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 {
@@ -345,77 +444,11 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
         return;
     }
 
-    /* Parse supplied cipher list and pass on to OpenSSL */
-    size_t begin_of_cipher, end_of_cipher;
-
-    const char *current_cipher;
-    size_t current_cipher_len;
-
-    const tls_cipher_name_pair *cipher_pair;
-
     char openssl_ciphers[4096];
-    size_t openssl_ciphers_len = 0;
-    openssl_ciphers[0] = '\0';
+    convert_tls_list_to_openssl(openssl_ciphers, sizeof(openssl_ciphers), ciphers);
 
     ASSERT(NULL != ctx);
 
-    /* Translate IANA cipher suite names to OpenSSL names */
-    begin_of_cipher = end_of_cipher = 0;
-    for (; begin_of_cipher < strlen(ciphers); begin_of_cipher = end_of_cipher)
-    {
-        end_of_cipher += strcspn(&ciphers[begin_of_cipher], ":");
-        cipher_pair = tls_get_cipher_name_pair(&ciphers[begin_of_cipher], end_of_cipher - begin_of_cipher);
-
-        if (NULL == cipher_pair)
-        {
-            /* No translation found, use original */
-            current_cipher = &ciphers[begin_of_cipher];
-            current_cipher_len = end_of_cipher - begin_of_cipher;
-
-            /* Issue warning on missing translation */
-            /* %.*s format specifier expects length of type int, so guarantee */
-            /* that length is small enough and cast to int. */
-            msg(D_LOW, "No valid translation found for TLS cipher '%.*s'",
-                constrain_int(current_cipher_len, 0, 256), current_cipher);
-        }
-        else
-        {
-            /* Use OpenSSL name */
-            current_cipher = cipher_pair->openssl_name;
-            current_cipher_len = strlen(current_cipher);
-
-            if (end_of_cipher - begin_of_cipher == current_cipher_len
-                && 0 != memcmp(&ciphers[begin_of_cipher], cipher_pair->iana_name,
-                               end_of_cipher - begin_of_cipher))
-            {
-                /* Non-IANA name used, show warning */
-                msg(M_WARN, "Deprecated TLS cipher name '%s', please use IANA name '%s'", cipher_pair->openssl_name, cipher_pair->iana_name);
-            }
-        }
-
-        /* Make sure new cipher name fits in cipher string */
-        if ((SIZE_MAX - openssl_ciphers_len) < current_cipher_len
-            || ((sizeof(openssl_ciphers)-1) < openssl_ciphers_len + current_cipher_len))
-        {
-            msg(M_FATAL,
-                "Failed to set restricted TLS cipher list, too long (>%d).",
-                (int)sizeof(openssl_ciphers)-1);
-        }
-
-        /* Concatenate cipher name to OpenSSL cipher string */
-        memcpy(&openssl_ciphers[openssl_ciphers_len], current_cipher, current_cipher_len);
-        openssl_ciphers_len += current_cipher_len;
-        openssl_ciphers[openssl_ciphers_len] = ':';
-        openssl_ciphers_len++;
-
-        end_of_cipher++;
-    }
-
-    if (openssl_ciphers_len > 0)
-    {
-        openssl_ciphers[openssl_ciphers_len-1] = '\0';
-    }
-
     /* Set OpenSSL cipher list */
     if (!SSL_CTX_set_cipher_list(ctx->ctx, openssl_ciphers))
     {
-- 
2.19.0


