From: Gert Doering <gert@...1296...>
Date: Sat, 28 Nov 2015 20:58:37 +0100
Message-Id: <1448740717-60914-1-git-send-email-gert@...1296...>
In-Reply-To: <1448456220-2042-1-git-send-email-heiko.hund@...1489...>
References: <1448456220-2042-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH] Un-break compilation on *BSD
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

Commit 2191c47165 introduced code to handle IP address query on
multihoming hosts for IP_PKTINFO-supporting OSes, but all the BSDs
need the "#elsif IP_RECVDSTADDR" variant... add code equivalent
to what we have in socket.c/print_link_socket_actual_ex()

Tested on FreeBSD 9.3/sparc64

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 5c17087..179c7ef 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1293,7 +1293,11 @@ initialization_sequence_completed (struct context *c, const unsigned int flags)
           switch (local.addr.sa.sa_family)
             {
             case AF_INET:
+#ifdef IP_PKTINFO
               local.addr.in4.sin_addr = actual->pi.in4.ipi_spec_dst;
+#else
+              local.addr.in4.sin_addr = actual->pi.in4;
+#endif
               break;
             case AF_INET6:
               local.addr.in6.sin6_addr = actual->pi.in6.ipi6_addr;
-- 
2.6.2


