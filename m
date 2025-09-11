From: Gert Doering <gert@...1296...>
Date: Thu, 11 Sep 2025 22:16:52 +0200
Message-ID: <20250911201658.25736-1-gert@...1296...>
In-Reply-To: <gerrit.1753360288000.I03e5ece7580ca4ebd41a7928ead544df46e8bad1@...2715...>
References: <gerrit.1753360288000.I03e5ece7580ca4ebd41a7928ead544df46e8bad1@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v9] ssl_common: Make sure ssl flags are
 treated as unsigned
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

From: Frank Lichtenheld <frank@...2641...>

tls_options.ssl_flags is already unsigned, make sure the
flags are as well to avoid spurious conversion warnings.

Also fix various warning regarding the use of the flags
for TLS version handling.

Change-Id: I03e5ece7580ca4ebd41a7928ead544df46e8bad1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: MaxF <max@...2606...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1104
This mail reflects revision 9 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@...2606...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 74946a4..7f86611 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2717,9 +2717,9 @@
                     "may accept clients which do not present a certificate");
     }
 
-    const int tls_version_max =
+    const unsigned int tls_version_max =
         (options->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) & SSLF_TLS_VERSION_MAX_MASK;
-    const int tls_version_min =
+    const unsigned int tls_version_min =
         (options->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) & SSLF_TLS_VERSION_MIN_MASK;
 
     if (tls_version_max > 0 && tls_version_max < tls_version_min)
@@ -3385,10 +3385,10 @@
 options_set_backwards_compatible_options(struct options *o)
 {
     /* TLS min version is not set */
-    int tls_ver_min = (o->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) & SSLF_TLS_VERSION_MIN_MASK;
+    unsigned int tls_ver_min = (o->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) & SSLF_TLS_VERSION_MIN_MASK;
     if (tls_ver_min == 0)
     {
-        int tls_ver_max = (o->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) & SSLF_TLS_VERSION_MAX_MASK;
+        unsigned int tls_ver_max = (o->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) & SSLF_TLS_VERSION_MAX_MASK;
         if (need_compatibility_before(o, 20307))
         {
             /* 2.3.6 and earlier have TLS 1.0 only, set minimum to TLS 1.0 */
@@ -9367,9 +9367,8 @@
     }
     else if (streq(p[0], "tls-version-min") && p[1] && !p[3])
     {
-        int ver;
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        ver = tls_version_parse(p[1], p[2]);
+        int ver = tls_version_parse(p[1], p[2]);
         if (ver == TLS_VER_BAD)
         {
             msg(msglevel, "unknown tls-version-min parameter: %s", p[1]);
@@ -9385,20 +9384,19 @@
 #endif
 
         options->ssl_flags &= ~(SSLF_TLS_VERSION_MIN_MASK << SSLF_TLS_VERSION_MIN_SHIFT);
-        options->ssl_flags |= (ver << SSLF_TLS_VERSION_MIN_SHIFT);
+        options->ssl_flags |= ((unsigned int)ver << SSLF_TLS_VERSION_MIN_SHIFT);
     }
     else if (streq(p[0], "tls-version-max") && p[1] && !p[2])
     {
-        int ver;
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        ver = tls_version_parse(p[1], NULL);
+        int ver = tls_version_parse(p[1], NULL);
         if (ver == TLS_VER_BAD)
         {
             msg(msglevel, "unknown tls-version-max parameter: %s", p[1]);
             goto err;
         }
         options->ssl_flags &= ~(SSLF_TLS_VERSION_MAX_MASK << SSLF_TLS_VERSION_MAX_SHIFT);
-        options->ssl_flags |= (ver << SSLF_TLS_VERSION_MAX_SHIFT);
+        options->ssl_flags |= ((unsigned int)ver << SSLF_TLS_VERSION_MAX_SHIFT);
     }
 #ifndef ENABLE_CRYPTO_MBEDTLS
     else if (streq(p[0], "pkcs12") && p[1] && !p[2])
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 428bf5a..a40f18d 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -421,17 +421,17 @@
 #endif
 
     /* configuration file SSL-related boolean and low-permutation options */
-#define SSLF_CLIENT_CERT_NOT_REQUIRED (1 << 0)
-#define SSLF_CLIENT_CERT_OPTIONAL     (1 << 1)
-#define SSLF_USERNAME_AS_COMMON_NAME  (1 << 2)
-#define SSLF_AUTH_USER_PASS_OPTIONAL  (1 << 3)
-#define SSLF_OPT_VERIFY               (1 << 4)
-#define SSLF_CRL_VERIFY_DIR           (1 << 5)
+#define SSLF_CLIENT_CERT_NOT_REQUIRED (1u << 0)
+#define SSLF_CLIENT_CERT_OPTIONAL     (1u << 1)
+#define SSLF_USERNAME_AS_COMMON_NAME  (1u << 2)
+#define SSLF_AUTH_USER_PASS_OPTIONAL  (1u << 3)
+#define SSLF_OPT_VERIFY               (1u << 4)
+#define SSLF_CRL_VERIFY_DIR           (1u << 5)
 #define SSLF_TLS_VERSION_MIN_SHIFT    6
-#define SSLF_TLS_VERSION_MIN_MASK     0xF /* (uses bit positions 6 to 9) */
+#define SSLF_TLS_VERSION_MIN_MASK     0xFu /* (uses bit positions 6 to 9) */
 #define SSLF_TLS_VERSION_MAX_SHIFT    10
-#define SSLF_TLS_VERSION_MAX_MASK     0xF /* (uses bit positions 10 to 13) */
-#define SSLF_TLS_DEBUG_ENABLED        (1 << 14)
+#define SSLF_TLS_VERSION_MAX_MASK     0xFu /* (uses bit positions 10 to 13) */
+#define SSLF_TLS_DEBUG_ENABLED        (1u << 14)
     unsigned int ssl_flags;
 
 #ifdef ENABLE_MANAGEMENT

