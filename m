From: Steffan Karger <steffan@...1856...>
Date: Sun,  1 Jun 2014 19:58:56 +0200
Message-Id: <1401645536-27849-6-git-send-email-steffan@...1856...>
In-Reply-To: <1401645536-27849-1-git-send-email-steffan@...1856...>
References: <1401645536-27849-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 5/5] Remove unused variable 'proxy' from
	socket_restart_pause()
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

Variable 'proxy' was set but never read, so remove it.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/init.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 021b5ca..76b1bbe 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1860,18 +1860,8 @@ do_hold (struct context *c)
 static void
 socket_restart_pause (struct context *c)
 {
-  bool proxy = false;
   int sec = 2;
 
-#ifdef ENABLE_HTTP_PROXY
-  if (c->options.ce.http_proxy_options)
-    proxy = true;
-#endif
-#ifdef ENABLE_SOCKS
-  if (c->options.ce.socks_proxy_server)
-    proxy = true;
-#endif
-
   switch (c->options.ce.proto)
     {
     case PROTO_TCP_SERVER:
-- 
1.9.1


