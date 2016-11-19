From: Arne Schwabe <arne@...1227...>
Date: Sat, 19 Nov 2016 16:35:56 +0100
Message-Id: <1479569756-23302-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Remove compat-stdbool.h.
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

Since we use C99, we are guaranteed to have stdbool.h available
---
 src/compat/compat-stdbool.h | 12 ------------
 src/openvpn/syshead.h       |  2 +-
 2 files changed, 1 insertion(+), 13 deletions(-)
 delete mode 100644 src/compat/compat-stdbool.h

diff --git a/src/compat/compat-stdbool.h b/src/compat/compat-stdbool.h
deleted file mode 100644
index 9941218..0000000
--- a/src/compat/compat-stdbool.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef __COMPAT_STDBOOL_H
-#define __COMPAT_STDBOOL_H
-
-#ifdef HAVE_STDBOOL_H
-#include <stdbool.h>
-#else
-typedef int bool;
-#define false 0
-#define true 1
-#endif
-
-#endif
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 8de7d87..f5008b7 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -26,7 +26,7 @@
 #define SYSHEAD_H
 
 #include "compat.h"
-#include "compat-stdbool.h"
+#include <stdbool.h>
 
 /* branch prediction hints */
 #if defined(__GNUC__)
-- 
2.9.3 (Apple Git-75)


