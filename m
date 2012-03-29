From: Alon Bar-Lev <alon.barlev@...277...>
Date: Thu, 29 Mar 2012 11:16:39 +0200
Message-Id: <1333012602-5419-2-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz0xh540Gk3j3T_O0B3ix9htz12dm0VMuKmB16FOQAAQoA@...278...>
References: <CAOazyz0xh540Gk3j3T_O0B3ix9htz12dm0VMuKmB16FOQAAQoA@...278...>
Subject: [Openvpn-devel] [PATCH 1/4] cleanup: avoid using ~0 - generic
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
To: Openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

Use limits.h for maximum value.

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 config-msvc.h         |    1 +
 configure.ac          |    2 +-
 src/openvpn/route.c   |    2 +-
 src/openvpn/syshead.h |    4 ++++
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/config-msvc.h b/config-msvc.h
index 0e42505..99c00f9 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -30,6 +30,7 @@
 #define HAVE_STRERROR 1
 #define HAVE_STRINGS_H 1
 #define HAVE_STRING_H 1
+#define HAVE_LIMITS_H 1
 #define HAVE_SYSTEM 1
 #define HAVE_TIME 1
 #define HAVE_TIME_H 1
diff --git a/configure.ac b/configure.ac
index ef34697..e962323 100644
--- a/configure.ac
+++ b/configure.ac
@@ -354,7 +354,7 @@ AX_EMPTY_ARRAY
 AC_CHECK_SIZEOF([unsigned int])
 AC_CHECK_SIZEOF([unsigned long])
 AC_CHECK_HEADERS([ \
-	stdio.h stdarg.h \
+	stdio.h stdarg.h limits.h \
 	time.h errno.h fcntl.h io.h direct.h \
 	ctype.h sys/types.h sys/socket.h \
 	signal.h unistd.h dlfcn.h \
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index bf7af63..a628e77 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2386,7 +2386,7 @@ get_default_gateway (struct route_gateway_info *rgi)
       {
 	char line[256];
 	int count = 0;
-	unsigned int lowest_metric = ~0;
+	unsigned int lowest_metric = UINT_MAX;
 	in_addr_t best_gw = 0;
 	bool found = false;
 	while (fgets (line, sizeof (line), fp) != NULL)
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index e60dc44..0595b67 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -129,6 +129,10 @@
 #include <signal.h>
 #endif
 
+#ifdef HAVE_LIMITS_H
+#include <limits.h>
+#endif
+
 #ifdef HAVE_STDIO_H
 #include <stdio.h>
 #endif
-- 
1.7.3.4


