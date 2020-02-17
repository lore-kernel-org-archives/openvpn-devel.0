From: Arne Schwabe <arne@...1227...>
Date: Mon, 17 Feb 2020 15:43:36 +0100
Message-Id: <20200217144339.3273-3-arne@...1227...>
In-Reply-To: <20200217144339.3273-1-arne@...1227...>
References: <20200217144339.3273-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v4 2/5] Add strsep compat function
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

Some operating system do not have the strsep function. Since this API
is more "modern" (4.4BSD) than strtok, add it as compat function.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 configure.ac               |  2 +-
 src/compat/Makefile.am     |  1 +
 src/compat/compat-strsep.c | 61 ++++++++++++++++++++++++++++++++++++++
 src/compat/compat.h        |  4 +++
 src/compat/compat.vcxproj  |  3 +-
 5 files changed, 69 insertions(+), 2 deletions(-)
 create mode 100644 src/compat/compat-strsep.c

diff --git a/configure.ac b/configure.ac
index 3c057295..a47ef3e7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -655,7 +655,7 @@ AC_CHECK_FUNCS([ \
 	ctime memset vsnprintf strdup \
 	setsid chdir putenv getpeername unlink \
 	chsize ftruncate execve getpeereid umask basename dirname access \
-	epoll_create \
+	epoll_create strsep \
 ])
 
 AC_CHECK_LIB(
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index b51f661e..2e94e943 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -30,4 +30,5 @@ libcompat_la_SOURCES = \
 	compat-inet_ntop.c \
 	compat-inet_pton.c \
 	compat-lz4.c compat-lz4.h \
+	compat-strsep.c \
 	compat-versionhelpers.h
diff --git a/src/compat/compat-strsep.c b/src/compat/compat-strsep.c
new file mode 100644
index 00000000..42ff6414
--- /dev/null
+++ b/src/compat/compat-strsep.c
@@ -0,0 +1,61 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2019 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 1992-2019 Free Software Foundation, Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#ifndef HAVE_STRSEP
+#include <string.h>
+
+/*
+ * Modified version based on the glibc
+ */
+char *
+strsep(char **stringp, const char *delim)
+{
+    char *begin, *end;
+    begin = *stringp;
+    if (begin == NULL)
+    {
+        return NULL;
+    }
+    /* Find the end of the token.  */
+    end = begin + strcspn(begin, delim);
+    if (*end)
+    {
+        /* Terminate the token and set *STRINGP past NUL character.  */
+        *end++ = '\0';
+        *stringp = end;
+    }
+    else
+    {
+        /* No more delimiters; this is the last token.  */
+        *stringp = NULL;
+    }
+    return begin;
+}
+#endif
diff --git a/src/compat/compat.h b/src/compat/compat.h
index d5228989..592881df 100644
--- a/src/compat/compat.h
+++ b/src/compat/compat.h
@@ -70,4 +70,8 @@ int inet_pton(int af, const char *src, void *dst);
 
 #endif
 
+#ifndef HAVE_STRSEP
+char* strsep(char **stringp, const char *delim);
+#endif
+
 #endif /* COMPAT_H */
diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
index e388008a..0c4c7b0f 100644
--- a/src/compat/compat.vcxproj
+++ b/src/compat/compat.vcxproj
@@ -102,6 +102,7 @@
     <ClCompile Include="compat-inet_pton.c" />
     <ClCompile Include="compat-daemon.c" />
     <ClCompile Include="compat-lz4.c" />
+    <ClCompile Include="compat-strsep.c" />
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="compat.h" />
@@ -115,4 +116,4 @@
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
   <ImportGroup Label="ExtensionTargets">
   </ImportGroup>
-</Project>
\ No newline at end of file
+</Project>
-- 
2.25.0


