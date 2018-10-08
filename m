From: David Sommerseth <davids@...515...>
Date: Mon,  8 Oct 2018 21:00:17 +0300
Message-Id: <20181008180017.31413-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] build: Fix another compile warning in
 console_systemd.c
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

console_systemd.c: In function ‘get_console_input_systemd’:
console_systemd.c:75:5: warning: implicit declaration of function ‘openvpn_popen’ [-Wimplicit-function-declaration]
     if ((std_out = openvpn_popen(&argv, NULL)) < 0)

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/console_systemd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
index e7a72ae3..8d9e825b 100644
--- a/src/openvpn/console_systemd.c
+++ b/src/openvpn/console_systemd.c
@@ -33,6 +33,7 @@
 #include "syshead.h"
 #include "console.h"
 #include "misc.h"
+#include "run_command.h"
 
 #include <systemd/sd-daemon.h>
 
-- 
2.17.1


