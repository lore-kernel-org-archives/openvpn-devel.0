From: Arne Schwabe <arne@...1227...>
Date: Wed,  9 Dec 2020 15:20:43 +0100
Message-Id: <20201209142045.4489-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/3] Move restoring pr pull options to
 initialising of c2 context
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

We currently delay restoring these options until we actually must
restore them. Since there is no reason to do so apart from the very
minor saving to not have to execute that code when a connection fails,
move them it into the general context_2 initialisation.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c    | 5 +++++
 src/openvpn/openvpn.h | 1 -
 src/openvpn/push.c    | 5 -----
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c3493c42..2f44befe 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4184,6 +4184,11 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
         }
     }
 
+    if (c->options.pull)
+    {
+        pre_pull_restore(&c->options, &c->c2.gc);
+    }
+
     /* map in current connection entry */
     next_connection_entry(c);
 
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 4ca89ba9..ece85e88 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -463,7 +463,6 @@ struct context_2
 
     struct event_timeout push_request_interval;
     int n_sent_push_requests;
-    bool did_pre_pull_restore;
 
     /* hash of pulled options, so we can compare when options change */
     bool pulled_options_digest_init_done;
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 26a6201f..95c28ff1 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -812,11 +812,6 @@ process_incoming_push_reply(struct context *c,
             md_ctx_init(c->c2.pulled_options_state, md_kt_get("SHA256"));
             c->c2.pulled_options_digest_init_done = true;
         }
-        if (!c->c2.did_pre_pull_restore)
-        {
-            pre_pull_restore(&c->options, &c->c2.gc);
-            c->c2.did_pre_pull_restore = true;
-        }
         if (apply_push_options(&c->options,
                                buf,
                                permission_mask,
-- 
2.26.2


