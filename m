From: Antonio Quartulli <a@...2181...>
Date: Sun, 18 Sep 2022 01:32:44 +0200
Message-Id: <20220917233244.13774-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] openssl: alternative names support for
 --verify-x509-name CN checks
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

From: Mateusz Markowicz <poniekad@...2282...>

When using "--verify-x509-name [hostname] subject-alt-name" hostname
will now be accepted also when matched against one of the
X509v3 Subject Alternative Name IP or DNS entries (instead of just
Subject's CN).

While at it, fix a few uncrustify complaints to allow committing this
change.

Signed-off-by: Mateusz Markowicz <poniekad@...2282...>
---
 doc/man-sections/tls-options.rst |  9 ++++---
 src/openvpn/options.c            |  4 +++
 src/openvpn/ssl_verify.c         | 46 ++++++++++++++++++--------------
 src/openvpn/ssl_verify.h         |  1 +
 src/openvpn/ssl_verify_backend.h |  8 ++++--
 src/openvpn/ssl_verify_mbedtls.c |  7 ++++-
 src/openvpn/ssl_verify_openssl.c | 16 +++++++----
 7 files changed, 59 insertions(+), 32 deletions(-)

diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index d51aff77..257c779a 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -647,10 +647,11 @@ If the option is inlined, ``algo`` is always :code:`SHA256`.
 
   Which X.509 name is compared to ``name`` depends on the setting of type.
   ``type`` can be :code:`subject` to match the complete subject DN
-  (default), :code:`name` to match a subject RDN or :code:`name-prefix` to
-  match a subject RDN prefix. Which RDN is verified as name depends on the
-  ``--x509-username-field`` option. But it defaults to the common name
-  (CN), e.g. a certificate with a subject DN
+  (default), :code:`name` to match a subject RDN, :code:`name-prefix` to
+  match a subject RDN prefix or :code:`subject-alt-name` to match the subject
+  SAN (or the CN if SAN is not specified). Which RDN is verified as name
+  depends on the ``--x509-username-field`` option. But it defaults to the
+  common name (CN), e.g. a certificate with a subject DN
   ::
 
      C=KG, ST=NA, L=Bishkek, CN=Server-1
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 76c09a0a..bde7ec98 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8894,6 +8894,10 @@ add_option(struct options *options,
             {
                 type = VERIFY_X509_SUBJECT_RDN_PREFIX;
             }
+            else if (streq(p[2], "subject-alt-name"))
+            {
+                type = VERIFY_X509_SAN;
+            }
             else
             {
                 msg(msglevel, "unknown X.509 name type: %s", p[2]);
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 45545c83..786d23ba 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -377,31 +377,37 @@ verify_peer_cert(const struct tls_options *opt, openvpn_x509_cert_t *peer_cert,
     /* verify X509 name or username against --verify-x509-[user]name */
     if (opt->verify_x509_type != VERIFY_X509_NONE)
     {
-        if ( (opt->verify_x509_type == VERIFY_X509_SUBJECT_DN
-              && strcmp(opt->verify_x509_name, subject) == 0)
-             || (opt->verify_x509_type == VERIFY_X509_SUBJECT_RDN
-                 && strcmp(opt->verify_x509_name, common_name) == 0)
-             || (opt->verify_x509_type == VERIFY_X509_SUBJECT_RDN_PREFIX
-                 && strncmp(opt->verify_x509_name, common_name,
-                            strlen(opt->verify_x509_name)) == 0) )
+        bool match;
+        if (opt->verify_x509_type == VERIFY_X509_SAN)
         {
-            msg(D_HANDSHAKE, "VERIFY X509NAME OK: %s", subject);
+            bool have_alt_names;
+            match = x509v3_is_host_in_alternative_names(peer_cert, opt->verify_x509_name,
+                                                        &have_alt_names);
+            if (!match && !have_alt_names)
+            {
+                match = (strcmp(opt->verify_x509_name, common_name) == 0);
+            }
         }
         else
         {
-            bool verfified_with_alt_names = opt->verify_x509_type == VERIFY_X509_SUBJECT_RDN &&
-                    x509v3_is_host_in_alternative_names(peer_cert, opt->verify_x509_name);
+            match = (opt->verify_x509_type == VERIFY_X509_SUBJECT_DN
+                     && strcmp(opt->verify_x509_name, subject) == 0)
+                    || (opt->verify_x509_type == VERIFY_X509_SUBJECT_RDN
+                        && strcmp(opt->verify_x509_name, common_name) == 0)
+                    || (opt->verify_x509_type == VERIFY_X509_SUBJECT_RDN_PREFIX
+                        && strncmp(opt->verify_x509_name, common_name,
+                                   strlen(opt->verify_x509_name)) == 0);
+        }
 
-            if (verfified_with_alt_names)
-            {
-                msg(D_HANDSHAKE, "VERIFY X509NAME OK (ALTERNATIVE): %s", opt->verify_x509_name);
-            }
-            else
-            {
-                msg(D_HANDSHAKE, "VERIFY X509NAME ERROR: %s, must be %s",
-                    subject, opt->verify_x509_name);
-                return FAILURE;             /* Reject connection */
-            }
+        if (match)
+        {
+            msg(D_HANDSHAKE, "VERIFY X509NAME OK: %s", opt->verify_x509_name);
+        }
+        else
+        {
+            msg(D_HANDSHAKE, "VERIFY X509NAME ERROR: %s, must be %s",
+                subject, opt->verify_x509_name);
+            return FAILURE;             /* Reject connection */
         }
     }
 
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 30dfc9bc..214243d8 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -64,6 +64,7 @@ struct cert_hash_set {
 #define VERIFY_X509_SUBJECT_DN          1
 #define VERIFY_X509_SUBJECT_RDN         2
 #define VERIFY_X509_SUBJECT_RDN_PREFIX  3
+#define VERIFY_X509_SAN                 4
 
 enum tls_auth_status
 {
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index 4e17e751..948daae2 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -269,8 +269,12 @@ result_t x509_write_pem(FILE *peercert_file, openvpn_x509_cert_t *peercert);
 bool tls_verify_crl_missing(const struct tls_options *opt);
 
 /**
- * Return true iff {host} was found in {cert} Subject Alternative Names DNS or IP entries.
+ * Return true iff {host} was found in {cert} Subject Alternative Names DNS or
+ * IP entries.
+ * If has_alt_names is not NULL it'll be set to true iff Subject Alternative
+ * Names were defined for cert.
  */
-bool x509v3_is_host_in_alternative_names(openvpn_x509_cert_t *cert, const char* host);
+bool x509v3_is_host_in_alternative_names(openvpn_x509_cert_t *cert,
+                                         const char *host, bool *has_alt_name);
 
 #endif /* SSL_VERIFY_BACKEND_H_ */
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 63e94b79..228e7fb6 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -263,9 +263,14 @@ x509_get_subject(mbedtls_x509_crt *cert, struct gc_arena *gc)
 }
 
 bool
-x509v3_is_host_in_alternative_names(mbedtls_x509_crt *cert, const char* host)
+x509v3_is_host_in_alternative_names(mbedtls_x509_crt *cert, const char *host,
+                                    bool *has_alt_names)
 {
     msg(M_WARN, "Missing support for subject alternative names in mbedtls.");
+    if (has_alt_names)
+    {
+        *has_alt_names = false;
+    }
     return false;
 }
 
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 3f3d99d0..3c6f629b 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -377,9 +377,14 @@ err:
 }
 
 bool
-x509v3_is_host_in_alternative_names(X509 *cert, const char* host)
+x509v3_is_host_in_alternative_names(X509 *cert, const char *host,
+                                    bool *has_alt_names)
 {
-    GENERAL_NAMES* altnames = X509_get_ext_d2i(cert, NID_subject_alt_name, NULL, NULL);
+    GENERAL_NAMES *altnames = X509_get_ext_d2i(cert, NID_subject_alt_name, NULL, NULL);
+    if (has_alt_names)
+    {
+        *has_alt_names = (altnames != NULL);
+    }
     if (altnames == NULL)
     {
         return false;
@@ -388,7 +393,7 @@ x509v3_is_host_in_alternative_names(X509 *cert, const char* host)
     int n = sk_GENERAL_NAME_num(altnames);
     for (int i = 0; i < n; i++)
     {
-        GENERAL_NAME* altname = sk_GENERAL_NAME_value(altnames, i);
+        GENERAL_NAME *altname = sk_GENERAL_NAME_value(altnames, i);
         ASN1_STRING *altname_asn1 = NULL;
         if (altname->type == GEN_DNS)
         {
@@ -401,8 +406,9 @@ x509v3_is_host_in_alternative_names(X509 *cert, const char* host)
 
         if (altname_asn1 != NULL)
         {
-            char* altname_cstr = NULL;
-            if (ASN1_STRING_to_UTF8((unsigned char **)&altname_cstr, altname_asn1) >= 0) {
+            char *altname_cstr = NULL;
+            if (ASN1_STRING_to_UTF8((unsigned char **)&altname_cstr, altname_asn1) >= 0)
+            {
                 bool match = strcmp(host, altname_cstr) == 0;
                 OPENSSL_free(altname_cstr);
                 if (match)
-- 
2.35.1


