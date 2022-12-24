From: Arne Schwabe <arne@...1227...>
Date: Sat, 24 Dec 2022 20:42:46 +0100
Message-Id: <20221224194253.3202231-3-arne@...1227...>
In-Reply-To: <20221224194253.3202231-1-arne@...1227...>
References: <20221224194253.3202231-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/9] Always start session in TM_INITIAL
 rather than TM_ACTIVE or TM_INITIAL
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

Currently we start new session in TM_ACTIVE or TM_INITIAL depending if
we already have an active session in TM_ACTIVE or not.

With this change, all session will be started in TM_INITIAL both initiated
by a peer but also session by ourselves. This simplifies state transitions
and eliminates the wacky state transition that when we have a failed
reneogitiation (and move TM_ACTIVE to TM_LAME_DUCK) that a new session of
a peer starts in TM_ACTIVE rather than TM_INITIAL

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/mudp.c |  2 +-
 src/openvpn/ssl.c  | 99 ++++++++++++++++------------------------------
 2 files changed, 36 insertions(+), 65 deletions(-)

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 458152335..c27c6da5b 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -257,7 +257,7 @@ multi_get_create_instance_udp(struct multi_context *m, bool *floated)
                             && session_id_defined((&state.peer_session_id)))
                         {
                             mi->context.c2.tls_multi->n_sessions++;
-                            struct tls_session *session = &mi->context.c2.tls_multi->session[TM_ACTIVE];
+                            struct tls_session *session = &mi->context.c2.tls_multi->session[TM_INITIAL];
                             session_skip_to_pre_start(session, &state, &m->top.c2.from);
                         }
                     }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index a5fb4fd22..b1dc80c40 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1327,11 +1327,7 @@ tls_multi_init_finalize(struct tls_multi *multi, int tls_mtu)
     /* initialize the active and untrusted sessions */
 
     tls_session_init(multi, &multi->session[TM_ACTIVE]);
