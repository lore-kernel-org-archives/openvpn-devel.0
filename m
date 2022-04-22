From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 16:29:40 +0200
Message-Id: <20220422142953.3805364-6-arne@...1227...>
In-Reply-To: <20220422142953.3805364-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 15/28] Remove pointless indentation from
 tls_process.
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

This is probably a result from earlier code that still needed to be
C89 compatible add probably added this to allow variable decleration
---
 src/openvpn/ssl.c | 56 +++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 15af58949..097be8c02 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2774,45 +2774,43 @@ tls_process(struct tls_multi *multi,
     }
 
     /* When should we wake up again? */
+    if (ks->state >= S_INITIAL)
     {
-        if (ks->state >= S_INITIAL)
-        {
-            compute_earliest_wakeup(wakeup,
-                                    reliable_send_timeout(ks->send_reliable));
-
-            if (ks->must_negotiate)
-            {
-                compute_earliest_wakeup(wakeup, ks->must_negotiate - now);
-            }
-        }
+        compute_earliest_wakeup(wakeup,
+                                reliable_send_timeout(ks->send_reliable));
 
-        if (ks->established && session->opt->renegotiate_seconds)
+        if (ks->must_negotiate)
         {
-            compute_earliest_wakeup(wakeup,
-                                    ks->established + session->opt->renegotiate_seconds - now);
+            compute_earliest_wakeup(wakeup, ks->must_negotiate - now);
         }
+    }
 
-        dmsg(D_TLS_DEBUG, "TLS: tls_process: timeout set to %d", *wakeup);
+    if (ks->established && session->opt->renegotiate_seconds)
+    {
+        compute_earliest_wakeup(wakeup,
+                                ks->established + session->opt->renegotiate_seconds - now);
+    }
 
-        /* prevent event-loop spinning by setting minimum wakeup of 1 second */
-        if (*wakeup <= 0)
-        {
-            *wakeup = 1;
+    dmsg(D_TLS_DEBUG, "TLS: tls_process: timeout set to %d", *wakeup);
 
-            /* if we had something to send to remote, but to_link was busy,
-             * let caller know we need to be called again soon */
-            return true;
-        }
+    /* prevent event-loop spinning by setting minimum wakeup of 1 second */
+    if (*wakeup <= 0)
+    {
+        *wakeup = 1;
 
-        /* If any of the state changes resulted in the to_link buffer being
-         * set, we are also active */
-        if (to_link->len)
-        {
-            return true;
-        }
+        /* if we had something to send to remote, but to_link was busy,
+         * let caller know we need to be called again soon */
+        return true;
+    }
 
-        return false;
+    /* If any of the state changes resulted in the to_link buffer being
+     * set, we are also active */
+    if (to_link->len)
+    {
+        return true;
     }
+
+    return false;
 }
 
 /*
-- 
2.32.0 (Apple Git-132)


