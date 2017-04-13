From: Steven McDonald <steven@...2262...>
Date: Fri, 14 Apr 2017 03:31:29 +1000
Message-Id: <20170413173129.87367-1-steven@...2262...>
Subject: [Openvpn-devel] [PATCH] Fix gateway detection with OpenBSD routing
	domains
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

When OpenVPN is started using a non-default routing table on OpenBSD
(e.g., with 'route -T10 exec openvpn ...'), it hangs forever trying to
read its default gateway from a PF_ROUTE socket. This is because
rtm_tableid is not being initialised after bzeroing the rt_msghdr we
write to the socket, so we end up asking the kernel for the default
route in routing table 0.

By default, the OpenBSD kernel will not respond to requests for routing
table 0 from a process running in a different routing table, and even
if it did, it would give us the wrong default gateway.

The solution here is to set rtm_tableid to the value returned by
getrtable(2), which always succeeds and returns the calling process's
current routing table.

This patch makes the test suite (without a t_client.rc) pass when run
in a non-default routing table, where it would fail previously. It has
also been successfully tested in client mode against both git master
and OpenVPN 2.4.1 from ports on an OpenBSD -current system.
---
 src/openvpn/route.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 08998d5f..33cdc0b0 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3597,6 +3597,9 @@ get_default_gateway(struct route_gateway_info *rgi)
     rtm.rtm_flags = RTF_UP | RTF_GATEWAY;
     rtm.rtm_version = RTM_VERSION;
     rtm.rtm_seq = ++seq;
+#ifdef TARGET_OPENBSD
+    rtm.rtm_tableid = getrtable();
+#endif
     rtm.rtm_addrs = rtm_addrs;
 
     so_dst.sa_family = AF_INET;
@@ -3812,6 +3815,9 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
     rtm.rtm_flags = RTF_UP;
     rtm.rtm_version = RTM_VERSION;
     rtm.rtm_seq = ++seq;
+#ifdef TARGET_OPENBSD
+    rtm.rtm_tableid = getrtable();
+#endif
 
     so_dst.sin6_family = AF_INET6;
     so_mask.sin6_family = AF_INET6;
-- 
2.12.2


