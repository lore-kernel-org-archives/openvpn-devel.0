From: Vladislav Grishenko <themiron@...2010...>
Date: Sat, 12 Sep 2020 20:36:47 +0500
Message-Id: <20200912153647.10631-1-themiron@...2010...>
In-Reply-To: <20200816010913.1794-1-themiron@...2010...>
References: <20200816010913.1794-1-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH v4] Support X509 field list to be username
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

OpenVPN has the ability to choose different X509 field in case "CN"
can't be use used to be unique connected username since commit
935c62be9c0c8a256112df818bfb8470586a23b6.
Unfortunately it's not enough in case client has multiple and valid
certificates from PKI for different devices (ex. laptop, mobile, etc)
with the same CN/UID.

Having --duplicate-cn as a workaround helps only partially: clients can
be connected, but it breaks coexistance with --ifconfig-pool-persist,
--client-config-dir and opens doors to DoS possibility since same client
device (with the same cert) being reconnected no more replaces previously
connected session, so it can exhaust server resources (ex. address pool)
and can prevent other clients to be connected.

With this patch, multiple X509 fields incl. "serialNumber" can be chosen
to be username with --x509-username-field space-separated parameters.
Multiple fields will be concatened into one username using '_' delimeter.
As long as resulting username is unique, --duplicate-cn will not be
required. Default value is preserved as "CN" only.

Openssl backend is the only supported at the moment, since so far MbedTLS
has no --x509-username-field support at all.

v2: conform C99, man update, fix typos
v3: reuse buffer methods, drop delimiter define, use memcpy
v4: man update, change delimeter "_" to avoid path issues on windows

Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 doc/man-sections/tls-options.rst | 14 +++++----
 src/openvpn/init.c               |  6 ++--
 src/openvpn/options.c            | 49 +++++++++++++++++---------------
 src/openvpn/options.h            |  4 +--
 src/openvpn/ssl_common.h         |  2 +-
 src/openvpn/ssl_verify.c         | 49 +++++++++++++++++++++++++-------
 src/openvpn/ssl_verify_openssl.c | 14 +++++++++
 7 files changed, 93 insertions(+), 45 deletions(-)

diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index 8c2db7cd..a670578d 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -632,13 +632,14 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
   options can be defined to track multiple attributes.
 
 --x509-username-field args
-  Field in the X.509 certificate subject to be used as the username
-  (default :code:`CN`).
+  Fields in the X.509 certificate subject to be used as the username
+  (default :code:`CN`). If multiple fields are specified their values
+  will be concatenated with :code:`_` delimeter.
 
   Valid syntax:
   ::
 
-     x509-username-field [ext:]fieldname
+     x509-username-field [ext:]fieldname [[ext:]fieldname...]
 
   Typically, this option is specified with **fieldname** as
   either of the following:
@@ -646,6 +647,7 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
 
      x509-username-field emailAddress
      x509-username-field ext:subjectAltName
+     x509-username-field CN serialNumber
 
   The first example uses the value of the :code:`emailAddress` attribute
   in the certificate's Subject field as the username. The second example
@@ -653,13 +655,15 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
   ``fieldname`` :code:`subjectAltName` be searched for an rfc822Name
   (email) field to be used as the username. In cases where there are
   multiple email addresses in :code:`ext:fieldname`, the last occurrence
-  is chosen.
+  is chosen. The last example uses the value of :code:`CN` attribute in
+  the Subject field concatened with :code:`_` delimeter and with the
+  certificate's :code:`serialNumber` as the username.
 
   When this option is used, the ``--verify-x509-name`` option will match
   against the chosen ``fieldname`` instead of the Common Name.
 
   Only the :code:`subjectAltName` and :code:`issuerAltName` X.509
-  extensions are supported.
+  extensions and :code:`serialNumber` X.509 attribute are supported.
 
   **Please note:** This option has a feature which will convert an
   all-lowercase ``fieldname`` to uppercase characters, e.g.,
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a785934a..fb19fac3 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2905,14 +2905,14 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.crl_file_inline = options->crl_file_inline;
     to.ssl_flags = options->ssl_flags;
     to.ns_cert_type = options->ns_cert_type;
