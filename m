From: Gert Doering <gert@...1296...>
Date: Sun, 27 Jul 2025 12:22:40 +0200
Message-ID: <20250727102245.24931-1-gert@...1296...>
In-Reply-To: <gerrit.1753486180000.Icbc70225d53ca678b8c22ed437b424c16e199d66@...2715...>
References: <gerrit.1753486180000.Icbc70225d53ca678b8c22ed437b424c16e199d66@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] dco_linux: clean up PEER_GET trigger and
 parser
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

This patch is intended to reduce code duplication and
cleanup the DCO code around the PEER_GET command.

Specifically it:
* unified PEER_GET reply parser for `multi` and
  `non-multi` case
* unified PEER_GET request trigger for `multi` and
  `non-multi` case
* dropped struct multi_context from the argument list of
  dco_get_peer_stats_multi()

Github: closes OpenVPN/openvpn#800
Change-Id: Icbc70225d53ca678b8c22ed437b424c16e199d66
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1114
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 9078417..2ce0eb1 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -230,11 +230,9 @@
  * Update traffic statistics for all peers
  *
  * @param dco                   DCO device context
- * @param m                     the server context
  * @param raise_sigusr1_on_err  whether to raise SIGUSR1 on error
  **/
-int dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,
-                             const bool raise_sigusr1_on_err);
+int dco_get_peer_stats_multi(dco_context_t *dco, const bool raise_sigusr1_on_err);
 
 /**
  * Update traffic statistics for single peer
@@ -374,8 +372,7 @@
 }
 
 static inline int
-dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,
-                         const bool raise_sigusr1_on_err)
+dco_get_peer_stats_multi(dco_context_t *dco, const bool raise_sigusr1_on_err)
 {
     return 0;
 }
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 98d8fb5..78ee9a1 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -167,6 +167,8 @@
 bool
 ovpn_dco_init(struct context *c)
 {
+    c->c1.tuntap->dco.c = c;
+
     if (open_fd(&c->c1.tuntap->dco) < 0)
     {
         msg(M_ERR, "Failed to open socket");
@@ -713,8 +715,7 @@
 }
 
 int
-dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,
-                         const bool raise_sigusr1_on_err)
+dco_get_peer_stats_multi(dco_context_t *dco, const bool raise_sigusr1_on_err)
 {
 
     struct ifdrv drv;
@@ -774,7 +775,7 @@
         const nvlist_t *peer = nvpeers[i];
         uint32_t peerid = nvlist_get_number(peer, "peerid");
 
-        dco_update_peer_stat(m, peerid, nvlist_get_nvlist(peer, "bytes"));
+        dco_update_peer_stat(dco->c->multi, peerid, nvlist_get_nvlist(peer, "bytes"));
     }
 
     nvlist_destroy(nvl);
diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h
index e1a054e..e926af5 100644
--- a/src/openvpn/dco_freebsd.h
+++ b/src/openvpn/dco_freebsd.h
@@ -57,6 +57,8 @@
     int dco_del_peer_reason;
     uint64_t dco_read_bytes;
     uint64_t dco_write_bytes;
+
+    struct context *c;
 } dco_context_t;
 
 #endif /* defined(ENABLE_DCO) && defined(TARGET_FREEBSD) */
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 728fb7e..9ad3d51 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -877,53 +877,8 @@
 }
 
 static int
