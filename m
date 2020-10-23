From: Arne Schwabe <arne@...1227...>
Date: Fri, 23 Oct 2020 14:02:59 +0200
Message-Id: <20201023120259.29783-7-arne@...1227...>
In-Reply-To: <20201023120259.29783-1-arne@...1227...>
References: <20201023113244.26295-1-arne@...1227...>
 <20201023120259.29783-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 8/8] Make any auth failure
 tls_authentication_status return auth failed
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

Previously tls_authentication_status only return
TLS_AUTHENTICATION_FAILED if there is no usable key at all. This
behaviour allows continuing using the still valid keys
(see --tran-window). However, the OpenVPN protocol lacks a way of
communicating that key is not useable to client once it reached
the TLS authenticated status (eg cert checks pass but connect or
user-pass verify fail). To avoid these desynchronisation issues
during deferred auth and renegotiation OpenVPN quietly only starts
using a new key after the hand-window has passed.

With this change any failure on a renogiation will lead to a
deauthentication of a client. This also fixes a number of bugs that
expiring auth-token and failed deferred auth is leading to key desync
or unexpected continuation of the VPN session.

The behaviour of deauthentication of all keys on deferred auth failure
has been already been used for years if authentication is done via
management interface. This commit also aligns the code paths for both.

A side effect might be that we also deauth clients earlier in some
other corner cases but the behaviour of continuing using an old
authenticated session while we already a failed authentication for the
client is most times unexpected behaviour from the user (admin).

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c      | 12 ++----------
 src/openvpn/ssl_verify.c | 25 +++++++++++++++++++++----
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 9becb2b2..401dfa8e 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3963,17 +3963,9 @@ management_client_auth(void *arg,
                     cc_config_owned = false;
                 }
             }
-            else
+            else if (reason)
             {
-                if (reason)
-                {
-                    msg(D_MULTI_LOW, "MULTI: connection rejected: %s, CLI:%s", reason, np(client_reason));
-                }
-                if (!is_cas_pending(mi->context.c2.context_auth))
-                {
-                    send_auth_failed(&mi->context, client_reason); /* mid-session reauth failed */
-                    multi_schedule_context_wakeup(m, mi);
-                }
+                msg(D_MULTI_LOW, "MULTI: connection rejected: %s, CLI:%s", reason, np(client_reason));
             }
         }
     }
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 98985c51..a4538d38 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -939,6 +939,9 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
     /* at least one key is enabled for decryption */
     int active = 0;
 
+    /* at least one key already failed authentication */
+    bool failed_auth = false;
+
     if (latency && multi->tas_last + latency >= now)
     {
         return TLS_AUTHENTICATION_UNDEFINED;
@@ -951,7 +954,11 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
         if (TLS_AUTHENTICATED(multi, ks))
         {
             active++;
-            if (ks->authenticated > KS_AUTH_FALSE)
+            if (ks->authenticated == KS_AUTH_FALSE)
+            {
+                failed_auth = true;
+            }
+            else
             {
                 unsigned int s1 = ACF_DISABLED;
                 unsigned int s2 = ACF_DISABLED;
@@ -964,6 +971,7 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
                 if (s1 == ACF_FAILED || s2 == ACF_FAILED)
                 {
                     ks->authenticated = KS_AUTH_FALSE;
+                    failed_auth = true;
                 }
                 else if (s1 == ACF_UNDEFINED || s2 == ACF_UNDEFINED)
                 {
@@ -983,10 +991,19 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
     }
 
 #if 0
-    dmsg(D_TLS_ERRORS, "TAS: a=%d s=%d d=%d", active, success, deferred);
+    dmsg(D_TLS_ERRORS, "TAS: a=%d s=%d d=%d f=%d", active, success, deferred, failed_auth);
 #endif
-
-    if (success)
+    if (failed_auth)
+    {
+        /* We have at least one session that failed authentication. There
+         * might be still another session with valid keys.
+         * Although our protocol allows keeping the VPN session alive
+         * with the other session (and we actually did that in earlier
+         * version, this behaviour is really strange from a user (admin)
+         * experience */
+        return TLS_AUTHENTICATION_FAILED;
+    }
+    else if (success)
     {
         return TLS_AUTHENTICATION_SUCCEEDED;
     }
-- 
2.26.2


