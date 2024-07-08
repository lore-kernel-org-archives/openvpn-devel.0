From: Ilia Shipitsin <chipitsine@...277...>
Date: Mon,  8 Jul 2024 23:08:22 +0200
Message-ID: <20240708210912.566-6-chipitsine@...277...>
In-Reply-To: <20240708210912.566-1-chipitsine@...277...>
References: <20240708210912.566-1-chipitsine@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/5]
 tests/unit_tests/openvpn/test_auth_token.c: handle strdup errors
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

Signed-off-by: Ilia Shipitsin <chipitsine@...277...>
---
 tests/unit_tests/openvpn/test_auth_token.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
index 3a3cb69b..8a0c16af 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -245,6 +245,7 @@ auth_token_test_known_keys(void **state)
     now = 0;
     /* Preload the session id so the same session id is used here */
     ctx->multi.auth_token_initial = strdup(now0key0);
+    assert_non_null(ctx->multi.auth_token_initial);
 
     /* Zero the hmac part to ensure we have a newly generated token */
     zerohmac(ctx->multi.auth_token_initial);
@@ -374,6 +375,7 @@ auth_token_test_random_keys(void **state)
     now = 0x5c331e9c;
     /* Preload the session id so the same session id is used here */
     ctx->multi.auth_token_initial = strdup(random_token);
+    assert_non_null(ctx->multi.auth_token_initial);
 
     free_key_ctx(&ctx->multi.opt.auth_token_key);
     auth_token_init_secret(&ctx->multi.opt.auth_token_key, random_key, true);
-- 
2.43.0.windows.1


