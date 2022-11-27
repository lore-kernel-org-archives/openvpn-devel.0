From: Frank Lichtenheld <frank@...2641...>
Date: Sun, 27 Nov 2022 15:25:06 +0100
Message-Id: <20221127142506.41986-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] options: Always define
 options->management_flags
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

That makes it possible to remove several preprocessor
directives which is a good thing. The cost should be
negligible.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/manage.h  | 41 +++++++++++++++++++-------------------
 src/openvpn/options.c | 46 +++++++++++++------------------------------
 src/openvpn/options.h |  6 ++++--
 3 files changed, 39 insertions(+), 54 deletions(-)

I tried to make options.c less ugly. I didn't get far. But it still
might be an incremental improvement.

diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index f46274e6..16ac6847 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -24,6 +24,27 @@
 #ifndef MANAGE_H
 #define MANAGE_H
 
+/* management_open flags */
+#define MF_SERVER            (1<<0)
+#define MF_QUERY_PASSWORDS   (1<<1)
+#define MF_HOLD              (1<<2)
+#define MF_SIGNAL            (1<<3)
+#define MF_FORGET_DISCONNECT (1<<4)
+#define MF_CONNECT_AS_CLIENT (1<<5)
+#define MF_CLIENT_AUTH       (1<<6)
+/* #define MF_CLIENT_PF         (1<<7) *REMOVED FEATURE* */
+#define MF_UNIX_SOCK                (1<<8)
+#define MF_EXTERNAL_KEY             (1<<9)
+#define MF_EXTERNAL_KEY_NOPADDING   (1<<10)
+#define MF_EXTERNAL_KEY_PKCS1PAD    (1<<11)
+#define MF_UP_DOWN                  (1<<12)
+#define MF_QUERY_REMOTE             (1<<13)
+#define MF_QUERY_PROXY              (1<<14)
+#define MF_EXTERNAL_CERT            (1<<15)
+#define MF_EXTERNAL_KEY_PSSPAD      (1<<16)
+#define MF_EXTERNAL_KEY_DIGEST      (1<<17)
+
+
 #ifdef ENABLE_MANAGEMENT
 
 #include "misc.h"
@@ -321,26 +342,6 @@ struct user_pass;
 
 struct management *management_init(void);
 
