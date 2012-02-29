From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:11:35 +0200
Message-Id: <1330546342-17794-6-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 05/52] cleanup: win32.c: wrong printf format
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 win32.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/win32.c b/win32.c
index 2ba97fc..acf5ebc 100644
--- a/win32.c
+++ b/win32.c
@@ -1012,12 +1012,12 @@ openvpn_execve (const struct argv *a, const struct env_set *es, const unsigned i
 		  if (GetExitCodeProcess (proc_info.hProcess, &exit_status))
 		    ret = (int)exit_status;
 		  else
-		    msg (M_WARN|M_ERRNO, "openvpn_execve: GetExitCodeProcess %s failed", cmd);
+		    msg (M_WARN|M_ERRNO, "openvpn_execve: GetExitCodeProcess %S failed", cmd);
 		  CloseHandle (proc_info.hProcess);
 		}
 	      else
 		{
-		  msg (M_WARN|M_ERRNO, "openvpn_execve: CreateProcess %s failed", cmd);
+		  msg (M_WARN|M_ERRNO, "openvpn_execve: CreateProcess %S failed", cmd);
 		}
 	      free (env);
 	      gc_free (&gc);
-- 
1.7.3.4


