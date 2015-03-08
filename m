From: Steffan Karger <steffan@...1856...>
Date: Sun,  8 Mar 2015 11:20:04 +0100
Message-Id: <1425810005-11893-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 1/2] polarssl: add easy logging for PolarSSL
	errors
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Add the functions polar_log_err(), polar_log_func_line() and a macro
polar_ok(), to easily log human-readable PolarSSL errors from
polarssl-specific code.

This does not provide the full logging interface as msg(), because I
would have to add a lot more of macro-magic to achieve that on the
various supported compilers and platforms, and this suffices too (for
now at least).

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto_polarssl.c | 27 +++++++++++++++++++++++++++
 src/openvpn/crypto_polarssl.h | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index e083398..263b4dc 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -46,6 +46,7 @@
 #include "misc.h"
 
 #include <polarssl/des.h>
+#include <polarssl/error.h>
 #include <polarssl/md5.h>
 #include <polarssl/cipher.h>
 #include <polarssl/havege.h>
@@ -86,6 +87,32 @@ crypto_clear_error (void)
 {
 }
 
+bool polar_log_err(unsigned int flags, int errval, const char *prefix)
+{
+  if (0 != errval)
+    {
+      char errstr[256];
+      polarssl_strerror(errval, errstr, sizeof(errstr));
+
+      if (NULL == prefix) prefix = "PolarSSL error";
+      msg (flags, "%s: %s", prefix, errstr);
+    }
+
+  return 0 == errval;
+}
+
+bool polar_log_func_line(unsigned int flags, int errval, const char *func,
+    int line)
+{
+  char prefix[256];
+
+  if (!openvpn_snprintf(prefix, sizeof(prefix), "%s:%d", func, line))
+    return polar_log_err(flags, errval, func);
+
+  return polar_log_err(flags, errval, prefix);
+}
+
+
 #ifdef DMALLOC
 void
 crypto_init_dmalloc (void)
diff --git a/src/openvpn/crypto_polarssl.h b/src/openvpn/crypto_polarssl.h
index b6da436..bd0f8b8 100644
--- a/src/openvpn/crypto_polarssl.h
+++ b/src/openvpn/crypto_polarssl.h
@@ -91,4 +91,44 @@ ctr_drbg_context * rand_ctx_get();
 void rand_ctx_enable_prediction_resistance();
 #endif
 
+/**
+ * Log the supplied PolarSSL error, prefixed by supplied prefix.
+ *
+ * @param flags		Flags to indicate error type and priority.
+ * @param errval	PolarSSL error code to convert to error message.
+ * @param prefix	Prefix to PolarSSL error message.
+ *
+ * @returns true if no errors are detected, false otherwise.
+ */
+bool polar_log_err(unsigned int flags, int errval, const char *prefix);
+
+/**
+ * Log the supplied PolarSSL error, prefixed by function name and line number.
+ *
+ * @param flags		Flags to indicate error type and priority.
+ * @param errval	PolarSSL error code to convert to error message.
+ * @param func		Function name where error was reported.
+ * @param line		Line number where error was reported.
+ *
+ * @returns true if no errors are detected, false otherwise.
+ */
+bool polar_log_func_line(unsigned int flags, int errval, const char *func,
+    int line);
+
+/**
+ * Check errval and log on error.
+ *
+ * Convenience wrapper to put around polarssl library calls, e.g.
+ *   if (!polar_ok(polarssl_func())) return 0;
+ * or
+ *   ASSERT (polar_ok(polarssl_func()));
+ *
+ * @param errval	PolarSSL error code to convert to error message.
+ *
+ * @returns true if no errors are detected, false otherwise.
+ */
+#define polar_ok(errval) \
+  polar_log_func_line(D_CRYPT_ERRORS, errval, __func__, __LINE__)
+
+
 #endif /* CRYPTO_POLARSSL_H_ */
-- 
2.1.0


