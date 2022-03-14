From: Antonio Quartulli <a@...2181...>
Date: Mon, 14 Mar 2022 14:13:56 +0100
Message-Id: <20220314131356.11577-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] options: drop useless netmask variable
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

netmask is simply used to reflect the value of p[2], therefore
it can be dropped and p[2] can directly be used instead.

Reported-by: Gert Doering <gert@...1296...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/options.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7ce0ba61..7d7b8dc1 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7282,14 +7282,8 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "iroute") && p[1] && !p[3])
     {
-        const char *netmask = NULL;
-
         VERIFY_PERMISSION(OPT_P_INSTANCE);
-        if (p[2])
-        {
-            netmask = p[2];
-        }
-        option_iroute(options, p[1], netmask, msglevel);
+        option_iroute(options, p[1], p[2], msglevel);
     }
     else if (streq(p[0], "iroute-ipv6") && p[1] && !p[2])
     {
-- 
2.34.1


