From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  6 Sep 2024 16:57:45 +0200
Message-Id: <20240906145745.67596-1-frank@...2641...>
In-Reply-To: <gerrit.1715339249000.Ic8538e734dba53cd43fead3961e4401c8037e079@...2715...>
References: <gerrit.1715339249000.Ic8538e734dba53cd43fead3961e4401c8037e079@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] Ensures all params are ready before
 invoking dco_set_peer()
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

In UDP case the dco_set_peer() is currently perfomed at the wrong time
since the mssfix param is calculated later on in
tls_session_update_crypto_params_do_work().
By moving the dco_set_peer() inside the
tls_session_update_crypto_params_do_work() and removing
the p2p_set_dco_keepalive() otherwise on client side the
dco_set_peer() will be called twice, we will ensure
that all crypto and frame params are properly initialized
and if an update occurs dco will be notified.

Change-Id: Ic8538e734dba53cd43fead3961e4401c8037e079
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Lev Stipakov <lstipakov@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/587
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a49e563..c636609 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2178,27 +2178,6 @@
            || !memcmp(a, &zero, sizeof(struct sha256_digest));
 }
 
-static bool
-p2p_set_dco_keepalive(struct context *c)
-{
-    if (dco_enabled(&c->options)
-        && (c->options.ping_send_timeout || c->c2.frame.mss_fix))
-    {
-        int ret = dco_set_peer(&c->c1.tuntap->dco,
-                               c->c2.tls_multi->dco_peer_id,
-                               c->options.ping_send_timeout,
-                               c->options.ping_rec_timeout,
-                               c->c2.frame.mss_fix);
-        if (ret < 0)
-        {
-            msg(D_DCO, "Cannot set parameters for DCO peer (id=%u): %s",
-                c->c2.tls_multi->dco_peer_id, strerror(-ret));
-            return false;
-        }
-    }
-    return true;
-}
-
 /**
  * Helper function for tls_print_deferred_options_results
  * Adds the ", " delimitor if there already some data in the
@@ -2359,7 +2338,8 @@
     if (!tls_session_update_crypto_params(c->c2.tls_multi, session,
                                           &c->options, &c->c2.frame,
                                           frame_fragment,
-                                          get_link_socket_info(c)))
+                                          get_link_socket_info(c),
+                                          &c->c1.tuntap->dco))
     {
         msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to import crypto options");
         return false;
@@ -2468,12 +2448,6 @@
             }
         }
 
-        if (c->mode == MODE_POINT_TO_POINT && !p2p_set_dco_keepalive(c))
-        {
-            msg(D_TLS_ERRORS, "ERROR: Failed to apply DCO keepalive or MSS fix parameters");
-            return false;
-        }
-
         if (c->c2.did_open_tun)
         {
             c->c1.pulled_options_digest_save = c->c2.pulled_options_digest;
@@ -2578,7 +2552,8 @@
 
     if (!tls_session_update_crypto_params(c->c2.tls_multi, session, &c->options,
                                           &c->c2.frame, frame_fragment,
-                                          get_link_socket_info(c)))
+                                          get_link_socket_info(c),
+                                          &c->c1.tuntap->dco))
     {
         msg(D_TLS_ERRORS, "ERROR: failed to set crypto cipher");
         return false;
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 03177bb..0509911 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2364,21 +2364,6 @@
         return false;
     }
 
-    if (mi->context.options.ping_send_timeout || mi->context.c2.frame.mss_fix)
-    {
-        ret = dco_set_peer(&mi->context.c1.tuntap->dco,
-                           mi->context.c2.tls_multi->dco_peer_id,
-                           mi->context.options.ping_send_timeout,
-                           mi->context.options.ping_rec_timeout,
-                           mi->context.c2.frame.mss_fix);
-        if (ret < 0)
-        {
-            msg(D_DCO, "Cannot set DCO peer parameters for %s (id=%u): %s",
-                multi_instance_string(mi, false, gc),
-                mi->context.c2.tls_multi->dco_peer_id, strerror(-ret));
-            return false;
-        }
-    }
     return true;
 }
 
@@ -2398,7 +2383,8 @@
     struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
     if (!tls_session_update_crypto_params(c->c2.tls_multi, session, &c->options,
                                           &c->c2.frame, frame_fragment,
-                                          get_link_socket_info(c)))
+                                          get_link_socket_info(c),
+                                          &c->c1.tuntap->dco))
     {
         msg(D_TLS_ERRORS, "TLS Error: initializing data channel failed");
         register_signal(c->sig, SIGUSR1, "process-push-msg-failed");
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e0e9591..0921ada 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1584,7 +1584,8 @@
                                          struct options *options,
                                          struct frame *frame,
                                          struct frame *frame_fragment,
-                                         struct link_socket_info *lsi)
+                                         struct link_socket_info *lsi,
+                                         dco_context_t *dco)
 {
     if (session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized)
     {
@@ -1631,6 +1632,26 @@
             return false;
         }
     }
+
+    if (dco_enabled(options))
+    {
+        /* dco_set_peer() must be called only when both
+         * keepalive and mss_fix are properly set. */
+        if (options->ping_send_timeout || frame->mss_fix)
+        {
+            int ret = dco_set_peer(dco,
+                                   multi->dco_peer_id,
+                                   options->ping_send_timeout,
+                                   options->ping_rec_timeout,
+                                   frame->mss_fix);
+            if (ret < 0)
+            {
+                msg(D_DCO, "Cannot set DCO peer parameters for peer (id=%u): %s",
+                    multi->dco_peer_id, strerror(-ret));
+                return false;
+            }
+        }
+    }
     return tls_session_generate_data_channel_keys(multi, session);
 }
 
@@ -1639,7 +1660,8 @@
                                  struct tls_session *session,
                                  struct options *options, struct frame *frame,
                                  struct frame *frame_fragment,
-                                 struct link_socket_info *lsi)
+                                 struct link_socket_info *lsi,
+                                 dco_context_t *dco)
 {
     if (!check_session_cipher(session, options))
     {
@@ -1650,7 +1672,7 @@
     session->opt->crypto_flags |= options->imported_protocol_flags;
 
     return tls_session_update_crypto_params_do_work(multi, session, options,
-                                                    frame, frame_fragment, lsi);
+                                                    frame, frame_fragment, lsi, dco);
 }
 
 
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 1a45048..0e43961 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -457,6 +457,8 @@
  * @param frame_fragment  The fragment frame options.
  * @param lsi             link socket info to adjust MTU related options
  *                        depending on the current protocol
+ * @param dco             The dco context to perform dco_set_peer()
+ *                        whenever a crypto param update occurs.
  *
  * @return true if updating succeeded or keys are already generated, false otherwise.
  */
@@ -465,7 +467,8 @@
                                       struct options *options,
                                       struct frame *frame,
                                       struct frame *frame_fragment,
-                                      struct link_socket_info *lsi);
+                                      struct link_socket_info *lsi,
+                                      dco_context_t *dco);
 
 /*
  * inline functions

