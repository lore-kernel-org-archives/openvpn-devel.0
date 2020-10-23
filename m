From: Arne Schwabe <arne@...1227...>
Date: Fri, 23 Oct 2020 13:34:28 +0200
Message-Id: <20201023113431.26691-2-arne@...1227...>
In-Reply-To: <20201023113431.26691-1-arne@...1227...>
References: <20201023113431.26691-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 2/5] xmit_hold is only required for
 port_share
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

Make options.c only set xmit_hold when port_share is active to least
document this dependency. I have not actually tested if this dependency
is actually true (or if port_share could work without xmit_hold).

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 034edba0..fdd9a6cc 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2908,12 +2908,15 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
         to.push_peer_info_detail = 0;
     }
 
+#ifdef ENABLE_PORT_SHARE
     /* should we not xmit any packets until we get an initial
      * response from client? */
-    if (to.server && options->ce.proto == PROTO_TCP_SERVER)
+    if (to.server && options->ce.proto == PROTO_TCP_SERVER
+        && options->port_share_host)
     {
         to.xmit_hold = true;
     }
+#endif
 
     to.disable_occ = !options->occ;
 
-- 
2.26.2