-    memmove(to.remote_cert_ku, options->remote_cert_ku, sizeof(to.remote_cert_ku));
+    memcpy(to.remote_cert_ku, options->remote_cert_ku, sizeof(to.remote_cert_ku));
     to.remote_cert_eku = options->remote_cert_eku;
     to.verify_hash = options->verify_hash;
     to.verify_hash_algo = options->verify_hash_algo;
 #ifdef ENABLE_X509ALTUSERNAME
-    to.x509_username_field = (char *) options->x509_username_field;
+    memcpy(to.x509_username_field, options->x509_username_field, sizeof(to.x509_username_field));
 #else
-    to.x509_username_field = X509_USERNAME_FIELD_DEFAULT;
+    to.x509_username_field[0] = X509_USERNAME_FIELD_DEFAULT;
 #endif
     to.es = c->c2.es;
     to.net_ctx = &c->net_ctx;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8bf82c57..f7e76d3e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -876,7 +876,7 @@ init_options(struct options *o, const bool init_gc)
     o->tls_cert_profile = NULL;
     o->ecdh_curve = NULL;
 #ifdef ENABLE_X509ALTUSERNAME
-    o->x509_username_field = X509_USERNAME_FIELD_DEFAULT;
+    o->x509_username_field[0] = X509_USERNAME_FIELD_DEFAULT;
 #endif
 #ifdef ENABLE_PKCS11
     o->pkcs11_pin_cache_period = -1;
@@ -8507,41 +8507,44 @@ add_option(struct options *options,
         x509_track_add(&options->x509_track, p[1], msglevel, &options->gc);
     }
 #ifdef ENABLE_X509ALTUSERNAME
-    else if (streq(p[0], "x509-username-field") && p[1] && !p[2])
+    else if (streq(p[0], "x509-username-field") && p[1])
     {
-        /* This option used to automatically upcase the fieldname passed as the
-         * option argument, e.g., "ou" became "OU". Now, this "helpfulness" is
+        /* This option used to automatically upcase the fieldnames passed as the
+         * option arguments, e.g., "ou" became "OU". Now, this "helpfulness" is
          * fine-tuned by only upcasing Subject field attribute names which consist
          * of all lower-case characters. Mixed-case attributes such as
          * "emailAddress" are left as-is. An option parameter having the "ext:"
          * prefix for matching X.509v3 extended fields will also remain unchanged.
          */
-        char *s = p[1];
-
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        if (strncmp("ext:", s, 4) != 0)
+        for (size_t j = 1; j < MAX_PARMS && p[j] != NULL; ++j)
         {
-            size_t i = 0;
-            while (s[i] && !isupper(s[i]))
-            {
-                i++;
-            }
-            if (strlen(s) == i)
+            char *s = p[j];
+
+            if (strncmp("ext:", s, 4) != 0)
             {
-                while ((*s = toupper(*s)) != '\0')
+                size_t i = 0;
+                while (s[i] && !isupper(s[i]))
+                {
+                    i++;
+                }
+                if (strlen(s) == i)
                 {
-                    s++;
+                    while ((*s = toupper(*s)) != '\0')
+                    {
+                        s++;
+                    }
+                    msg(M_WARN, "DEPRECATED FEATURE: automatically upcased the "
+                        "--x509-username-field parameter to '%s'; please update your"
+                        "configuration", p[j]);
                 }
-                msg(M_WARN, "DEPRECATED FEATURE: automatically upcased the "
-                    "--x509-username-field parameter to '%s'; please update your"
-                    "configuration", p[1]);
             }
+            else if (!x509_username_field_ext_supported(s+4))
+            {
+                msg(msglevel, "Unsupported x509-username-field extension: %s", s);
+            }
+            options->x509_username_field[j-1] = p[j];
         }
-        else if (!x509_username_field_ext_supported(s+4))
-        {
-            msg(msglevel, "Unsupported x509-username-field extension: %s", s);
-        }
-        options->x509_username_field = p[1];
     }
 #endif /* ENABLE_X509ALTUSERNAME */
 #ifdef ENABLE_PKCS11
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 877e9396..e527d70e 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -584,8 +584,8 @@ struct options
     int handshake_window;
 
 #ifdef ENABLE_X509ALTUSERNAME
