From: Gert Doering <gert@...1296...>
Date: Sat, 17 May 2025 10:32:23 +0200
Message-ID: <20250517083231.27977-1-gert@...1296...>
In-Reply-To: <gerrit.1747427153000.I104b4adeb9f65cce3487b82f35470174acba92bc@...2715...>
References: <gerrit.1747427153000.I104b4adeb9f65cce3487b82f35470174acba92bc@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dco_linux: fix peer stats parsing with
 new ovpn kernel module
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

The new ovpn kernel module has changed the netlink attribute
type of the fields containing the pkt/bytes counters in the
peer stats.

We moved from uint64 to uint (a dynamic type can be either
32 or 64 bits), therefore the parsing code must be adapted
accordingly.

While at it, also fix the peer object parsing in the P2P code
path.

The fix can be verified by enabling --status with verb 6 and
watching the counters increasing:

	2025-05-16 22:23:56 us=649488 dco_get_peer_stats_multi
	2025-05-16 22:23:56 us=651008 dco_parse_peer_multi: parsing message...
	2025-05-16 22:23:56 us=651734 dco_update_peer_stat / dco_read_bytes: 116280
	2025-05-16 22:23:56 us=652682 dco_update_peer_stat / dco_write_bytes: 115776
	2025-05-16 22:23:56 us=653467 dco_update_peer_stat / tun_read_bytes: 90048
	2025-05-16 22:23:56 us=654110 dco_update_peer_stat / tun_write_bytes: 90048

Change-Id: I104b4adeb9f65cce3487b82f35470174acba92bc
Closes: https://github.com/OpenVPN/openvpn/issues/746
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1025
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index a5f9e06..3f7965e 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -908,12 +908,26 @@
     return ovpn_nl_recvmsgs(dco, __func__);
 }
 
+/* libnl < 3.11.0 does not implement nla_get_uint() */
+static uint64_t
+ovpn_nla_get_uint(struct nlattr *attr)
+{
+    if (nla_len(attr) == sizeof(uint32_t))
+    {
+        return nla_get_u32(attr);
+    }
+    else
+    {
+        return nla_get_u64(attr);
+    }
+}
+
 static void
 dco_update_peer_stat(struct context_2 *c2, struct nlattr *tb[], uint32_t id)
 {
     if (tb[OVPN_A_PEER_LINK_RX_BYTES])
     {
-        c2->dco_read_bytes = nla_get_u64(tb[OVPN_A_PEER_LINK_RX_BYTES]);
+        c2->dco_read_bytes = ovpn_nla_get_uint(tb[OVPN_A_PEER_LINK_RX_BYTES]);
         msg(D_DCO_DEBUG, "%s / dco_read_bytes: " counter_format, __func__,
             c2->dco_read_bytes);
     }
@@ -925,7 +939,7 @@
 
     if (tb[OVPN_A_PEER_LINK_TX_BYTES])
     {
-        c2->dco_write_bytes = nla_get_u64(tb[OVPN_A_PEER_LINK_TX_BYTES]);
+        c2->dco_write_bytes = ovpn_nla_get_uint(tb[OVPN_A_PEER_LINK_TX_BYTES]);
         msg(D_DCO_DEBUG, "%s / dco_write_bytes: " counter_format, __func__,
             c2->dco_write_bytes);
     }
@@ -937,7 +951,7 @@
 
     if (tb[OVPN_A_PEER_VPN_RX_BYTES])
     {
-        c2->tun_read_bytes = nla_get_u64(tb[OVPN_A_PEER_VPN_RX_BYTES]);
+        c2->tun_read_bytes = ovpn_nla_get_uint(tb[OVPN_A_PEER_VPN_RX_BYTES]);
         msg(D_DCO_DEBUG, "%s / tun_read_bytes: " counter_format, __func__,
             c2->tun_read_bytes);
     }
@@ -949,7 +963,7 @@
 
     if (tb[OVPN_A_PEER_VPN_TX_BYTES])
     {
-        c2->tun_write_bytes = nla_get_u64(tb[OVPN_A_PEER_VPN_TX_BYTES]);
+        c2->tun_write_bytes = ovpn_nla_get_uint(tb[OVPN_A_PEER_VPN_TX_BYTES]);
         msg(D_DCO_DEBUG, "%s / tun_write_bytes: " counter_format, __func__,
             c2->tun_write_bytes);
     }
@@ -1028,12 +1042,12 @@
 dco_parse_peer(struct nl_msg *msg, void *arg)
 {
     struct context *c = arg;
-    struct nlattr *tb[OVPN_A_MAX];
+    struct nlattr *tb[OVPN_A_MAX + 1];
     struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
 
     msg(D_DCO_DEBUG, "%s: parsing message...", __func__);
 
-    nla_parse(tb, OVPN_A_PEER_MAX, genlmsg_attrdata(gnlh, 0),
+    nla_parse(tb, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),
               genlmsg_attrlen(gnlh, 0), NULL);
 
     if (!tb[OVPN_A_PEER])
@@ -1043,10 +1057,7 @@
     }
 
     struct nlattr *tb_peer[OVPN_A_PEER_MAX + 1];
-
-    nla_parse(tb_peer, OVPN_A_PEER,
-              nla_data(tb[OVPN_A_PEER]),
-              nla_len(tb[OVPN_A_PEER]), NULL);
+    nla_parse_nested(tb_peer, OVPN_A_PEER_MAX, tb[OVPN_A_PEER], NULL);
 
     if (!tb_peer[OVPN_A_PEER_ID])
     {

