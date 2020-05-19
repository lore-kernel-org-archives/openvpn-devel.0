From: Arne Schwabe <arne@...1227...>
Date: Wed, 20 May 2020 00:00:03 +0200
Message-Id: <20200519220004.25136-5-arne@...1227...>
In-Reply-To: <20200519220004.25136-1-arne@...1227...>
References: <20200519220004.25136-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3 4/5] Implement sending AUTH_PENDING
 challenges to clients
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
challenge/response two like TOTP (CR_TEXT).

Unfortunately this patch spend so much time in review in openvpn2 that
the corosponding IV_SSO commit in openvpn3 (34a3f264) already made its
way to released products so changing this right now is difficult.

https://github.com/OpenVPN/openvpn3/commit/34a3f264f56bd050d9b26d2e7163f88af9a559e2

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/management-notes.txt | 86 ++++++++++++++++++++++++++++++++++++++++
 src/openvpn/manage.c     | 46 +++++++++++++++++++++
 src/openvpn/manage.h     |  3 ++
 src/openvpn/multi.c      | 19 +++++++++
 src/openvpn/push.c       | 24 +++++++++++
 src/openvpn/push.h       |  7 ++++
 6 files changed, 185 insertions(+)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index a7ae84e3..ce32b85f 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -592,6 +592,92 @@ interface to approve client connections.
 CID,KID -- client ID and Key ID.  See documentation for ">CLIENT:"
 notification for more info.
 
+COMMAND -- client-pending-auth  (OpenVPN 2.5 or higher)
+----------------------------------------------------
+
+Instruct OpenVPN server to send AUTH_PENDING and INFO_PRE message
+to signal a pending authenticating to the client. A pending auth means
+that the connecting requires extra authentication like a one time
+password or doing a single sign one via web.
+
+    client-pending-auth {CID} {EXTRA}
+
+The server will send AUTH_PENDING and INFO_PRE,{EXTRA} to the client.
+The client is expected to inform the user that authentication is pending and
+display the extra information. For the format of EXTRA see below
+For the OpenVPN server this is stateless operation and needs to be
+followed by a client-deny/client-auth[-nt] command (that is the result of the
+out of band authentication).
+
+Before issuing a client-pending-auth to a client instead of a
+client-auth/client-deny, the server should check the IV_SSO
+environment variable if the method is support. The currently
+defined method are crtext for challenge/response using text
+(e.g. TOTP), openurl and proxy_url for opening an URL in the client to
+continue authentication. A client supporting the first two methods would
+set
+
+    setenv IV_SSO openurl,crtext
+
+The variable name IV_SSO is historic as AUTH_PENDING was first used
+to signal single sign on support. To keep compatiblity with existing
+implementations the name IV_SSO is kept in lieu of a better name.
+
+openurl
+========
+For a web based extra authentication (like for
+SSO/SAML) EXTRA should be
+
+    OPEN_URL:url
+          
+and client should ask to the user to open the URL to continue.
+
+The space in a control message is limited, so this url should be kept
+short to avoid issues. If a loger url is required a URL that redirects
+to the longer URL should be sent instead.
+
+url_proxy
+========
+To avoid issues with OpenVPN connection persist-tun and not able
+to reach the web server, a method a virant of openurl via a HTTPS
+Proxy exists. The client should announce url_proxy in its IV_SSO
+and parse the PROXY_URL message. The format is
+
+    PROXY_URL:<proxy>:<proxy_port>:<proxyuser_base64>:<proxy_password_bade64>:url
+
+The proxy should be a literal IPv4 address or Ipv6 address in [] to avoid
+ambiguity in parsing. A literal IP address is preferred as DNS might not
+be available when the needs to open the url. The IP address will usually
+be the address that client uses to connect to the server. For dual-homed
+server, the server should respond with the same address that the client
+connects to.
+
+This address is also usually excluded from being redirected over the VPN
+by a host route. If the platform (like Android) uses another way of protecting
+the VPN connection routing loops the client needs to also exclude the
+connection to the proxy in the same manner.
+
+Should another IP be used the VPN configuration should include the route
+statement to exclude that route from being routed over the VPN.
+
+crtext
+=======
+
+The format of EXTRA is similar to the already used two step authentication
+described in Challenge/Response Protocol section of this document. Since
+most of the fields are not necessary or can be infered only the <flags>
+and <challgenge_text> fields are used:
+
+    CR_TEXT:<flags>:<challenge_text>
+
+<flags>: a series of optional, comma-separated flags:
+ E : echo the response when the user types it.
+ R : a response is required.
+
+<challenge_text>: the challenge text to be shown to the user.
+
+
+
 COMMAND -- client-deny  (OpenVPN 2.1 or higher)
 -----------------------------------------------
 
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index a72c7678..3ebe72ec 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -105,6 +105,8 @@ man_help(void)
     msg(M_CLIENT, "client-auth-nt CID KID : Authenticate client-id/key-id CID/KID");
     msg(M_CLIENT, "client-deny CID KID R [CR] : Deny auth client-id/key-id CID/KID with log reason");
     msg(M_CLIENT, "                             text R and optional client reason text CR");
