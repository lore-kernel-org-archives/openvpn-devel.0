From: Antonio Quartulli <a@...2181...>
Date: Thu, 26 Apr 2018 03:57:22 +0800
Message-Id: <20180425195722.20744-9-a@...2181...>
In-Reply-To: <20180425195722.20744-1-a@...2181...>
References: <20180425195722.20744-1-a@...2181...>
Subject: [Openvpn-devel] [RFC 8/8] override ai_family if 'local' numeric
 address was specified
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
Cc: Antonio Quartulli <a@...2181...>

This change ensures that when a numeric IP address is specified
as argument to a 'local' directive, its ai_family overrides
the one extracted from the 'proto' config option.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/socket.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 9d961347..3dd44b83 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -378,9 +378,8 @@ openvpn_getaddrinfo(unsigned int flags,
         signal_received = &sigrec;
     }
 
-    /* try numeric ipv6 addr first */
+    /* try numeric ip addr first */
     CLEAR(hints);
-    hints.ai_family = ai_family;
     hints.ai_flags = AI_NUMERICHOST;
 
     if (flags & GETADDR_PASSIVE)
@@ -408,6 +407,10 @@ openvpn_getaddrinfo(unsigned int flags,
         const char *fmt;
         int level = 0;
 
+        /* this is not a numeric IP, therefore force resolution using the
+         * provided ai_family */
+        hints.ai_family = ai_family;
+
         if (hostname && (flags & GETADDR_RANDOMIZE))
         {
             hostname = hostname_randomize(hostname, &gc);
@@ -1599,6 +1602,10 @@ resolve_bind_local(struct link_socket *sock, const sa_family_t af)
                 sock->local_host, sock->local_port,
                 gai_strerror(status));
         }
+
+        /* the resolved 'local entry' might have a different family than what
+         * was globally configured */
+        sock->info.af = sock->info.lsa->bind_local->ai_family;
     }
 
     gc_free(&gc);
-- 
2.17.0


