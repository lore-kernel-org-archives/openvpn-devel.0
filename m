From: Ilya Shipitsin <chipitsine@...277...>
Date: Tue, 10 Jan 2017 13:18:07 +0500
Message-Id: <1484036287-12801-1-git-send-email-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH] resolving trivial issue found by clang
	static analyzer variable "ret" is assigned a value that is
	redefined later
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

details can be found here: https://delft.syzzer.nl/openvpn-scan-build/2017-01-10-000020-23912-1/report-856cea.html#EndPath
---
 src/openvpn/init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b2547f4..5b39929 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -266,7 +266,6 @@ ce_management_query_remote(struct context *c)
             management_event_loop_n_seconds(management, 1);
             if (IS_SIG(c))
             {
-                ret = false;
                 break;
             }
         }
-- 
2.5.5


