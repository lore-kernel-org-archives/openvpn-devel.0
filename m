From: Arne Schwabe <arne@...1227...>
Date: Thu, 24 Jun 2021 15:08:40 +0200
Message-Id: <20210624130840.2583433-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Ensure tls session is authenticated before
 sending push reply
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

We ensure here that the tls session is authenticated before sending
a push_reply

This a part of to fix CVE-2020-15078 in the master branch.
---
 src/openvpn/push.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index b6f1252d2..b27f401e1 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -863,7 +863,8 @@ process_incoming_push_request(struct context *c)
         send_auth_failed(c, client_reason);
         ret = PUSH_MSG_AUTH_FAILURE;
     }
-    else if (c->c2.tls_multi->multi_state >= CAS_CONNECT_DONE)
+    else if (tls_authentication_status(c->c2.tls_multi) == TLS_AUTHENTICATION_SUCCEEDED
+        && c->c2.tls_multi->multi_state >= CAS_CONNECT_DONE)
     {
         time_t now;
 
-- 
2.32.0


