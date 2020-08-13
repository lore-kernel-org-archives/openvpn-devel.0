From: Eric Thorpe <eric@...1918...>
Date: Thu, 13 Aug 2020 00:29:22 -0700
Message-Id: <20200813072923.24385-1-eric@...1918...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Send auth-fail messages to clients on
 renegotiation failures via auth-token or user-pass expiry
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
 src/openvpn/multi.c      |  2 ++
 src/openvpn/push.c       | 30 ++++++++++++++++++++++++++++++
 src/openvpn/ssl_common.h |  1 +
 src/openvpn/ssl_verify.c |  7 +++++++
 4 files changed, 40 insertions(+)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 13738180..288680c9 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2689,6 +2689,8 @@ multi_connection_established(struct multi_context *m,=
 struct multi_instance *mi)
=20
         mi->context.c2.context_auth =3D CAS_FAILED;
     }
+    /* Set connection established for reneg handling */
+    mi->context.c2.tls_multi->connection_established =3D true;
=20
     /* increment number of current authenticated clients */
     ++m->n_clients;
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index e0d2eeaf..3567b22d 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -311,6 +311,36 @@ send_auth_pending_messages(struct context *c, const ch=
ar *extra)
     return true;
 }
=20
+/*
+* Send auth failed message from server to client without scheduling.
+* Main use for queuing a message during renegotiation
+*/
+void
+send_push_reply_auth_failed(struct tls_multi *multi, const char *client_re=
ason)
+{
+    struct gc_arena gc =3D gc_new();
+    static const char auth_failed[] =3D "AUTH_FAILED";
+    size_t len;
+
+    len =3D (client_reason ? strlen(client_reason)+1 : 0) + sizeof(auth_fa=
iled);
+    if (len > PUSH_BUNDLE_SIZE)
+    {
+        len =3D PUSH_BUNDLE_SIZE;
+    }
+
+    {
+        struct buffer buf =3D alloc_buf_gc(len, &gc);
+        buf_printf(&buf, auth_failed);
+        if (client_reason)
+        {
+            buf_printf(&buf, ",%s", client_reason);
+        }
+        send_control_channel_string_dowork(multi, BSTR(&buf), D_PUSH);
+    }
+
+    gc_free(&gc);
+}
+
 /*
  * Send restart message from server to client.
  */
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 96897e48..b5cc9dc9 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -576,6 +576,7 @@ struct tls_multi
=20
     char *remote_ciphername;    /**< cipher specified in peer's config fil=
e */
=20
+    bool connection_established; /** Notifies future auth calls this is a =
reneg */
     /*
      * Our session objects.
      */
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 97ccb93b..8d8531c7 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1318,6 +1318,7 @@ verify_user_pass(struct user_pass *up, struct tls_mul=
ti *multi,
         }
         else
         {
+            send_push_reply_auth_failed(multi, "SESSION:Auth-token expired=
");
             wipe_auth_token(multi);
             ks->authenticated =3D KS_AUTH_FALSE;
             msg(M_WARN, "TLS: Username/auth-token authentication "
@@ -1432,6 +1433,12 @@ verify_user_pass(struct user_pass *up, struct tls_mu=
lti *multi,
     }
     else
     {
+        if (multi->connection_established)
+        {
+            /* Notify the client */
+            send_push_reply_auth_failed(multi, "SESSION:Auth failed");
+
+        }
         ks->authenticated =3D KS_AUTH_FALSE;
         msg(D_TLS_ERRORS, "TLS Auth Error: Auth Username/Password verifica=
tion failed for peer");
     }
--=20
2.25.1


