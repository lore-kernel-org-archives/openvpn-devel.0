From: Gert Doering <gert@...1296...>
Date: Sun, 22 Mar 2026 12:11:15 +0100
Message-ID: <20260322111131.8251-1-gert@...1296...>
In-Reply-To: <gerrit.1773754326000.I4adbdf0c8b82fd7de309aa5f6f3b0c8157c5ffe7@...2715...>
References: <gerrit.1773754326000.I4adbdf0c8b82fd7de309aa5f6f3b0c8157c5ffe7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Use openssl_err_t typedef to deal with
 difference between TLS libraries
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

From: Arne Schwabe <arne@...1227...>

AWS-LC and OpenSSL disagree on the type of that errors are reported in.

Instead of having a lot of glue code and casting back and forth, use a
typedef to always use the right type.

Change-Id: I4adbdf0c8b82fd7de309aa5f6f3b0c8157c5ffe7
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1578
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1578
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 19cb9a9..9900d06 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -229,7 +229,7 @@
 void
 crypto_print_openssl_errors(const unsigned int flags)
 {
-    unsigned long err = 0;
+    openssl_err_t err = 0;
     int line, errflags;
     const char *file, *data, *func;
 
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index ab011d3..8fdb39a 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -45,6 +45,15 @@
 #include <openssl/x509.h>
 #include <openssl/err.h>
 
+/* Define the type of error. This is something that is less
+ * intrusive than casts everywhere */
+#if defined(OPENSSL_IS_AWSLC)
+typedef uint32_t openssl_err_t;
+#else
+typedef unsigned long openssl_err_t;
+#endif
+
+
 /* Functionality missing in 1.1.0 */
 #if OPENSSL_VERSION_NUMBER < 0x10101000L && !defined(ENABLE_CRYPTO_WOLFSSL)
 #define SSL_CTX_set1_groups SSL_CTX_set1_curves
@@ -157,12 +166,12 @@
     /* OpenSSL 1.1.1 and lower use only const EVP_MD, nothing to free */
 }
 
-static inline unsigned long
+static inline openssl_err_t
 ERR_get_error_all(const char **file, int *line, const char **func, const char **data, int *flags)
 {
     static const char *empty = "";
     *func = empty;
-    unsigned long err = ERR_get_error_line_data(file, line, data, flags);
+    openssl_err_t err = ERR_get_error_line_data(file, line, data, flags);
     return err;
 }
 

