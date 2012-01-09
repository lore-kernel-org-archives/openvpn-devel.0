From: David Sommerseth <davids@...1347...>
Date: Mon,  9 Jan 2012 18:11:27 +0100
Message-Id: <1326129087-8697-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Fix a couple of issues in openvpn_execve()
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

If openvpn_execve() is not able to fork(), it would make any noise about
it.  So this patch adds a log notification if this happens.

In addition, if openvpn_execve() is called with an empty argv array,
it should exit instantly.  This is not expected to happen at all and
might indicate a much more serious issue (or programming error)
somewhere else in the code.  Thus, abort execution to get these issues
flushed out as quickly as possible.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 misc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc.c b/misc.c
index 9ac2877..b834a3e 100644
--- a/misc.c
+++ b/misc.c
@@ -529,7 +529,7 @@ openvpn_execve (const struct argv *a, const struct env_set *es, const unsigned i
 		  exit (127);
 		}
 	      else if (pid < (pid_t)0) /* fork failed */
-		;
+		msg (M_ERR, "openvpn_execve: unable to fork");
 	      else /* parent side */
 		{
 		  if (waitpid (pid, &ret, 0) != pid)
@@ -556,7 +556,7 @@ openvpn_execve (const struct argv *a, const struct env_set *es, const unsigned i
     }
   else
     {
-      msg (M_WARN, "openvpn_execve: called with empty argv");
+      msg (M_FATAL, "openvpn_execve: called with empty argv");
     }
 
   gc_free (&gc);
-- 
1.7.4.4


