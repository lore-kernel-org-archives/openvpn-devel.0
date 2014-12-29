From: Gert Doering <gert@...1296...>
Date: Mon, 29 Dec 2014 18:48:45 +0100
Message-Id: <1419875325-96015-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Print remote IPv4 address on a dual-stack
	v6 socket in IPv4 format
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

Previously, the code would print IPv4-mapped format ("::ffff:1.2.3.4"),
which is technically correct but adds no extra value, and is confusingly
different from the output if using a v4 socket.  Print "1.2.3.4" instead,
whatever socket type is used.

Affects client IP address in log file, status output (mroute_addr_print_ex),
and environment (setenv_sockaddr).

The fact that a dual-stack socket was used is still visible in the initial
peer connect message in the log:
  '... Peer Connection Initiated with [AF_INET6]::ffff:1.1.3.4:53779'

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/mroute.c | 12 ++++++++++--
 src/openvpn/socket.c | 16 +++++++++++++---
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index ba4ef46..972f1dd 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -426,8 +426,16 @@ mroute_addr_print_ex (const struct mroute_addr *ma,
 	  break;
 	case MR_ADDR_IPV6:
 	  {
-	    buf_printf (&out, "%s",
-		  print_in6_addr( *(struct in6_addr*)&maddr.addr, 0, gc)); 
+	    if ( IN6_IS_ADDR_V4MAPPED( (struct in6_addr*)&maddr.addr ) )
+	      {
+		buf_printf (&out, "%s",
+		     print_in_addr_t( *(in_addr_t*)(&maddr.addr[12]), IA_NET_ORDER, gc));
+	      }
+	    else
+	      {
+	        buf_printf (&out, "%s",
+		      print_in6_addr( *(struct in6_addr*)&maddr.addr, 0, gc));
+	      }
 	    if (maddr.type & MR_WITH_NETBITS)
 	      {
 		buf_printf (&out, "/%d", maddr.netbits);
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 331a9d9..f5c740d 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2573,9 +2573,19 @@ setenv_sockaddr (struct env_set *es, const char *name_prefix, const struct openv
 	}
       break;
     case AF_INET6:
-      openvpn_snprintf (name_buf, sizeof (name_buf), "%s_ip6", name_prefix);
-      getnameinfo(&addr->addr.sa, sizeof (struct sockaddr_in6),
-		  buf, sizeof(buf), NULL, 0, NI_NUMERICHOST);
+      if ( IN6_IS_ADDR_V4MAPPED( &addr->addr.in6.sin6_addr ))
+	{
+	  struct in_addr ia;
+	  ia.s_addr = *(in_addr_t *)&addr->addr.in6.sin6_addr.s6_addr[12] ;
+	  openvpn_snprintf (name_buf, sizeof (name_buf), "%s_ip", name_prefix);
+	  openvpn_snprintf (buf, sizeof(buf), "%s", inet_ntoa(ia) );
+	}
+      else
+        {
+	  openvpn_snprintf (name_buf, sizeof (name_buf), "%s_ip6", name_prefix);
+	  getnameinfo(&addr->addr.sa, sizeof (struct sockaddr_in6),
+		      buf, sizeof(buf), NULL, 0, NI_NUMERICHOST);
+	}
       setenv_str (es, name_buf, buf);
 
       if ((flags & SA_IP_PORT) && addr->addr.in6.sin6_port)
-- 
2.1.2


