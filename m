From: Arne Schwabe <arne@...1227...>
Date: Wed,  1 Jul 2020 14:22:39 +0200
Message-Id: <20200701122239.6924-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Remove parameter config from
 multi_client_connect_mda
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

config is always used as mi->cc_config and we pass mi,
so directly use mi->cc_config

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 95b16744..19261c37 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1722,11 +1722,10 @@ multi_client_connect_post_plugin(struct multi_context *m,
 static void
 multi_client_connect_mda(struct multi_context *m,
                          struct multi_instance *mi,
-                         const struct buffer_list *config,
                          unsigned int option_permissions_mask,
                          unsigned int *option_types_found)
 {
-    if (config)
+    if (mi->cc_config)
     {
         struct buffer_entry *be;
 
@@ -1986,7 +1985,7 @@ script_failed:
 #ifdef MANAGEMENT_DEF_AUTH
         if (cc_succeeded && mi->cc_config)
         {
-            multi_client_connect_mda(m, mi, mi->cc_config, option_permissions_mask, &option_types_found);
+            multi_client_connect_mda(m, mi, option_permissions_mask, &option_types_found);
             ++cc_succeeded_count;
         }
 #endif
-- 
2.26.2


