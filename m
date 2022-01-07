From: Lev Stipakov <lstipakov@...277...>
Date: Fri,  7 Jan 2022 14:35:50 +0200
Message-Id: <20220107123550.188-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] auth_token.c: add NULL initialization
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

This fixes

  error C4703: potentially uninitialized local pointer variable 'b64output' used

found by arm64 msvc compiler with SDL enabled.

Not sure why this is not triggered on x86/x64.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/auth_token.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index e8875464..ceae68f6 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -259,7 +259,7 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
     ASSERT(buf_write(&token, &timestamp, sizeof(timestamp)));
     ASSERT(buf_write(&token, hmac_output, sizeof(hmac_output)));
 
-    char *b64output;
+    char *b64output = NULL;
     openvpn_base64_encode(BPTR(&token), BLEN(&token), &b64output);
 
     struct buffer session_token = alloc_buf_gc(
-- 
2.23.0.windows.1


