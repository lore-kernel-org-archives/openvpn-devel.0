From: Heiko Hund <heiko.hund@...1489...>
Date: Fri,  1 Feb 2013 15:19:14 +0100
Message-Id: <1359728354-9405-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH] close more file descriptors on exec
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

Don't inherit the --status and --ifconfig-pool-persist, and on Linux
the epoll(7), file descriptors to scripts and other processes that
may be forked by plugins.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/event.c  |    3 +++
 src/openvpn/status.c |    2 ++
 2 files changed, 5 insertions(+)

diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index 2a13e1c..34a3c45 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -34,6 +34,7 @@
 #include "error.h"
 #include "integer.h"
 #include "event.h"
+#include "fdmisc.h"
 
 #include "memdbg.h"
 
@@ -582,6 +583,8 @@ ep_init (int *maxevents, unsigned int flags)
   if (fd < 0)
     return NULL;
 
+  set_cloexec (fd);
+
   ALLOC_OBJ_CLEAR (eps, struct ep_set);
 
   /* set dispatch functions */
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index 5f9ab9e..8773f3d 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -33,6 +33,7 @@
 #include "status.h"
 #include "perf.h"
 #include "misc.h"
+#include "fdmisc.h"
 
 #include "memdbg.h"
 
@@ -98,6 +99,7 @@ status_open (const char *filename,
 	  if (so->fd >= 0)
 	    {
 	      so->filename = string_alloc (filename, NULL);
+              set_cloexec (so->fd);
 
 	      /* allocate read buffer */
 	      if (so->flags & STATUS_OUTPUT_READ)
-- 
1.7.9.5


