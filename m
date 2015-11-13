From: Selva Nair <selva.nair@...277...>
Date: Thu, 12 Nov 2015 21:41:27 -0500
Message-Id: <1447382487-26031-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Do not hard-code windows systemroot in
	env_block
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

FWIW, fixes trac #500

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/win32.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 7c89a5a..d06b41f 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -763,7 +763,12 @@ win_safe_filename (const char *fn)
 static char *
 env_block (const struct env_set *es)
 {
-  char * force_path = "PATH=C:\\Windows\\System32;C:\\WINDOWS;C:\\WINDOWS\\System32\\Wbem";
+  char force_path[256];
+  char *sysroot = get_win_sys_path();
+
+  if (!openvpn_snprintf(force_path, sizeof(force_path), "PATH=%s\\System32;%s;%s\\System32\\Wbem",
+                        sysroot, sysroot, sysroot))
+    msg(M_WARN, "env_block: default path truncated to %s", force_path);
 
   if (es)
     {
-- 
2.6.2


