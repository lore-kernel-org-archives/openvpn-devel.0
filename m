From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 23 Nov 2011 19:08:34 +0100
Message-ID: <1322071714-17389-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1322057700-15531-1-git-send-email-heiko.hund@...1489...>
References: <1322057700-15531-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCHv2] Windows UTF-8 input/output
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

This patch makes openvpn read unicode from the console and convert the input
to UTF-8. And then display UTF-8 output to the console correctly.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 configure.ac |    1 +
 openvpn.c    |    4 ++++
 win32.c      |   14 +++++++++++++-
 3 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index a4d68e6..169d616 100644
--- a/configure.ac
+++ b/configure.ac
@@ -343,6 +343,7 @@ case "$host" in
 	OPENVPN_ADD_LIBS(-lcrypt32)
 	OPENVPN_ADD_LIBS(-liphlpapi)
 	OPENVPN_ADD_LIBS(-lwinmm)
+	OPENVPN_ADD_LIBS(-lshell32)
 	;;
 *-*-dragonfly*)
 	AC_DEFINE(TARGET_DRAGONFLY, 1, [Are we running on DragonFlyBSD?])
diff --git a/openvpn.c b/openvpn.c
index 520fda1..611dffa 100644
--- a/openvpn.c
+++ b/openvpn.c
@@ -131,6 +131,10 @@ main (int argc, char *argv[])
   return 1;
 #endif
 
+#ifdef TARGET_WIN32
+  SetConsoleOutputCP (CP_UTF8);
+#endif
+
   CLEAR (c);
 
   /* signify first time for components which can
diff --git a/win32.c b/win32.c
index cf6cc2d..865d1e3 100644
--- a/win32.c
+++ b/win32.c
@@ -763,6 +763,7 @@ get_console_input_win32 (const char *prompt, const bool echo, char *input, const
       bool is_console = (GetFileType (in) == FILE_TYPE_CHAR);
       DWORD flags_save = 0;
       int status = 0;
+      WCHAR *winput;
 
       if (is_console)
 	{
@@ -777,7 +778,18 @@ get_console_input_win32 (const char *prompt, const bool echo, char *input, const
 	    is_console = 0;
 	}
 
-      status = ReadFile (in, input, capacity, &len, NULL);
+      if (is_console)
+        {
+          winput = malloc (capacity * sizeof (WCHAR));
+          if (winput == NULL)
+            return false;
+
+          status = ReadConsoleW (in, winput, capacity, &len, NULL);
+          WideCharToMultiByte (CP_UTF8, 0, winput, len, input, capacity, NULL, NULL);
+          free (winput);
+        }
+      else
+        status = ReadFile (in, input, capacity, &len, NULL);
 
       string_null_terminate (input, (int)len, capacity);
       chomp (input);
-- 
1.7.5.4


