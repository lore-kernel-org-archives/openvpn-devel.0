From: Antonio Quartulli <a@...2181...>
Date: Thu, 28 Jul 2022 21:47:33 +0200
Message-Id: <20220728194733.27721-1-a@...2181...>
In-Reply-To: <20220624083809.23487-12-a@...2181...>
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 11/25] dco: split option parsing routines
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

DCO will try to install keys upon generating them, however, this happens
when parsing pushed cipher options (due to NCP).

For this reason we need to postpone parsing pushed cipher options to *after*
the tunnel interface has been opened, otherwise we would have no DCO netdev
object to operate on.

At the same time we split the parsing code, so that we can ensure that
the NEW_PEER call can happen after the received peer-id has been parsed
(it is required by all DCO API calls).

Signed-off-by: Antonio Quartulli <a@...2181...>
---

Changes from v1:
* removed error message in case of failure of finish_options(). The
  latter already warns the user about the failure - no need to print
  another generic message.
---
 src/openvpn/init.c  | 57 ++++++++++++++++++++++++++++-----------------
 src/openvpn/init.h  |  2 ++
 src/openvpn/multi.c |  7 ++++++
 3 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 338d797b..db42d540 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2093,14 +2093,6 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
                 return false;
             }
         }
-        else if (c->mode == MODE_POINT_TO_POINT)
-        {
-            if (!do_deferred_p2p_ncp(c))
-            {
-                msg(D_TLS_ERRORS, "ERROR: Failed to apply P2P negotiated protocol options");
-                return false;
-            }
-        }
 
         /* if --up-delay specified, open tun, do ifconfig, and run up script now */
         if (c->options.up_delay || PULL_DEFINED(&c->options))
@@ -2127,6 +2119,20 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
             }
         }
 
+        if (!pulled_options && c->mode == MODE_POINT_TO_POINT)
+        {
+            if (!do_deferred_p2p_ncp(c))
+            {
+                msg(D_TLS_ERRORS, "ERROR: Failed to apply P2P negotiated protocol options");
+                return false;
+            }
+        }
+
+        if (!finish_options(c))
+        {
+            return false;
+        }
+
         if (c->c2.did_open_tun)
         {
             c->c1.pulled_options_digest_save = c->c2.pulled_options_digest;
@@ -2332,23 +2338,30 @@ do_deferred_options(struct context *c, const unsigned int found)
         {
             return false;
         }
-        struct frame *frame_fragment = NULL;
+    }
+
+    return true;
+}
+
+bool
+finish_options(struct context *c)
+{
+    struct frame *frame_fragment = NULL;
 #ifdef ENABLE_FRAGMENT
-        if (c->options.ce.fragment)
-        {
-            frame_fragment = &c->c2.frame_fragment;
-        }
+    if (c->options.ce.fragment)
+    {
+        frame_fragment = &c->c2.frame_fragment;
+    }
 #endif
 
-        struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
-        if (!tls_session_update_crypto_params(c->c2.tls_multi, session,
-                                              &c->options, &c->c2.frame,
-                                              frame_fragment,
-                                              get_link_socket_info(c)))
-        {
-            msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to import crypto options");
-            return false;
-        }
+    struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
+    if (!tls_session_update_crypto_params(c->c2.tls_multi, session,
+                                          &c->options, &c->c2.frame,
+                                          frame_fragment,
+                                          get_link_socket_info(c)))
+    {
+        msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to import crypto options");
+        return false;
     }
 
     return true;
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 5f412a33..9389e0db 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -97,6 +97,8 @@ void reset_coarse_timers(struct context *c);
 
 bool do_deferred_options(struct context *c, const unsigned int found);
 
+bool finish_options(struct context *c);
+
 void inherit_context_child(struct context *dest,
                            const struct context *src);
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index c72575ae..34ab90b4 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2405,6 +2405,13 @@ multi_client_connect_late_setup(struct multi_context *m,
     {
         mi->context.c2.tls_multi->multi_state = CAS_FAILED;
     }
+    /* Continue processing options only if authentication hasn't failed.
+     * Otherwise it does not make sense and we may operate on a non-configured
+     * client instance */
+    else
+    {
+        finish_options(&mi->context);
+    }
 
     /* send push reply if ready */
     if (mi->context.c2.push_request_received)
-- 
2.35.1


