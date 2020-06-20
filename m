From: Gert Doering <gert@...1296...>
Date: Sat, 20 Jun 2020 20:05:32 +0200
Message-Id: <20200620180532.15738-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Depreciation warning for --topology net30
 on servers with IPv4 pools.
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

IPv4 pool handling needs lots of extra code to deal with "topology net30",
so we want to remove that combination in a future release.

Warn people about this in 2.5 so nobody is hit by this as a surprise.

Client- and ifconfig-support for net30 will stay, as "just net30" is not
what brings maintenance effort here (totally removing all options except
"topology subnet" would be beneficial but is a bit too radical today)

Trac: #1288

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index fbfc287f..2cc579e7 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -359,6 +359,14 @@ helper_client_server(struct options *o)
             }
 
             push_option(o, print_opt_topology(topology, &o->gc), M_USAGE);
+
+            if (topology == TOP_NET30 && !(o->server_flags & SF_NOPOOL))
+            {
+                msg(M_WARN, "WARNING: --topology net30 support for server "
+                    "configs with IPv4 pools will be removed in a future "
+                    "release. Please migrate to --topology subnet as soon "
+                    "as possible.");
+            }
         }
         else if (dev == DEV_TYPE_TAP)
         {
-- 
2.26.2


