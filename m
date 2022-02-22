From: Gert Doering <gert@...1296...>
Date: Tue, 22 Feb 2022 15:35:14 +0100
Message-Id: <20220222143514.3480-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Implement --mtu-disc for IPv6 UDP sockets.
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

Commit 4225114b96 repaired "--mtu-disc yes" brokenness for IPv4 UDP sockets
(caused by autoconf/ifdef issues).  This patch adds new functionality
to do --mtu-disc for IPv6 sockets as well.

Half of it (setsockopt(IPV6_MTU_DISCOVER)) was already there, but
receiving of detailed socket errors was missing the enablement of
setsockopt(IPV6_RECVERR) and parsing of IPPROTO_IPV6/IPV6_RECVERR
messages received.

With that, we now get (sending over a route with "mtu 1300"):

2022-02-22 15:28:07 write UDPv6 [EMSGSIZE Path-MTU=1300]: Message too long (fd=3,code=90)
2022-02-22 15:28:07 Note adjusting 'mssfix 1400 mtu' to 'mssfix 1300 mtu' according to path MTU discovery
2022-02-22 15:28:07 Note adjusting 'fragment 1400 mtu' to 'fragment 1300 mtu' according to path MTU discovery

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/mtu.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index aa810f1c..51eeaa64 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -352,6 +352,17 @@ format_extended_socket_error(int fd, int *mtu, struct gc_arena *gc)
                     buf_printf(&out,"CMSG=%d|", cmsg->cmsg_type);
                 }
             }
+            else if (cmsg->cmsg_level == IPPROTO_IPV6)
+            {
+                if (cmsg->cmsg_type == IPV6_RECVERR)
+                {
+                    e = (struct sock_extended_err *) CMSG_DATA(cmsg);
+                }
+                else
+                {
+                    buf_printf(&out,"CMSG=%d|", cmsg->cmsg_type);
+                }
+            }
         }
         if (e == NULL)
         {
@@ -405,11 +416,18 @@ void
 set_sock_extended_error_passing(int sd)
 {
     int on = 1;
-    if (setsockopt(sd, SOL_IP, IP_RECVERR, (void *) &on, sizeof(on)))
+    /* see "man 7 ip" (on Linux) */
+    if (setsockopt(sd, SOL_IP, IP_RECVERR, (void *) &on, sizeof(on)) != 0)
     {
         msg(M_WARN | M_ERRNO,
             "Note: enable extended error passing on TCP/UDP socket failed (IP_RECVERR)");
     }
+    /* see "man 7 ipv6" (on Linux) */
+    if (setsockopt(sd, IPPROTO_IPV6, IPV6_RECVERR, (void *) &on, sizeof(on)) != 0)
+    {
+        msg(M_WARN | M_ERRNO,
+            "Note: enable extended error passing on TCP/UDP socket failed (IPV6_RECVERR)");
+    }
 }
 
 #endif /* if EXTENDED_SOCKET_ERROR_CAPABILITY */
-- 
2.26.3


