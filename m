From: <steffan.karger@...1435...>
Date: Thu, 7 Jan 2016 10:15:16 +0100
Message-ID: <1452158116-17363-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <20160107084439.GO24952@...1296...>
References: <20160107084439.GO24952@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] polarssl: optimize polar_ok() for
	non-errors
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

From: Steffan Karger <steffan.karger@...1435...>

Adding polar_ok() was a good plan for improving error reporting, but also
added two function calls (one to polar_log_func_line() and one to
polar_log_err()) for each function call wrapped with polar_ok().
Especially in the critical path, this is a waste of time.

To avoid this overhead, add a simple static inline wrapper to reduce it to
a single branch.

v2 - use a static inline wrapper to prevent evaluating 'errval' twice in
     the macro.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/crypto_polarssl.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/crypto_polarssl.h b/src/openvpn/crypto_polarssl.h
index bd0f8b8..94306ed 100644
--- a/src/openvpn/crypto_polarssl.h
+++ b/src/openvpn/crypto_polarssl.h
@@ -115,6 +115,15 @@ bool polar_log_err(unsigned int flags, int errval, const char *prefix);
 bool polar_log_func_line(unsigned int flags, int errval, const char *func,
     int line);
 
+/** Wraps polar_log_func_line() to prevent function calls for non-errors */
+static inline bool polar_log_func_line_lite(unsigned int flags, int errval,
+    const char *func, int line) {
+  if (errval) {
+    return polar_log_func_line (flags, errval, func, line);
+  }
+  return true;
+}
+
 /**
  * Check errval and log on error.
  *
@@ -128,7 +137,7 @@ bool polar_log_func_line(unsigned int flags, int errval, const char *func,
  * @returns true if no errors are detected, false otherwise.
  */
 #define polar_ok(errval) \
-  polar_log_func_line(D_CRYPT_ERRORS, errval, __func__, __LINE__)
+  polar_log_func_line_lite(D_CRYPT_ERRORS, errval, __func__, __LINE__)
 
 
 #endif /* CRYPTO_POLARSSL_H_ */
-- 
2.5.0


