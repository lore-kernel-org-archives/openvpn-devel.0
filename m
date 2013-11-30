From: Gert Doering <gert@...1296...>
Date: Sat, 30 Nov 2013 22:38:28 +0100
Message-Id: <1385847508-32248-1-git-send-email-gert@...1296...>
In-Reply-To: <1385382680-5912-7-git-send-email-arne@...1227...>
References: <1385382680-5912-7-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix IPv6_V6ONLY logic.
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

The "ipv6only" setsockopt logic introduced by 8832c6c4cf was inverted,
fix.  Also add a msg() to show what value is set, as that makes strange
v4/v6 connectivity problems much easier to spot.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/socket.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 141af72..100eedd 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -908,8 +908,9 @@ socket_bind (socket_descriptor_t sd,
 
   if (ai_family == AF_INET6)
     {
-      int v6only = ipv6only ? 0: 1;	/* setsockopt must have an "int" */
+      int v6only = ipv6only ? 1: 0;	/* setsockopt must have an "int" */
 
+      msg (M_INFO, "setsockopt(IPV6_V6ONLY=%d)", v6only);
       if (setsockopt(sd, IPPROTO_IPV6, IPV6_V6ONLY, &v6only, sizeof(v6only)))
 	{
 	  msg (M_NONFATAL|M_ERRNO, "Setting IPV6_V6ONLY=%d failed", v6only);
-- 
1.8.1.5


