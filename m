From: Antonio Quartulli <a@...2181...>
Date: Sat, 17 Sep 2022 16:05:18 +0200
Message-Id: <20220917140518.2497-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Changes open vpn exit code defines
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
Cc: Alexandr Kutashov <kutashov.alexandr@...1411...>

From: Alexandr Kutashov <kutashov.alexandr@...1411...>

It's better to have distinct enums for more straightforward debug of exit function.

Signed-off-by: Alexandr Kutashov <kutashov.alexandr@...1411...>
---
 src/openvpn/error.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 89adb3e6..6289c0d8 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -58,8 +58,8 @@ struct gc_arena;
 
 #define OPENVPN_EXIT_STATUS_GOOD                    0
 #define OPENVPN_EXIT_STATUS_ERROR                   1
-#define OPENVPN_EXIT_STATUS_USAGE                   1
-#define OPENVPN_EXIT_STATUS_CANNOT_OPEN_DEBUG_FILE  1
+#define OPENVPN_EXIT_STATUS_USAGE                   2
+#define OPENVPN_EXIT_STATUS_CANNOT_OPEN_DEBUG_FILE  3
 
 /*
  * Special command line debugging mode.
-- 
2.35.1


