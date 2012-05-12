From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 22:19:39 +0300
Message-Id: <1336850389-23719-7-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
References: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 06/16] clenaup: syshead: remove wait macros
	wrappers
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
To: openvpn-devel@lists.sourceforge.net, openvpn.list@...1114..., openvpn-devel@lists.sourceforge.net, openvpn.list@...1114...
Cc: Alon Bar-Lev <alon.barlev@...277...>

WEXITSTATUS is POSIX, show me the platform that does not support this.

WIFEXITED is not used at Windows code.

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/syshead.h |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index c5bf4a8..3e64936 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -53,15 +53,6 @@
 # include <sys/wait.h>
 #endif
 
-#ifndef WIN32
-#ifndef WEXITSTATUS
-# define WEXITSTATUS(stat_val) ((unsigned)(stat_val) >> 8)
-#endif
-#ifndef WIFEXITED
-# define WIFEXITED(stat_val) (((stat_val) & 255) == 0)
-#endif
-#endif
-
 #ifdef HAVE_SYS_TIME_H
 #include <sys/time.h>
 #endif
-- 
1.7.3.4


