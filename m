From: Ilia Shipitsin <chipitsine@...277...>
Date: Mon,  8 Jul 2024 23:08:20 +0200
Message-ID: <20240708210912.566-4-chipitsine@...277...>
In-Reply-To: <20240708210912.566-1-chipitsine@...277...>
References: <20240708210912.566-1-chipitsine@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/5] src/openvpn/auth_token.c: handle strdup
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
 src/openvpn/auth_token.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 6787ea7d..2278afe6 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -260,6 +260,10 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
     /* free the auth-token if defined, we will replace it with a new one */
     free(multi->auth_token);
     multi->auth_token = strdup((char *)BPTR(&session_token));
+    if (!multi->auth_token)
+    {
+        msg( M_FATAL, "Failed allocate memory for multi->auth_token");
+    }
 
     dmsg(D_SHOW_KEYS, "Generated token for client: %s (%s)",
          multi->auth_token, up->username);
@@ -271,6 +275,10 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
          * and timestamp in updates
          */
         multi->auth_token_initial = strdup(multi->auth_token);
+        if (!multi->auth_token_initial)
+        {
+            msg( M_FATAL, "Failed allocate memory for multi->auth_token_initial");
+        }
     }
 
     gc_free(&gc);
-- 
2.43.0.windows.1


