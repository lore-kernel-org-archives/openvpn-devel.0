From: Lev Stipakov <lstipakov@...277...>
Date: Tue,  8 Oct 2019 15:26:45 +0300
Message-Id: <1570537606-29323-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH 1/2] push.c: fix Visual Studio build
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

Visual Studio doesn't support designated initializers
for C code, so replace it with CLEAR() macro.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/push.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 49b9d1b..213e2b6 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -504,9 +504,10 @@ void
 send_push_reply_auth_token(struct tls_multi *multi)
 {
     struct gc_arena gc = gc_new();
+    struct push_list push_list;
 
+    CLEAR(push_list);
 
-    struct push_list push_list = {};
     prepare_auth_token_push_reply(multi, &gc, &push_list);
 
     /* prepare auth token should always add the auth-token option */
-- 
2.7.4


