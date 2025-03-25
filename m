From: Gert Doering <gert@...1296...>
Date: Tue, 25 Mar 2025 10:01:15 +0100
Message-ID: <20250325090121.28813-1-gert@...1296...>
In-Reply-To: <gerrit.1741816346000.I27f305d3ae9bf650bab409e99173688d9f88ab65@...2715...>
References: <gerrit.1741816346000.I27f305d3ae9bf650bab409e99173688d9f88ab65@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] socket: don't transfer bind family to
 socket in case of ANY address
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

From: Antonio Quartulli <antonio@...2726...>

With the introduction of multisocket, we need to transfer the
AI family of the bound address to the socket, as it may differ
from what was set globally.

However, this operation makes sense only when getaddrinfo()
for bind is performed on a non-empty hostname.
An empty hostname (ANY) may return AF_INET which will break
following connection attempts to v6 only remotes.

Change-Id: I27f305d3ae9bf650bab409e99173688d9f88ab65
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/907
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 6b32e30..be7395d 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1724,9 +1724,19 @@
                 gai_strerror(status));
         }
 
-        /* the resolved 'local entry' might have a different family than what
-         * was globally configured */
-        sock->info.af = sock->info.lsa->bind_local->ai_family;
+        /* the address family returned by openvpn_getaddrinfo() should be
+         * taken into consideration only if we really passed an hostname
+         * to resolve. Otherwise its value is not useful to us and may
+         * actually break our socket, i.e. when it returns AF_INET
+         * but our remote is v6 only.
+         */
+        if (sock->local_host)
+        {
+            /* the resolved 'local entry' might have a different family than
+             * what was globally configured
+             */
+            sock->info.af = sock->info.lsa->bind_local->ai_family;
+        }
     }
 
     gc_free(&gc);

