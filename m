From: Arne Schwabe <arne@...1227...>
Date: Wed, 12 Oct 2022 15:34:55 +0200
Message-Id: <20221012133457.1927871-2-arne@...1227...>
In-Reply-To: <20221012133457.1927871-1-arne@...1227...>
References: <20221012133457.1927871-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] Use dedicated multi->dco_peer_id for
 DCO instead of multi->peer_id
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

The lifetime and state machine of multi->peer_id does not exactly the
lifetime/state of DCO. This is especially for p2p NCP where a reconnection
can change the peer id. Also use this new field with value -1 to mean
not installed, replacing the dco_peer_added field.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/dco.c        | 24 ++++++++++++------------
 src/openvpn/forward.c    |  2 +-
 src/openvpn/init.c       |  4 ++--
 src/openvpn/multi.c      |  8 ++++----
 src/openvpn/ssl.c        |  1 +
 src/openvpn/ssl_common.h |  9 ++++++++-
 6 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 1f402bfc2..51d595611 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -55,7 +55,7 @@ dco_install_key(struct tls_multi *multi, struct key_state *ks,
                 const char *ciphername)
 
 {
-    msg(D_DCO_DEBUG, "%s: peer_id=%d keyid=%d", __func__, multi->peer_id,
+    msg(D_DCO_DEBUG, "%s: peer_id=%d keyid=%d", __func__, multi->dco_peer_id,
         ks->key_id);
 
     /* Install a key in the PRIMARY slot only when no other key exist.
@@ -69,7 +69,7 @@ dco_install_key(struct tls_multi *multi, struct key_state *ks,
         slot = OVPN_KEY_SLOT_SECONDARY;
     }
 
-    int ret = dco_new_key(multi->dco, multi->peer_id, ks->key_id, slot,
+    int ret = dco_new_key(multi->dco, multi->dco_peer_id, ks->key_id, slot,
                           encrypt_key, encrypt_iv,
                           decrypt_key, decrypt_iv,
                           ciphername);
@@ -133,7 +133,7 @@ dco_get_secondary_key(struct tls_multi *multi, const struct key_state *primary)
 void
 dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
 {
-    msg(D_DCO_DEBUG, "%s: peer_id=%d", __func__, multi->peer_id);
+    msg(D_DCO_DEBUG, "%s: peer_id=%d", __func__, multi->dco_peer_id);
 
     /* this function checks if keys have to be swapped or erased, therefore it
      * can't do much if we don't have any key installed
@@ -151,14 +151,14 @@ dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
     {
         msg(D_DCO, "No encryption key found. Purging data channel keys");
 
-        int ret = dco_del_key(dco, multi->peer_id, OVPN_KEY_SLOT_PRIMARY);
+        int ret = dco_del_key(dco, multi->dco_peer_id, OVPN_KEY_SLOT_PRIMARY);
         if (ret < 0)
         {
             msg(D_DCO, "Cannot delete primary key during wipe: %s (%d)", strerror(-ret), ret);
             return;
         }
 
-        ret = dco_del_key(dco, multi->peer_id, OVPN_KEY_SLOT_SECONDARY);
+        ret = dco_del_key(dco, multi->dco_peer_id, OVPN_KEY_SLOT_SECONDARY);
         if (ret < 0)
         {
             msg(D_DCO, "Cannot delete secondary key during wipe: %s (%d)", strerror(-ret), ret);
@@ -184,7 +184,7 @@ dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
         msg(D_DCO_DEBUG, "Swapping primary and secondary keys, now: id1=%d id2=%d",
             primary->key_id, secondary ? secondary->key_id : -1);
 
-        int ret = dco_swap_keys(dco, multi->peer_id);
+        int ret = dco_swap_keys(dco, multi->dco_peer_id);
         if (ret < 0)
         {
             msg(D_DCO, "Cannot swap keys: %s (%d)", strerror(-ret), ret);
@@ -202,7 +202,7 @@ dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
     /* if we have no secondary key anymore, inform DCO about it */
     if (!secondary && multi->dco_keys_installed == 2)
     {
-        int ret = dco_del_key(dco, multi->peer_id, OVPN_KEY_SLOT_SECONDARY);
+        int ret = dco_del_key(dco, multi->dco_peer_id, OVPN_KEY_SLOT_SECONDARY);
         if (ret < 0)
         {
             msg(D_DCO, "Cannot delete secondary key: %s (%d)", strerror(-ret), ret);
@@ -447,7 +447,7 @@ dco_p2p_add_new_peer(struct context *c)
         return ret;
     }
 
-    c->c2.tls_multi->dco_peer_added = true;
+    c->c2.tls_multi->dco_peer_id = multi->peer_id;
     c->c2.link_socket->info.lsa->actual.dco_installed = true;
 
     return 0;
@@ -461,10 +461,10 @@ dco_remove_peer(struct context *c)
         return;
     }
 
-    if (c->c1.tuntap && c->c2.tls_multi && c->c2.tls_multi->dco_peer_added)
+    if (c->c1.tuntap && c->c2.tls_multi && c->c2.tls_multi->dco_peer_id)
     {
-        dco_del_peer(&c->c1.tuntap->dco, c->c2.tls_multi->peer_id);
-        c->c2.tls_multi->dco_peer_added = false;
+        dco_del_peer(&c->c1.tuntap->dco, c->c2.tls_multi->dco_peer_id);
+        c->c2.tls_multi->dco_peer_id = -1;
     }
 }
 
@@ -567,7 +567,7 @@ dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
         return ret;
     }
 
