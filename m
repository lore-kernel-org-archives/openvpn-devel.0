From: Arne Schwabe <arne@...1227...>
Date: Fri, 17 Jul 2020 15:47:37 +0200
Message-Id: <20200717134739.21168-7-arne@...1227...>
In-Reply-To: <20200717134739.21168-1-arne@...1227...>
References: <20200717134739.21168-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 7/9] Avoid sending --cipher to clients not
 supporting NCP
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

The NCP rework introduced a regression of sending a --cipher
command as part of the push message when the client does not
support NCP. This is is more a cosmetic issue since the client
will log that as warning in the log and ignore it.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/push.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 2183b74a..1c4f2033 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -472,9 +472,15 @@ prepare_push_reply(struct context *c, struct gc_arena *gc,
 
     /*
      * Push the selected cipher, at this point the cipher has been
-     * already negotiated and been fixed
+     * already negotiated and been fixed.
+     *
+     * We avoid pushing the cipher to clients not supporting NCP
+     * to avoid error messages in their logs
      */
-    push_option_fmt(gc, push_list, M_USAGE, "cipher %s", o->ciphername);
+    if (tls_peer_supports_ncp(c->c2.tls_multi->peer_info))
+    {
+        push_option_fmt(gc, push_list, M_USAGE, "cipher %s", o->ciphername);
+    }
 
     return true;
 }
-- 
2.26.2


