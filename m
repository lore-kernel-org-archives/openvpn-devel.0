From: Lev Stipakov <lstipakov@...277...>
Date: Tue,  8 Oct 2019 15:52:33 +0300
Message-Id: <1570539154-31784-1-git-send-email-lstipakov@...277...>
In-Reply-To: <20191008124217.GI40538@...1296...>
References: <20191008124217.GI40538@...1296...>
Subject: [Openvpn-devel] [PATCH v2 1/2] push.c: fix Visual Studio build
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

From: Lev Stipakov <lev@...515...>

Visual Studio doesn't support empty designated initializers
for C code, so use { 0 }. Also replace existing CLEAR() call with
the new initializers.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/push.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 49b9d1b..368b692 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -504,9 +504,8 @@ void
 send_push_reply_auth_token(struct tls_multi *multi)
 {
     struct gc_arena gc = gc_new();
+    struct push_list push_list = { 0 };
 
-
-    struct push_list push_list = {};
     prepare_auth_token_push_reply(multi, &gc, &push_list);
 
     /* prepare auth token should always add the auth-token option */
@@ -734,10 +733,9 @@ process_incoming_push_request(struct context *c)
         else
         {
             /* per-client push options - peer-id, cipher, ifconfig, ipv6-ifconfig */
-            struct push_list push_list;
+            struct push_list push_list = { 0 };
             struct gc_arena gc = gc_new();
 
-            CLEAR(push_list);
             if (prepare_push_reply(c, &gc, &push_list)
                 && send_push_reply(c, &push_list))
             {
-- 
2.7.4


