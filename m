From: Arne Schwabe <arne@...1227...>
Date: Thu, 13 Jun 2019 16:41:13 +0200
Message-Id: <20190613144113.6418-6-arne@...1227...>
In-Reply-To: <20190613144113.6418-1-arne@...1227...>
References: <20190613144113.6418-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 5/5] Implement sending SSO challenge to
 clients
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

This implements sending AUTH_PENDING and INFO_PRE messages to clients
that indicate that the clients should be continue authentication with
a second factor. This can currently be out of band (openurl) or a normal
challenge/response 2FA like TOTP (CR_TEXT).

Note that this also sends a AUTH_PENDING message that signal the
client to change its behaviour and continue polling with PUSH request.
In OpenVPN2 this is already default behaviour, so we can ignore this
message in OpenVPN2.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/management-notes.txt | 47 ++++++++++++++++++++++++++++++++++++++++
 src/openvpn/manage.c     | 36 ++++++++++++++++++++++++++++++
 src/openvpn/manage.h     |  3 +++
 src/openvpn/multi.c      | 19 ++++++++++++++++
 src/openvpn/push.c       | 24 ++++++++++++++++++++
 src/openvpn/push.h       |  2 ++
 6 files changed, 131 insertions(+)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 29f2da75..a3c09b78 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -592,6 +592,53 @@ interface to approve client connections.
 CID,KID -- client ID and Key ID.  See documentation for ">CLIENT:"
 notification for more info.
 
+COMMAND -- client-sso-auth  (OpenVPN 2.5 or higher)
+----------------------------------------------------
+
+Instruct OpenVPN server to send AUTH_PENDING and INFO_PRE signal
+a single sign on url to the client.
+
+  client-sso-auth {CID} {EXTRA}
+
+The server will send AUTH_PENDING and INFO_PRE,{EXTRA} to the client.
+The client is expected to inform the user that authentication is pending and
+display the extra information.
+For the openurl SSO method EXTRA has the form OPEN_URL:url
+and an example is:
+
+  client-sso-auth 17 "OPENURL:https://examples.com/do_web_auth"
+  
+and client should ask to the user to open the URL to continue. 
+
+For the OpenVPN server this is stateless operation and needs to be
+followed by a client-deny/client-auth[-nt] command (that is the result of the
+out of band authentication).
+
+The other implemented method is challenge/response (crtext). This uses
+the same format as the user and password bases challenge respsonse with
+AUTH_FAILED but omits the session id and username.
+
+   client-sso-auth 18 "CR_TEXT:<flags>:<challenge_text>"
+
+For exmaple:
+
+   client-sso-auth 18 "CR_TEXT:R,E:Please enter token PIN"
+
+The client should present the user the challenge and follow up
+with cr-response command.
+
+See the section >CLIENT,CR_RESPONSE for the client response.
+
+A client should announce its support for these methods with
+the IV_SSO variable seperated by comma. E.g., in the configuration file
+
+    setenv IV_SSO openurl,crtext
+
+A server should check wether these methods are supported by
+examining IV_SSO and otherwise fall back to classic challenge
+response protocol or sending a AUTH_FAILED message that points
+out missing client support.
+
 COMMAND -- client-deny  (OpenVPN 2.1 or higher)
 -----------------------------------------------
 
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 8ec90bb1..ffd48445 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -105,6 +105,8 @@ man_help(void)
     msg(M_CLIENT, "client-auth-nt CID KID : Authenticate client-id/key-id CID/KID");
     msg(M_CLIENT, "client-deny CID KID R [CR] : Deny auth client-id/key-id CID/KID with log reason");
     msg(M_CLIENT, "                             text R and optional client reason text CR");
+    msg(M_CLIENT, "client-sso-auth CID MSG : Instruct OpenVPN to send AUTH_PENDING and INFO_PRE msg"
+                  "                          to the client and wait for a final client-auth/client-deny");
     msg(M_CLIENT, "client-kill CID [M]    : Kill client instance CID with message M (def=RESTART)");
     msg(M_CLIENT, "env-filter [level]     : Set env-var filter level");
 #ifdef MANAGEMENT_PF
@@ -1000,6 +1002,33 @@ parse_kid(const char *str, unsigned int *kid)
         return false;
     }
 }
