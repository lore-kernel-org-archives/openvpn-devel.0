From: Gert Doering <gert@...1296...>
Date: Fri, 25 Sep 2015 08:36:10 +0200
Message-Id: <1443162970-38210-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Repair test_local_addr() on WIN32
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

Intermediate result was stored in a "bool" variable, but the actual
range of results is 0/1/2 - so "2" (TLA_LOCAL) never worked.  Change
to "int".

Diagnosed by "dferbas" in trac #609 (thanks).

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d45a02e..7baa3b6 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3600,7 +3600,7 @@ test_local_addr (const in_addr_t addr, const struct route_gateway_info *rgi)
 {
   struct gc_arena gc = gc_new ();
   const in_addr_t nonlocal_netmask = 0x80000000L; /* routes with netmask <= to this are considered non-local */
-  bool ret = TLA_NONLOCAL;
+  int ret = TLA_NONLOCAL;
 
   /* get full routing table */
   const MIB_IPFORWARDTABLE *rt = get_windows_routing_table (&gc);
-- 
2.4.6


