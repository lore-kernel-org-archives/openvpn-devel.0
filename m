From: Arne Schwabe <arne@...1227...>
Date: Fri, 23 Oct 2020 14:02:56 +0200
Message-Id: <20201023120259.29783-4-arne@...1227...>
In-Reply-To: <20201023120259.29783-1-arne@...1227...>
References: <20201023113244.26295-1-arne@...1227...>
 <20201023120259.29783-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 5/8] Clean up tls_authentication_status and
 document it
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

The gain of the used optimisation approach of using a array with a
calculated index in favour of simple ifs is questionable with modern
compilers and the readability of the function suffers.

Also change the return type from simple int to an enum and add comments
and doxygen documentation.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/push.c       |   3 +-
 src/openvpn/ssl.c        |   2 +-
 src/openvpn/ssl_verify.c | 108 +++++++++++++++------------------------
 src/openvpn/ssl_verify.h |  35 +++++++++----
 4 files changed, 70 insertions(+), 78 deletions(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 19004077..26a6201f 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -736,7 +736,8 @@ process_incoming_push_request(struct context *c)
 {
     int ret = PUSH_MSG_ERROR;
 
-    if (tls_authentication_status(c->c2.tls_multi, 0) == TLS_AUTHENTICATION_FAILED || c->c2.context_auth == CAS_FAILED)
+    if ((c->c2.tls_multi && tls_authentication_status(c->c2.tls_multi, 0) == TLS_AUTHENTICATION_FAILED)
+        || c->c2.context_auth == CAS_FAILED)
     {
         const char *client_reason = tls_client_reason(c->c2.tls_multi);
         send_auth_failed(c, client_reason);
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 79ad322a..e59dba31 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3196,7 +3196,7 @@ tls_multi_process(struct tls_multi *multi,
 
     update_time();
 
-    int tas = tls_authentication_status(multi, TLS_MULTI_AUTH_STATUS_INTERVAL);
+    enum tls_auth_status tas = tls_authentication_status(multi, TLS_MULTI_AUTH_STATUS_INTERVAL);
 
     /*
      * If lame duck session expires, kill it.
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 862a6f56..4172e2fd 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -928,86 +928,56 @@ key_state_test_auth_control_file(struct key_state *ks)
     return ACF_DISABLED;
 }
 
-/*
- * Return current session authentication state.  Return
- * value is TLS_AUTHENTICATION_x.
- */
-
-int
+enum tls_auth_status
 tls_authentication_status(struct tls_multi *multi, const int latency)
 {
     bool deferred = false;
+
+    /* at least one valid key has successfully completed authentication */
     bool success = false;
-    bool active = false;
-
-    static const unsigned char acf_merge[] =
-    {
-        ACF_UNDEFINED, /* s1=ACF_UNDEFINED s2=ACF_UNDEFINED */
-        ACF_UNDEFINED, /* s1=ACF_UNDEFINED s2=ACF_SUCCEEDED */
-        ACF_UNDEFINED, /* s1=ACF_UNDEFINED s2=ACF_DISABLED */
-        ACF_FAILED,  /* s1=ACF_UNDEFINED s2=ACF_FAILED */
-        ACF_UNDEFINED, /* s1=ACF_SUCCEEDED s2=ACF_UNDEFINED */
-        ACF_SUCCEEDED, /* s1=ACF_SUCCEEDED s2=ACF_SUCCEEDED */
-        ACF_SUCCEEDED, /* s1=ACF_SUCCEEDED s2=ACF_DISABLED */
-        ACF_FAILED,  /* s1=ACF_SUCCEEDED s2=ACF_FAILED */
-        ACF_UNDEFINED, /* s1=ACF_DISABLED  s2=ACF_UNDEFINED */
-        ACF_SUCCEEDED, /* s1=ACF_DISABLED  s2=ACF_SUCCEEDED */
-        ACF_DISABLED, /* s1=ACF_DISABLED  s2=ACF_DISABLED */
-        ACF_FAILED,  /* s1=ACF_DISABLED  s2=ACF_FAILED */
-        ACF_FAILED,  /* s1=ACF_FAILED    s2=ACF_UNDEFINED */
-        ACF_FAILED,  /* s1=ACF_FAILED    s2=ACF_SUCCEEDED */
-        ACF_FAILED,  /* s1=ACF_FAILED    s2=ACF_DISABLED */
-        ACF_FAILED   /* s1=ACF_FAILED    s2=ACF_FAILED */
-    };
 
-    if (multi)
-    {
-        int i;
+    /* at least one key is enabled for decryption */
+    int active = 0;
 
-        if (latency && multi->tas_last && multi->tas_last + latency >= now)
-        {
-            return TLS_AUTHENTICATION_UNDEFINED;
-        }
-        multi->tas_last = now;
+    if (latency && multi->tas_last + latency >= now)
+    {
+        return TLS_AUTHENTICATION_UNDEFINED;
+    }
+    multi->tas_last = now;
 
-        for (i = 0; i < KEY_SCAN_SIZE; ++i)
+    for (int i = 0; i < KEY_SCAN_SIZE; ++i)
+    {
+        struct key_state *ks = get_key_scan(multi, i);
+        if (DECRYPT_KEY_ENABLED(multi, ks))
         {
-            struct key_state *ks = get_key_scan(multi, i);
-            if (DECRYPT_KEY_ENABLED(multi, ks))
+            active++;
+            if (ks->authenticated > KS_AUTH_FALSE)
             {
-                active = true;
-                if (ks->authenticated > KS_AUTH_FALSE)
-                {
-                    unsigned int s1 = ACF_DISABLED;
-                    unsigned int s2 = ACF_DISABLED;
-                    s1 = key_state_test_auth_control_file(ks);
+                unsigned int s1 = ACF_DISABLED;
+                unsigned int s2 = ACF_DISABLED;
+                s1 = key_state_test_auth_control_file(ks);
 #ifdef ENABLE_MANAGEMENT
-                    s2 = man_def_auth_test(ks);
+                s2 = man_def_auth_test(ks);
 #endif
-                    ASSERT(s1 < 4 && s2 < 4);
-                    switch (acf_merge[(s1<<2) + s2])
+                ASSERT(s1 < 4 && s2 < 4);
+
+                if (s1 == ACF_FAILED || s2 == ACF_FAILED)
+                {
+                    ks->authenticated = KS_AUTH_FALSE;
+                }
+                else if (s1 == ACF_UNDEFINED || s2 == ACF_UNDEFINED)
+                {
+                    if (now < ks->auth_deferred_expire)
                     {
-                        case ACF_SUCCEEDED:
-                        case ACF_DISABLED:
-                            success = true;
-                            ks->authenticated = KS_AUTH_TRUE;
-                            break;
-
-                        case ACF_UNDEFINED:
-                            if (now < ks->auth_deferred_expire)
-                            {
-                                deferred = true;
-                            }
-                            break;
-
-                        case ACF_FAILED:
-                            ks->authenticated = KS_AUTH_FALSE;
-                            break;
-
-                        default:
-                            ASSERT(0);
+                        deferred = true;
                     }
                 }
+                else
+                {
+                    /* s1 and s2 are either ACF_DISABLED or ACF_SUCCEDED */
+                    success = true;
+                    ks->authenticated = KS_AUTH_TRUE;
+                }
             }
         }
     }
@@ -1020,12 +990,16 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
     {
         return TLS_AUTHENTICATION_SUCCEEDED;
     }
-    else if (!active || deferred)
+    else if (active == 0 || deferred)
     {
+        /* We have a deferred authentication and no currently active key
+         * (first auth, no renegotiation)  */
         return TLS_AUTHENTICATION_DEFERRED;
     }
     else
     {
+        /* at least one key is active but none is fully authenticated (!success)
+         * and all active are either failed authed or expired deferred auth */
         return TLS_AUTHENTICATION_FAILED;
     }
 }
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index d913f102..b3fe25d2 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -65,18 +65,35 @@ struct cert_hash_set {
 #define VERIFY_X509_SUBJECT_RDN         2
 #define VERIFY_X509_SUBJECT_RDN_PREFIX  3
 
-#define TLS_AUTHENTICATION_SUCCEEDED  0
-#define TLS_AUTHENTICATION_FAILED     1
-#define TLS_AUTHENTICATION_DEFERRED   2
-#define TLS_AUTHENTICATION_UNDEFINED  3
+enum tls_auth_status
+{
+    TLS_AUTHENTICATION_SUCCEEDED=0,
+    TLS_AUTHENTICATION_FAILED=1,
+    TLS_AUTHENTICATION_DEFERRED=2,
+    TLS_AUTHENTICATION_UNDEFINED=3
+};
 
-/*
- * Return current session authentication state.  Return
- * value is TLS_AUTHENTICATION_x.
+/**
+ * Return current session authentication state of the tls_multi structure
+ * This will return TLS_AUTHENTICATION_SUCCEEDED only if the session is
+ * fully authenicated, i.e. VPN traffic is allowed over it.
+ *
+ * Checks the status of all active keys and checks if the deferred
+ * authentication has succeeded.
+ *
+ * As a side effect this function will also transition ks->authenticated
+ * from KS_AUTH_DEFERRED to KS_AUTH_FALSE/KS_AUTH_TRUE if the deferred
+ * authentication has succeeded after last call.
+ *
+ * @param   latency     if not null,  return TLS_AUTHENTICATION_UNDEFINED if
+ *                      the last call for this multi struct has been less
+ *                      than latency seconds ago
+ * @param   multi       the tls_multi struct to operate on
  *
- * TODO: document this function
+ * @return              Current authentication status of the tls_multi
  */
-int tls_authentication_status(struct tls_multi *multi, const int latency);
+enum tls_auth_status
+tls_authentication_status(struct tls_multi *multi, const int latency);
 
 /** Check whether the \a ks \c key_state is ready to receive data channel
  *   packets.
-- 
2.26.2


