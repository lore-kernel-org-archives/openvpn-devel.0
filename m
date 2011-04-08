From: David Sommerseth <davids@...1347...>
Date: Fri,  8 Apr 2011 13:40:05 +0200
Message-Id: <1302262805-23686-3-git-send-email-davids@...1347...>
In-Reply-To: <1302262805-23686-1-git-send-email-davids@...1347...>
References: <1302106222-10256-1-git-send-email-davids@...1347...>
	<1302262805-23686-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH 2/2] Use %SystemRoot% instead of hard-coded
	C:\WINDOWS for temp directory path
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
Cc: David Sommerseth <davids@...1347...>

It is expected that %SystemRoot% is always defined to the directory of the
Windows system.  If this is undefined, Windows do not work properly.

So instead of hard-coding C:\WINDOWS\Temp as the default temporary directory
if %TEMP% or %TMP% is not found, use %SystemRoot%\Temp instead as the fallback.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 win/config.h.in |    3 ---
 win32.c         |   36 ++++++++++++++++++++++++++----------
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/win/config.h.in b/win/config.h.in
index abf71d2..fb349d0 100644
--- a/win/config.h.in
+++ b/win/config.h.in
@@ -286,9 +286,6 @@ typedef unsigned long in_addr_t;
 /* Route command */
 #define ROUTE_PATH "route"
 
-/* Default temporary directory, if not found via getenv() */
-#define DEFAULT_TMPDIR "C:\\WINDOWS\\Temp"   /* FIXME: Should be configurable */
-
 #ifdef _MSC_VER
 /* MSVC++ hacks */
 #pragma warning(disable:4244) // conversion from 'foo' to 'bar', possible loss of data
diff --git a/win32.c b/win32.c
index b65f987..29653da 100644
--- a/win32.c
+++ b/win32.c
@@ -1097,19 +1097,35 @@ env_set_add_win32 (struct env_set *es)
 const char *
 win_get_tempdir()
 {
-  static char *tmpdir = NULL;
+  static char tmpdir[258];
+  char *envptr = NULL;
 
-  /* Try to use %TEMP% or %TMP% */
-  tmpdir = getenv("TEMP");
-  if( !tmpdir ) {
-    tmpdir = getenv("TMP");
+  CLEAR (tmpdir);
+
+  /* Try to use %TEMP%, %TMP% or %SystemRoot%\Temp */
+  envptr = getenv("TEMP");
+  if( envptr ) {
+    return envptr;
   }
-  if( !tmpdir ) {
-    /* Warn if we're using a hard coded path */
-    msg (M_WARN, "Could not find %TEMP% or %TMP% environment variables.  "
-         "Falling back to %s.  Consider to use --tmp-dir", DEFAULT_TMPDIR);
-    tmpdir = DEFAULT_TMPDIR;
+
+  envptr = getenv("TMP");
+  if( envptr ) {
+    return envptr;
   }
+
+  envptr = getenv(SYS_PATH_ENV_VAR_NAME);
+  if( !envptr ) {
+    /* This indicates something is really wrong with the Windows
+     * environment, and we shouldn't try to start OpenVPN in this case
+     */
+    msg (M_FATAL, "Could not find %%%s%% environment variable",
+         SYS_PATH_ENV_VAR_NAME);
+    return NULL; /* Just in case M_FATAL doesn't exit() */
+  }
+
+  openvpn_snprintf(tmpdir, 256, "%.249s\\Temp", envptr);
+  msg (M_WARN, "Could not find %%TEMP%% or %%TMP%% environment variables.  "
+       "Falling back to %s.  Consider to use --tmp-dir", tmpdir);
   return tmpdir;
 }
 #endif
-- 
1.7.4.2


