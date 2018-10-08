From: David Sommerseth <davids@...515...>
Date: Mon,  8 Oct 2018 19:56:48 +0300
Message-Id: <20181008165648.27504-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] build: Fix build warnings related to
 get_random()
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

This fixes this compile warning:

    platform.c: In function ‘platform_create_temp_file’:
    platform.c:355:31: warning: implicit declaration of function ‘get_random’ [-Wimplicit-function-declaration]
                                   prefix, (unsigned long) get_random(),

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 5ecccf1c..53d07f9c 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -30,6 +30,7 @@
 #include "syshead.h"
 
 #include "buffer.h"
+#include "crypto.h"
 #include "error.h"
 #include "misc.h"
 #include "win32.h"
-- 
2.17.1


