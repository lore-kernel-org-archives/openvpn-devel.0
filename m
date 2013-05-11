From: Josh Cepek <josh.cepek@...1085...>
Date: Sat, 11 May 2013 14:00:24 -0500
Message-ID: <kmm4g5$fg9$1@...1062...>
Mime-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix Windows script execution when called
	from script hooks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Console applications under Windows, such as batch scripts, require the
CREATE_NO_WINDOW process flag when run without an actual console window
present. This change allows such scripts to execute and impact the hook
status by way of their return code.

Fixes bug #240.

Signed-off-by: Josh Cepek <josh.cepek@...1085...>
---
 src/openvpn/win32.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 2db96a8..291124e 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -879,7 +879,10 @@ openvpn_execve (const struct argv *a, const struct env_set *es, const unsigned i
           start_info.dwFlags = STARTF_USESHOWWINDOW;
           start_info.wShowWindow = SW_HIDE;
 
-          if (CreateProcessW (cmd, cl, NULL, NULL, FALSE, 0, env, NULL, &start_info, &proc_info))
+          /* this allows console programs to run, and is ignored otherwise */
+          unsigned int proc_flags = CREATE_NO_WINDOW;
+
+          if (CreateProcessW (cmd, cl, NULL, NULL, FALSE, proc_flags, env, NULL, &start_info, &proc_info))
             {
               DWORD exit_status = 0;
               CloseHandle (proc_info.hThread);
-- 
1.8.1.5




