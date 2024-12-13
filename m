From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 13 Dec 2024 17:45:52 +0100
Message-Id: <20241213164552.265863-1-frank@...2641...>
In-Reply-To: <gerrit.1733989644000.I81d4bb0abdd421f5ba260c10c610918652334a4d@...2715...>
References: <gerrit.1733989644000.I81d4bb0abdd421f5ba260c10c610918652334a4d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dns: store IPv4 addresses in network
 byte order
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

From: Heiko Hund <heiko@...2662...>

This is done so that inet_ntop(3) can be used with IPv4 name server
addresses. It expects the binary address in network byte order. If they
are not that way the address octets are reversed.

Change-Id: I81d4bb0abdd421f5ba260c10c610918652334a4d
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/834
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 0539ca5..15e7322 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -121,7 +121,7 @@
     if (ai->ai_family == AF_INET)
     {
         struct sockaddr_in *sin = (struct sockaddr_in *)ai->ai_addr;
-        server->addr[server->addr_count].in.a4.s_addr = ntohl(sin->sin_addr.s_addr);
+        server->addr[server->addr_count].in.a4.s_addr = sin->sin_addr.s_addr;
     }
     else
     {
@@ -384,7 +384,7 @@
             if (s->addr[j].family == AF_INET)
             {
                 setenv_dns_option(es, "dns_server_%d_address_%d", i, j + 1,
-                                  print_in_addr_t(s->addr[j].in.a4.s_addr, 0, &gc));
+                                  print_in_addr_t(s->addr[j].in.a4.s_addr, IA_NET_ORDER, &gc));
             }
             else
             {
@@ -443,7 +443,7 @@
             const char *fmt_port;
             if (server->addr[j].family == AF_INET)
             {
-                addr = print_in_addr_t(server->addr[j].in.a4.s_addr, 0, &gc);
+                addr = print_in_addr_t(server->addr[j].in.a4.s_addr, IA_NET_ORDER, &gc);
                 fmt_port = "    address = %s:%s";
             }
             else

