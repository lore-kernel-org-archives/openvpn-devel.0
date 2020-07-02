From: Arne Schwabe <arne@...1227...>
Date: Thu,  2 Jul 2020 14:52:24 +0200
Message-Id: <20200702125224.13516-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Remove push_reply_deferred variable
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

The variable has no useful function (anymore?).

There is only one place where this variable was checked

    else if (!c->c2.push_reply_deferred && c->c2.context_auth == CAS_SUCCEEDED)

This condition also depends on context_auth == CAS_SUCCEEDED but the only
code path that sets context_auth = CAS_SUCCEEDED also sets
push_reply_deferred = false;

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c   | 7 -------
 src/openvpn/openvpn.h | 1 -
 src/openvpn/push.c    | 2 +-
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 95b16744..138701a9 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -828,8 +828,6 @@ multi_create_instance(struct multi_context *m, const struct mroute_addr *real)
     mi->did_cid_hash = true;
 #endif
 
-    mi->context.c2.push_reply_deferred = true;
-
 #ifdef ENABLE_ASYNC_PUSH
     mi->context.c2.push_request_received = false;
     mi->inotify_watch = -1;
@@ -2109,11 +2107,6 @@ script_failed:
 
         gc_free(&gc);
     }
-
-    /*
-     * Reply now to client's PUSH_REQUEST query
-     */
-    mi->context.c2.push_reply_deferred = false;
 }
 
 #ifdef ENABLE_ASYNC_PUSH
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 1afc3a92..4609af3e 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -432,7 +432,6 @@ struct context_2
 #if P2MP
 
     /* --ifconfig endpoints to be pushed to client */
-    bool push_reply_deferred;
 #ifdef ENABLE_ASYNC_PUSH
     bool push_request_received;
 #endif
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 369cd6a4..56d652a3 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -803,7 +803,7 @@ process_incoming_push_request(struct context *c)
         send_auth_failed(c, client_reason);
         ret = PUSH_MSG_AUTH_FAILURE;
     }
-    else if (!c->c2.push_reply_deferred && c->c2.context_auth == CAS_SUCCEEDED)
+    else if (c->c2.context_auth == CAS_SUCCEEDED)
     {
         time_t now;
 
-- 
2.26.2


