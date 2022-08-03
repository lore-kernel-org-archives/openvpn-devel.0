From: Antonio Quartulli <a@...2181...>
Date: Wed,  3 Aug 2022 11:50:12 +0200
Message-Id: <20220803095012.24975-1-a@...2181...>
In-Reply-To: <20220803085114.15117-1-a@...2181...>
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4 11/25] dco: split option parsing routines
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

Changes from v3:
* call do_deferred_options_part2() only if !pulled_options. This is the
  same condition that triggered the call to do_deferred_options() in the
  first place, therefore part2 must follow the same logic.
* add extra comment in do_up to explain "step2" after open_tun()

Changes from v2:
* rename finish_options() to do_deferred_options_part2()
* add comments to explain why this new function is required
* remove invocation in multi.c: we already perform key generation as
  last step

Changes from v1:
* removed error message in case of failure of finish_options(). The
  latter already warns the user about the failure - no need to print
  another generic message.
---
 src/openvpn/init.c | 81 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 25 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 338d797b..de8faeb4 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2078,6 +2078,37 @@ options_hash_changed_or_zero(const struct sha256_digest *a,
            || !memcmp(a, &zero, sizeof(struct sha256_digest));
 }
 
+/**
+ * This function is expected to be invoked after open_tun() was performed.
+ *
+ * This kind of behaviour is required by DCO, because the following operations
+ * can be done only after the DCO device was created and the new peer was
+ * properly added.
+ */
+static bool
+do_deferred_options_part2(struct context *c)
+{
+    struct frame *frame_fragment = NULL;
+#ifdef ENABLE_FRAGMENT
+    if (c->options.ce.fragment)
+    {
+        frame_fragment = &c->c2.frame_fragment;
+    }
+#endif
+
+    struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
+    if (!tls_session_update_crypto_params(c->c2.tls_multi, session,
+                                          &c->options, &c->c2.frame,
+                                          frame_fragment,
+                                          get_link_socket_info(c)))
+    {
+        msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to import crypto options");
+        return false;
+    }
+
+    return true;
+}
+
 bool
 do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
 {
@@ -2093,14 +2124,6 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
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
@@ -2127,6 +2150,31 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
             }
         }
 
+        /* do_deferred_options_part2() and do_deferred_p2p_ncp() *must* be
+         * invoked after open_tun().
+         * This is required by DCO because we must have created the interface
+         * and added the peer before we can fiddle with the keys or any other
+         * data channel per-peer setting.
+         */
+        if (pulled_options)
+        {
+            if (!do_deferred_options_part2(c))
+            {
+                return false;
+            }
+        }
+        else
+        {
+            if (c->mode == MODE_POINT_TO_POINT)
+            {
+                if (!do_deferred_p2p_ncp(c))
+                {
+                    msg(D_TLS_ERRORS, "ERROR: Failed to apply P2P negotiated protocol options");
+                    return false;
+                }
+            }
+        }
+
         if (c->c2.did_open_tun)
         {
             c->c1.pulled_options_digest_save = c->c2.pulled_options_digest;
@@ -2332,23 +2380,6 @@ do_deferred_options(struct context *c, const unsigned int found)
         {
             return false;
         }
-        struct frame *frame_fragment = NULL;
-#ifdef ENABLE_FRAGMENT
-        if (c->options.ce.fragment)
-        {
-            frame_fragment = &c->c2.frame_fragment;
-        }
-#endif
-
-        struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
-        if (!tls_session_update_crypto_params(c->c2.tls_multi, session,
-                                              &c->options, &c->c2.frame,
-                                              frame_fragment,
-                                              get_link_socket_info(c)))
-        {
-            msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to import crypto options");
-            return false;
-        }
     }
 
     return true;
-- 
2.35.1


