From: Gert Doering <gert@...1296...>
Date: Sun, 20 Nov 2016 08:47:40 +0100
Message-Id: <1479628060-32673-1-git-send-email-gert@...1296...>
In-Reply-To: <1479569756-23302-1-git-send-email-arne@...1227...>
References: <1479569756-23302-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Remove remaining traces of compat-stdbool.h
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

commit 35be7e0d5 removed most references to compat-stdbool.h but
overlooked configure and "make dist"

Signed-off-by: Gert Doering <gert@...1296...>
---
 configure.ac           | 2 +-
 src/compat/Makefile.am | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4a45f05..f4073d0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -435,7 +435,7 @@ AX_EMPTY_ARRAY
 AC_CHECK_SIZEOF([unsigned int])
 AC_CHECK_SIZEOF([unsigned long])
 AC_CHECK_HEADERS([ \
-	stdio.h stdarg.h stdbool.h limits.h \
+	stdio.h stdarg.h limits.h \
 	time.h errno.h fcntl.h io.h direct.h \
 	ctype.h sys/types.h sys/socket.h \
 	signal.h unistd.h dlfcn.h \
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index 06bab5c..0a9d1c2 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -20,7 +20,6 @@ noinst_LTLIBRARIES = libcompat.la
 
 libcompat_la_SOURCES = \
 	compat.h \
-	compat-stdbool.h \
 	compat-dirname.c \
 	compat-basename.c \
 	compat-gettimeofday.c \
-- 
2.7.3


