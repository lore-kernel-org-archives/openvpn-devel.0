From: Antonio Quartulli <a@...2181...>
Date: Fri, 24 Jun 2022 10:37:50 +0200
Message-Id: <20220624083809.23487-7-a@...2181...>
In-Reply-To: <20220624083809.23487-1-a@...2181...>
References: <20220624083809.23487-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 06/25] dco: initialize context and save
 pointer in TLS object
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
Cc: Antonio Quartulli <a@...2181...>

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/init.c       | 49 ++++++++++++++++++++++++++++++++--------
 src/openvpn/ssl_common.h | 23 +++++++++++++++++++
 2 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 7099eba4..7ab2c9a2 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -55,6 +55,7 @@
 #include "auth_token.h"
 #include "mss.h"
 #include "mudp.h"
+#include "dco.h"
 
 #include "memdbg.h"
 
@@ -1295,15 +1296,23 @@ do_init_timers(struct context *c, bool deferred)
     }
 
     /* initialize pings */
-
-    if (c->options.ping_send_timeout)
+    if (dco_enabled(&c->options))
     {
-        event_timeout_init(&c->c2.ping_send_interval, c->options.ping_send_timeout, 0);
+        /* The DCO kernel module will send the pings instead of user space */
+        event_timeout_clear(&c->c2.ping_rec_interval);
+        event_timeout_clear(&c->c2.ping_send_interval);
     }
-
-    if (c->options.ping_rec_timeout)
+    else
     {
-        event_timeout_init(&c->c2.ping_rec_interval, c->options.ping_rec_timeout, now);
+        if (c->options.ping_send_timeout)
+        {
+            event_timeout_init(&c->c2.ping_send_interval, c->options.ping_send_timeout, 0);
+        }
+
+        if (c->options.ping_rec_timeout)
+        {
+            event_timeout_init(&c->c2.ping_rec_interval, c->options.ping_rec_timeout, now);
+        }
     }
 
     if (!deferred)
@@ -1708,6 +1717,12 @@ do_open_tun(struct context *c)
     /* initialize (but do not open) tun/tap object */
     do_init_tun(c);
 
+    /* inherit the dco context from the tuntap object */
+    if (c->c2.tls_multi)
+    {
+        c->c2.tls_multi->dco = &c->c1.tuntap->dco;
+    }
+
 #ifdef _WIN32
     /* store (hide) interactive service handle in tuntap_options */
     c->c1.tuntap->options.msg_channel = c->options.msg_channel;
@@ -1756,6 +1771,11 @@ do_open_tun(struct context *c)
     /* Store the old fd inside the fd so open_tun can use it */
     c->c1.tuntap->fd = oldtunfd;
 #endif
+    if (dco_enabled(&c->options))
+    {
+        ovpn_dco_init(c->mode, &c->c1.tuntap->dco);
+    }
+
     /* open the tun device */
     open_tun(c->options.dev, c->options.dev_type, c->options.dev_node,
              c->c1.tuntap, &c->net_ctx);
@@ -2979,12 +2999,20 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
         }
     }
 
+    /* let the TLS engine know if keys have to be installed in DCO or not */
+    to.disable_dco = !dco_enabled(options);
+
     /*
      * Initialize OpenVPN's master TLS-mode object.
      */
     if (flags & CF_INIT_TLS_MULTI)
     {
         c->c2.tls_multi = tls_multi_init(&to);
+        /* inherit the dco context from the tuntap object */
+        if (c->c1.tuntap)
+        {
+            c->c2.tls_multi->dco = &c->c1.tuntap->dco;
+        }
     }
 
     if (flags & CF_INIT_TLS_AUTH_STANDALONE)
@@ -4365,15 +4393,18 @@ inherit_context_child(struct context *dest,
 #endif
 
     /* context init */
+
+    /* inherit tun/tap interface object now as it may be required
+     * to initialize the DCO context in init_instance()
+     */
+    dest->c1.tuntap = src->c1.tuntap;
+
     init_instance(dest, src->c2.es, CC_NO_CLOSE | CC_USR1_TO_HUP);
     if (IS_SIG(dest))
     {
         return;
     }
 
-    /* inherit tun/tap interface object */
-    dest->c1.tuntap = src->c1.tuntap;
-
     /* UDP inherits some extra things which TCP does not */
     if (dest->mode == CM_CHILD_UDP)
     {
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index cef2611b..83373a97 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -167,6 +167,12 @@ enum auth_deferred_result {
     ACF_FAILED        /**< deferred auth has failed */
 };
 
+enum dco_key_status {
+    DCO_NOT_INSTALLED,
+    DCO_INSTALLED_PRIMARY,
+    DCO_INSTALLED_SECONDARY
+};
+
 /**
  * Security parameter state of one TLS and data channel %key session.
  * @ingroup control_processor
@@ -197,6 +203,12 @@ struct key_state
      */
     int key_id;
 
+    /**
+     * Key id for this key_state, inherited from struct tls_session.
+     * @see tls_multi::peer_id.
+     */
+    uint32_t peer_id;
+
     struct key_state_ssl ks_ssl; /* contains SSL object and BIOs for the control channel */
 
     time_t initial;             /* when we created this session */
@@ -241,6 +253,8 @@ struct key_state
 
     struct auth_deferred_status plugin_auth;
     struct auth_deferred_status script_auth;
+
+    enum dco_key_status dco_status;
 };
 
 /** Control channel wrapping (--tls-auth/--tls-crypt) context */
@@ -404,6 +418,8 @@ struct tls_options
     const char *ekm_label;
     size_t ekm_label_size;
     size_t ekm_size;
+
+    bool disable_dco; /**< Whether keys have to be installed in DCO or not */
 };
 
 /** @addtogroup control_processor
@@ -636,6 +652,13 @@ struct tls_multi
     /**< Array of \c tls_session objects
      *   representing control channel
      *   sessions with the remote peer. */
+
+    /* Only used when DCO is used to remember how many keys we installed
+     * for this session */
+    int dco_keys_installed;
+    bool dco_peer_added;
+
+    dco_context_t *dco;
 };
 
 /**  gets an item  of \c key_state objects in the
-- 
2.35.1


