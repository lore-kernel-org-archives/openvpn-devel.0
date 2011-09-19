From: Davide Brini <dave_br@...1278...>
Date: Mon, 19 Sep 2011 19:19:01 +0200
Message-Id: <1316452741-4080-1-git-send-email-dave_br@...1278...>
Subject: [Openvpn-devel] [PATCH] When using multihome,
	create environment variables for target IP and interface on the
	server
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

Signed-off-by: Davide Brini <dave_br@...1278...>

This patch creates two new environment variables: "multihome_iface" and
"multihome_ip", which contain respectively the interface name and IP address
where the client connection came in, so scripts can use them.

Tested on IPv4, "works for me". The patch is against the master branch.

Besides the style issues or the errors that surely this patch contains, I have
some questions:

- Is this (ie, function link_socket_connection_initiated()) the right place to
  do it?

- Currently it uses the same variable names for IPv4 and IPv6; would using 
  multihome_ip and multihome_ip6 make more sense, for example? (I don't think
  so, but asking for confirmation)

- For consistency, I think it would be nice to set the same variables even
  when --multihome is not in effect. However, as it is now, OpenVPN explicitly
  checks for --multihome and if it's not set, it doesn't set the 
  IP_PKTINFO/IP_RECVDSTADDR option in the socket, so that information is not
  always available (hence the addr_defined_ipi() check is needed). Any reason
  why this is so? What would be the problem in always setting 
  IP_PKTINFO/IP_RECVDSTADDR (if supported by the platform, of course)?

- Again for consistency, the same variables could/should be set for TCP
  connections, however I have no idea where to look for that (I don't even 
  know whether link_socket_connection_initiated() is called at all when using
  TCP). Any suggestions?

Thanks.

---
 socket.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/socket.c b/socket.c
index a2f9511..e21294f 100644
--- a/socket.c
+++ b/socket.c
@@ -2112,6 +2112,74 @@ link_socket_connection_initiated (const struct buffer *buf,
   /* set environmental vars */
   setenv_str (es, "common_name", common_name);
 
+#if ENABLE_IP_PKTINFO
+  {
+    /* determine server's IP and interface where the connection came in,
+       and create corresponding environment variables  */
+
+    char ifname[IF_NAMESIZE];
+    int ok_ifindex = 1;     /* whether if_indextoname() succeeded */
+
+    if (addr_defined_ipi(act))
+      {
+        switch(act->dest.addr.sa.sa_family)
+          {
+          case AF_INET:
+              {
+                struct openvpn_sockaddr sa;
+                char v4addr[INET_ADDRSTRLEN];
+                CLEAR (sa);
+                CLEAR (v4addr);
+
+#ifdef IP_PKTINFO
+                sa.addr.in4.sin_addr = act->pi.in4.ipi_spec_dst;
+                if (!if_indextoname(act->pi.in4.ipi_ifindex, ifname))
+                  ok_ifindex = 0;
+
+#elif defined(IP_RECVDSTADDR)
+                sa.addr.in4.sin_addr = act->pi.in4;
+                ifname[0] = 0;
+
+#else
+#error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix syshead.h)
+#endif
+
+                if (ok_ifindex)
+                  setenv_str (es, "multihome_iface", ifname);
+                else
+                  msg (M_WARN, "WARNING: if_indextoname() failed for index %d: %s", act->pi.in4.ipi_ifindex, strerror(errno));
+
+                if (inet_ntop(AF_INET, &(sa.addr.in4.sin_addr), v4addr, INET_ADDRSTRLEN))
+                  setenv_str (es, "multihome_ip", v4addr);
+                else
+                  msg (M_WARN, "WARNING: inet_ntop() failed when converting address: %s", strerror(errno));
+
+              }
+            break;
+          case AF_INET6:
+              {
+                struct sockaddr_in6 sin6;
+                char v6addr[INET6_ADDRSTRLEN];
+                CLEAR(sin6);
+                CLEAR(v6addr);
+                sin6.sin6_addr = act->pi.in6.ipi6_addr;
+
+                if (if_indextoname(act->pi.in6.ipi6_ifindex, ifname))
+                  setenv_str (es, "multihome_iface", ifname);
+                else
+                  msg (M_WARN, "WARNING: if_indextoname() failed for index %d: %s", act->pi.in6.ipi6_ifindex, strerror(errno));
+
+                if (inet_ntop(AF_INET6, &(sin6.sin6_addr), v6addr, INET6_ADDRSTRLEN))
+                  setenv_str (es, "multihome_ip", v6addr);
+                else
+                  msg (M_WARN, "WARNING: inet_ntop() failed wen converting address: %s", strerror(errno));
+              }
+            break;
+          }
+      }
+  }
+#endif
+
   /* Process --ipchange plugin */
   if (plugin_defined (info->plugins, OPENVPN_PLUGIN_IPCHANGE))
     {
-- 
1.7.5.4


