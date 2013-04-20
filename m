From: Arne Schwabe <arne@...1227...>
Date: Sat, 20 Apr 2013 16:22:44 +0200
Message-Id: <1366467768-16260-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/5] Remove script-security warning
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
 src/openvpn/init.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 979ba23..b7f71c3 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2480,12 +2480,6 @@ do_option_warnings (struct context *c)
     msg (M_WARN, "NOTE: --connect-timeout option is not supported on this OS");
 #endif
 
-  if (script_security >= SSEC_SCRIPTS)
-    msg (M_WARN, "NOTE: the current --script-security setting may allow this configuration to call user-defined scripts");
-  else if (script_security >= SSEC_PW_ENV)
-    msg (M_WARN, "WARNING: the current --script-security setting may allow passwords to be passed to scripts via environmental variables");
-  else
-    msg (M_WARN, "NOTE: " PACKAGE_NAME " 2.1 requires '--script-security 2' or higher to call user-defined scripts or executables");
 }
 
 static void
-- 
1.7.9.5