-ovpn_handle_peer_multi(dco_context_t *dco, struct nlattr *attrs[])
-{
-    msg(D_DCO_DEBUG, "%s: parsing message...", __func__);
-
-    /* this function assumes openvpn is running in multipeer mode as
-     * it accesses c->multi
-     */
-    if (dco->ifmode != OVPN_MODE_MP)
-    {
-        msg(M_WARN, "%s: can't parse 'multi-peer' message on P2P instance", __func__);
-        return NL_SKIP;
-    }
-
-    if (!attrs[OVPN_A_PEER])
-    {
-        return NL_SKIP;
-    }
-
-    struct nlattr *tb_peer[OVPN_A_PEER_MAX + 1];
-    nla_parse_nested(tb_peer, OVPN_A_PEER_MAX, attrs[OVPN_A_PEER], NULL);
-
-    if (!tb_peer[OVPN_A_PEER_ID])
-    {
-        msg(M_WARN, "ovpn-dco: no peer-id provided in (MULTI) PEER_GET reply");
-        return NL_SKIP;
-    }
-
-    struct multi_context *m = dco->c->multi;
-    uint32_t peer_id = nla_get_u32(tb_peer[OVPN_A_PEER_ID]);
-
-    if (peer_id >= m->max_clients || !m->instances[peer_id])
-    {
-        msg(M_WARN, "%s: cannot store DCO stats for peer %u", __func__,
-            peer_id);
-        return NL_SKIP;
-    }
-
-    dco_update_peer_stat(&m->instances[peer_id]->context.c2, tb_peer, peer_id);
-
-    return NL_OK;
-}
-
-static int
 ovpn_handle_peer(dco_context_t *dco, struct nlattr *attrs[])
 {
-    msg(D_DCO_DEBUG, "%s: parsing message...", __func__);
-
     if (!attrs[OVPN_A_PEER])
     {
         msg(D_DCO_DEBUG, "%s: malformed reply", __func__);
@@ -942,12 +897,25 @@
     uint32_t peer_id = nla_get_u32(tb_peer[OVPN_A_PEER_ID]);
     struct context_2 *c2;
 
+    msg(D_DCO_DEBUG, "%s: parsing message for peer %u...", __func__, peer_id);
+
     if (dco->ifmode == OVPN_MODE_P2P)
     {
         c2 = &dco->c->c2;
+        if (c2->tls_multi->dco_peer_id != peer_id)
+        {
+            return NL_SKIP;
+        }
     }
     else
     {
+        if (peer_id >= dco->c->multi->max_clients)
+        {
+            msg(M_WARN, "%s: received out of bound peer_id %u (max=%u)", __func__, peer_id,
+                dco->c->multi->max_clients);
+            return NL_SKIP;
+        }
+
         struct multi_instance *mi = dco->c->multi->instances[peer_id];
         if (!mi)
         {
@@ -958,14 +926,6 @@
         c2 = &mi->context.c2;
     }
 
-    /* at this point this check should never fail for MP mode,
-     * but it's still fully valid for P2P mode
-     */
-    if (c2->tls_multi->dco_peer_id != peer_id)
-    {
-        return NL_SKIP;
-    }
-
     dco_update_peer_stat(c2, tb_peer, peer_id);
 
     return NL_OK;
@@ -1176,17 +1136,7 @@
     {
         case OVPN_CMD_PEER_GET:
         {
-            /* this message is part of a peer list dump, hence triggered
-             * by a MP/server instance
-             */
-            if (nlh->nlmsg_flags & NLM_F_MULTI)
-            {
-                return ovpn_handle_peer_multi(dco, attrs);
-            }
-            else
-            {
-                return ovpn_handle_peer(dco, attrs);
-            }
+            return ovpn_handle_peer(dco, attrs);
         }
 
         case OVPN_CMD_PEER_DEL_NTF:
@@ -1221,52 +1171,32 @@
     return ovpn_nl_recvmsgs(dco, __func__);
 }
 
-int
-dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,
-                         const bool raise_sigusr1_on_err)
+static int
+dco_get_peer(dco_context_t *dco, int peer_id, const bool raise_sigusr1_on_err)
 {
-    msg(D_DCO_DEBUG, "%s", __func__);
-
-    struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_GET);
-
-    nlmsg_hdr(nl_msg)->nlmsg_flags |= NLM_F_DUMP;
-
-    int ret = ovpn_nl_msg_send(dco, nl_msg, __func__);
-
-    nlmsg_free(nl_msg);
-
-    if (raise_sigusr1_on_err && ret < 0)
-    {
-        msg(M_WARN, "Error retrieving DCO peer stats: the underlying DCO peer"
-            "may have been deleted from the kernel without notifying "
-            "userspace. Restarting the session");
-        register_signal(m->top.sig, SIGUSR1, "dco peer stats error");
-    }
-    return ret;
-}
-
-int
-dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
-{
-    int peer_id = c->c2.tls_multi->dco_peer_id;
-    if (peer_id == -1)
+    /* peer_id == -1 means "dump all peers", but this is allowed in MP mode only.
+     * If it happens in P2P mode it means that the DCO peer was deleted and we
+     * can simply bail out
+     */
+    if (peer_id == -1 && dco->ifmode == OVPN_MODE_P2P)
     {
         return 0;
     }
 
     msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);
 
-    if (!c->c1.tuntap)
-    {
-        return 0;
-    }
-
-    dco_context_t *dco = &c->c1.tuntap->dco;
     struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_GET);
     struct nlattr *attr = nla_nest_start(nl_msg, OVPN_A_PEER);
     int ret = -EMSGSIZE;
 
-    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peer_id);
+    if (peer_id != -1)
+    {
+        NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peer_id);
+    }
+    else
+    {
+        nlmsg_hdr(nl_msg)->nlmsg_flags |= NLM_F_DUMP;
+    }
     nla_nest_end(nl_msg, attr);
 
     ret = ovpn_nl_msg_send(dco, nl_msg, __func__);
@@ -1279,11 +1209,23 @@
         msg(M_WARN, "Error retrieving DCO peer stats: the underlying DCO peer"
             "may have been deleted from the kernel without notifying "
             "userspace. Restarting the session");
-        register_signal(c->sig, SIGUSR1, "dco peer stats error");
+        register_signal(dco->c->sig, SIGUSR1, "dco peer stats error");
     }
     return ret;
 }
 
+int
+dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
+{
+    return dco_get_peer(&c->c1.tuntap->dco, c->c2.tls_multi->dco_peer_id, raise_sigusr1_on_err);
+}
+
+int
+dco_get_peer_stats_multi(dco_context_t *dco, const bool raise_sigusr1_on_err)
+{
+    return dco_get_peer(dco, -1, raise_sigusr1_on_err);
+}
+
 bool
 dco_available(int msglevel)
 {
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index e5a33a0..995b121 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -715,8 +715,7 @@
 }
 
 int
-dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,
-                         const bool raise_sigusr1_on_err)
+dco_get_peer_stats_multi(dco_context_t *dco, const bool raise_sigusr1_on_err)
 {
     /* Not implemented. */
     return 0;
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a62c57a..c5691ff 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -551,7 +551,7 @@
 {
     if (dco_enabled(&m->top.options))
     {
-        if (dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, m, false) < 0)
+        if (dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, false) < 0)
         {
             return;
         }
@@ -862,7 +862,7 @@
 
         if (dco_enabled(&m->top.options))
         {
-            if (dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, m, true) < 0)
+            if (dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, true) < 0)
             {
                 return;
             }

