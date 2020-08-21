From: Eric Thorpe <eric@...1918...>
Date: Thu, 20 Aug 2020 23:24:43 -0700
Message-Id: <20200821062443.69245-1-eric@...1918...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Adds client-auth-pending-extra management
 functionality.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

This allows extra INFO_PRE mesasges to be sent to a client during an
authentication stage. This may be required to send additional challenges,
or allow longer messages to be sent by breaking them up and sending in part=
s.

Signed-off-by: Eric Thorpe <eric@...1918...>
---
 doc/management-notes.txt | 32 +++++++++++++++++++++++-----
 src/openvpn/manage.c     | 45 ++++++++++++++++++++++++++++++++++++++++
 src/openvpn/manage.h     |  3 +++
 src/openvpn/multi.c      | 17 +++++++++++++++
 src/openvpn/push.c       |  7 ++++++-
 src/openvpn/push.h       |  1 +
 6 files changed, 99 insertions(+), 6 deletions(-)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 61daaf07..74e05414 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -595,10 +595,10 @@ notification for more info.
 COMMAND -- client-pending-auth  (OpenVPN 2.5 or higher)
 ----------------------------------------------------
=20
-Instruct OpenVPN server to send AUTH_PENDING and INFO_PRE message
+Instruct the OpenVPN server to send AUTH_PENDING and INFO_PRE message
 to signal a pending authenticating to the client. A pending auth means
-that the connecting requires extra authentication like a one time
-password or doing a single sign one via web.
+that the connection requires extra authentication like a one time
+password or doing a single sign on via web.
=20
     client-pending-auth {CID} {EXTRA}
=20
@@ -611,8 +611,8 @@ out of band authentication).
=20
 Before issuing a client-pending-auth to a client instead of a
 client-auth/client-deny, the server should check the IV_SSO
-environment variable if the method is support. The currently
-defined method are crtext for challenge/response using text
+environment variable if the method is supported. The currently
+defined methods are crtext for challenge/response using text
 (e.g. TOTP), openurl and proxy_url for opening an URL in the client to
 continue authentication. A client supporting the first two methods would
 set
@@ -676,7 +676,29 @@ and <challgenge_text> fields are used:
=20
 <challenge_text>: the challenge text to be shown to the user.
