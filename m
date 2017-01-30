From: Antonio Quartulli <a@...2181...>
Date: Mon, 30 Jan 2017 23:26:58 +0800
Message-Id: <20170130152658.15786-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH] ignore remote-random-hostname if a numeric
	host is provided
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
Cc: Antonio Quartulli <a@...2181...>

Although it does not make sense to specify remote-random-hostname
when a numeric hostname is provided (being it the remote, the http
proxy or the socks server), this is still a valid configuration.

For this reason, this combination should still work as expected,
which means ignoring the randomization and directly using the
numeric IP.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/socket.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 82d0967d..58db96da 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -338,20 +338,6 @@ openvpn_getaddrinfo(unsigned int flags,
     ASSERT(hostname || servname);
     ASSERT(!(flags & GETADDR_HOST_ORDER));
 
-    if (hostname && (flags & GETADDR_RANDOMIZE))
-    {
-        hostname = hostname_randomize(hostname, &gc);
-    }
-
-    if (hostname)
-    {
-        print_hostname = hostname;
-    }
-    else
-    {
-        print_hostname = "undefined";
-    }
-
     if (servname)
     {
         print_servname = servname;
@@ -402,6 +388,20 @@ openvpn_getaddrinfo(unsigned int flags,
         const char *fmt;
         int level = 0;
 
+        if (hostname && (flags & GETADDR_RANDOMIZE))
+        {
+            hostname = hostname_randomize(hostname, &gc);
+        }
+
+        if (hostname)
+        {
+            print_hostname = hostname;
+        }
+        else
+        {
+            print_hostname = "undefined";
+        }
+
         fmt = "RESOLVE: Cannot resolve host address: %s:%s (%s)";
         if ((flags & GETADDR_MENTION_RESOLVE_RETRY)
             && !resolve_retry_seconds)
@@ -512,6 +512,10 @@ openvpn_getaddrinfo(unsigned int flags,
     else
     {
         /* IP address parse succeeded */
+        if (flags & GETADDR_RANDOMIZE)
+        {
+            msg(M_WARN, "WARNING: ignoring --remote-random-hostname because the hostname is an IP address");
+        }
     }
 
 done:
-- 
2.11.0


