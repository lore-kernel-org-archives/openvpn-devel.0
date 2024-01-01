From: Gert Doering <gert@...1296...>
Date: Mon,  1 Jan 2024 10:40:54 +0100
Message-ID: <20240101094054.38869-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] OpenBSD: repair --show-gateway
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

OpenBSD route sockets do not want to be passed RTA_IFP on RTM_GET
- if we do this, we get back EINVAL.

On other platforms, if we do not request RTA_IFP, we will not get
back interface information for queried routes - on OpenBSD, RTA_IFP
comes back always...

So we need to #ifdef this, RTA_IFP on all platforms except OpenBSD.

(Found this fix in OpenBSD's ports tree, in their patches for OpenVPN
2.6.8 - but they just remove RTA_IFP, no #ifdef, so we can't just apply
their patch)

While at it, add M_ERRNO to the "write to routing socket" error message.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index f75199c6..b05729f1 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3518,7 +3518,11 @@ get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
     /* setup data to send to routing socket */
     pid = getpid();
     seq = 0;
+#ifdef TARGET_OPENBSD
+    rtm_addrs = RTA_DST | RTA_NETMASK;		/* Kernel refuses RTA_IFP */
+#else
     rtm_addrs = RTA_DST | RTA_NETMASK | RTA_IFP;
+#endif
 
     bzero(&m_rtmsg, sizeof(m_rtmsg));
     bzero(&so_dst, sizeof(so_dst));
@@ -3556,7 +3560,7 @@ get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
     }
     if (write(sockfd, (char *)&m_rtmsg, l) < 0)
     {
-        msg(M_WARN, "GDG: problem writing to routing socket");
+        msg(M_WARN|M_ERRNO, "GDG: problem writing to routing socket");
         goto done;
     }
     do
@@ -3733,7 +3737,11 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
     /* setup data to send to routing socket */
     pid = getpid();
     seq = 0;
+#ifdef TARGET_OPENBSD
+    rtm_addrs = RTA_DST | RTA_NETMASK;		/* Kernel refuses RTA_IFP */
+#else
     rtm_addrs = RTA_DST | RTA_NETMASK | RTA_IFP;
+#endif
 
     bzero(&m_rtmsg, sizeof(m_rtmsg));
     bzero(&so_dst, sizeof(so_dst));
-- 
2.28.0


