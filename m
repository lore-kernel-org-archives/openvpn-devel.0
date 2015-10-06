From: Lev Stipakov <lstipakov@...277...>
Date: Tue,  6 Oct 2015 14:15:13 +0300
Message-Id: <1444130113-23387-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Continuation of MSVS fixes
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

 * Upgrade API level to Vista to implement get_default_gateway_ipv6
 * Define HAVE_INET_NTOP/PTON since Vista has its own implementation of those

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 config-msvc.h | 6 ++++++
 msvc-env.bat  | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/config-msvc.h b/config-msvc.h
index ffd35f4..07032ce 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -128,3 +128,9 @@ typedef __int8		int8_t;
 #include <config-msvc-local.h>
 #endif
 
+// Vista and above has implementation of inet_ntop / inet_pton
+#if _WIN32_WINNT >= _WIN32_WINNT_VISTA
+    #define HAVE_INET_NTOP
+    #define HAVE_INET_PTON
+#endif
+
diff --git a/msvc-env.bat b/msvc-env.bat
index 2dd0f00..aabed75 100644
--- a/msvc-env.bat
+++ b/msvc-env.bat
@@ -12,7 +12,7 @@ if "%VCHOME%"=="" SET VCHOME=%VSHOME%\VC
 set SOURCEBASE=%cd%
 set SOLUTION=openvpn.sln
 set CPPFLAGS=%CPPFLAGS%;_CRT_SECURE_NO_WARNINGS;WIN32_LEAN_AND_MEAN;_CRT_NONSTDC_NO_WARNINGS;_CRT_SECURE_NO_WARNINGS
-set CPPFLAGS=%CPPFLAGS%;NTDDI_VERSION=NTDDI_WINXP;_WIN32_WINNT=_WIN32_WINNT_WINXP
+set CPPFLAGS=%CPPFLAGS%;NTDDI_VERSION=NTDDI_VISTA;_WIN32_WINNT=_WIN32_WINNT_VISTA
 set CPPFLAGS=%CPPFLAGS%;_USE_32BIT_TIME_T
 set CPPFLAGS=%CPPFLAGS%;%EXTRA_CPPFLAGS%
 
-- 
1.9.1


