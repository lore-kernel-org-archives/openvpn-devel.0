From: Arne Schwabe <arne@...1227...>
Date: Wed,  1 Mar 2023 14:53:53 +0100
Message-Id: <20230301135353.2811069-2-arne@...1227...>
In-Reply-To: <20230301135353.2811069-1-arne@...1227...>
References: <20230301135353.2811069-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Make sending plain text control message
 session aware
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

The control messages coming from auth pending should always be on the
session that triggered them (i.e. INITIAL or ACTIVE) and not always on the
active session. Rework the code path that trigger those messsages from
management and plugin/script to specify the TLS session.

We only support the two TLS sessions that are supposed to be active. TLS
sessions in any lame slot (TM_LAME or KS_LAME) are not considered to be
candidates for sending messages as these slots only serve to keep key
material around.

Unfortunately, this fix requires the management interface to be changed
to allow including the specific session the messages should to go to. As
there are very few users of this interface with auth-pending, I made this
a hard change instead of adding hacky workaround code that is not always
working correctly anyway.

send_control_channel_string will continue to only use the primary session
and key but the current users of that (push replys and exit notification)
already require the established session to be the active one, so there
no changes needed at the moment.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst              |  3 +++
 doc/management-notes.txt | 13 +++++++++----
 src/openvpn/forward.c    | 12 ++++++------
 src/openvpn/forward.h    | 11 ++++++-----
 src/openvpn/manage.c     | 13 ++++++++-----
 src/openvpn/manage.h     |  3 ++-
 src/openvpn/multi.c      | 20 +++++++++++++++++++-
 src/openvpn/push.c       | 27 +++++++++++++++++++--------
 src/openvpn/push.h       |  8 +++++---
 src/openvpn/ssl_verify.c |  9 +++++----
 10 files changed, 82 insertions(+), 37 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index c5335ce93..43f312fc6 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -223,6 +223,9 @@ User-visible Changes
   compatibility with older versions. See the manual page on the
   ``--compat-mode`` for details.
 
+- The ``client-pending-auth`` management command now requires also the
+  key id. The management version has been changed to 5 to indicate this change.
+
 Common errors with OpenSSL 3.0 and OpenVPN 2.6
 ----------------------------------------------
 Both OpenVPN 2.6 and OpenSSL 3.0 tighten the security considerable, so some
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 34f301db7..5c51bc997 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -613,10 +613,10 @@ COMMAND -- client-pending-auth  (OpenVPN 2.5 or higher)
 
 Instruct OpenVPN server to send AUTH_PENDING and INFO_PRE message
 to signal a pending authenticating to the client. A pending auth means
-that the connecting requires extra authentication like a one time
+that connecting requires extra authentication like a one time
 password or doing a single sign on via web.
 
-    client-pending-auth {CID} {EXTRA} {TIMEOUT}
+    client-pending-auth {CID} {KID} {EXTRA} {TIMEOUT}
 
 The server will send AUTH_PENDING and INFO_PRE,{EXTRA} to the client. If the
 client supports accepting keywords to AUTH_PENDING (announced via IV_PROTO),
@@ -639,11 +639,16 @@ Both client and server limit the maximum timeout to the smaller value of half th
 
 For the format of {EXTRA} see below. For OpenVPN server this is a stateless
 operation and needs to be followed by a client-deny/client-auth[-nt] command
-(that is the result of the out of band authentication).
+(that is the result of the out-of-band authentication).
+
+Note that the {KID} argument has been added in management version 5 to
+correctly allow specifing the pending client authentication the message is
+
+tying together this message strictly to the authentication
 
 Before issuing a client-pending-auth to a client instead of a
 client-auth/client-deny, the server should check the IV_SSO
-environment variable for whether the method is supported. Currently
+environment variable for whether the method is supported. Currently,
 defined methods are crtext for challenge/response using text
 (e.g., TOTP), openurl (deprecated) and webauth for opening a URL in
 the client to continue authentication. A client supporting webauth and
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 9bb099097..8fcd703c4 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -366,20 +366,20 @@ check_connection_established(struct context *c)
 }
 
 bool