=20
+COMMAND -- client-auth-pending-extra  (OpenVPN 2.5 or higher)
+-------------------------------------------------------------
=20
+Instruct the OpenVPN server to send an INFO_PRE message to the client.=20
+This should be used following client-auth-pending to send extra messages=20
+to the client during an authentication stage, or respond to CR_RESPONSE me=
ssages
+if further challenges are required.
+
+    client-pending-auth-extra {CID} {EXTRA}
+
+The server will send INFO_PRE,{EXTRA} to the client.
+The client is expected to display the extra information to the user. For t=
he=20
+format of EXTRA, see the client-pending-auth section of this document.
+For the OpenVPN server this is stateless operation and needs to be
+followed by a client-deny/client-auth[-nt] command (that is the result of =
the
+out of band authentication).
+
+Before issuing a client-pending-auth-extra to a client, the server should=
=20
+check the IV_SSO environment variable if the method is supported.
+
+    setenv IV_SSO openurl,crtext
+
+Refer to client-auth-pending for further information.
=20
 COMMAND -- client-deny  (OpenVPN 2.1 or higher)
 -----------------------------------------------
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 898cb3b3..b5a7d0df 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -107,6 +107,8 @@ man_help(void)
     msg(M_CLIENT, "                             text R and optional client=
 reason text CR");
     msg(M_CLIENT, "client-pending-auth CID MSG : Instruct OpenVPN to send =
AUTH_PENDING and INFO_PRE msg"
         "                          to the client and wait for a final clie=
nt-auth/client-deny");
+    msg(M_CLIENT, "client-pending-auth-extra CID MSG : Instruct OpenVPN to=
 send INFO_PRE msg to the client"
+        "                          without AUTH_PENDING. For additional me=
ssages");
     msg(M_CLIENT, "client-kill CID [M]    : Kill client instance CID with =
message M (def=3DRESTART)");
     msg(M_CLIENT, "env-filter [level]     : Set env-var filter level");
 #ifdef MANAGEMENT_PF
@@ -1040,6 +1042,42 @@ man_client_pending_auth(struct management *man, cons=
t char *cid_str, const char
     }
 }
=20
+/**
+ * Send additional INFO_PRE information to the client for additional authe=
ntication steps
+ *
+ * @param man           The management interface struct
+ * @param cid_str       The CID in string form
+ * @param extra         The string to be send to the client containing
+ *                      the information of the additional steps
+ */
+static void
+man_client_pending_auth_extra(struct management* man, const char* cid_str,=
 const char* extra)
+{
+    unsigned long cid =3D 0;
+    if (parse_cid(cid_str, &cid))
+    {
+        if (man->persist.callback.client_pending_auth_extra)
+        {
+            bool ret =3D (*man->persist.callback.client_pending_auth_extra)
+                (man->persist.callback.arg, cid, extra);
+
+            if (ret)
+            {
+                msg(M_CLIENT, "SUCCESS: client-pending-auth-extra command =
succeeded");
+            }
+            else
+            {
+                msg(M_CLIENT, "SUCCESS: client-pending-auth-extra command =
failed."
+                    " Extra paramter might be too long");
+            }
+        }
+        else
+        {
+            msg(M_CLIENT, "ERROR: The client-pending-auth-extra command is=
 not supported by the current daemon mode");
+        }
+    }
+}
+
 static void
 man_client_auth(struct management *man, const char *cid_str, const char *k=
id_str, const bool extra)
 {
@@ -1587,6 +1625,13 @@ man_dispatch_command(struct management *man, struct =
status_output *so, const cha
             man_client_pending_auth(man, p[1], p[2]);
         }
     }
+    else if (streq(p[0], "client-pending-auth-extra"))
+    {
+        if (man_need(man, p, 2, 0))
+        {
+            man_client_pending_auth_extra(man, p[1], p[2]);
+        }
+    }
 #ifdef MANAGEMENT_PF
     else if (streq(p[0], "client-pf"))
     {
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 881bfb14..e586f9ca 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -177,6 +177,9 @@ struct management_callback
     bool (*client_pending_auth) (void *arg,
                                  const unsigned long cid,
                                  const char *url);
+    bool (*client_pending_auth_extra) (void* arg,
+                                       const unsigned long cid,
+                                       const char* url);
     char *(*get_peer_info) (void *arg, const unsigned long cid);
 #endif
 #ifdef MANAGEMENT_PF
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 13738180..157db302 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3931,6 +3931,22 @@ management_client_pending_auth(void *arg,
     return false;
 }
=20
+static bool
+management_client_pending_auth_extra(void* arg,
+    const unsigned long cid,
+    const char* extra)
+{
+    struct multi_context* m =3D (struct multi_context*)arg;
+    struct multi_instance* mi =3D lookup_by_cid(m, cid);
+    if (mi)
+    {
+        /* sends INFO_PRE message to client */
+        bool ret =3D send_auth_info_pre_message(&mi->context, extra);
+        multi_schedule_context_wakeup(m, mi);
+        return ret;
+    }
+    return false;
+}
=20
 static bool
 management_client_auth(void *arg,
@@ -4040,6 +4056,7 @@ init_management_callback_multi(struct multi_context *=
m)
         cb.kill_by_cid =3D management_kill_by_cid;
         cb.client_auth =3D management_client_auth;
         cb.client_pending_auth =3D management_client_pending_auth;
+        cb.client_pending_auth_extra =3D management_client_pending_auth_ex=
tra;
         cb.get_peer_info =3D management_get_peer_info;
 #endif
 #ifdef MANAGEMENT_PF
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index e0d2eeaf..beb3223b 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -292,8 +292,13 @@ send_auth_pending_messages(struct context *c, const ch=
ar *extra)
 {
     send_control_channel_string(c, "AUTH_PENDING", D_PUSH);
=20
-    static const char info_pre[] =3D "INFO_PRE,";
+    return send_auth_info_pre_message(c, extra);
+}
=20
+bool
+send_auth_info_pre_message(struct context* c, const char* extra)
+{
+    static const char info_pre[] =3D "INFO_PRE,";
=20
     size_t len =3D strlen(extra)+1 + sizeof(info_pre);
     if (len > PUSH_BUNDLE_SIZE)
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 2faf19a6..e067f8b1 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -78,6 +78,7 @@ void send_auth_failed(struct context *c, const char *clie=
nt_reason);
  * more details on message format
  */
 bool send_auth_pending_messages(struct context *c, const char *extra);
+bool send_auth_info_pre_message(struct context* c, const char* extra);
=20
 void send_restart(struct context *c, const char *kill_msg);
=20
--=20
2.25.1


