From: Arne Schwabe <arne@...1227...>
Date: Wed,  2 Dec 2020 11:59:46 +0100
Message-Id: <20201202105946.8891-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Remove auth_user_pass.wait_for_push variable
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

This variable was first introduce in earlier attempt to fix the
auth-token problems with auth-nocache before user_password and
auth_token were split into two variables. The idea of the variable it
is being set if --pull is in use. However the variable was not always
set correctly, especially if username/password are queried after an
expired auth-token. Instead using that variable use session->opt->pull
directly.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/manage.c | 1 -
 src/openvpn/misc.h   | 1 -
 src/openvpn/ssl.c    | 7 +++----
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 68b136fb..446b82f4 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3579,7 +3579,6 @@ management_query_user_pass(struct management *man,
         {
             /* preserve caller's settings */
             man->connection.up_query.nocache = up->nocache;
-            man->connection.up_query.wait_for_push = up->wait_for_push;
             *up = man->connection.up_query;
         }
         secure_memzero(&man->connection.up_query, sizeof(man->connection.up_query));
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 8c3a1227..e4342b0d 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -64,7 +64,6 @@ struct user_pass
 {
     bool defined;
     bool nocache;
-    bool wait_for_push; /* true if this object is waiting for a push-reply */
 
 /* max length of username/password */
 #ifdef ENABLE_PKCS11
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 950bf421..52774a9a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -434,8 +434,6 @@ ssl_set_auth_nocache(void)
 {
     passbuf.nocache = true;
     auth_user_pass.nocache = true;
-    /* wait for push-reply, because auth-token may still need the username */
-    auth_user_pass.wait_for_push = true;
 }
 
 /*
@@ -2414,14 +2412,15 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
         }
         /* if auth-nocache was specified, the auth_user_pass object reaches
          * a "complete" state only after having received the push-reply
-         * message.
+         * message. The push message might contain an auth-token that needs
+         * the username of auth_user_pass.
          *
          * For this reason, skip the purge operation here if no push-reply
          * message has been received yet.
          *
          * This normally happens upon first negotiation only.
          */
-        if (!auth_user_pass.wait_for_push)
+        if (!session->opt->pull)
         {
             purge_user_pass(&auth_user_pass, false);
         }
-- 
2.26.2


