From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 23 Oct 2018 17:51:28 +0300
Message-Id: <1540306288-23847-1-git-send-email-lstipakov@...277...>
In-Reply-To: <CAKuzo_ji71-1Td7XO38MUB3YhdPDYrHcy21XBiSj8L1YZsa2NA@...278...>
References: <CAKuzo_ji71-1Td7XO38MUB3YhdPDYrHcy21XBiSj8L1YZsa2NA@...278...>
Subject: [Openvpn-devel] [PATCH] Wrap openvpn_swprintf into Windows define
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

From: Lev Stipakov <lev@...515...>

Commit 43a5a4f3b4e411419639c195fee8a76495fdc88e added
vswprintf() call which turned to me missing in OpenBSD 4.9.

Since that call is inside openvpn_swprintf() function which
is only used by Windows, wrap that function info #ifdef _WIN32.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/buffer.c | 3 +++
 src/openvpn/buffer.h | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 8ca189f..acf76ae 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -310,6 +310,7 @@ openvpn_snprintf(char *str, size_t size, const char *format, ...)
     return (len >= 0 && len < size);
 }
 
+#ifdef _WIN32
 bool
 openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t *const format, ...)
 {
@@ -318,12 +319,14 @@ openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t *const for
     if (size > 0)
     {
         va_start(arglist, format);
+        /* vswprintf is missing in OpenBSD 4.2 */
         len = vswprintf(str, size, format, arglist);
         va_end(arglist);
         str[size - 1] = L'\0';
     }
     return (len >= 0 && len < size);
 }
+#endif
 
 /*
  * write a string to the end of a buffer that was
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index c5b78a0..c48c925 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -449,7 +449,11 @@ __attribute__ ((format(__printf__, 3, 4)))
 ;
 
 
+#ifdef _WIN32
 /*
+ * This is under #ifdef because only Windows-specific code
+ * uses this function and its implementation is broken in OpenBSD 4.9
+ *
  * Like swprintf but guarantees null termination for size > 0
  */
 bool
@@ -458,6 +462,7 @@ openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t *const for
  * Unlike in openvpn_snprintf, we cannot use format attributes since
  * GCC doesn't support wprintf as archetype.
  */
+#endif
 
 /*
  * remove/add trailing characters
-- 
2.7.4


