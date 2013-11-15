From: Gert Doering <gert@...1296...>
Date: Fri, 15 Nov 2013 15:41:57 +0100
Message-Id: <1384526517-6020-1-git-send-email-gert@...1296...>
In-Reply-To: <1382688143-17247-1-git-send-email-arne@...1227...>
References: <1382688143-17247-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix argument type warning introduced by
	http extra proxy header patch.
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

d0cb816cf8be68359617b61a55799f6330901f6a introduced add_proxy_headers(),
passing "port" as "const char *" - but it should be an "int".  As port
is not yet actually used inside add_proxy_headers(), it's just a warning.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/proxy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index ed4aedd..c3496e2 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -492,7 +492,7 @@ bool
 add_proxy_headers (struct http_proxy_info *p,
 		  socket_descriptor_t sd, /* already open to proxy */
 		  const char *host,	  /* openvpn server remote */
-		  const char *port	  /* openvpn server port */
+		  const int port	  /* openvpn server port */
 		  )
 {
   char buf[512];
-- 
1.8.1.5


