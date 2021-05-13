From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 13 May 2021 17:00:39 +0300
Message-Id: <20210513140039.265-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] win32: add missing include header
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Commit 5a571fb0 ("Move utility function from win32.c to win32-util.c")
moved some functions from win32.[ch] to a new win32-util.[ch], but missed
adding new include header, which results in compilation errors like:

    >cryptoapi.c
    >C:\Users\lev\Projects\openvpn\src\openvpn\cryptoapi.c(755,53): error C2220: the following warning is treated as an error
    >C:\Users\lev\Projects\openvpn\src\openvpn\cryptoapi.c(755,53): warning C4047: '=': 'const void *' differs in levels of indirection from 'int'

Fix by adding #include "win32-util.h" to "win32.h".

While on it, update vcxproj.filters with a new header so that
it looks "correct" in VS project view.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/openvpn.vcxproj.filters | 3 +++
 src/openvpn/win32.h                 | 1 +
 2 files changed, 4 insertions(+)

diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index a4dbb6cd..3b75eecd 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -518,6 +518,9 @@
     <ClInclude Include="ssl_util.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="win32-util.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include="openvpn_win32_resources.rc">
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 23573835..f075e0ae 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -30,6 +30,7 @@
 #include "mtu.h"
 #include "openvpn-msg.h"
 #include "argv.h"
+#include "win32-util.h"
 
 /* location of executables */
 #define SYS_PATH_ENV_VAR_NAME "SystemRoot"  /* environmental variable name that normally contains the system path */
-- 
2.23.0.windows.1


