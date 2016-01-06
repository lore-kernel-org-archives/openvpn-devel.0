From: Steffan Karger <steffan@...1856...>
Date: Wed,  6 Jan 2016 21:03:59 +0100
Message-Id: <1452110639-18262-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] polarssl: optimize polar_ok() for non-errors
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

Adding polar_ok() was a good plan for improving error reporting, but also
added two function calls (one to polar_log_func_line() and one to
polar_log_err()) for each function call wrapped with polar_ok().
Especially in the critical path, this is a waste of time.

To avoid this overhead, add a simple check to the polar_ok() macro that
reduces it to a single branch.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto_polarssl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/crypto_polarssl.h b/src/openvpn/crypto_polarssl.h
index 92c2c30..e6db445 100644
--- a/src/openvpn/crypto_polarssl.h
+++ b/src/openvpn/crypto_polarssl.h
@@ -130,8 +130,8 @@ bool polar_log_func_line(unsigned int flags, int errval, const char *func,
  *
  * @returns true if no errors are detected, false otherwise.
  */
-#define polar_ok(errval) \
-  polar_log_func_line(D_CRYPT_ERRORS, errval, __func__, __LINE__)
+#define polar_ok(errval) ((0 == errval) || \
+  polar_log_func_line(D_CRYPT_ERRORS, errval, __func__, __LINE__))
 
 
 #endif /* CRYPTO_POLARSSL_H_ */
-- 
2.5.0


