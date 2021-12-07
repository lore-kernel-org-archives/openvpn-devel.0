From: Antonio Quartulli <a@...2181...>
Date: Tue,  7 Dec 2021 13:11:36 +0100
Message-Id: <20211207121137.3221-8-a@...2181...>
In-Reply-To: <20211207121137.3221-1-a@...2181...>
References: <20211207121137.3221-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [RFC 7/8] ovpn-dco-win: fix mingw i686 build
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
Cc: Lev Stipakov <lev@...515...>, Arne Schwabe <arne@...1227...>

From: Lev Stipakov <lev@...515...>

mingw i686 has GetOverlappedResultEx() in header file
but not in lib file, causing linking error.

To work around this issue, introduce dco_get_overlapped_result
compat macro, which is defined as GetOverlappedResultEx() for
all build configurations except mingw i686. For latter case,
define compat implementation which uses GetOverlappedResult()
and Sleep().

Signed-off-by: Lev Stipakov <lev@...515...>
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/compat/Makefile.am                        |  3 +-
 src/compat/compat-dco_get_overlapped_result.c | 44 +++++++++++++++++++
 src/compat/compat.h                           |  6 +++
 src/compat/compat.vcxproj                     |  1 +
 src/compat/compat.vcxproj.filters             |  3 ++
 src/openvpn/networking_windco.c               | 11 +++--
 6 files changed, 64 insertions(+), 4 deletions(-)
 create mode 100644 src/compat/compat-dco_get_overlapped_result.c

diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index 95eb04bb..cefc2d81 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -28,4 +28,5 @@ libcompat_la_SOURCES = \
 	compat-gettimeofday.c \
 	compat-daemon.c \
 	compat-strsep.c \
-	compat-versionhelpers.h
+	compat-versionhelpers.h \
+	compat-dco_get_overlapped_result.c
diff --git a/src/compat/compat-dco_get_overlapped_result.c b/src/compat/compat-dco_get_overlapped_result.c
new file mode 100644
index 00000000..4a52dd46
--- /dev/null
+++ b/src/compat/compat-dco_get_overlapped_result.c
@@ -0,0 +1,44 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2021 Lev Stipakov <lev@...515...>
+ *  Copyright (C) 2021 OpenVPN Inc <sales@...515...>
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
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "compat.h"
+
+#if defined(__MINGW32__) && !defined(__MINGW64__)
+BOOL dco_get_overlapped_result(HANDLE handle, OVERLAPPED* ov, DWORD* transferred, DWORD delay_millisec, BOOL unused)
+{
+    BOOL res = GetOverlappedResult(handle, ov, transferred, FALSE);
+    if ((res == 0) && (GetLastError() == ERROR_IO_INCOMPLETE))
+    {
+        Sleep(delay_millisec);
+    }
+    return res;
+}
+#endif
diff --git a/src/compat/compat.h b/src/compat/compat.h
index 026974a8..274febce 100644
--- a/src/compat/compat.h
+++ b/src/compat/compat.h
@@ -62,4 +62,10 @@ char *strsep(char **stringp, const char *delim);
 
 #endif
 
+#if defined(__MINGW32__) && !defined(__MINGW64__)
+BOOL dco_get_overlapped_result(HANDLE handle, OVERLAPPED* ov, DWORD* transferred, DWORD delay_millisec, BOOL unused);
+#else
+#define dco_get_overlapped_result GetOverlappedResultEx
+#endif
+
 #endif /* COMPAT_H */
diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
index fe03a51a..1dacb503 100644
--- a/src/compat/compat.vcxproj
+++ b/src/compat/compat.vcxproj
@@ -159,6 +159,7 @@
   </ItemDefinitionGroup>
   <ItemGroup>
     <ClCompile Include="compat-basename.c" />
+    <ClCompile Include="compat-dco_get_overlapped_result.c" />
     <ClCompile Include="compat-dirname.c" />
     <ClCompile Include="compat-gettimeofday.c" />
     <ClCompile Include="compat-daemon.c" />
diff --git a/src/compat/compat.vcxproj.filters b/src/compat/compat.vcxproj.filters
index 96ca026a..73fc9f91 100644
--- a/src/compat/compat.vcxproj.filters
+++ b/src/compat/compat.vcxproj.filters
@@ -30,6 +30,9 @@
     <ClCompile Include="compat-strsep.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="compat-dco_get_overlapped_result.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="compat.h">
diff --git a/src/openvpn/networking_windco.c b/src/openvpn/networking_windco.c
index 3c88b752..f4ec01bc 100644
--- a/src/openvpn/networking_windco.c
+++ b/src/openvpn/networking_windco.c
@@ -74,17 +74,22 @@ void dco_start_tun(struct tuntap* tt)
 
 int dco_connect_wait(HANDLE handle, OVERLAPPED* ov, int timeout, volatile int* signal_received)
 {
-    while (timeout-- > 0)
+    DWORD timeout_msec = timeout * 1000;
+    const int poll_interval_ms = 50;
+
+    while (timeout_msec > 0)
     {
+        timeout_msec -= poll_interval_ms;
+
         DWORD transferred;
-        if (GetOverlappedResultEx(handle, ov, &transferred, 1000, FALSE) != 0)
+        if (dco_get_overlapped_result(handle, ov, &transferred, poll_interval_ms, FALSE) != 0)
         {
             /* TCP connection established by dco */
             return 0;
         }
 
         DWORD err = GetLastError();
-        if (err != WAIT_TIMEOUT)
+        if ((err != WAIT_TIMEOUT) && (err != ERROR_IO_INCOMPLETE))
         {
             /* dco reported connection error */
             struct gc_arena gc = gc_new();
-- 
2.32.0


