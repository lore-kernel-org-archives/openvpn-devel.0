From: Gert Doering <gert@...1296...>
Date: Fri, 27 Dec 2024 17:17:55 +0100
Message-ID: <20241227161755.4010-1-gert@...1296...>
In-Reply-To: <gerrit.1727098847000.Ie2471e6b2d6974e70423b09918ad1c2136253754@...2715...>
References: <gerrit.1727098847000.Ie2471e6b2d6974e70423b09918ad1c2136253754@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v9] override ai_family if 'local' numeric
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

From: Antonio Quartulli <a@...2181...>

This change ensures that when a numeric IP address is specified
as argument to a 'local' directive, its ai_family overrides
the one extracted from the 'proto' config option.

Change-Id: Ie2471e6b2d6974e70423b09918ad1c2136253754
Signed-off-by: Antonio Quartulli <a@...2181...>
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/762
This mail reflects revision 9 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 7921433..b84521a 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -488,9 +488,8 @@
         sig_info = &sigrec;
     }
 
-    /* try numeric ipv6 addr first */
+    /* try numeric ip addr first */
     CLEAR(hints);
-    hints.ai_family = ai_family;
     hints.ai_flags = AI_NUMERICHOST;
 
     if (flags & GETADDR_PASSIVE)
@@ -507,6 +506,13 @@
         hints.ai_socktype = SOCK_STREAM;
     }
 
+    /* if hostname is not set, we want to bind to 'ANY', with
+     * the correct address family - v4-only or v6/v6-dual-stack */
+    if (!hostname)
+    {
+        hints.ai_family = ai_family;
+    }
+
     status = getaddrinfo(hostname, servname, &hints, res);
 
     if (status != 0) /* parse as numeric address failed? */
@@ -518,6 +524,10 @@
         const char *fmt;
         int level = 0;
 
+        /* this is not a numeric IP, therefore force resolution using the
+         * provided ai_family */
+        hints.ai_family = ai_family;
+
         if (hostname && (flags & GETADDR_RANDOMIZE))
         {
             hostname = hostname_randomize(hostname, &gc);
@@ -1716,6 +1726,10 @@
                 sock->local_host, sock->local_port,
                 gai_strerror(status));
         }
+
+        /* the resolved 'local entry' might have a different family than what
+         * was globally configured */
+        sock->info.af = sock->info.lsa->bind_local->ai_family;
     }
 
     gc_free(&gc);

