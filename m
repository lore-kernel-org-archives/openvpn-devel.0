From: Arne Schwabe <arne@...1227...>
Date: Fri, 21 Mar 2014 14:18:45 +0100
Message-Id: <1395407925-25518-13-git-send-email-arne@...1227...>
In-Reply-To: <1395407925-25518-1-git-send-email-arne@...1227...>
References: <1395407925-25518-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 12/12] Fix client-nat only working is also
	mss-fix is specified.
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

Also make sure that with this fix compiling without ENABLE_CLIENT_NAT does not result in always checking the ip header
---
 src/openvpn/forward.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 0ec00f3..453ab3f 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1017,6 +1017,10 @@ process_ip_header (struct context *c, unsigned int flags, struct buffer *buf)
   if (!c->options.passtos)
     flags &= ~PIPV4_PASSTOS;
 #endif
+#ifdef ENABLE_CLIENT_NAT
+  if (!c->options.client_nat)
+    flags &= ~PIPV4_CLIENT_NAT;
+#endif
   if (!c->options.route_gateway_via_dhcp)
     flags &= ~PIPV4_EXTRACT_DHCP_ROUTER;
 
@@ -1026,11 +1030,14 @@ process_ip_header (struct context *c, unsigned int flags, struct buffer *buf)
        * The --passtos and --mssfix options require
        * us to examine the IPv4 header.
        */
+      if (flags & (PIP_MSSFIX|PIPV4_EXTRACT_DHCP_ROUTER
 #if PASSTOS_CAPABILITY
-      if (flags & (PIPV4_PASSTOS|PIP_MSSFIX))
-#else
-      if (flags & PIP_MSSFIX)
+                   | PIPV4_PASSTOS
+#endif
+#ifdef ENABLE_CLIENT_NAT
+                   | PIPV4_CLIENT_NAT
 #endif
+                   ))
 	{
 	  struct buffer ipbuf = *buf;
 	  if (is_ipv4 (TUNNEL_TYPE (c->c1.tuntap), &ipbuf))
-- 
1.8.5.2 (Apple Git-48)


