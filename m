From: selva.nair@...277...
Date: Mon, 27 Mar 2023 13:12:36 -0400
Message-Id: <20230327171236.51771-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Bug-fix: segfault in dco_get_peer_stats()
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

From: Selva Nair <selva.nair@...277...>

  We persist peer-stats when restarting, but an early restart
  before open_tun results in a segfault in dco_get_peer_stats().
  To reproduce, trigger a TLS handshake error due to lack of common
  protocols, for example.

  Fix by checking  that tuntap is defined before dereferencing it.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
I'm not entirely sure this is the right place to fix this.
Or is it the caller at fault exercising  dco_get_peer_stats()
when tuntap is not set?

 src/openvpn/dco_linux.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 317f9dc0..41540c0f 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -975,6 +975,11 @@ dco_get_peer_stats(struct context *c)
     uint32_t peer_id = c->c2.tls_multi->dco_peer_id;
     msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);
 
+    if (!c->c1.tuntap)
+    {
+        return 0;
+    }
+
     dco_context_t *dco = &c->c1.tuntap->dco;
     struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_GET_PEER);
     struct nlattr *attr = nla_nest_start(nl_msg, OVPN_ATTR_GET_PEER);
-- 
2.34.1


