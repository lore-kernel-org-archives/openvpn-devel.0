From: Lev Stipakov <lstipakov@...277...>
Date: Thu,  5 Nov 2015 18:06:26 +0200
Message-Id: <1446739586-18192-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Enable replay-window usage for
	configurations with both UDP and TCP remotes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 src/openvpn/options.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2f8915d..de6e453 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2110,12 +2110,13 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 #ifdef ENABLE_CRYPTO
 
   /*
-   * Check consistency of replay options
+   * Check consistency of replay options.
+   * Use nonfatal warning in case of config contains both UDP and TCP remotes.
    */
   if ((!proto_is_udp(ce->proto))
       && (options->replay_window != defaults.replay_window
 	  || options->replay_time != defaults.replay_time))
-    msg (M_USAGE, "--replay-window only makes sense with --proto udp");
+    msg (M_WARN, "--replay-window only makes sense with --proto udp");
 
   if (!options->replay
       && (options->replay_window != defaults.replay_window
-- 
1.9.1


