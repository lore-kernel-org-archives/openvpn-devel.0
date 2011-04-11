MIME-Version: 1.0
Date: Tue, 12 Apr 2011 05:23:27 +0900
Message-ID: <BANLkTi=-c2jxGcNj=+gdujJhhDjwrWP2TQ@...278...>
From: crocket <crockabiscuit@...277...>
Subject: [Openvpn-devel] I made a patch that prevents POSIX capabilities
 from disappearing during UID downgrade.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

diff -Naur a/init.c b/init.c
--- a/init.c	2010-11-05 04:29:02.000000000 +0900
+++ b/init.c	2011-04-12 05:11:43.540370471 +0900
@@ -41,6 +41,10 @@

 #include "occ-inline.h"

+#ifdef TARGET_LINUX
+#include <sys/prctl.h>
+#endif
+
 static struct context *static_context; /* GLOBAL */

 /*
@@ -904,6 +908,10 @@
       if (no_delay)
 	{
 	  set_group (&c0->group_state);
+#ifdef TARGET_LINUX
+	  if(prctl(PR_SET_KEEPCAPS, 1) < 0)
+	    msg (M_ERR, "prctl(PR_SET_KEEPCAPS, 1) failed");
+#endif
 	  set_user (&c0->user_state);
 	  c0->uid_gid_set = true;
 	}

The patch is above.
I had been investigating why OpenVPN refused to use CAP_IPC_LOCK capability.
I found out that it was because OpenVPN invoked setuid and setuid
erased POSIX capabilities.
prctl(PR_SET_KEEPCAPS, 1) lets OpenVPN keep capabilities after setuid
invocation.

Thanks in advance for considering this patch.

