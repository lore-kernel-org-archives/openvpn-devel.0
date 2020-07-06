From: Arne Schwabe <arne@...1227...>
Date: Mon,  6 Jul 2020 18:35:15 +0200
Message-Id: <20200706163516.11390-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/2] Remember if we have seen a push request
 without async push
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

The logic if we already have seen a push request is still
correct/useful without async push. I am not entirely sure if also
deferred management authentication can trigger this code path but
it should be able to. The other benefit is removing a number of
ifdefs.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c   | 4 +---
 src/openvpn/openvpn.h | 2 --
 src/openvpn/push.c    | 2 --
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f1ced9b7..f6be6618 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -824,8 +824,8 @@ multi_create_instance(struct multi_context *m, const struct mroute_addr *real)
     mi->did_cid_hash = true;
 #endif
 
-#ifdef ENABLE_ASYNC_PUSH
     mi->context.c2.push_request_received = false;
+#ifdef ENABLE_ASYNC_PUSH
     mi->inotify_watch = -1;
 #endif
 
@@ -2074,13 +2074,11 @@ script_failed:
         /* set context-level authentication flag */
         mi->context.c2.context_auth = CAS_SUCCEEDED;
 
-#ifdef ENABLE_ASYNC_PUSH
         /* authentication complete, send push reply */
         if (mi->context.c2.push_request_received)
         {
             process_incoming_push_request(&mi->context);
         }
-#endif
     }
     else
     {
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 4609af3e..a1308852 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -432,9 +432,7 @@ struct context_2
 #if P2MP
 
     /* --ifconfig endpoints to be pushed to client */
-#ifdef ENABLE_ASYNC_PUSH
     bool push_request_received;
-#endif
     bool push_ifconfig_defined;
     time_t sent_push_reply_expiry;
     in_addr_t push_ifconfig_local;
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 56d652a3..e7c3c08c 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -794,9 +794,7 @@ process_incoming_push_request(struct context *c)
 {
     int ret = PUSH_MSG_ERROR;
 
-#ifdef ENABLE_ASYNC_PUSH
     c->c2.push_request_received = true;
-#endif
     if (tls_authentication_status(c->c2.tls_multi, 0) == TLS_AUTHENTICATION_FAILED || c->c2.context_auth == CAS_FAILED)
     {
         const char *client_reason = tls_client_reason(c->c2.tls_multi);
-- 
2.26.2


