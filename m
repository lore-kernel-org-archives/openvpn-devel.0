From: Arne Schwabe <arne@...1227...>
Date: Mon, 17 Mar 2014 13:45:45 +0100
Message-Id: <1395060345-30870-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix warning for max-routes: do not quit
	when parsing an old configuration. Format the message to be
	more like the other deprecated options
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

---
 src/openvpn/options.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ef6170c..d69e28f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5225,8 +5225,10 @@ add_option (struct options *options,
     }
   else if (streq (p[0], "max-routes"))
     {
-      msg (msglevel, "--max-routes option ignored. The number of routes is unlimited as of version 2.4. "
-           "This option will be removed in a future version, please remove it from your configuration.");
+      msg (M_WARN, "DEPRECATED OPTION: --max-routes option ignored."
+	   "The number of routes is unlimited as of version 2.4. "
+	   "This option will be removed in a future version, "
+	   "please remove it from your configuration.");
     }
   else if (streq (p[0], "route-gateway") && p[1])
     {
-- 
1.8.5.2 (Apple Git-48)


