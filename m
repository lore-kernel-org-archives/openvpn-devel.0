From: Arne Schwabe <arne@...1227...>
Date: Fri, 30 Nov 2012 20:17:55 +0100
Message-Id: <1354303076-13606-9-git-send-email-arne@...1227...>
In-Reply-To: <1354303076-13606-1-git-send-email-arne@...1227...>
References: <1354303076-13606-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 09/10] When resolving fails print the error
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
 src/openvpn/socket.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index b4d7ea7..7b4a4fb 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -186,15 +186,15 @@ openvpn_getaddrinfo (unsigned int flags,
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
 
-- 
1.7.9.5


