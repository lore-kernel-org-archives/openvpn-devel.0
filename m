From: James Yonan <james@...515...>
Date: Mon, 21 Apr 2014 01:10:02 -0600
Message-Id: <1398064204-26476-2-git-send-email-james@...515...>
In-Reply-To: <1398064204-26476-1-git-send-email-james@...515...>
References: <1398064204-26476-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH 2/4] Added PIP_OPT_MASK for
	process_ip_header fast exit path.
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
Cc: James Yonan <james@...515...>

Define PIP_OPT_MASK to represent all flags of interest to
process_ip_header, so that it can have a fast exit path
if no flags are set.

Merged from OpenVPN 2.1

Signed-off-by: James Yonan <james@...515...>
---
 src/openvpn/forward.c | 6 +-----
 src/openvpn/forward.h | 4 +++-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 0ec00f3..fbc58c7 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1026,11 +1026,7 @@ process_ip_header (struct context *c, unsigned int flags, struct buffer *buf)
        * The --passtos and --mssfix options require
        * us to examine the IPv4 header.
        */
-#if PASSTOS_CAPABILITY
-      if (flags & (PIPV4_PASSTOS|PIP_MSSFIX))
-#else
-      if (flags & PIP_MSSFIX)
-#endif
+      if (flags & PIP_OPT_MASK)
 	{
 	  struct buffer ipbuf = *buf;
 	  if (is_ipv4 (TUNNEL_TYPE (c->c1.tuntap), &ipbuf))
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 1830a00..0ece01e 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -229,9 +229,11 @@ bool send_control_channel_string (struct context *c, const char *str, int msglev
 
 #define PIPV4_PASSTOS         (1<<0)
 #define PIP_MSSFIX            (1<<1)         /* v4 and v6 */
-#define PIPV4_OUTGOING        (1<<2)
 #define PIPV4_EXTRACT_DHCP_ROUTER (1<<3)
 #define PIPV4_CLIENT_NAT      (1<<4)
+#define PIP_OPT_MASK          0xFFFF         /* all possible options for */
+                                             /* process_ip_header() */
+#define PIPV4_OUTGOING        (1<<16)
 
 void process_ip_header (struct context *c, unsigned int flags, struct buffer *buf);
 
-- 
1.8.5.5


