From: Eric Thorpe <eric@...1918...>
Date: Thu, 13 Aug 2020 00:29:23 -0700
Message-Id: <20200813072923.24385-2-eric@...1918...>
In-Reply-To: <20200813072923.24385-1-eric@...1918...>
References: <20200813072923.24385-1-eric@...1918...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Allows a plugin to provide a
 client_reason for authentication failure
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

Signed-off-by: Eric Thorpe <eric@...1918...>
---
 src/openvpn/ssl_verify.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 8d8531c7..356b30fd 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1157,6 +1157,9 @@ verify_user_pass_plugin(struct tls_session *session, =
struct tls_multi *multi,
     /* Is username defined? */
     if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen=
(up->username))
     {
+        struct plugin_return pr, prfetch;
+        plugin_return_init(&pr);
+
         /* set username/password in private env space */
         setenv_str(session->opt->es, "username", up->username);
         setenv_str(session->opt->es, "password", up->password);
@@ -1180,7 +1183,23 @@ verify_user_pass_plugin(struct tls_session *session,=
 struct tls_multi *multi,
 #endif
=20
         /* call command */
-        retval =3D plugin_call(session->opt->plugins, OPENVPN_PLUGIN_AUTH_=
USER_PASS_VERIFY, NULL, NULL, session->opt->es);
+        retval =3D plugin_call(session->opt->plugins, OPENVPN_PLUGIN_AUTH_=
USER_PASS_VERIFY, NULL, &pr, session->opt->es);
+
+        /* Fetch client reason */
+        plugin_return_get_column(&pr, &prfetch, "client_reason");
+        if (plugin_return_defined(&prfetch))
+        {
+            int i;
+            for (i =3D 0; i < prfetch.n; ++i)
+            {
+                if (prfetch.list[i] && prfetch.list[i]->value)
+                {
+                    auth_set_client_reason(multi, prfetch.list[i]->value);
+                }
+            }
+        }
+
+        plugin_return_free(&pr);
=20
 #ifdef PLUGIN_DEF_AUTH
         /* purge auth control filename (and file itself) for non-deferred =
returns */
@@ -1436,8 +1455,16 @@ verify_user_pass(struct user_pass *up, struct tls_mu=
lti *multi,
         if (multi->connection_established)
         {
             /* Notify the client */
-            send_push_reply_auth_failed(multi, "SESSION:Auth failed");
-
+            const char *client_reason;
+            if (multi->client_reason !=3D NULL)
+            {
+                client_reason =3D multi->client_reason;
+            }
+            else
+            {
+                client_reason =3D "SESSION:Auth failed";
+            }
+            send_push_reply_auth_failed(multi, client_reason);
         }
         ks->authenticated =3D KS_AUTH_FALSE;
         msg(D_TLS_ERRORS, "TLS Auth Error: Auth Username/Password verifica=
tion failed for peer");
--=20
2.25.1


