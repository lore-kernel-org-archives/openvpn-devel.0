From: James Yonan <james@...515...>
Date: Thu,  3 Mar 2016 01:18:58 -0700
Message-Id: <1456993146-63968-2-git-send-email-james@...515...>
In-Reply-To: <1456993146-63968-1-git-send-email-james@...515...>
References: <1456993146-63968-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH 02/10] Added PIP_OPT_MASK for
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
 src/openvpn/forward.c | 8 +-------
 src/openvpn/forward.h | 4 +++-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 4a91f92..ef554fc 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1054,13 +1054,7 @@ process_ip_header (struct context *c, unsigned int flags, struct buffer *buf)
        * The --passtos and --mssfix options require
        * us to examine the IPv4 header.
        */
-
-      if (flags & (PIP_MSSFIX
-#if PASSTOS_CAPABILITY
-	  | PIPV4_PASSTOS
-#endif
-	  | PIPV4_CLIENT_NAT
-	  ))
+      if (flags & PIP_OPT_MASK)
 	{
 	  struct buffer ipbuf = *buf;
 	  if (is_ipv4 (TUNNEL_TYPE (c->c1.tuntap), &ipbuf))
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index af3b0a6..7debcb1 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -249,9 +249,11 @@ bool send_control_channel_string (struct context *c, const char *str, int msglev
 
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
1.9.1


