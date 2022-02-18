From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 18 Feb 2022 14:41:49 +0200
Message-Id: <20220218124149.149-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH master+release/2.5] error.c: use correct API
 to get error description on Windows
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

On Windows we use GetLastError() to get error code. To get
error description, we must use FormatMessage() and not strerror().

Replace strerror() with openvpn_strerror() macro, which is resolved
to strerror_win32() (which calls FormatMessage) on Windows and
to strerror() on other platforms.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/error.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 54796d03..cb2a0db1 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -268,7 +268,7 @@ x_msg_va(const unsigned int flags, const char *format, va_list arglist)
     if ((flags & M_ERRNO) && e)
     {
         openvpn_snprintf(m2, ERR_BUF_SIZE, "%s: %s (errno=%d)",
-                         m1, strerror(e), e);
+                         m1, openvpn_strerror(e, &gc), e);
         SWAP;
     }
 
-- 
2.23.0.windows.1


