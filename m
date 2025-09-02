From: Gert Doering <gert@...1296...>
Date: Tue,  2 Sep 2025 13:59:49 +0200
Message-ID: <20250902115954.29021-1-gert@...1296...>
In-Reply-To: <gerrit.1756305807000.I84a73d625c79d6a6a19122e48c91960dbe01ec49@...2715...>
References: <gerrit.1756305807000.I84a73d625c79d6a6a19122e48c91960dbe01ec49@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dco: avoid printing mi prefix on float
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

From: Gianmarco De Gregori <gianmarco@...2726...>

On float, a new prefix is generated which leads
to a mismatch between the current and previous
peer-id being logged. To avoid this, the
M_NOIPREFIX flag is now used along with msglevel.

Change-Id: I84a73d625c79d6a6a19122e48c91960dbe01ec49
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1158
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index a3907fe..6115d51 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -548,7 +548,7 @@
 int
 dco_del_peer(dco_context_t *dco, unsigned int peerid)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: peer-id %d", __func__, peerid);
 
     struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_DEL);
     if (!nl_msg)
@@ -868,7 +868,7 @@
     uint32_t peer_id = nla_get_u32(tb_peer[OVPN_A_PEER_ID]);
     struct context_2 *c2;
 
-    msg(D_DCO_DEBUG, "%s: parsing message for peer %u...", __func__, peer_id);
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: parsing message for peer %u...", __func__, peer_id);
 
     if (dco->ifmode == OVPN_MODE_P2P)
     {
@@ -890,7 +890,7 @@
         struct multi_instance *mi = dco->c->multi->instances[peer_id];
         if (!mi)
         {
-            msg(M_WARN, "%s: received data for a non-existing peer %u", __func__, peer_id);
+            msg(M_WARN | M_NOIPREFIX, "%s: received data for a non-existing peer %u", __func__, peer_id);
             return NL_SKIP;
         }
 
@@ -934,32 +934,32 @@
 
     if (!attrs[OVPN_A_PEER])
     {
-        msg(D_DCO, "ovpn-dco: no peer in PEER_DEL_NTF message");
+        msg(D_DCO | M_NOIPREFIX, "ovpn-dco: no peer in PEER_DEL_NTF message");
         return NL_STOP;
     }
 
     struct nlattr *dp_attrs[OVPN_A_PEER_MAX + 1];
     if (nla_parse_nested(dp_attrs, OVPN_A_PEER_MAX, attrs[OVPN_A_PEER], NULL))
     {
-        msg(D_DCO, "ovpn-dco: can't parse peer in PEER_DEL_NTF messsage");
+        msg(D_DCO | M_NOIPREFIX, "ovpn-dco: can't parse peer in PEER_DEL_NTF messsage");
         return NL_STOP;
     }
 
     if (!dp_attrs[OVPN_A_PEER_DEL_REASON])
     {
-        msg(D_DCO, "ovpn-dco: no reason in PEER_DEL_NTF message");
+        msg(D_DCO | M_NOIPREFIX, "ovpn-dco: no reason in PEER_DEL_NTF message");
         return NL_STOP;
     }
     if (!dp_attrs[OVPN_A_PEER_ID])
     {
-        msg(D_DCO, "ovpn-dco: no peer-id in PEER_DEL_NTF message");
+        msg(D_DCO | M_NOIPREFIX, "ovpn-dco: no peer-id in PEER_DEL_NTF message");
         return NL_STOP;
     }
 
     int reason = nla_get_u32(dp_attrs[OVPN_A_PEER_DEL_REASON]);
     unsigned int peerid = nla_get_u32(dp_attrs[OVPN_A_PEER_ID]);
 
-    msg(D_DCO_DEBUG, "ovpn-dco: received CMD_PEER_DEL_NTF, ifindex: %d, peer-id %u, reason: %d",
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "ovpn-dco: received CMD_PEER_DEL_NTF, ifindex: %d, peer-id %u, reason: %d",
         dco->ifindex, peerid, reason);
     dco->dco_message_peer_id = peerid;
     dco->dco_del_peer_reason = reason;
@@ -1065,7 +1065,7 @@
     struct nlmsghdr *nlh = nlmsg_hdr(msg);
     struct genlmsghdr *gnlh = genlmsg_hdr(nlh);
 
-    msg(D_DCO_DEBUG, "ovpn-dco: received netlink message type=%u cmd=%u flags=%#.4x",
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "ovpn-dco: received netlink message type=%u cmd=%u flags=%#.4x",
         nlh->nlmsg_type, gnlh->cmd, nlh->nlmsg_flags);
 
     /* if we get a message from the NLCTRL family, it means
@@ -1148,7 +1148,7 @@
         return 0;
     }
 
-    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: peer-id %d", __func__, peer_id);
 
     struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_GET);
     struct nlattr *attr = nla_nest_start(nl_msg, OVPN_A_PEER);
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 5f5a808..ecea635 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -239,7 +239,7 @@
         {
             si->source = SIG_SOURCE_CONNECTION_FAILED;
         }
-        msg(D_SIGNAL_DEBUG, "register signal: %s (%s)", signal_name(signum, true), signal_text);
+        msg(D_SIGNAL_DEBUG | M_NOIPREFIX, "register signal: %s (%s)", signal_name(signum, true), signal_text);
     }
     else
     {

