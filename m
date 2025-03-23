From: Gert Doering <gert@...1296...>
Date: Sun, 23 Mar 2025 22:13:53 +0100
Message-ID: <20250323211359.14117-1-gert@...1296...>
In-Reply-To: <gerrit.1742731599000.I28a8abd0ee3fa9168a716171b0a405476089c4a1@...2715...>
References: <gerrit.1742731599000.I28a8abd0ee3fa9168a716171b0a405476089c4a1@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix incorrect condition for checking
 password related check
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

From: Arne Schwabe <arne@...1227...>

Commit db48cea chagned logic to move logic from a variable and repeated
checks to an if clause.

The old code had

            const bool ccnr = (options->auth_user_pass_verify_script
                                || PLUGIN_OPTION_LIST(options)
                                || MAN_CLIENT_AUTH_ENABLED(options));

followed by several condition that checked !ccnr

This commit fixes the if clause by correctly applying De Margan's law.

Change-Id: I28a8abd0ee3fa9168a716171b0a405476089c4a1
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Antonio Quartulli <a@...2181...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/912
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <a@...2181...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 67ef55b..ab56609 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2752,8 +2752,8 @@
 
         }
         if (!options->auth_user_pass_verify_script
-            || PLUGIN_OPTION_LIST(options)
-            || MAN_CLIENT_AUTH_ENABLED(options))
+            && !PLUGIN_OPTION_LIST(options)
+            && !MAN_CLIENT_AUTH_ENABLED(options))
         {
             const char *use_err = "--%s must be used with --management-client-auth, an --auth-user-pass-verify script, or plugin";
 