-send_control_channel_string_dowork(struct tls_multi *multi,
+send_control_channel_string_dowork(struct tls_session *session,
                                    const char *str, int msglevel)
 {
     struct gc_arena gc = gc_new();
     bool stat;
 
-    ASSERT(multi);
-    struct key_state *ks = get_key_scan(multi, 0);
+    ASSERT(session);
+    struct key_state *ks = &session->key[KS_PRIMARY];
 
     /* buffered cleartext write onto TLS control channel */
     stat = tls_send_payload(ks, (uint8_t *) str, strlen(str) + 1);
 
     msg(msglevel, "SENT CONTROL [%s]: '%s' (status=%d)",
-        tls_common_name(multi, false),
+        session->common_name ? session->common_name : "UNDEF",
         sanitize_control_message(str, &gc),
         (int) stat);
 
@@ -399,8 +399,8 @@ send_control_channel_string(struct context *c, const char *str, int msglevel)
 {
     if (c->c2.tls_multi)
     {
-        bool ret = send_control_channel_string_dowork(c->c2.tls_multi,
-                                                      str, msglevel);
+        struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
+        bool ret = send_control_channel_string_dowork(session, str, msglevel);
         reschedule_multi_process(c);
 
         return ret;
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 7376bca23..e19115ea1 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -265,21 +265,22 @@ send_control_channel_string(struct context *c, const char *str, int msglevel);
 
 /*
  * Send a string to remote over the TLS control channel.
- * Used for push/pull messages, passing username/password,
- * etc.
+ * Used for push/pull messages, auth pending and other clear text
+ * control messages.
  *
  * This variant does not schedule the actual sending of the message
  * The caller needs to ensure that it is scheduled or call
  * send_control_channel_string
  *
- * @param multi      - The tls_multi structure of the VPN tunnel associated
- *                     with the packet.
+ * @param session    - The session structure of the VPN tunnel associated
+ *                     with the packet. The method will always use the
+ *                     primary key (KS_PRIMARY) for sending the message
  * @param str        - The message to be sent
  * @param msglevel   - Message level to use for logging
  */
 
 bool
-send_control_channel_string_dowork(struct tls_multi *multi,
+send_control_channel_string_dowork(struct tls_session *session,
                                    const char *str, int msglevel);
 
 
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index db88e3479..05358af45 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1042,22 +1042,25 @@ parse_uint(const char *str, const char *what, unsigned int *uint)
  *
  * @param man           The management interface struct
  * @param cid_str       The CID in string form
+ * @param kid_str       The key ID in string form
  * @param extra         The string to be send to the client containing
  *                      the information of the additional steps
  */
 static void
 man_client_pending_auth(struct management *man, const char *cid_str,
-                        const char *extra, const char *timeout_str)
+                        const char *kid_str, const char *extra,
+                        const char *timeout_str)
 {
     unsigned long cid = 0;
+    unsigned int kid = 0;
     unsigned int timeout = 0;
-    if (parse_cid(cid_str, &cid)
+    if (parse_cid(cid_str, &cid) && parse_uint(kid_str, "KID", &kid)
         && parse_uint(timeout_str, "TIMEOUT", &timeout))
     {
         if (man->persist.callback.client_pending_auth)
         {
             bool ret = (*man->persist.callback.client_pending_auth)
-                           (man->persist.callback.arg, cid, extra, timeout);
+                           (man->persist.callback.arg, cid, kid, extra, timeout);
 
             if (ret)
             {
@@ -1594,9 +1597,9 @@ man_dispatch_command(struct management *man, struct status_output *so, const cha
     }
     else if (streq(p[0], "client-pending-auth"))
     {
-        if (man_need(man, p, 3, 0))
+        if (man_need(man, p, 4, 0))
         {
-            man_client_pending_auth(man, p[1], p[2], p[3]);
+            man_client_pending_auth(man, p[1], p[2], p[3], p[4]);
         }
     }
     else if (streq(p[0], "rsa-sig"))
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 2ced90835..07317a402 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -52,7 +52,7 @@
 #include "socket.h"
 #include "mroute.h"
 
-#define MANAGEMENT_VERSION                      4
+#define MANAGEMENT_VERSION                      5
 #define MANAGEMENT_N_PASSWORD_RETRIES           3
 #define MANAGEMENT_LOG_HISTORY_INITIAL_SIZE   100
 #define MANAGEMENT_ECHO_BUFFER_SIZE           100
@@ -194,6 +194,7 @@ struct management_callback
                          struct buffer_list *cc_config); /* ownership transferred */
     bool (*client_pending_auth) (void *arg,
                                  const unsigned long cid,
+                                 const unsigned int kid,
                                  const char *extra,
                                  unsigned int timeout);
     char *(*get_peer_info) (void *arg, const unsigned long cid);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f25590168..14ec39dc5 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -4025,15 +4025,33 @@ management_kill_by_cid(void *arg, const unsigned long cid, const char *kill_msg)
 static bool
 management_client_pending_auth(void *arg,
                                const unsigned long cid,
+                               const unsigned int mda_key_id,
                                const char *extra,
                                unsigned int timeout)
 {
     struct multi_context *m = (struct multi_context *) arg;
     struct multi_instance *mi = lookup_by_cid(m, cid);
+
     if (mi)
     {
+        struct tls_multi *multi = mi->context.c2.tls_multi;
+        struct tls_session *session;
+
+        if (multi->session[TM_INITIAL].key[KS_PRIMARY].mda_key_id == mda_key_id)
+        {
+            session = &multi->session[TM_INITIAL];
+        }
+        else if (multi->session[TM_ACTIVE].key[KS_PRIMARY].mda_key_id == mda_key_id)
+        {
+            session = &multi->session[TM_ACTIVE];
+        }
+        else
+        {
+            return false;
+        }
+
         /* sends INFO_PRE and AUTH_PENDING messages to client */
-        bool ret = send_auth_pending_messages(mi->context.c2.tls_multi, extra,
+        bool ret = send_auth_pending_messages(multi, session, extra,
                                               timeout);
         reschedule_multi_process(&mi->context);
         multi_schedule_context_wakeup(m, mi);
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 4d64ad1af..3475cbda8 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -412,7 +412,16 @@ send_auth_failed(struct context *c, const char *client_reason)
         {
             buf_printf(&buf, ",%s", client_reason);
         }
-        send_control_channel_string(c, BSTR(&buf), D_PUSH);
+
+        /* We kill the whole session, send the AUTH_FAILED to any TLS session
+         * that might be active */
+        send_control_channel_string_dowork(&c->c2.tls_multi->session[TM_INITIAL],
+                                           BSTR(&buf), D_PUSH);
+        send_control_channel_string_dowork(&c->c2.tls_multi->session[TM_ACTIVE],
+                                           BSTR(&buf), D_PUSH);
+
+        reschedule_multi_process(c);
+
     }
 
     gc_free(&gc);
@@ -420,10 +429,11 @@ send_auth_failed(struct context *c, const char *client_reason)
 
 
 bool
-send_auth_pending_messages(struct tls_multi *tls_multi, const char *extra,
-                           unsigned int timeout)
+send_auth_pending_messages(struct tls_multi *tls_multi,
+                           struct tls_session *session,
+                           const char *extra, unsigned int timeout)
 {
-    struct key_state *ks = get_key_scan(tls_multi, 0);
+    struct key_state *ks = &session->key[KS_PRIMARY];
 
     static const char info_pre[] = "INFO_PRE,";
 
@@ -440,7 +450,7 @@ send_auth_pending_messages(struct tls_multi *tls_multi, const char *extra,
     struct gc_arena gc = gc_new();
     if ((proto & IV_PROTO_AUTH_PENDING_KW) == 0)
     {
-        send_control_channel_string_dowork(tls_multi, "AUTH_PENDING", D_PUSH);
+        send_control_channel_string_dowork(session, "AUTH_PENDING", D_PUSH);
     }
     else
     {
@@ -451,7 +461,7 @@ send_auth_pending_messages(struct tls_multi *tls_multi, const char *extra,
         struct buffer buf = alloc_buf_gc(len, &gc);
         buf_printf(&buf, auth_pre);
         buf_printf(&buf, "%u", timeout);
-        send_control_channel_string_dowork(tls_multi, BSTR(&buf), D_PUSH);
+        send_control_channel_string_dowork(session, BSTR(&buf), D_PUSH);
     }
 
     size_t len = strlen(extra) + 1 + sizeof(info_pre);
@@ -464,7 +474,7 @@ send_auth_pending_messages(struct tls_multi *tls_multi, const char *extra,
     struct buffer buf = alloc_buf_gc(len, &gc);
     buf_printf(&buf, info_pre);
     buf_printf(&buf, "%s", extra);
-    send_control_channel_string_dowork(tls_multi, BSTR(&buf), D_PUSH);
+    send_control_channel_string_dowork(session, BSTR(&buf), D_PUSH);
 
     ks->auth_deferred_expire = now + timeout;
 
@@ -736,6 +746,7 @@ send_push_reply_auth_token(struct tls_multi *multi)
 {
     struct gc_arena gc = gc_new();
     struct push_list push_list = { 0 };
+    struct tls_session *session = &multi->session[TM_ACTIVE];
 
     prepare_auth_token_push_reply(multi, &gc, &push_list);
 
@@ -746,7 +757,7 @@ send_push_reply_auth_token(struct tls_multi *multi)
     /* Construct a mimimal control channel push reply message */
     struct buffer buf = alloc_buf_gc(PUSH_BUNDLE_SIZE, &gc);
     buf_printf(&buf, "%s,%s", push_reply_cmd, e->option);
-    send_control_channel_string_dowork(multi, BSTR(&buf), D_PUSH);
+    send_control_channel_string_dowork(session, BSTR(&buf), D_PUSH);
     gc_free(&gc);
 }
 
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 5e594a30a..f43ab0966 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -78,16 +78,18 @@ void send_auth_failed(struct context *c, const char *client_reason);
  * more details on message format
  */
 bool
-send_auth_pending_messages(struct tls_multi *tls_multi, const char *extra,
+send_auth_pending_messages(struct tls_multi *tls_multi,
+                           struct tls_session *session, const char *extra,
                            unsigned int timeout);
 
 void send_restart(struct context *c, const char *kill_msg);
 
 /**
  * Sends a push reply message only containin the auth-token to update
- * the auth-token on the client
+ * the auth-token on the client. Always pushes to the active session
  *
- * @param multi  - The tls_multi structure belonging to the instance to push to
+ * @param multi    - The \c tls_multi structure belonging to the instance
+ *                   to push to
  */
 void send_push_reply_auth_token(struct tls_multi *multi);
 
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 996aee01f..1b589f1a6 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -916,7 +916,8 @@ check_auth_pending_method(const char *peer_info, const char *method)
  */
 static bool
 key_state_check_auth_pending_file(struct auth_deferred_status *ads,
-                                  struct tls_multi *multi)
+                                  struct tls_multi *multi,
+                                  struct tls_session *session)
 {
     bool ret = true;
     if (ads->auth_pending_file)
@@ -965,7 +966,7 @@ key_state_check_auth_pending_file(struct auth_deferred_status *ads,
             }
             else
             {
-                send_auth_pending_messages(multi, BSTR(extra_buf), timeout);
+                send_auth_pending_messages(multi, session, BSTR(extra_buf), timeout);
             }
         }
 
@@ -1390,7 +1391,7 @@ verify_user_pass_script(struct tls_session *session, struct tls_multi *multi,
         /* Check if we the plugin has written the pending auth control
          * file and send the pending auth to the client */
         if (!key_state_check_auth_pending_file(&ks->script_auth,
-                                               multi))
+                                               multi, session))
         {
             retval = OPENVPN_PLUGIN_FUNC_ERROR;
             key_state_rm_auth_control_files(&ks->script_auth);
@@ -1514,7 +1515,7 @@ verify_user_pass_plugin(struct tls_session *session, struct tls_multi *multi,
     {
         /* Check if the plugin has written the pending auth control
          * file and send the pending auth to the client */
-        if (!key_state_check_auth_pending_file(&ks->plugin_auth, multi))
+        if (!key_state_check_auth_pending_file(&ks->plugin_auth, multi, session))
         {
             retval = OPENVPN_PLUGIN_FUNC_ERROR;
         }
-- 
2.37.1 (Apple Git-137.1)


