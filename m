From: Arne Schwabe <arne@...1227...>
Date: Mon, 25 Jan 2021 13:56:20 +0100
Message-Id: <20210125125628.30364-4-arne@...1227...>
In-Reply-To: <20210125125628.30364-1-arne@...1227...>
References: <20210125125628.30364-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 03/11] Implement server side of
 AUTH_PENDING with extending timeout
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

Patch V2: eliminate parse_kid function, fix style

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/manage.c     | 23 +++++++++--------
 src/openvpn/manage.h     |  3 ++-
 src/openvpn/multi.c      | 27 +++-----------------
 src/openvpn/push.c       | 55 +++++++++++++++++++++++++++++++++++++---
 src/openvpn/push.h       | 10 ++++++++
 src/openvpn/ssl.c        |  1 +
 src/openvpn/ssl_common.h |  1 +
 7 files changed, 81 insertions(+), 39 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index ed9dde1e..98a9a4cc 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -972,15 +972,15 @@ parse_cid(const char *str, unsigned long *cid)
 }
 
 static bool
-parse_kid(const char *str, unsigned int *kid)
+parse_uint(const char *str, const char* what, unsigned int *uint)
 {
-    if (sscanf(str, "%u", kid) == 1)
+    if (sscanf(str, "%u", uint) == 1)
     {
         return true;
     }
     else
     {
-        msg(M_CLIENT, "ERROR: cannot parse KID");
+        msg(M_CLIENT, "ERROR: cannot parse %s", what);
         return false;
     }
 }
@@ -995,15 +995,18 @@ parse_kid(const char *str, unsigned int *kid)
  *                      the information of the additional steps
  */
 static void
