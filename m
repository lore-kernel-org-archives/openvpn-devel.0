From: Arne Schwabe <arne@...1227...>
Date: Wed, 17 Mar 2021 17:00:37 +0100
Message-Id: <20210317160038.25828-2-arne@...1227...>
In-Reply-To: <20210317160038.25828-1-arne@...1227...>
References: <20210317160038.25828-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 2/3] Move NCP saving and restore to the
 prepush restore code
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

This unifies save/restoring options that might be changed by a push
from the server. It also removes using the context_1 to store something
that is not related to a SIGHUP lifetime.

Patch v2: rebase on master.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c    | 36 +++++-------------------------------
 src/openvpn/openvpn.h |  4 ----
 src/openvpn/options.c | 11 +++++++++++
 src/openvpn/options.h |  4 ++++
 4 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 81aaa6c9..74c42c2c 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -668,28 +668,6 @@ uninit_proxy(struct context *c)
     uninit_proxy_dowork(c);
 }
 
-/*
- * Saves the initial state of NCP-regotiable
- * options into a storage which persists over SIGUSR1.
- */
-static void
-save_ncp_options(struct context *c)
-{
-    c->c1.ciphername = c->options.ciphername;
-    c->c1.authname = c->options.authname;
-    c->c1.keysize = c->options.keysize;
-}
-
-/* Restores NCP-negotiable options to original values */
-static void
-restore_ncp_options(struct context *c)
-{
-    c->options.ciphername = c->c1.ciphername;
-    c->options.authname = c->c1.authname;
-    c->options.keysize = c->c1.keysize;
-    c->options.data_channel_use_ekm = false;
-}
-
 void
 context_init_1(struct context *c)
 {
@@ -699,8 +677,6 @@ context_init_1(struct context *c)
 
     init_connection_list(c);
 
-    save_ncp_options(c);
-
 #if defined(ENABLE_PKCS11)
     if (c->first_time)
     {
@@ -2868,8 +2844,8 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.replay_window = options->replay_window;
     to.replay_time = options->replay_time;
     to.tcp_mode = link_socket_proto_connection_oriented(options->ce.proto);
-    to.config_ciphername = c->c1.ciphername;
-    to.config_ncp_ciphers = options->ncp_ciphers;
+    to.config_ciphername = c->options.ciphername;
+    to.config_ncp_ciphers = c->options.ncp_ciphers;
     to.ncp_enabled = options->ncp_enabled;
     to.transition_window = options->transition_window;
     to.handshake_window = options->handshake_window;
@@ -4465,8 +4441,6 @@ close_instance(struct context *c)
         /* free key schedules */
         do_close_free_key_schedule(c, (c->mode == CM_P2P || c->mode == CM_TOP));
 
-        restore_ncp_options(c);
-
         /* close TCP/UDP connection */
         do_close_link_socket(c);
 
@@ -4537,9 +4511,9 @@ inherit_context_child(struct context *dest,
     dest->c1.ks.tls_auth_key_type = src->c1.ks.tls_auth_key_type;
     dest->c1.ks.tls_crypt_v2_server_key = src->c1.ks.tls_crypt_v2_server_key;
     /* inherit pre-NCP ciphers */
-    dest->c1.ciphername = src->c1.ciphername;
-    dest->c1.authname = src->c1.authname;
-    dest->c1.keysize = src->c1.keysize;
+    dest->options.ciphername = src->options.ciphername;
+    dest->options.authname = src->options.authname;
+    dest->options.keysize = src->options.keysize;
 
     /* inherit auth-token */
     dest->c1.ks.auth_token_key = src->c1.ks.auth_token_key;
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 436c10ee..3cef2638 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -203,10 +203,6 @@ struct context_1
     struct user_pass *auth_user_pass;
     /**< Username and password for
      *   authentication. */
-
-    const char *ciphername;     /**< Data channel cipher from config file */
-    const char *authname;       /**< Data channel auth from config file */
-    int keysize;                /**< Data channel keysize from config file */
 #endif
 };
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0eb049d8..645fc38b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3535,7 +3535,13 @@ pre_pull_save(struct options *o)
             o->pre_pull->client_nat = clone_client_nat_option_list(o->client_nat, &o->gc);
             o->pre_pull->client_nat_defined = true;
         }
+
+        /* NCP related options that can be overwritten by a push */
+        o->pre_pull->ciphername = o->ciphername;
+        o->pre_pull->authname = o->authname;
+        o->pre_pull->keysize = o->keysize;
     }
+
 }
 
 void
@@ -3581,10 +3587,15 @@ pre_pull_restore(struct options *o, struct gc_arena *gc)
         }
 
         o->foreign_option_index = pp->foreign_option_index;
+
+        o->ciphername = pp->ciphername;
+        o->authname = pp->authname;
+        o->keysize = pp->keysize;
     }
 
     o->push_continuation = 0;
     o->push_option_types_found = 0;
+    o->data_channel_use_ekm = false;
 }
 
 #endif /* if P2MP */
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 56228668..fe67ec72 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -75,6 +75,10 @@ struct options_pre_pull
     bool client_nat_defined;
     struct client_nat_option_list *client_nat;
 
+    const char* ciphername;
+    const char* authname;
+    int keysize;
+
     int foreign_option_index;
 };
 
-- 
2.30.1


