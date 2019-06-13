From: Arne Schwabe <arne@...1227...>
Date: Thu, 13 Jun 2019 16:41:10 +0200
Message-Id: <20190613144113.6418-3-arne@...1227...>
In-Reply-To: <20190613144113.6418-1-arne@...1227...>
References: <20190613144113.6418-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 2/5] Implement forwarding client CR_RESPONSE
 messages to management
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

When signalling the client that it should do Challenge response
without reconnecting (IV_SSO=crtext/INFOPRE=CR_TEXT), the server
needs forward the response via the management console.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/management-notes.txt | 19 +++++++++++++++++++
 src/openvpn/forward.c    |  4 ++++
 src/openvpn/manage.c     | 28 +++++++++++++++++++++++++++-
 src/openvpn/manage.h     |  4 ++++
 src/openvpn/push.c       | 21 +++++++++++++++++++++
 src/openvpn/push.h       |  2 ++
 6 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 17645c1d..05d30b0a 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -979,6 +979,24 @@ CLIENT notification types:
 
     >CLIENT:ADDRESS,{CID},{ADDR},{PRI}
 
+(5) Single Sign On Based Challenge/Response
+
+   >CLIENT:CR_RESPONSE,{CID},{KID},{response_base64}
+   >CLIENT:ENV,name1=val1
+   >CLIENT:ENV,name2=val2
+   >CLIENT:ENV,...
+   >CLIENT:ENV,END
+   
+   CR_RESPONSE notifcation. The >CR_RESPONSE fulfils the same purpose as the
+   CRV1 response in the traditional challenge/response. See that section below for more
+   details. Since this still uses the same cid as the original response, we do
+   not use the username and opaque session data in this response.
+
+   It is important to note that OpenVPN2 merely passes the authentication information and
+   does not do any further checks. (E.g. if a CR was issued before or if multiple CR responses
+   were sent from the client).
+
+
 Variables:
 
 CID --  Client ID, numerical ID for each connecting client, sequence = 0,1,2,...
@@ -1175,3 +1193,4 @@ issued:
 
   ("YmFy" is the base 64 encoding of "bar" and "ODY3NTMwOQ==" is the
    base 64 encoding of "8675309".)
+
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 3803479f..0dbbb88c 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -403,6 +403,10 @@ check_incoming_control_channel_dowork(struct context *c)
             {
                 server_pushed_info(c, &buf, 4);
             }
+            else if (buf_string_match_head_str(&buf, "CR_RESPONSE"))
+            {
+                receive_cr_response(c, &buf);
+            }
             else
             {
                 msg(D_PUSH_ERRORS, "WARNING: Received unknown control message: %s", BSTR(&buf));
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 2d86dad4..a2b58296 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2823,7 +2823,7 @@ management_notify_generic(struct management *man, const char *str)
 #ifdef MANAGEMENT_DEF_AUTH
 
 static void
-man_output_peer_info_env(struct management *man, struct man_def_auth_context *mdac)
+man_output_peer_info_env(struct management *man, const struct man_def_auth_context *mdac)
 {
     char line[256];
     if (man->persist.callback.get_peer_info)
@@ -2873,6 +2873,32 @@ management_notify_client_needing_auth(struct management *management,
     }
 }
 
+void
+management_notify_client_cr_response(unsigned mda_key_id,
+        const struct man_def_auth_context *mdac,
+        const struct env_set *es,
+        const char* response)
+{
+    struct gc_arena gc;
+    if (management)
+    {
+        gc = gc_new();
+
+        struct buffer out = alloc_buf_gc(256, &gc);
+        msg(M_CLIENT, ">CLIENT:CR_RESPONSE,%lu,%u,%s",
+                mdac->cid, mda_key_id, response);
+        man_output_extra_env(management, "CLIENT");
+        if (management->connection.env_filter_level>0)
+        {
+            man_output_peer_info_env(management, mdac);
+        }
+        man_output_env(es, true, management->connection.env_filter_level, "CLIENT");
+        management_notify_generic(management, BSTR(&out));
+
+        gc_free(&gc);
+    }
+}
+
 void
 management_connection_established(struct management *management,
                                   struct man_def_auth_context *mdac,
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index d24abe09..5f19cc3d 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -428,6 +428,10 @@ void management_learn_addr(struct management *management,
                            const struct mroute_addr *addr,
                            const bool primary);
 
+void management_notify_client_cr_response(unsigned mda_key_id,
+                                          const struct man_def_auth_context *mdac,
+                                          const struct env_set *es,
+                                          const char* response);
 #endif
 
 char *management_query_pk_sig(struct management *man, const char *b64_data);
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 8632a9bb..3b568b9b 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -208,6 +208,27 @@ server_pushed_info(struct context *c, const struct buffer *buffer,
     msg(D_PUSH, "Info command was pushed by server ('%s')", m);
 }
 
+void
+receive_cr_response(struct context *c, const struct buffer *buffer)
+{
+    struct buffer buf = *buffer;
+    const char *m = "";
+
+    if (buf_advance(&buf, 11) && buf_read_u8(&buf) == ',' && BLEN(&buf))
+    {
+        m = BSTR(&buf);
+    }
+#ifdef MANAGEMENT_DEF_AUTH
+    struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
+    struct man_def_auth_context *mda = session->opt->mda_context;
+    struct env_set *es = session->opt->es;
+    int key_id = session->key[KS_PRIMARY].key_id;
+
+
+    management_notify_client_cr_response(key_id, mda, es, m);
+#endif
+    msg(D_PUSH, "CR response was sent by client ('%s')", m);
+}
 
 #if P2MP_SERVER
 /**
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 750a9800..3f5079f3 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -53,6 +53,8 @@ void server_pushed_signal(struct context *c, const struct buffer *buffer, const
 void server_pushed_info(struct context *c, const struct buffer *buffer,
                         const int adv);
 
+void receive_cr_response(struct context *c, const struct buffer *buffer);
+
 void incoming_push_message(struct context *c, const struct buffer *buffer);
 
 #if P2MP_SERVER
-- 
2.22.0


