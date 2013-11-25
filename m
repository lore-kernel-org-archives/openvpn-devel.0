From: Arne Schwabe <arne@...1227...>
Date: Mon, 25 Nov 2013 13:31:16 +0100
Message-Id: <1385382680-5912-5-git-send-email-arne@...1227...>
In-Reply-To: <1385382680-5912-1-git-send-email-arne@...1227...>
References: <1385382680-5912-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [Patch v2 5/9] When resolving fails print the error
	message from socket layer
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

---
 src/openvpn/socket.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index c179818..cf6e8f4 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -187,15 +187,15 @@ openvpn_getaddrinfo (unsigned int flags,
       const char *fmt;
       int level = 0;
 
-      fmt = "RESOLVE: Cannot resolve host address: %s: %s";
+      fmt = "RESOLVE: Cannot resolve host address: %s:%s (%s)";
       if ((flags & GETADDR_MENTION_RESOLVE_RETRY)
           && !resolve_retry_seconds)
-        fmt = "RESOLVE: Cannot resolve host address: %s: %s (I would have retried this name query if you had specified the --resolv-retry option.)";
+        fmt = "RESOLVE: Cannot resolve host address: %s:%s (%s) (I would have retried this name query if you had specified the --resolv-retry option.)";
 
       if (!(flags & GETADDR_RESOLVE) || status == EAI_FAIL)
         {
-          msg (msglevel, "RESOLVE: Cannot parse IP address: %s:%s",
-               print_hostname,print_servname);
+          msg (msglevel, "RESOLVE: Cannot parse IP address: %s:%s (%s)",
+               print_hostname,print_servname, gai_strerror(status));
           goto done;
         }
 
@@ -1718,8 +1718,10 @@ phase2_socks_client (struct link_socket *sock, bool *remote_changed,
     sock->did_resolve_remote = false;
 
     addr_zero_host(&sock->info.lsa->actual.dest);
-    if (sock->info.lsa->remote_list)
+    if (sock->info.lsa->remote_list) {
       freeaddrinfo(sock->info.lsa->remote_list);
+      sock->info.lsa->remote_list=NULL;
+    }
 
     resolve_remote (sock, 1, NULL, signal_received);
 }
-- 
1.8.3.4 (Apple Git-47)


