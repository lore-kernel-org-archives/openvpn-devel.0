From: Arne Schwabe <arne@...1227...>
Date: Thu, 22 Apr 2021 17:29:36 +0200
Message-Id: <20210422152939.2134046-3-arne@...1227...>
In-Reply-To: <20210422152939.2134046-1-arne@...1227...>
References: <20210422152939.2134046-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 3/6] Move direct.h header where it is used
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The direct.h header provides only a handful of functions [1] of which
we only use _wchdir. Directly included the direct.h file where it is
used and remove autoconf magic around it.

[1] https://docs.microsoft.com/en-us/previous-versions/visualstudio/visual-studio-2012/as5kw0ze(v=vs.110)?redirectedfrom=MSDN

Patch V2: also remove from config-msvc.h

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 config-msvc.h          | 1 -
 configure.ac           | 2 +-
 src/openvpn/platform.c | 4 ++++
 src/openvpn/syshead.h  | 4 ----
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/config-msvc.h b/config-msvc.h
index 3750f0799..e73dd8c6f 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -29,7 +29,6 @@
 #define HAVE_WINSOCK2_H 1
 #define HAVE_WS2TCPIP_H 1
 #define HAVE_IO_H 1
-#define HAVE_DIRECT_H 1
 #define HAVE_SYS_TYPES_H 1
 #define HAVE_SYS_STAT_H 1
 #define HAVE_LZO_LZO1X_H 1
diff --git a/configure.ac b/configure.ac
index aaac65c3d..a67bf2595 100644
--- a/configure.ac
+++ b/configure.ac
@@ -407,7 +407,7 @@ AX_TYPE_SOCKLEN_T
 AC_CHECK_SIZEOF([unsigned int])
 AC_CHECK_SIZEOF([unsigned long])
 AC_CHECK_HEADERS([ \
-	fcntl.h io.h direct.h \
+	fcntl.h io.h \
 	sys/types.h sys/socket.h \
 	unistd.h dlfcn.h \
 	netinet/in.h netinet/in_systm.h \
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 45ee54541..c63c1d994 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -39,6 +39,10 @@
 
 #include "platform.h"
 
+#if _WIN32
+#include <direct.h>
+#endif
+
 /* Redefine the top level directory of the filesystem
  * to restrict access to files for security */
 void
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 4650846fe..f29c63c73 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -100,10 +100,6 @@
 #include <fcntl.h>
 #endif
 
-#ifdef HAVE_DIRECT_H
-#include <direct.h>
-#endif
-
 #ifdef HAVE_IO_H
 #include <io.h>
 #endif
-- 
2.31.1


