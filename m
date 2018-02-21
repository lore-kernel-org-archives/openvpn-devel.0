Resent-Message-ID: <20180221171750.GA5755@...2378...>
Resent-To: openvpn-devel@lists.sourceforge.net
From: selva.nair@...277...
Date: Wed, 21 Feb 2018 00:38:30 -0500
Message-Id: <1519191510-3826-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Adapt to RegGetValue brokenness in Windows 7
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

From: Selva Nair <selva.nair@...277...>

- RegGetValue with flags = RRF_RT_REG_SZ|RRF_RT_REG_EXPAND_SZ
  fails in Windows 7 with an "invalid parameter" error.
  Fix by using RRF_RT_REG_SZ alone.

Note: This is not a regression as in no released version did the
service support expandable strings (ones with embedded %FOO%) in
the registry. However, the GUI does expand such strings. The two
can be made consistent by explicitly expanding the strings -- that
is left for a future patch.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index 6c29f57..dc47666 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -59,7 +59,7 @@ openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...)
 static DWORD
 GetRegString(HKEY key, LPCTSTR value, LPTSTR data, DWORD size, LPCTSTR default_value)
 {
-    LONG status = RegGetValue(key, NULL, value, RRF_RT_REG_SZ|RRF_RT_REG_EXPAND_SZ,
+    LONG status = RegGetValue(key, NULL, value, RRF_RT_REG_SZ,
                               NULL, (LPBYTE) data, &size);
 
     if (status == ERROR_FILE_NOT_FOUND && default_value)
-- 
2.1.4