-man_client_pending_auth(struct management *man, const char *cid_str, const char *extra)
+man_client_pending_auth(struct management *man, const char *cid_str,
+                        const char *extra, const char *timeout_str)
 {
     unsigned long cid = 0;
-    if (parse_cid(cid_str, &cid))
+    unsigned int timeout = 0;
+    if (parse_cid(cid_str, &cid)
+        && parse_uint(timeout_str, "TIMEOUT", &timeout))
     {
         if (man->persist.callback.client_pending_auth)
         {
             bool ret = (*man->persist.callback.client_pending_auth)
-                           (man->persist.callback.arg, cid, extra);
+                           (man->persist.callback.arg, cid, extra, timeout);
 
             if (ret)
             {
@@ -1029,7 +1032,7 @@ man_client_auth(struct management *man, const char *cid_str, const char *kid_str
     mc->in_extra_cid = 0;
     mc->in_extra_kid = 0;
     if (parse_cid(cid_str, &mc->in_extra_cid)
-        && parse_kid(kid_str, &mc->in_extra_kid))
+        && parse_uint(kid_str, "KID", &mc->in_extra_kid))
     {
         mc->in_extra_cmd = IEC_CLIENT_AUTH;
         in_extra_reset(mc, IER_NEW);
@@ -1045,7 +1048,7 @@ man_client_deny(struct management *man, const char *cid_str, const char *kid_str
 {
     unsigned long cid = 0;
     unsigned int kid = 0;
-    if (parse_cid(cid_str, &cid) && parse_kid(kid_str, &kid))
+    if (parse_cid(cid_str, &cid) && parse_uint(kid_str, "KID", &kid))
     {
         if (man->persist.callback.client_auth)
         {
@@ -1560,9 +1563,9 @@ man_dispatch_command(struct management *man, struct status_output *so, const cha
     }
     else if (streq(p[0], "client-pending-auth"))
     {
-        if (man_need(man, p, 2, 0))
+        if (man_need(man, p, 3, 0))
         {
-            man_client_pending_auth(man, p[1], p[2]);
+            man_client_pending_auth(man, p[1], p[2], p[3]);
         }
     }
 #ifdef MANAGEMENT_PF
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index a3364644..aaa3b848 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -173,7 +173,8 @@ struct management_callback
                          struct buffer_list *cc_config); /* ownership transferred */
     bool (*client_pending_auth) (void *arg,
                                  const unsigned long cid,
-                                 const char *url);
+                                 const char *extra,
+                                 unsigned int timeout);
     char *(*get_peer_info) (void *arg, const unsigned long cid);
 #ifdef MANAGEMENT_PF
     bool (*client_pf)(void *arg,
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index dd713049..ac5d3f5b 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1768,28 +1768,6 @@ multi_client_connect_setenv(struct multi_context *m,
     gc_free(&gc);
 }
 
-/**
- * Extracts the IV_PROTO variable and returns its value or 0
- * if it cannot be extracted.
- *
- */
-static unsigned int
-extract_iv_proto(const char *peer_info)
-{
-
-    const char *optstr = peer_info ? strstr(peer_info, "IV_PROTO=") : NULL;
-    if (optstr)
-    {
-        int proto = 0;
-        int r = sscanf(optstr, "IV_PROTO=%d", &proto);
-        if (r == 1 && proto > 0)
-        {
-            return proto;
-        }
-    }
-    return 0;
-}
-
 /**
  * Calculates the options that depend on the client capabilities
  * based on local options and available peer info
@@ -3918,14 +3896,15 @@ management_kill_by_cid(void *arg, const unsigned long cid, const char *kill_msg)
 static bool
 management_client_pending_auth(void *arg,
                                const unsigned long cid,
-                               const char *extra)
+                               const char *extra,
+                               unsigned int timeout)
 {
     struct multi_context *m = (struct multi_context *) arg;
     struct multi_instance *mi = lookup_by_cid(m, cid);
     if (mi)
     {
         /* sends INFO_PRE and AUTH_PENDING messages to client */
-        bool ret = send_auth_pending_messages(&mi->context, extra);
+        bool ret = send_auth_pending_messages(&mi->context, extra, timeout);
         multi_schedule_context_wakeup(m, mi);
         return ret;
     }
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 2ceee2c4..e68fda9f 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -343,26 +343,57 @@ send_auth_failed(struct context *c, const char *client_reason)
     gc_free(&gc);
 }
 
+
 bool
-send_auth_pending_messages(struct context *c, const char *extra)
+send_auth_pending_messages(struct context *c, const char *extra,
+                           unsigned int timeout)
 {
-    send_control_channel_string(c, "AUTH_PENDING", D_PUSH);
+    struct key_state *ks = &tls_multi->session[TM_ACTIVE].key[KS_PRIMARY];
 
     static const char info_pre[] = "INFO_PRE,";
 
+    struct tls_multi *tls_multi = c->c2.tls_multi;
+    const char *const peer_info = tls_multi->peer_info;
+    unsigned int proto = extract_iv_proto(peer_info);
+
 
-    size_t len = strlen(extra)+1 + sizeof(info_pre);
+    /* Calculate the maximum timeout and subtract the time we already waited */
+    unsigned int max_timeout = max_uint(tls_multi->opt.renegotiate_seconds/2,
+                                        tls_multi->opt.handshake_window);
+    max_timeout = max_timeout - (now - ks->initial);
+    timeout = min_uint(max_timeout, timeout);
+
+    struct gc_arena gc = gc_new();
+    if ((proto & IV_PROTO_AUTH_PENDING_KW) == 0)
+    {
+        send_control_channel_string(c, "AUTH_PENDING", D_PUSH);
+    }
+    else
+    {
+        static const char auth_pre[] = "AUTH_PENDING,timeout ";
+        // Assume a worst case of 8 byte uint64 in decimal which
+        // needs 20 bytes
+        size_t len = 20 + 1 + sizeof(auth_pre);
+        struct buffer buf = alloc_buf_gc(len, &gc);
+        buf_printf(&buf, auth_pre);
+        buf_printf(&buf, "%u", timeout);
+        send_control_channel_string(c, BSTR(&buf), D_PUSH);
+    }
+
+    size_t len = strlen(extra) + 1 + sizeof(info_pre);
     if (len > PUSH_BUNDLE_SIZE)
     {
+        gc_free(&gc);
         return false;
     }
-    struct gc_arena gc = gc_new();
 
     struct buffer buf = alloc_buf_gc(len, &gc);
     buf_printf(&buf, info_pre);
     buf_printf(&buf, "%s", extra);
     send_control_channel_string(c, BSTR(&buf), D_PUSH);
 
+    ks->auth_deferred_expire = now + timeout;
+
     gc_free(&gc);
     return true;
 }
@@ -1010,4 +1041,20 @@ remove_iroutes_from_push_route_list(struct options *o)
     }
 }
 
+unsigned int
+extract_iv_proto(const char *peer_info)
+{
+    const char *optstr = peer_info ? strstr(peer_info, "IV_PROTO=") : NULL;
+    if (optstr)
+    {
+        int proto = 0;
+        int r = sscanf(optstr, "IV_PROTO=%d", &proto);
+        if (r == 1 && proto > 0)
+        {
+            return proto;
+        }
+    }
+    return 0;
+}
+
 #endif /* if P2MP */
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 01847671..a2192114 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -89,6 +89,16 @@ void send_restart(struct context *c, const char *kill_msg);
  */
 void send_push_reply_auth_token(struct tls_multi *multi);
 
+
+/**
+ * Extracts the IV_PROTO variable and returns its value or 0
+ * if it cannot be extracted.
+ *
+ * @param peer_info     peer info string to search for IV_PROTO
+ */
+unsigned int
+extract_iv_proto(const char *peer_info);
+
 /**
  * Parses an AUTH_PENDING message and if in pull mode extends the timeout
  *
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 5a231387..14c8116f 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2771,6 +2771,7 @@ tls_process(struct tls_multi *multi,
             buf = reliable_get_buf_output_sequenced(ks->send_reliable);
             if (buf)
             {
+                ks->initial = now;
                 ks->must_negotiate = now + session->opt->handshake_window;
                 ks->auth_deferred_expire = now + auth_deferred_expire_window(session->opt);
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index bbb8135d..bf7f9ba3 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -175,6 +175,7 @@ struct key_state
 
     struct key_state_ssl ks_ssl; /* contains SSL object and BIOs for the control channel */
 
+    time_t initial;             /* when we created this session */
     time_t established;         /* when our state went S_ACTIVE */
     time_t must_negotiate;      /* key negotiation times out if not finished before this time */
     time_t must_die;            /* this object is destroyed at this time */
-- 
2.30.0