-/* management_open flags */
-#define MF_SERVER            (1<<0)
-#define MF_QUERY_PASSWORDS   (1<<1)
-#define MF_HOLD              (1<<2)
-#define MF_SIGNAL            (1<<3)
-#define MF_FORGET_DISCONNECT (1<<4)
-#define MF_CONNECT_AS_CLIENT (1<<5)
-#define MF_CLIENT_AUTH       (1<<6)
-/* #define MF_CLIENT_PF         (1<<7) *REMOVED FEATURE* */
-#define MF_UNIX_SOCK                (1<<8)
-#define MF_EXTERNAL_KEY             (1<<9)
-#define MF_EXTERNAL_KEY_NOPADDING   (1<<10)
-#define MF_EXTERNAL_KEY_PKCS1PAD    (1<<11)
-#define MF_UP_DOWN                  (1<<12)
-#define MF_QUERY_REMOTE             (1<<13)
-#define MF_QUERY_PROXY              (1<<14)
-#define MF_EXTERNAL_CERT            (1<<15)
-#define MF_EXTERNAL_KEY_PSSPAD      (1<<16)
-#define MF_EXTERNAL_KEY_DIGEST      (1<<17)
-
 bool management_open(struct management *man,
                      const char *addr,
                      const char *port,
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b7b34c9c..5eca4a39 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1952,24 +1952,24 @@ show_settings(const struct options *o)
     SHOW_STR_INLINE(ca_file);
     SHOW_STR(ca_path);
     SHOW_STR_INLINE(dh_file);
-#ifdef ENABLE_MANAGEMENT
     if ((o->management_flags & MF_EXTERNAL_CERT))
     {
         SHOW_PARM("cert_file", "EXTERNAL_CERT", "%s");
     }
     else
-#endif
-    SHOW_STR_INLINE(cert_file);
+    {
+        SHOW_STR_INLINE(cert_file);
+    }
     SHOW_STR_INLINE(extra_certs_file);
 
-#ifdef ENABLE_MANAGEMENT
     if ((o->management_flags & MF_EXTERNAL_KEY))
     {
         SHOW_PARM("priv_key_file", "EXTERNAL_PRIVATE_KEY", "%s");
     }
     else
-#endif
-    SHOW_STR_INLINE(priv_key_file);
+    {
+        SHOW_STR_INLINE(priv_key_file);
+    }
 #ifndef ENABLE_CRYPTO_MBEDTLS
     SHOW_STR_INLINE(pkcs12_file);
 #endif
@@ -2425,7 +2425,7 @@ options_postprocess_verify_ce(const struct options *options,
 
 #endif /* ifdef ENABLE_MANAGEMENT */
 
-#if defined(ENABLE_MANAGEMENT) && !defined(HAVE_XKEY_PROVIDER)
+#if !defined(HAVE_XKEY_PROVIDER)
     if ((tls_version_max() >= TLS_VER_1_3)
         && (options->management_flags & MF_EXTERNAL_KEY)
         && !(options->management_flags & (MF_EXTERNAL_KEY_NOPADDING))
@@ -2846,7 +2846,6 @@ options_postprocess_verify_ce(const struct options *options,
             {
                 msg(M_USAGE, "Parameter --key cannot be used when --pkcs11-provider is also specified.");
             }
-#ifdef ENABLE_MANAGEMENT
             if (options->management_flags & MF_EXTERNAL_KEY)
             {
                 msg(M_USAGE, "Parameter --management-external-key cannot be used when --pkcs11-provider is also specified.");
@@ -2855,7 +2854,6 @@ options_postprocess_verify_ce(const struct options *options,
             {
                 msg(M_USAGE, "Parameter --management-external-cert cannot be used when --pkcs11-provider is also specified.");
             }
-#endif
             if (options->pkcs12_file)
             {
                 msg(M_USAGE, "Parameter --pkcs12 cannot be used when --pkcs11-provider is also specified.");
@@ -2869,7 +2867,6 @@ options_postprocess_verify_ce(const struct options *options,
         }
         else
 #endif /* ifdef ENABLE_PKCS11 */
-#ifdef ENABLE_MANAGEMENT
         if ((options->management_flags & MF_EXTERNAL_KEY) && options->priv_key_file)
         {
             msg(M_USAGE, "--key and --management-external-key are mutually exclusive");
@@ -2886,7 +2883,6 @@ options_postprocess_verify_ce(const struct options *options,
             }
         }
         else
-#endif
 #ifdef ENABLE_CRYPTOAPI
         if (options->cryptoapi_cert)
         {
@@ -2902,7 +2898,6 @@ options_postprocess_verify_ce(const struct options *options,
             {
                 msg(M_USAGE, "Parameter --pkcs12 cannot be used when --cryptoapicert is also specified.");
             }
-#ifdef ENABLE_MANAGEMENT
             if (options->management_flags & MF_EXTERNAL_KEY)
             {
                 msg(M_USAGE, "Parameter --management-external-key cannot be used when --cryptoapicert is also specified.");
@@ -2911,7 +2906,6 @@ options_postprocess_verify_ce(const struct options *options,
             {
                 msg(M_USAGE, "Parameter --management-external-cert cannot be used when --cryptoapicert is also specified.");
             }
-#endif
         }
         else
 #endif /* ifdef ENABLE_CRYPTOAPI */
@@ -2932,7 +2926,6 @@ options_postprocess_verify_ce(const struct options *options,
             {
                 msg(M_USAGE, "Parameter --key cannot be used when --pkcs12 is also specified.");
             }
-#ifdef ENABLE_MANAGEMENT
             if (options->management_flags & MF_EXTERNAL_KEY)
             {
                 msg(M_USAGE, "Parameter --management-external-key cannot be used when --pkcs12 is also specified.");
@@ -2941,7 +2934,6 @@ options_postprocess_verify_ce(const struct options *options,
             {
                 msg(M_USAGE, "Parameter --management-external-cert cannot be used when --pkcs12 is also specified.");
             }
-#endif
 #endif /* ifdef ENABLE_CRYPTO_MBEDTLS */
         }
         else
@@ -2956,12 +2948,8 @@ options_postprocess_verify_ce(const struct options *options,
             {
 
                 const int sum =
-#ifdef ENABLE_MANAGEMENT
                     ((options->cert_file != NULL) || (options->management_flags & MF_EXTERNAL_CERT))
-                    +((options->priv_key_file != NULL) || (options->management_flags & MF_EXTERNAL_KEY));
-#else
-                    (options->cert_file != NULL) + (options->priv_key_file != NULL);
-#endif
+                    + ((options->priv_key_file != NULL) || (options->management_flags & MF_EXTERNAL_KEY));
 
                 if (sum == 0)
                 {
@@ -2983,14 +2971,14 @@ options_postprocess_verify_ce(const struct options *options,
             }
             else
             {
-#ifdef ENABLE_MANAGEMENT
                 if (!(options->management_flags & MF_EXTERNAL_CERT))
-#endif
-                notnull(options->cert_file, "certificate file (--cert) or PKCS#12 file (--pkcs12)");
-#ifdef ENABLE_MANAGEMENT
+                {
+                    notnull(options->cert_file, "certificate file (--cert) or PKCS#12 file (--pkcs12)");
+                }
                 if (!(options->management_flags & MF_EXTERNAL_KEY))
-#endif
-                notnull(options->priv_key_file, "private key file (--key) or PKCS#12 file (--pkcs12)");
+                {
+                    notnull(options->priv_key_file, "private key file (--key) or PKCS#12 file (--pkcs12)");
+                }
             }
         }
         if (ce->tls_auth_file && ce->tls_crypt_file)
@@ -3999,9 +3987,7 @@ options_postprocess_filechecks(struct options *options)
                                      options->extra_certs_file, R_OK,
                                      "--extra-certs");
 
-#ifdef ENABLE_MANAGMENT
     if (!(options->management_flags & MF_EXTERNAL_KEY))
-#endif
     {
         errs |= check_file_access_inline(options->priv_key_file_inline,
                                          CHKACC_FILE|CHKACC_PRIVATE,
@@ -5627,9 +5613,7 @@ bool
 key_is_external(const struct options *options)
 {
     bool ret = false;
-#ifdef ENABLE_MANAGEMENT
     ret = ret || (options->management_flags & MF_EXTERNAL_KEY);
-#endif
 #ifdef ENABLE_PKCS11
     ret = ret || (options->pkcs11_providers[0] != NULL);
 #endif
@@ -5836,7 +5820,6 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->management_flags |= MF_CONNECT_AS_CLIENT;
     }
-#ifdef ENABLE_MANAGEMENT
     else if (streq(p[0], "management-external-key"))
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
@@ -5885,7 +5868,6 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->management_flags |= MF_CLIENT_AUTH;
     }
-#endif /* ifdef ENABLE_MANAGEMENT */
     else if (streq(p[0], "management-log-cache") && p[1] && !p[2])
     {
         int cache;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 68ad0cac..6f4b1f4a 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -438,10 +438,12 @@ struct options
     const char *management_client_user;
     const char *management_client_group;
 
-    /* Mask of MF_ values of manage.h */
-    unsigned int management_flags;
     const char *management_certificate;
 #endif
+    /* Mask of MF_ values of manage.h
+     * Always available to simplify options.c
+     */
+    unsigned int management_flags;
 
 #ifdef ENABLE_PLUGIN
     struct plugin_option_list *plugin_list;
-- 
2.34.1


