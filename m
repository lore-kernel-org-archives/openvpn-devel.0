From: Vladislav Grishenko <themiron@...2010...>
Date: Tue, 28 Jul 2020 22:10:53 +0500
Message-Id: <20200728171053.15508-1-themiron@...2010...>
In-Reply-To: <20200727221341.22544-1-themiron@...2010...>
References: <20200727221341.22544-1-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH v2] Support x509 field list to be username
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

OpenVPN has the ability to choose different x509 field in case "CN"
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

With this patch, multiple x509 fields incl. "serialNumber" can be chosen
to be username as --x509-username-field space-separated parameters.
Multiple fields will be joined into one username using '/' delimeter for
consistency with CN/addr logging and preserving ability for hierarchical
ccd. As long as resulting username is unique, --duplicate-cn will not
be required. Default value is preserved as "CN" only.

Openssl backend is the only supported at the moment, since so far MbedTLS
has no alt user name support at all.

v2: conform C99, man update, fix typos

Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 doc/man-sections/tls-options.rst |  9 ++++--
 src/openvpn/init.c               |  4 +--
 src/openvpn/options.c            | 49 +++++++++++++++++---------------
 src/openvpn/options.h            |  4 +--
 src/openvpn/ssl.h                |  1 +
 src/openvpn/ssl_common.h         |  8 +++++-
 src/openvpn/ssl_verify.c         | 35 ++++++++++++++++-------
 src/openvpn/ssl_verify_openssl.c | 14 +++++++++
 8 files changed, 82 insertions(+), 42 deletions(-)

diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index 8c2db7cd..8449f5dc 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -632,13 +632,13 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
   options can be defined to track multiple attributes.
 
 --x509-username-field args
-  Field in the X.509 certificate subject to be used as the username
+  Field list in the X.509 certificate subject to be used as the username
   (default :code:`CN`).
 
   Valid syntax:
   ::
 
-     x509-username-field [ext:]fieldname
+     x509-username-field [ext:]fieldname [[ext:]fieldname...]
 
   Typically, this option is specified with **fieldname** as
   either of the following:
@@ -646,6 +646,7 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
 
      x509-username-field emailAddress
      x509-username-field ext:subjectAltName
+     x509-username-field CN serialNumber
 
   The first example uses the value of the :code:`emailAddress` attribute
   in the certificate's Subject field as the username. The second example
@@ -653,7 +654,9 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
   ``fieldname`` :code:`subjectAltName` be searched for an rfc822Name
   (email) field to be used as the username. In cases where there are
   multiple email addresses in :code:`ext:fieldname`, the last occurrence
-  is chosen.
+  is chosen. The last example uses the value of :code:`CN` attribute in
+  the Subject field and the certificate's :code:`serialNumber` field in
+  hex delimited by slash symbol as the resulting username.
 
   When this option is used, the ``--verify-x509-name`` option will match
   against the chosen ``fieldname`` instead of the Common Name.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1ea4735d..11b417a8 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2912,9 +2912,9 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.verify_hash = options->verify_hash;
     to.verify_hash_algo = options->verify_hash_algo;
 #ifdef ENABLE_X509ALTUSERNAME
-    to.x509_username_field = (char *) options->x509_username_field;
+    memmove(to.x509_username_field, options->x509_username_field, sizeof(to.x509_username_field));
 #else
-    to.x509_username_field = X509_USERNAME_FIELD_DEFAULT;
+    to.x509_username_field[0] = X509_USERNAME_FIELD_DEFAULT;
 #endif
     to.es = c->c2.es;
     to.net_ctx = &c->net_ctx;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index bc256b18..6fa17b3d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -877,7 +877,7 @@ init_options(struct options *o, const bool init_gc)
     o->tls_cert_profile = NULL;
     o->ecdh_curve = NULL;
 #ifdef ENABLE_X509ALTUSERNAME
-    o->x509_username_field = X509_USERNAME_FIELD_DEFAULT;
+    o->x509_username_field[0] = X509_USERNAME_FIELD_DEFAULT;
 #endif
 #ifdef ENABLE_PKCS11
     o->pkcs11_pin_cache_period = -1;
@@ -8434,41 +8434,44 @@ add_option(struct options *options,
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
index c5df2d18..e84aafec 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -582,8 +582,8 @@ struct options
     int handshake_window;
 
 #ifdef ENABLE_X509ALTUSERNAME
-    /* Field used to be the username in X509 cert. */
-    char *x509_username_field;
+    /* Field list used to be the username in X509 cert. */
+    char *x509_username_field[MAX_PARMS];
 #endif
 
     /* Old key allowed to live n seconds after new key goes active */
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 005628f6..51d6ab32 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -119,6 +119,7 @@
 
 /* Default field in X509 to be username */
 #define X509_USERNAME_FIELD_DEFAULT "CN"
+#define X509_USERNAME_FIELD_DELIMITER '/'
 
 #define KEY_METHOD_2  2
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 9f777750..a322b923 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -285,7 +285,13 @@ struct tls_options
     const char *remote_cert_eku;
     uint8_t *verify_hash;
     hash_algo_type verify_hash_algo;
-    char *x509_username_field;
+
+    /* Field list used to be the username in X509 cert. */
+#ifdef ENABLE_X509ALTUSERNAME
+    char *x509_username_field[MAX_PARMS];
+#else
+    char *x509_username_field[2];
+#endif
 
     /* allow openvpn config info to be
      * passed over control channel */
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 844bc57d..e53b1bd0 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -48,7 +48,7 @@
 #include "push.h"
 
 /** Maximum length of common name */
-#define TLS_USERNAME_LEN 64
+#define TLS_USERNAME_LEN 128
 
 static void
 string_mod_remap_name(char *str)
@@ -660,19 +660,32 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
     string_replace_leading(subject, '-', '_');
 
     /* extract the username (default is CN) */
-    if (SUCCESS != backend_x509_get_username(common_name, sizeof(common_name),
-                                             opt->x509_username_field, cert))
+    for (size_t i = 0, len = 0; opt->x509_username_field[i] != NULL; i++)
     {
-        if (!cert_depth)
+        char *buf = common_name + len;
+        int size = sizeof(common_name) - len - !!i;
+
+        if (size <= 0 ||
+            SUCCESS != backend_x509_get_username(buf + !!i, size,
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
+                    "subject string ('%s') -- note that the username length is "
+                    "limited to %d characters",
+                    opt->x509_username_field[i],
+                    subject,
+                    TLS_USERNAME_LEN);
+                goto cleanup;
+            }
+            break;
+        }
+        if (i != 0)
+        {
+            *buf = X509_USERNAME_FIELD_DELIMITER;
         }
+        len += strlen(buf);
     }
 
     /* enforce character class restrictions in common name */
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index ff14db23..11a72d3e 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -268,6 +268,20 @@ backend_x509_get_username(char *common_name, int cn_len,
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