-    c->c2.tls_multi->dco_peer_added = true;
+    c->c2.tls_multi->dco_peer_id = peer_id;
 
     if (c->mode == CM_CHILD_TCP)
     {
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 18308c2c5..8db4f2ce1 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1724,7 +1724,7 @@ process_outgoing_link(struct context *c)
                 if (should_use_dco_socket(c->c2.to_link_addr))
                 {
                     size = dco_do_write(&c->c1.tuntap->dco,
-                                        c->c2.tls_multi->peer_id,
+                                        c->c2.tls_multi->dco_peer_id,
                                         &c->c2.to_link);
                 }
                 else
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 351515aa2..35e63dbc3 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2150,14 +2150,14 @@ do_deferred_options_part2(struct context *c)
         && (c->options.ping_send_timeout || c->c2.frame.mss_fix))
     {
         int ret = dco_set_peer(&c->c1.tuntap->dco,
-                               c->c2.tls_multi->peer_id,
+                               c->c2.tls_multi->dco_peer_id,
                                c->options.ping_send_timeout,
                                c->options.ping_rec_timeout,
                                c->c2.frame.mss_fix);
         if (ret < 0)
         {
             msg(D_DCO, "Cannot set parameters for DCO peer (id=%u): %s",
-                c->c2.tls_multi->peer_id, strerror(-ret));
+                c->c2.tls_multi->dco_peer_id, strerror(-ret));
             return false;
         }
     }
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index b9b087e01..bd823e81f 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2448,14 +2448,14 @@ multi_client_connect_late_setup(struct multi_context *m,
             if (mi->context.options.ping_send_timeout || mi->context.c2.frame.mss_fix)
             {
                 int ret = dco_set_peer(&mi->context.c1.tuntap->dco,
-                                       mi->context.c2.tls_multi->peer_id,
+                                       mi->context.c2.tls_multi->dco_peer_id,
                                        mi->context.options.ping_send_timeout,
                                        mi->context.options.ping_rec_timeout,
                                        mi->context.c2.frame.mss_fix);
                 if (ret < 0)
                 {
                     msg(D_DCO, "Cannot set parameters for DCO peer (id=%u): %s",
-                        mi->context.c2.tls_multi->peer_id, strerror(-ret));
+                        mi->context.c2.tls_multi->dco_peer_id, strerror(-ret));
                     mi->context.c2.tls_multi->multi_state = CAS_FAILED;
                 }
             }
@@ -3226,8 +3226,8 @@ process_incoming_del_peer(struct multi_context *m, struct multi_instance *mi,
     }
 
     /* When kernel already deleted the peer, the socket is no longer
-     * installed and we don't need to cleanup the state in the kernel */
-    mi->context.c2.tls_multi->dco_peer_added = false;
+     * installed, and we do not need to clean up the state in the kernel */
+    mi->context.c2.tls_multi->dco_peer_id = -1;
     mi->context.sig->signal_text = reason;
     multi_signal_instance(m, mi, SIGTERM);
 }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 5ed71f0c5..5b9ce77fe 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1266,6 +1266,7 @@ tls_multi_init(struct tls_options *tls_options)
 
     /* get command line derived options */
     ret->opt = *tls_options;
+    ret->dco_peer_id = -1;
 
     return ret;
 }
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 9aa28f1e5..78f9288e5 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -659,7 +659,14 @@ struct tls_multi
     /* Only used when DCO is used to remember how many keys we installed
      * for this session */
     int dco_keys_installed;
-    bool dco_peer_added;
+    /**
+     * This is the handle that DCO uses to identify this session with the
+     * kernel.
+     *
+     * We keep this separate as the normal peer_id can change during
+     * p2p NCP and we need to track the id that is really used.
+     */
+    int dco_peer_id;
 
     dco_context_t *dco;
 };
-- 
2.37.0 (Apple Git-136)


