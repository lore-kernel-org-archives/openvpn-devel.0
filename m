Message-ID: <tencent_C49D67EAA5678D180C293706A9469EFE8307@...1414...>
From: yatta <ytzhang01@...2752...>
Date: Fri, 20 Oct 2023 01:12:13 +0800
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] fix(ssl): init peer_id when init tls_multi
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
Cc: pushan <62173185+pushan01@...2243...>

From: pushan <62173185+pushan01@...2243...>

When openvpn run in UDP server mode, if ssl connections reach the max clients, the next connection would be failed in `multi_create_instance` and the half connection will be close in `multi_close_instance`, which may lead array `m->instances[0]`  covered unexpectedly and make the first connection  interrupt, this patch fix this problem by init `peer_id` with `MAX_PEER_ID` in `tils_multi_init`.
---
 src/openvpn/ssl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 5e6205cc..c4420b2e 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -64,6 +64,7 @@
 #include "dco.h"
 
 #include "memdbg.h"
+#include "openvpn.h"
 
 #ifdef MEASURE_TLS_HANDSHAKE_STATS
 
@@ -1312,6 +1313,7 @@ tls_multi_init(struct tls_options *tls_options)
     /* get command line derived options */
     ret->opt = *tls_options;
     ret->dco_peer_id = -1;
+    ret->peer_id = MAX_PEER_ID;
 
     return ret;
 }
-- 
2.37.1 (Apple Git-137.1)


