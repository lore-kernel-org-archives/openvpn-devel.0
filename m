From: Antonio Quartulli <a@...2181...>
Date: Thu,  7 Sep 2017 17:55:30 +0800
Message-Id: <20170907095530.15972-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH] tcp-server: ensure AF family is propagated
 to child context
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
Cc: Gert Doering <gert@...1296...>, Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

Commit 23d61c56 introduced the AF_UNSPEC socket family
to be used when we don't know the actual one until the local
socket binding is performed.

In such case AF_UNSPEC is stored in the `ce.af` member of
the `c->options` object, indicating that the family has to be
determined at runtime.

However, the determined value is never propagated back to the
`options` object, which remains AF_UNSPEC and that is
later used to initialize the TCP children contexts (UDP
children contexts are unaffected).

This unexpected setting can trigger weird behaviours, like
the one reported in ticket #933.
In this case the value AF_UNSPEC in combination with the
changes implemented in 2bed089d are leading to a TCP
server quitting with M_FATAL upon client connection.

Note that the misbehaviour described in #933 can only be
triggered when running a TCP server with mtu-disc set
in the config (no matter the value).

Fix this inconsistency by always propagating the AF
family from the top to the child context when running
in TCP server mode.

As a direct consequence, this patch fixes Trac #933.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 3d4f881e..0fc91f21 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1786,6 +1786,8 @@ link_socket_init_phase1(struct link_socket *sock,
         ASSERT(sock->info.proto == PROTO_TCP_SERVER);
         ASSERT(!sock->inetd);
         sock->sd = accept_from->sd;
+        /* inherit (possibly guessed) info AF from parent context */
+        sock->info.af = accept_from->info.af;
     }
 
     /* are we running in HTTP proxy mode? */
-- 
2.14.1


