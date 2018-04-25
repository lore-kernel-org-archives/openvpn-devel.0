From: Antonio Quartulli <a@...2181...>
Date: Thu, 26 Apr 2018 03:57:20 +0800
Message-Id: <20180425195722.20744-7-a@...2181...>
In-Reply-To: <20180425195722.20744-1-a@...2181...>
References: <20180425195722.20744-1-a@...2181...>
Subject: [Openvpn-devel] [RFC 6/8] if a local IPv6 address is provided,
 socket must be v6-only
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

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/socket.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 84d828e6..79fbc6a8 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -988,9 +988,15 @@ bind_local(struct link_socket *sock, const sa_family_t ai_family)
         }
         else
         {
+            bool v6only = sock->info.bind_ipv6_only;
+
+            /* force binding IPv6-only if an address was specified
+             * an it is a IPv6 */
+            if (sock->local_host && ai_family == AF_INET6)
+                v6only = true;
+
             socket_bind(sock->sd, sock->info.lsa->bind_local,
-                        ai_family,
-                        "TCP/UDP", sock->info.bind_ipv6_only);
+                        ai_family, "TCP/UDP", v6only);
         }
     }
 }
-- 
2.17.0


