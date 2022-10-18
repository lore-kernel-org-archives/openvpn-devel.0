From: Arne Schwabe <arne@...1227...>
Date: Tue, 18 Oct 2022 16:37:04 +0200
Message-Id: <20221018143704.2759522-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix renewal spelling and actually allow
 external-auth with renewal time
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

The previous commit  9a516170 forgot to change to allow more than 2 parameters
to auth-gen-token, so you could eitherh ave renewal time or external-auth but
not both. Also fix two instances of misspelled auth-gen-token

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 60fec147..9f5e4b35 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2635,7 +2635,7 @@ options_postprocess_verify_ce(const struct options *options,
         if (options->auth_token_generate && options->auth_token_renewal
             && options->auth_token_renewal < 2 * options->handshake_window)
         {
-            msg(M_USAGE, "--auth-gen-token reneweal time needs to be at least "
+            msg(M_USAGE, "--auth-gen-token renewal time needs to be at least "
                 " two times --hand-window (%d).",
                 options->handshake_window);
 
@@ -7476,7 +7476,7 @@ add_option(struct options *options,
                         &options->auth_user_pass_verify_script,
                         p[1], "auth-user-pass-verify", true);
     }
-    else if (streq(p[0], "auth-gen-token") && !p[3])
+    else if (streq(p[0], "auth-gen-token"))
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->auth_token_generate = true;
@@ -7484,7 +7484,7 @@ add_option(struct options *options,
 
         for (int i = 2; i < MAX_PARMS && p[i] != NULL; i++)
         {
-            /* the second parameter can be the reneweal time */
+            /* the second parameter can be the renewal time */
             if (i == 2 && positive_atoi(p[i]))
             {
                 options->auth_token_renewal = positive_atoi(p[i]);
-- 
2.37.0 (Apple Git-136)


