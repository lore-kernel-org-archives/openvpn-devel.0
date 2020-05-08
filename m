From: Antonio Quartulli <a@...2181...>
Date: Fri,  8 May 2020 23:14:34 +0200
Message-Id: <20200508211434.27545-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] options: fix inlining auth-gen-token-secret
 file
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
Cc: Antonio Quartulli <a@...2181...>

With commit ("convert *_inline attributes to bool") the logic for
signaling when a certain option is inline has been changed.
Due to an overlook, the auth-gen-token-secret was not converted, thus
making it impossible to be inlined.

Fix parsing logic and allow auth-gen-token-secret to be inlined as well.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/options.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 56c9e411..2d2089e3 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6981,16 +6981,12 @@ add_option(struct options *options,
         }
 
     }
-    else if (streq(p[0], "auth-gen-token-secret") && p[1] && (!p[2]
-                                                              || (p[2] && streq(p[1], INLINE_FILE_TAG))))
+    else if (streq(p[0], "auth-gen-token-secret") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
         options->auth_token_secret_file = p[1];
+        options->auth_token_secret_file_inline = is_inline;
 
-        if (streq(p[1], INLINE_FILE_TAG) && p[2])
-        {
-            options->auth_token_secret_file_inline = p[2];
-        }
     }
     else if (streq(p[0], "client-connect") && p[1])
     {
-- 
2.26.2


