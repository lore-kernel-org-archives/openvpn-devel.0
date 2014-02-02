From: James Yonan <james@...515...>
Date: Sat,  1 Feb 2014 20:30:57 -0700
Message-Id: <1391311857-13684-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH] MSVC 2013 C library now defines strtoull()
	function, so use the native implementation when available.
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
Cc: James Yonan <james@...515...>

---
 config-msvc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/config-msvc.h b/config-msvc.h
index 99c00f9..9a95ae6 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -89,7 +89,10 @@
 #define strncasecmp strnicmp
 #define strcasecmp _stricmp
 #define snprintf _snprintf
+
+#if _MSC_VER < 1800
 #define strtoull strtoul
+#endif
 
 #define in_addr_t uint32_t
 #define ssize_t SSIZE_T
-- 
1.8.5.3


