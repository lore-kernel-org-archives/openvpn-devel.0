From: Arne Schwabe <arne@...1227...>
Date: Sat,  9 Nov 2019 16:13:06 +0100
Message-Id: <20191109151306.18597-5-arne@...1227...>
In-Reply-To: <20191109151306.18597-1-arne@...1227...>
References: <20191109151306.18597-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 5/5] Implement forwarding client
 CR_RESPONSE messages to management
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
 doc/management-notes.txt | 26 +++++++++++++++++++++++++-
 src/openvpn/forward.c    |  4 ++++
 src/openvpn/manage.c     | 28 +++++++++++++++++++++++++++-
 src/openvpn/manage.h     |  4 ++++
 src/openvpn/push.c       | 21 +++++++++++++++++++++
 src/openvpn/push.h       |  2 ++
 6 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 4b405a9b..6d29b0d6 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -971,7 +971,7 @@ The ">CLIENT:" notification is enabled by the --management-client-auth
 OpenVPN configuration directive that gives the management interface client
 the responsibility to authenticate OpenVPN clients after their client
 certificate has been verified.  CLIENT notifications may be multi-line, and
-the sequentiality of a given CLIENT notification, its associated environmental
+the sequentially of a given CLIENT notification, its associated environmental
 variables, and the terminating ">CLIENT:ENV,END" line are guaranteed to be
 atomic.
 
@@ -1013,6 +1013,30 @@ CLIENT notification types:
 
     >CLIENT:ADDRESS,{CID},{ADDR},{PRI}
 
+(5) Single Sign On Based Challenge/Response
+
+   >CLIENT:CR_RESPONSE,{CID},{KID},{response_base64}
+   >CLIENT:ENV,name1=val1
+   >CLIENT:ENV,name2=val2
+   >CLIENT:ENV,...
+   >CLIENT:ENV,END
+
+   CR_RESPONSE notification. The >CR_RESPONSE fulfils the same purpose as the
+   CRV1 response in the traditional challenge/response. See that section below for more
+   details. Since this still uses the same cid as the original response, we do
+   not use the username and opaque session data in this response.
+
+   It is important to note that OpenVPN2 merely passes the authentication information and
+   does not do any further checks. (E.g. if a CR was issued before or if multiple CR responses
+   were sent from the client).
+
+   This interface should be be sufficient for almost all challenge/response system that
+   can be implemented with a single round and base64 encoding the response. Mechanisms that
+   need multiple rounds or more complex answers should implement a different response type
+   than CR_RESPONSE.
+
+
+
 Variables:
 
 CID --  Client ID, numerical ID for each connecting client, sequence = 0,1,2,...
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 0f735384..48c316c9 100644
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
index c055f2ce..b3a4d5c8 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2908,7 +2908,7 @@ management_notify_generic(struct management *man, const char *str)
 #ifdef MANAGEMENT_DEF_AUTH
 
 static void
-man_output_peer_info_env(struct management *man, struct man_def_auth_context *mdac)
+man_output_peer_info_env(struct management *man, const struct man_def_auth_context *mdac)
 {
     char line[256];
     if (man->persist.callback.get_peer_info)
@@ -2958,6 +2958,32 @@ management_notify_client_needing_auth(struct management *management,
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
index f570afc6..ff6b6737 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -432,6 +432,10 @@ void management_learn_addr(struct management *management,
                            const struct mroute_addr *addr,
                            const bool primary);
 
+void management_notify_client_cr_response(unsigned mda_key_id,
+                                          const struct man_def_auth_context *mdac,
+                                          const struct env_set *es,
+                                          const char* response);
 #endif
 
 char *management_query_pk_sig(struct management *man, const char *b64_data);
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 4b375ae3..c94076cb 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -210,6 +210,27 @@ server_pushed_info(struct context *c, const struct buffer *buffer,
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
index f814f572..75ad330c 100644
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


