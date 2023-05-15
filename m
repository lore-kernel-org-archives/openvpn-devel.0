From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 15 May 2023 16:21:16 +0200
Message-Id: <20230515142116.33135-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] DCO: fix memory leak in
 dco_get_peer_stats_multi for Linux
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

Leaks a small amount of memory every 15s.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/dco_linux.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 796e6f25..2bfdf980 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -925,7 +925,10 @@ dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
 
     nlmsg_hdr(nl_msg)->nlmsg_flags |= NLM_F_DUMP;
 
-    return ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer_multi, m, __func__);
+    int ret = ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer_multi, m, __func__);
+
+    nlmsg_free(nl_msg);
+    return ret;
 }
 
 static int
-- 
2.34.1


