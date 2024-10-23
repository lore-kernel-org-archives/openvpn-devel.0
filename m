From: Razvan Cojocaru <rzvncj@...277...>
Date: Wed, 23 Oct 2024 16:49:03 +0300
Message-ID: <20241023134903.66485-1-rzvncj@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Allow setting an empty auth-token in push
 replies
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

This in turn allows the server to signal to the client that it
should no longer attempt to reconnect, if it wants to keep the
client out after an AUTH_FAILED.

Signed-off-by: Razvan Cojocaru <rzvncj@...277...>
---
 src/openvpn/misc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 70ba5e4d..82ac8056 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -524,6 +524,11 @@ set_auth_token(struct user_pass *tk, const char *token)
         }
         protect_user_pass(tk);
     }
+    else
+    {
+        tk->defined = false;
+        tk->token_defined = false;
+    }
 }
 
 void
-- 
2.47.0


