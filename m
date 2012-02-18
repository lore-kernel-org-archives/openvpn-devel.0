From: Heiko Hund <heiko.hund@...1489...>
Date: Sat, 18 Feb 2012 20:44:12 +0100
Message-Id: <1329594252-5257-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH] define access mode flag X_OK as 0 on Windows
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

The _access and _waccess functions in Windows don't know about
X_OK (1). If you pass an uneven mode flag the C runtime's default
invalid parameter handler ends execution of openvpn.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 win/config.h.in |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/win/config.h.in b/win/config.h.in
index b5c31b8..fcb8d6c 100644
--- a/win/config.h.in
+++ b/win/config.h.in
@@ -243,7 +243,7 @@ typedef unsigned long in_addr_t;
 #endif
 
 #ifndef X_OK
-#define X_OK 1
+#define X_OK 0
 #endif
 
 #ifndef F_OK
-- 
1.7.5.4


