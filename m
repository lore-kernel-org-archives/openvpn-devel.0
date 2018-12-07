From: Gert Doering <gert@...1296...>
Date: Fri,  7 Dec 2018 13:33:03 +0100
Message-Id: <20181207123303.70827-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add 'printing of port number' to
 mroute_addr_print_ex() for v4-mapped v6.
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

For whatever reason, this function never printed port numbers for
IPv6 addresses (but it did for IPv4) - which creates a bit of
confusion for IPv6-mapped v4 addresses on a dual stack socket,
that will have ports numbers printed or not, depending on whether
it's a dual-stack v6 socket or single-stack v4.

This will not(!) add printing of port numbers for "proper" v6
addresses yet, because that might have adverse side effects to address
parsing elsewhere.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/mroute.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 28940a8d..134f4c00 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -477,6 +477,13 @@ mroute_addr_print_ex(const struct mroute_addr *ma,
                 {
                     buf_printf(&out, "%s", print_in_addr_t(maddr.v4mappedv6.addr,
                                                            IA_NET_ORDER, gc));
+		    /* we only print port numbers for v4mapped v6 as of
+		     * today, because "v6addr:port" is too ambiguous
+		     */
+                    if (maddr.type & MR_WITH_PORT)
+                    {
+                        buf_printf(&out, ":%d", ntohs(maddr.v6.port));
+                    }
                 }
                 else
                 {
-- 
2.19.1


