From: Antonio Quartulli <a@...2181...>
Date: Wed, 10 Jun 2020 11:01:00 +0200
Message-Id: <20200610090100.29738-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] pool: remove useless 'options.h' include
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
Cc: Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>

Commit 6a8cd033 ("pool: add support for ifconfig-pool-persist with IPv6
only") has accidentally introduced an include for 'options.h', which
revealed to not be useful at all. Remove it.

Reported-by: Gert Doering <gert@...1296...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/pool.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 68fa4782..370f6af7 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -34,7 +34,6 @@
 #include "error.h"
 #include "socket.h"
 #include "otime.h"
-#include "options.h"
 
 #include "memdbg.h"
 
-- 
2.27.0


