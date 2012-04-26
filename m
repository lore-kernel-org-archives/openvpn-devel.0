From: Alon Bar-Lev <alon.barlev@...277...>
Date: Fri, 27 Apr 2012 01:27:18 +0300
Message-Id: <1335479238-26420-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz02OcvCdJJ-JHBZWcxB-99nEBOXUcCHE6fkN4eGUkyCgQ@...278...>
References: <CAOazyz02OcvCdJJ-JHBZWcxB-99nEBOXUcCHE6fkN4eGUkyCgQ@...278...>
Subject: [Openvpn-devel] [PATCH] build: use stdbool.h if available
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

If stdbool.h is available use it, otherwise create emulation.

basic.h defines a type 'bool' that conflicts with
the altivec keyword bool which has to be fixed upstream, see
bugs[1][2].

[1] https://bugs.gentoo.org/show_bug.cgi?id=293840
[2] https://bugs.gentoo.org/show_bug.cgi?id=297854

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac                |    2 +-
 src/compat/compat-stdbool.h |   12 ++++++++++++
 src/openvpn/basic.h         |   13 -------------
 src/openvpn/syshead.h       |    1 +
 4 files changed, 14 insertions(+), 14 deletions(-)
 create mode 100644 src/compat/compat-stdbool.h

diff --git a/configure.ac b/configure.ac
index 8ac5ac4..1a284c7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -354,7 +354,7 @@ AX_EMPTY_ARRAY
 AC_CHECK_SIZEOF([unsigned int])
 AC_CHECK_SIZEOF([unsigned long])
 AC_CHECK_HEADERS([ \
-	stdio.h stdarg.h limits.h \
+	stdio.h stdarg.h stdbool.h limits.h \
 	time.h errno.h fcntl.h io.h direct.h \
 	ctype.h sys/types.h sys/socket.h \
 	signal.h unistd.h dlfcn.h \
diff --git a/src/compat/compat-stdbool.h b/src/compat/compat-stdbool.h
new file mode 100644
index 0000000..9941218
--- /dev/null
+++ b/src/compat/compat-stdbool.h
@@ -0,0 +1,12 @@
+#ifndef __COMPAT_STDBOOL_H
+#define __COMPAT_STDBOOL_H
+
+#ifdef HAVE_STDBOOL_H
+#include <stdbool.h>
+#else
+typedef int bool;
+#define false 0
+#define true 1
+#endif
+
+#endif
diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h
index 7c13e22..298cf10 100644
--- a/src/openvpn/basic.h
+++ b/src/openvpn/basic.h
@@ -25,19 +25,6 @@
 #ifndef BASIC_H
 #define BASIC_H
 
-/* bool definitions */
-#ifndef bool
-#define bool int
-#endif
-
-#ifndef true
-#define true 1
-#endif
-
-#ifndef false
-#define false 0
-#endif
-
 #define BOOL_CAST(x) ((x) ? (true) : (false))
 
 /* size of an array */
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 0595b67..8bc4a0f 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -26,6 +26,7 @@
 #define SYSHEAD_H
 
 #include "compat.h"
+#include "compat-stdbool.h"
 
 /* branch prediction hints */
 #if defined(__GNUC__)
-- 
1.7.3.4


