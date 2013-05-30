Date: Thu, 30 May 2013 16:20:55 +0200
From: Davide Brini <dave_br@...1278...>
Mime-Version: 1.0
Message-ID: <0LzcMG-1ULZ4T0Fuc-014gq9@...1825...>
Subject: [Openvpn-devel] Provide more accurate warning message
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Very simple fix.

---
 src/openvpn/init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2a0ba85..9a9c49a 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2547,7 +2547,7 @@ do_option_warnings (struct context *c)
   else if (script_security >= SSEC_PW_ENV)
     msg (M_WARN, "WARNING: the current --script-security setting may allow passwords to be passed to scripts via environmental variables");
   else
-    msg (M_WARN, "NOTE: " PACKAGE_NAME " 2.1 requires '--script-security 2' or higher to call user-defined scripts or executables");
+    msg (M_WARN, "NOTE: starting with " PACKAGE_NAME " 2.1, '--script-security 2' or higher is required to call user-defined scripts or executables");
 }
 
 static void
-- 
1.7.10.4


-- 
D.

