From: Arne Schwabe <arne@...1227...>
Date: Fri,  4 Jun 2021 13:47:46 +0200
Message-Id: <20210604114746.761950-1-arne@...1227...>
In-Reply-To: <20210520151148.2565578-4-arne@...1227...>
References: <20210520151148.2565578-4-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 4/9] Make waiting on auth an explicit
 state in the context state machine
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

Previously we relied on checking tls_authentication_status to check
wether to determine if the context auth state is actually valid or not.
This patch eliminates that check by introducing waiting on the
authentication as extra state in the context auth, state machine.

Patch v3: Fix ccd config from management being ignored

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c      | 7 +------
 src/openvpn/ssl.c        | 9 ++++++++-
 src/openvpn/ssl_common.h | 1 +
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 3f9710134..2cb71d851 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2596,11 +2596,6 @@ static const multi_client_connect_handler client_connect_handlers[] = {
 static void
 multi_connection_established(struct multi_context *m, struct multi_instance *mi)
 {
-    if (tls_authentication_status(mi->context.c2.tls_multi) != TLS_AUTHENTICATION_SUCCEEDED)
-    {
-        return;
-    }
-
     /* We are only called for the CAS_PENDING_x states, so we
      * can ignore other states here */
     bool from_deferred = (mi->context.c2.tls_multi->multi_state != CAS_PENDING);
@@ -3970,7 +3965,7 @@ management_client_auth(void *arg,
         {
             if (auth)
             {
-                if (is_cas_pending(mi->context.c2.tls_multi->multi_state))
+                if (mi->context.c2.tls_multi->multi_state == CAS_WAITING_AUTH)
                 {
                     set_cc_config(mi, cc_config);
                     cc_config_owned = false;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 9f3f83f16..fd64b8d4e 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2810,7 +2810,7 @@ tls_process(struct tls_multi *multi,
                     if (session->opt->mode == MODE_SERVER)
                     {
                         /* On a server we continue with running connect scripts next */
-                        multi->multi_state = CAS_PENDING;
+                        multi->multi_state = CAS_WAITING_AUTH;
                     }
                     else
                     {
@@ -3136,6 +3136,13 @@ tls_multi_process(struct tls_multi *multi,
 
     enum tls_auth_status tas = tls_authentication_status(multi);
 
+    /* If we have successfully authenticated and are still waiting for the authentication to finish
+     * move the state machine for the multi context forward */
+    if (multi->multi_state == CAS_WAITING_AUTH && tas == TLS_AUTHENTICATION_SUCCEEDED)
+    {
+        multi->multi_state = CAS_PENDING;
+    }
+
     /*
      * If lame duck session expires, kill it.
      */
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 8a65ab984..66700bf68 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -511,6 +511,7 @@ struct tls_session
  * connect scripts/plugins */
 enum multi_status {
     CAS_NOT_CONNECTED,
+    CAS_WAITING_AUTH,               /**< TLS connection established but deferred auth not finished */
     CAS_PENDING,
     CAS_PENDING_DEFERRED,
     CAS_PENDING_DEFERRED_PARTIAL,   /**< at least handler succeeded, no result yet*/
-- 
2.31.1


