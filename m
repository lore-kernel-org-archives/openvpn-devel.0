From: davids@...1347...
Date: Wed,  3 Sep 2014 18:23:37 +0200
Message-Id: <1409761417-30948-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Don't let openvpn_popen() keep zoombies
	around
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
Cc: fcrozat@...1519...

From: David Sommerseth <davids@...1347...>

Commit 9449e6a9eba30c9ed054f57d630a88c9f087080f introduced the
openvpn_popen() function to support retrieving passwords via systemd.

It was discovered that the child processes openvpn fork()ed would
be lingering around until openvpn stopped.  This was due to the lack
of a wait() call.

This patch also cleans up a few minor white-space issues in the same
code segment.

Cc: Frederic Crozat <fcrozat@...1519...>
Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/openvpn/misc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 63b4c1c..16c8dcf 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -376,8 +376,11 @@ openvpn_popen (const struct argv *a,  const struct env_set *es)
 			}
 		      else /* parent side */
 			{
-                            ret=pipe_stdout[0];
-			    close (pipe_stdout[1]);
+                          int status;
+
+                          waitpid(pid, &status, 0);
+                          ret = pipe_stdout[0];
+                          close (pipe_stdout[1]);
 			}
 	      }
 	      else {
-- 
1.8.3.1