-    /* Field used to be the username in X509 cert. */
-    char *x509_username_field;
+    /* Field list used to be the username in X509 cert. */
+    char *x509_username_field[MAX_PARMS];
 #endif
 
     /* Old key allowed to live n seconds after new key goes active */
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 96897e48..484bca49 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -284,7 +284,7 @@ struct tls_options
     const char *remote_cert_eku;
     uint8_t *verify_hash;
     hash_algo_type verify_hash_algo;
-    char *x509_username_field;
+    char *x509_username_field[MAX_PARMS];
 
     /* allow openvpn config info to be
      * passed over control channel */
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 97ccb93b..76260967 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -645,7 +645,6 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
 {
     result_t ret = FAILURE;
     char *subject = NULL;
-    char common_name[TLS_USERNAME_LEN+1] = {0}; /* null-terminated */
     const struct tls_options *opt;
     struct gc_arena gc = gc_new();
 
@@ -668,19 +667,47 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
     string_replace_leading(subject, '-', '_');
 
     /* extract the username (default is CN) */
-    if (SUCCESS != backend_x509_get_username(common_name, sizeof(common_name),
-                                             opt->x509_username_field, cert))
+    struct buffer buf = alloc_buf_gc(256, &gc);
+    for (int i = 0; opt->x509_username_field[i] != NULL; i++)
     {
-        if (!cert_depth)
+        char username[TLS_USERNAME_LEN+1] = {0}; /* null-terminated */
+
+        if (SUCCESS != backend_x509_get_username(username, sizeof(username),
+                                                 opt->x509_username_field[i], cert))
         {
-            msg(D_TLS_ERRORS, "VERIFY ERROR: could not extract %s from X509 "
-                "subject string ('%s') -- note that the username length is "
-                "limited to %d characters",
-                opt->x509_username_field,
-                subject,
-                TLS_USERNAME_LEN);
-            goto cleanup;
+            if (!cert_depth)
+            {
+                msg(D_TLS_ERRORS, "VERIFY ERROR: could not extract %s from X509 "
+                    "subject string ('%s') -- note that the field length is "
+                    "limited to %d characters",
+                    opt->x509_username_field[i],
+                    subject,
+                    TLS_USERNAME_LEN);
+                goto cleanup;
+            }
+            break;
         }
+        if (!buf_printf(&buf, i ? "_%s" : "%s", username))
+        {
+            if (!cert_depth)
+            {
+                msg(D_TLS_ERRORS, "VERIFY ERROR: could not append %s from X509 "
+                    "certificate -- note that the username length is "
+                    "limited to %d characters",
+                    opt->x509_username_field[i],
+                    buf.capacity - 1);
+                goto cleanup;
+            }
+            break;
+        }
+    }
+
+    char *common_name = BSTR(&buf);
+    if (!common_name)
+    {
+        msg(D_TLS_ERRORS, "VERIFY ERROR: depth=%d, could not extract X509 "
+            "username string from certificate", cert_depth);
+        goto cleanup;
     }
 
     /* enforce character class restrictions in common name */
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 454efeec..9fd3eb50 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -269,6 +269,20 @@ backend_x509_get_username(char *common_name, int cn_len,
             return FAILURE;
         }
     }
+    else if (strcmp(LN_serialNumber,x509_username_field) == 0)
+    {
+        ASN1_INTEGER *asn1_i = X509_get_serialNumber(peer_cert);
+        struct gc_arena gc = gc_new();
+        char *serial = format_hex_ex(asn1_i->data, asn1_i->length, 0, 1, NULL, &gc);
+
+        if (!serial || cn_len <= strlen(serial)+2)
+        {
+            gc_free(&gc);
+            return FAILURE;
+        }
+        openvpn_snprintf(common_name, cn_len, "0x%s", serial);
+        gc_free(&gc);
+    }
     else
 #endif
     if (FAILURE == extract_x509_field_ssl(X509_get_subject_name(peer_cert),
-- 
2.17.1


