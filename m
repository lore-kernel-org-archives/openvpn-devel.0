From: Arne Schwabe <arne@...1227...>
Date: Fri, 20 May 2022 23:32:48 +0200
Message-Id: <20220520213250.3126372-3-arne@...1227...>
In-Reply-To: <20220520213250.3126372-1-arne@...1227...>
References: <20220520213250.3126372-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 2/4] Cleanup receive_auth_failed and
 simplify method
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

This simplifies the buffer handling in the method and adds a quick
return instead of wrapping the whole method in a if (pull) block

Patch V2: remove uncessary ifdef/endif and unnecassary block
---
 src/openvpn/push.c | 99 ++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 48 deletions(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index fa0def7f8..1c4e637e4 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -53,64 +53,67 @@ receive_auth_failed(struct context *c, const struct buffer *buffer)
     msg(M_VERB0, "AUTH: Received control message: %s", BSTR(buffer));
     c->options.no_advance = true;
 
-    if (c->options.pull)
+    if (!c->options.pull)
     {
-        /* Before checking how to react on AUTH_FAILED, first check if the
-         * failed auth might be the result of an expired auth-token.
-         * Note that a server restart will trigger a generic AUTH_FAILED
-         * instead an AUTH_FAILED,SESSION so handle all AUTH_FAILED message
-         * identical for this scenario */
-        if (ssl_clean_auth_token())
-        {
-            c->sig->signal_received = SIGUSR1; /* SOFT-SIGUSR1 -- Auth failure error */
-            c->sig->signal_text = "auth-failure (auth-token)";
-        }
-        else
+        return;
+    }
+
+    struct buffer buf = *buffer;
+
+    /* If the AUTH_FAIL message ends with a , it is an extended message that
+     * contains further flags */
+    bool authfail_extended = buf_string_compare_advance(&buf, "AUTH_FAILED,");
+
+    /* Before checking how to react on AUTH_FAILED, first check if the
+     * failed auth might be the result of an expired auth-token.
+     * Note that a server restart will trigger a generic AUTH_FAILED
+     * instead an AUTH_FAILED,SESSION so handle all AUTH_FAILED message
+     * identical for this scenario */
+    if (ssl_clean_auth_token())
+    {
+        c->sig->signal_received = SIGUSR1;     /* SOFT-SIGUSR1 -- Auth failure error */
+        c->sig->signal_text = "auth-failure (auth-token)";
+    }
+    else
+    {
+        switch (auth_retry_get())
         {
-            switch (auth_retry_get())
-            {
-                case AR_NONE:
-                    c->sig->signal_received = SIGTERM; /* SOFT-SIGTERM -- Auth failure error */
-                    break;
+            case AR_NONE:
+                c->sig->signal_received = SIGTERM;     /* SOFT-SIGTERM -- Auth failure error */
+                break;
 
-                case AR_INTERACT:
-                    ssl_purge_auth(false);
+            case AR_INTERACT:
+                ssl_purge_auth(false);
 
-                case AR_NOINTERACT:
-                    c->sig->signal_received = SIGUSR1; /* SOFT-SIGUSR1 -- Auth failure error */
-                    break;
+            case AR_NOINTERACT:
+                c->sig->signal_received = SIGUSR1;     /* SOFT-SIGUSR1 -- Auth failure error */
+                break;
 
-                default:
-                    ASSERT(0);
-            }
-            c->sig->signal_text = "auth-failure";
+            default:
+                ASSERT(0);
         }
+        c->sig->signal_text = "auth-failure";
+    }
 #ifdef ENABLE_MANAGEMENT
-        if (management)
-        {
-            const char *reason = NULL;
-            struct buffer buf = *buffer;
-            if (buf_string_compare_advance(&buf, "AUTH_FAILED,") && BLEN(&buf))
-            {
-                reason = BSTR(&buf);
-            }
-            management_auth_failure(management, UP_TYPE_AUTH, reason);
-        }
-#endif
-        /*
-         * Save the dynamic-challenge text even when management is defined
-         */
+    if (management)
+    {
+        const char *reason = NULL;
+        if (authfail_extended && BLEN(&buf))
         {
-#ifdef ENABLE_MANAGEMENT
-            struct buffer buf = *buffer;
-            if (buf_string_match_head_str(&buf, "AUTH_FAILED,CRV1:") && BLEN(&buf))
-            {
-                buf_advance(&buf, 12); /* Length of "AUTH_FAILED," substring */
-                ssl_put_auth_challenge(BSTR(&buf));
-            }
-#endif
+            reason = BSTR(&buf);
         }
+        management_auth_failure(management, UP_TYPE_AUTH, reason);
+    }
+    /*
+     * Save the dynamic-challenge text even when management is defined
+     */
+    if (authfail_extended
+        && buf_string_match_head_str(&buf, "CRV1:") && BLEN(&buf))
+    {
+        ssl_put_auth_challenge(BSTR(&buf));
     }
+#endif
+
 }
 
 /*
-- 
2.32.0 (Apple Git-132)