+    msg(M_CLIENT, "client-pending-auth CID MSG : Instruct OpenVPN to send AUTH_PENDING and INFO_PRE msg"
+        "                          to the client and wait for a final client-auth/client-deny");
     msg(M_CLIENT, "client-kill CID [M]    : Kill client instance CID with message M (def=RESTART)");
     msg(M_CLIENT, "env-filter [level]     : Set env-var filter level");
 #ifdef MANAGEMENT_PF
@@ -1001,6 +1003,43 @@ parse_kid(const char *str, unsigned int *kid)
     }
 }
 
+/**
+ * Will send a notification to the client that succesful authentication
+ * will require an additional step (web based SSO/2-factor auth/etc)
+ *
+ * @param man           The management interface struct
+ * @param cid_str       The CID in string form
+ * @param extra         The string to be send to the client containing
+ *                      the information of the additional steps
+ */
+static void
+man_client_pending_auth(struct management *man, const char *cid_str, const char *extra)
+{
+    unsigned long cid = 0;
+    if (parse_cid(cid_str, &cid))
+    {
+        if (man->persist.callback.client_pending_auth)
+        {
+            bool ret = (*man->persist.callback.client_pending_auth)
+                           (man->persist.callback.arg, cid, extra);
+
+            if (ret)
+            {
+                msg(M_CLIENT, "SUCCESS: client-pending-auth command succeeded");
+            }
+            else
+            {
+                msg(M_CLIENT, "SUCCESS: client-pending-auth command failed."
+                    " Extra paramter might be too long");
+            }
+        }
+        else
+        {
+            msg(M_CLIENT, "ERROR: The client-pending-auth command is not supported by the current daemon mode");
+        }
+    }
+}
+
 static void
 man_client_auth(struct management *man, const char *cid_str, const char *kid_str, const bool extra)
 {
@@ -1541,6 +1580,13 @@ man_dispatch_command(struct management *man, struct status_output *so, const cha
             man_client_auth(man, p[1], p[2], true);
         }
     }
+    else if (streq(p[0], "client-pending-auth"))
+    {
+        if (man_need(man, p, 2, 0))
+        {
+            man_client_pending_auth(man, p[1], p[2]);
+        }
+    }
 #ifdef MANAGEMENT_PF
     else if (streq(p[0], "client-pf"))
     {
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index e1dabceb..e28b11d1 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -174,6 +174,9 @@ struct management_callback
                          const char *reason,
                          const char *client_reason,
                          struct buffer_list *cc_config); /* ownership transferred */
+    bool (*client_pending_auth) (void *arg,
+                                 const unsigned long cid,
+                                 const char *url);
     char *(*get_peer_info) (void *arg, const unsigned long cid);
 #endif
 #ifdef MANAGEMENT_PF
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 7f61350d..74e035e5 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3310,6 +3310,24 @@ management_kill_by_cid(void *arg, const unsigned long cid, const char *kill_msg)
     }
 }
 
+static bool
+management_client_pending_auth(void *arg,
+        const unsigned long cid,
+        const char *extra)
+{
+    struct multi_context *m = (struct multi_context *) arg;
+    struct multi_instance *mi = lookup_by_cid(m, cid);
+    if (mi)
+    {
+        /* sends INFO_PRE and AUTH_PENDING messages to client */
+        bool ret = send_auth_pending_messages(&mi->context, extra);
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
@@ -3417,6 +3435,7 @@ init_management_callback_multi(struct multi_context *m)
 #ifdef MANAGEMENT_DEF_AUTH
         cb.kill_by_cid = management_kill_by_cid;
         cb.client_auth = management_client_auth;
+        cb.client_pending_auth = management_client_pending_auth;
         cb.get_peer_info = management_get_peer_info;
 #endif
 #ifdef MANAGEMENT_PF
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 965dd139..a5fa87d8 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -265,6 +265,30 @@ send_auth_failed(struct context *c, const char *client_reason)
     gc_free(&gc);
 }
 
+bool
+send_auth_pending_messages(struct context *c, const char* extra)
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
index 1898f238..42ab100d 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -70,6 +70,13 @@ void remove_iroutes_from_push_route_list(struct options *o);
 
 void send_auth_failed(struct context *c, const char *client_reason);
 
+/**
+ * Sends the auth pending control messages to a client. See
+ * doc/management-notes.txt under client-pending-auth for
+ * more details on message format
+ */
+bool send_auth_pending_messages(struct context *c, const char *extra);
+
 void send_restart(struct context *c, const char *kill_msg);
 
 /**
-- 
2.26.0