-
-    if (!multi->opt.single_session)
-    {
-        tls_session_init(multi, &multi->session[TM_INITIAL]);
-    }
+    tls_session_init(multi, &multi->session[TM_INITIAL]);
 }
 
 /*
@@ -3173,8 +3169,11 @@ tls_multi_process(struct tls_multi *multi,
         struct key_state *ks = &session->key[KS_PRIMARY];
         struct key_state *ks_lame = &session->key[KS_LAME_DUCK];
 
-        /* set initial remote address */
-        if (i == TM_ACTIVE && ks->state == S_INITIAL
+        /* set initial remote address. This triggers connecting with that
+         * session. So we only do that if the TM_ACTIVE session is not
+         * established */
+        if (i == TM_INITIAL && ks->state == S_INITIAL
+            && get_primary_key(multi)->state <= S_INITIAL
             && link_socket_actual_defined(&to_link_socket_info->lsa->actual))
         {
             ks->remote_addr = to_link_socket_info->lsa->actual;
@@ -3221,13 +3220,14 @@ tls_multi_process(struct tls_multi *multi,
             {
                 ++multi->n_soft_errors;
 
-                if (i == TM_ACTIVE)
+                if (i == TM_ACTIVE
+                    || (i == TM_INITIAL && get_primary_key(multi)->state < S_ACTIVE))
                 {
                     error = true;
                 }
 
                 if (i == TM_ACTIVE
-                    && ks_lame->state >= S_ACTIVE
+                    && ks_lame->state >= S_GENERATED_KEYS
                     && !multi->opt.single_session)
                 {
                     move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true);
@@ -3302,7 +3302,9 @@ tls_multi_process(struct tls_multi *multi,
     if (TLS_AUTHENTICATED(multi, &multi->session[TM_INITIAL].key[KS_PRIMARY]))
     {
         move_session(multi, TM_ACTIVE, TM_INITIAL, true);
-        msg(D_TLS_DEBUG_LOW, "TLS: tls_multi_process: untrusted session promoted to %strusted",
+        tas = tls_authentication_status(multi);
+        msg(D_TLS_DEBUG_LOW, "TLS: tls_multi_process: initial untrusted "
+            "session promoted to %strusted",
             tas == TLS_AUTHENTICATION_SUCCEEDED ? "" : "semi-");
 
         if (multi->multi_state == CAS_CONNECT_DONE)
@@ -3633,55 +3635,8 @@ tls_pre_decrypt(struct tls_multi *multi,
 
     /*
      * Hard reset and session id does not match any session in
-     * multi->session: Possible initial packet
-     */
-    if (i == TM_SIZE && is_hard_reset_method2(op))
-    {
-        struct tls_session *session = &multi->session[TM_ACTIVE];
-        const struct key_state *ks = get_primary_key(multi);
-
-        /*
-         * If we have no session currently in progress, the initial packet will
-         * open a new session in TM_ACTIVE rather than TM_UNTRUSTED.
-         */
-        if (!session_id_defined(&ks->session_id_remote))
-        {
-            if (multi->opt.single_session && multi->n_sessions)
-            {
-                msg(D_TLS_ERRORS,
-                    "TLS Error: Cannot accept new session request from %s due to session context expire or --single-session [1]",
-                    print_link_socket_actual(from, &gc));
-                goto error;
-            }
-
-#ifdef ENABLE_MANAGEMENT
-            if (management)
-            {
-                management_set_state(management,
-                                     OPENVPN_STATE_AUTH,
-                                     NULL,
-                                     NULL,
-                                     NULL,
-                                     NULL,
-                                     NULL);
-            }
-#endif
-
-            msg(D_TLS_DEBUG_LOW,
-                "TLS: Initial packet from %s, sid=%s",
-                print_link_socket_actual(from, &gc),
-                session_id_print(&sid, &gc));
-
-            do_burst = true;
-            new_link = true;
-            i = TM_ACTIVE;
-            session->untrusted_addr = *from;
-        }
-    }
-
-    /*
-     * If we detected new session in the last if block, variable i has
-     * changed to TM_ACTIVE, so check the condition again.
+     * multi->session: Possible initial packet. New sessions always start
+     * as TM_INITIAL
      */
     if (i == TM_SIZE && is_hard_reset_method2(op))
     {
@@ -3689,16 +3644,17 @@ tls_pre_decrypt(struct tls_multi *multi,
          * No match with existing sessions,
          * probably a new session.
          */
-        struct tls_session *session = &multi->session[TM_UNTRUSTED];
+        struct tls_session *session = &multi->session[TM_INITIAL];
 
         /*
          * If --single-session, don't allow any hard-reset connection request
          * unless it the first packet of the session.
          */
-        if (multi->opt.single_session)
+        if (multi->opt.single_session && multi->n_sessions)
         {
             msg(D_TLS_ERRORS,
-                "TLS Error: Cannot accept new session request from %s due to session context expire or --single-session [2]",
+                "TLS Error: Cannot accept new session request from %s due "
+                "to session context expire or --single-session",
                 print_link_socket_actual(from, &gc));
             goto error;
         }
@@ -3709,6 +3665,19 @@ tls_pre_decrypt(struct tls_multi *multi,
             goto error;
         }
 
+#ifdef ENABLE_MANAGEMENT
+        if (management)
+        {
+            management_set_state(management,
+                                 OPENVPN_STATE_AUTH,
+                                 NULL,
+                                 NULL,
+                                 NULL,
+                                 NULL,
+                                 NULL);
+        }
+#endif
+
         /*
          * New session-initiating control packet is authenticated at this point,
          * assuming that the --tls-auth command line option was used.
@@ -3716,9 +3685,11 @@ tls_pre_decrypt(struct tls_multi *multi,
          * Without --tls-auth, we leave authentication entirely up to TLS.
          */
         msg(D_TLS_DEBUG_LOW,
-            "TLS: new session incoming connection from %s",
-            print_link_socket_actual(from, &gc));
+            "TLS: Initial packet from %s, sid=%s",
+            print_link_socket_actual(from, &gc),
+            session_id_print(&sid, &gc));
 
+        do_burst = true;
         new_link = true;
         i = TM_INITIAL;
         session->untrusted_addr = *from;
-- 
2.37.1 (Apple Git-137.1)


