From: Gert Doering <gert@...1296...>
Date: Wed, 15 Jul 2020 13:31:32 +0200
Message-Id: <20200715113132.22754-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix environment variables for p2mp-assigned
 IPv6 addresses.
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

commit a8f8b926718 introduces $ENV{ifconfig_pool_local_ip6} and
$ENV{ifconfig_pool_remote_ip6}, but instead of properly setting them,
the code overwrites the IPv4 variables, $ENV{ifconfig_pool_remote}
and $ENV{ifconfig_pool_local}.

Trivial fix.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/multi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index fe8fcd50..01da8c73 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1624,11 +1624,11 @@ multi_set_virtual_addr_env(struct multi_instance *mi)
     if (mi->context.c2.push_ifconfig_ipv6_defined)
     {
         setenv_in6_addr(mi->context.c2.es,
-                        "ifconfig_pool_remote",
+                        "ifconfig_pool_remote_ip6",
                         &mi->context.c2.push_ifconfig_ipv6_local,
                         SA_SET_IF_NONZERO);
         setenv_in6_addr(mi->context.c2.es,
-                        "ifconfig_pool_local",
+                        "ifconfig_pool_local_ip6",
                         &mi->context.c2.push_ifconfig_ipv6_remote,
                         SA_SET_IF_NONZERO);
         setenv_int(mi->context.c2.es,
-- 
2.26.2


