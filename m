From: Heiko Hund <heiko@...2662...>
Date: Fri, 27 May 2022 13:34:11 +0200
Message-Id: <20220527113411.1846837-1-heiko@...2662...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] include unistd.h for _exit(2) declaration
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

Signed-off-by: Heiko Hund <heiko@...2662...>
---
 src/openvpn/error.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 972619fe..76308560 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -33,6 +33,8 @@
 
 #if _WIN32
 #include <windows.h>
+#else
+#include <unistd.h>
 #endif
 
 /* #define ABORT_ON_ERROR */
-- 
2.32.0


