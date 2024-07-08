From: Ilia Shipitsin <chipitsine@...277...>
Date: Mon,  8 Jul 2024 23:08:21 +0200
Message-ID: <20240708210912.566-5-chipitsine@...277...>
In-Reply-To: <20240708210912.566-1-chipitsine@...277...>
References: <20240708210912.566-1-chipitsine@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/5] src/openvpn/ssl_verify.c: handle strdup
 errors
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
 src/openvpn/ssl_verify.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 934ff8d8..c4b95553 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1629,6 +1629,10 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
         if (!multi->auth_token_initial)
         {
             multi->auth_token_initial = strdup(up->password);
+            if (!multi->auth_token_initial)
+            {
+                msg( M_FATAL, "Failed allocate memory for multi->auth_token_initial");
+            }
         }
 
         if (session->opt->auth_token_call_auth)
@@ -1749,6 +1753,10 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
                 && !(ks->auth_token_state_flags & AUTH_TOKEN_EXPIRED))
             {
                 multi->auth_token = strdup(up->password);
+                if (!multi->auth_token)
+                {
+                    msg( M_FATAL, "Failed allocate memory for multi->auth_token");
+                }
             }
 
             /*
-- 
2.43.0.windows.1