+static void
+man_client_sso_auth(struct management *man, const char *cid_str, const char *extra)
+{
+    unsigned long cid = 0;
+    if (parse_cid(cid_str, &cid))
+    {
+        if (man->persist.callback.client_sso)
+        {
+            bool ret = (*man->persist.callback.client_sso)
+                           (man->persist.callback.arg, cid, extra);
+
+            if (ret)
+            {
+                msg(M_CLIENT, "SUCCESS: client-sso-auth command succeeded");
+            }
+            else
+            {
+                msg(M_CLIENT, "SUCCESS: client-sso-auth command failed."
+                              " Extra paramter might be too long");
+            }
+        }
+        else
+        {
+            msg(M_CLIENT, "ERROR: The client-deny command is not supported by the current daemon mode");
+        }
+    }
+}
 
 static void
 man_client_auth(struct management *man, const char *cid_str, const char *kid_str, const bool extra)
@@ -1539,6 +1568,13 @@ man_dispatch_command(struct management *man, struct status_output *so, const cha
             man_client_auth(man, p[1], p[2], true);
         }
     }
+    else if (streq(p[0], "client-sso-auth"))
+    {
+        if (man_need(man, p, 2, 0))
+        {
+            man_client_sso_auth(man, p[1], p[2]);
+        }
+    }
 #ifdef MANAGEMENT_PF
     else if (streq(p[0], "client-pf"))
     {
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 6a749725..ff6b6737 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -174,6 +174,9 @@ struct management_callback
                          const char *reason,
                          const char *client_reason,
                          struct buffer_list *cc_config); /* ownership transferred */
+    bool (*client_sso) (void *arg,
+                        const unsigned long cid,
+                        const char *url);
     char *(*get_peer_info) (void *arg, const unsigned long cid);
 #endif
 #ifdef MANAGEMENT_PF
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index d1f9c72e..03e03aff 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3253,6 +3253,24 @@ management_kill_by_cid(void *arg, const unsigned long cid, const char *kill_msg)
     }
 }
 
+static bool
+management_client_sso(void *arg,
+        const unsigned long cid,
+        const char *extra)
+{
+    struct multi_context *m = (struct multi_context *) arg;
+    struct multi_instance *mi = lookup_by_cid(m, cid);
+    if (mi)
+    {
+        /* sends INFO_PRE and AUTH_PENDING messages to client */
+        bool ret = send_sso_messages(&mi->context, extra);
+        multi_schedule_context_wakeup(m, mi);
+        return ret;
+    }
+    return false;
+}
+
+
 static bool
 management_client_auth(void *arg,
                        const unsigned long cid,
@@ -3360,6 +3378,7 @@ init_management_callback_multi(struct multi_context *m)
 #ifdef MANAGEMENT_DEF_AUTH
         cb.kill_by_cid = management_kill_by_cid;
         cb.client_auth = management_client_auth;
+        cb.client_sso = management_client_sso;
         cb.get_peer_info = management_get_peer_info;
 #endif
 #ifdef MANAGEMENT_PF
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 3b568b9b..0cec692c 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -287,6 +287,30 @@ send_auth_failed(struct context *c, const char *client_reason)
     gc_free(&gc);
 }
 
+bool
+send_sso_messages(struct context *c, const char* extra)
+{
+    send_control_channel_string(c, "AUTH_PENDING", D_PUSH);
+
+    static const char info_pre[] = "INFO_PRE,";
+
+
+    size_t len = strlen(extra)+1 + sizeof(info_pre);
+    if (len > PUSH_BUNDLE_SIZE)
+    {
+        return false;
+    }
+    struct gc_arena gc = gc_new();
+
+    struct buffer buf = alloc_buf_gc(len, &gc);
+    buf_printf(&buf, info_pre);
+    buf_printf(&buf, "%s", extra);
+    send_control_channel_string(c, BSTR(&buf), D_PUSH);
+
+    gc_free(&gc);
+    return true;
+}
+
 /*
  * Send restart message from server to client.
  */
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 3f5079f3..a15aa58c 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -72,6 +72,8 @@ void remove_iroutes_from_push_route_list(struct options *o);
 
 void send_auth_failed(struct context *c, const char *client_reason);
 
+bool send_sso_messages(struct context *c, const char *url);
+
 void send_restart(struct context *c, const char *kill_msg);
 
 #endif
-- 
2.22.0


