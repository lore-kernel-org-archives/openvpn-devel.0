From: Steffan Karger <steffan@...1856...>
Date: Sat, 25 Oct 2014 22:35:22 +0200
Message-Id: <1414269324-14102-5-git-send-email-steffan@...1856...>
In-Reply-To: <1414269324-14102-1-git-send-email-steffan@...1856...>
References: <1414269324-14102-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 4/6] openssl: add crypto_msg(),
	to easily log openssl errors
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

This works towards removing OpenSSL-specific error printing code from
error.c. The crypto_msg() functions provide convenience wrappers, specific
to OpenSSL. Instead of passing the magical 'M_SSLERR' flag to msg(), a
developer now just calls crypto_msg() to get OpenSSL errors dumped to log.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto_openssl.c |  9 +++++++++
 src/openvpn/crypto_openssl.h | 25 +++++++++++++++++++++++++
 src/openvpn/error.h          |  6 ++++++
 3 files changed, 40 insertions(+)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 0ac89a1..25d8cf9 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -195,6 +195,15 @@ crypto_clear_error (void)
   ERR_clear_error ();
 }
 
+void
+crypto_print_openssl_errors(const unsigned int flags) {
+  size_t err = 0;
+
+  while ((err = ERR_get_error ()))
+    msg (flags, "OpenSSL: %s", ERR_error_string (err, NULL));
+}
+
+
 /*
  *
  * OpenSSL memory debugging.  If dmalloc debugging is enabled, tell
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index f883c2a..42c7e9a 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -70,4 +70,29 @@ typedef HMAC_CTX hmac_ctx_t;
 #define DES_KEY_LENGTH 8
 #define MD4_DIGEST_LENGTH 	16
 
+/**
+ * Retrieve any occurred OpenSSL errors and print those errors.
+ *
+ * Note that this function uses the not thread-safe OpenSSL error API.
+ *
+ * @param flags		Flags to indicate error type and priority.
+ */
+void crypto_print_openssl_errors(const unsigned int flags);
+
+/**
+ * Retrieve any OpenSSL errors, then print the supplied error message.
+ *
+ * This is just a convenience wrapper for often occurring situations.
+ *
+ * @param flags		Flags to indicate error type and priority.
+ * @param format	Format string to print.
+ * @param format args	(optional) arguments for the format string.
+ */
+# define crypto_msg(flags, ...) \
+do { \
+  crypto_print_openssl_errors(nonfatal(flags)); \
+  msg((flags), __VA_ARGS__); \
+} while (false)
+
+
 #endif /* CRYPTO_OPENSSL_H_ */
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 1e1f2ac..a977f51 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -354,6 +354,12 @@ ignore_sys_error (const int err)
   return false;
 }
 
+/** Convert fatal errors to nonfatal, don't touch other errors */
+static inline const unsigned int
+nonfatal(const unsigned int err) {
+  return err & M_FATAL ? (err ^ M_FATAL) | M_NONFATAL : err;
+}
+
 #include "errlevel.h"
 
 #endif
-- 
1.9.1


