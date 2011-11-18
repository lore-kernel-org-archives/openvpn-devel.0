Date: Fri, 18 Nov 2011 13:39:50 +0100
From: David Sommerseth <davids@...1347...>
Message-id: <1321619990-12173-1-git-send-email-davids@...1347...>
MIME-version: 1.0
Subject: [Openvpn-devel] [PATCH] Make '--win-sys env' default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Without this patch, the default path used by OpenVPN is hard coded
to C:\WINDOWS.  As users might install Windows in a different directory,
this approach will cause OpenVPN to malfunction in some configurations.

OpenVPN have supported using the system path, by adding --win-sys env.
This patch removes the hard coded approach and uses the --win-sys env
approach by default instead.

Trac-ticket: 66
URL: http://thread.gmane.org/gmane.network.openvpn.user/32508
Signed-off-by: David Sommerseth <davids@...1347...>
Tested-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 openvpn.8 |   19 +++++++++++--------
 openvpn.c |    2 +-
 options.c |    8 +++++---
 win32.c   |    6 ------
 win32.h   |    2 --
 5 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/openvpn.8 b/openvpn.8
index b8594e1..4a86ce7 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -4769,20 +4769,23 @@ Optional group to be owner of this tunnel.
 .SS Windows-Specific Options:
 .\"*********************************************************
 .TP
-.B \-\-win-sys path|'env'
+.B \-\-win-sys path
 Set the Windows system directory pathname to use when looking for system
 executables such as
 .B route.exe
 and
 .B netsh.exe.
 By default, if this directive is
-not specified, the pathname will be set to "C:\\WINDOWS"
-
-The special string
-.B 'env'
-indicates that the pathname should be read from the
-.B SystemRoot
-environmental variable.
+not specified, OpenVPN will use the SystemRoot environment variable.
+
+This option have changed behaviour in OpenVPN 2.3.  Earlier you had to
+define
+.B --win-sys env
+to use the SystemRoot environment variable, otherwise it defaulted to C:\\=
WINDOWS.
+It is not needed to use the
+.B env
+keyword any more, and it will just be ignored. A warning is logged when th=
is
+is found in the configuration file.
 .\"*********************************************************
 .TP
 .B \-\-ip-win32 method
diff --git a/openvpn.c b/openvpn.c
index 520fda1..b4d6fd2 100644
--- a/openvpn.c
+++ b/openvpn.c
@@ -162,7 +162,7 @@ main (int argc, char *argv[])
 	  /* initialize environmental variable store */
 	  c.es =3D env_set_create (NULL);
 #ifdef WIN32
-	  env_set_add_win32 (c.es);
+	  set_win_sys_path_via_env (c.es);
 #endif
=20
 #ifdef ENABLE_MANAGEMENT
diff --git a/options.c b/options.c
index 0d86cd0..e422c0d 100644
--- a/options.c
+++ b/options.c
@@ -652,8 +652,8 @@ static const char usage_message[] =3D
 #ifdef WIN32
   "\n"
   "Windows Specific:\n"
-  "--win-sys path|'env' : Pathname of Windows system directory, C:\\WINDOW=
S by default.\n"
-  "                       If specified as 'env', read the pathname from Sy=
stemRoot env var.\n"
+  "--win-sys path    : Pathname of Windows system directory. Default is th=
e pathname\n"
+  "                    from SystemRoot environment variable.\n"
   "--ip-win32 method : When using --ifconfig on Windows, set TAP-Win32 ada=
pter\n"
   "                    IP address using method =3D manual, netsh, ipapi,\n"
   "                    dynamic, or adaptive (default =3D adaptive).\n"
@@ -5687,7 +5687,9 @@ add_option (struct options *options,
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       if (streq (p[1], "env"))
-	set_win_sys_path_via_env (es);
+	msg (M_INFO, "NOTE: --win-sys env is default from OpenVPN v2.3.	 "
+	     "This entry will now be ignored.  "
+	     "Please remove this entry from your configuration file.");
       else
 	set_win_sys_path (p[1], es);
     }
diff --git a/win32.c b/win32.c
index cf6cc2d..416af86 100644
--- a/win32.c
+++ b/win32.c
@@ -1103,12 +1103,6 @@ set_win_sys_path_via_env (struct env_set *es)
   set_win_sys_path (buf, es);
 }
=20
-void
-env_set_add_win32 (struct env_set *es)
-{
-  set_win_sys_path (DEFAULT_WIN_SYS_PATH, es);
-}
-
=20
 const char *
 win_get_tempdir()
diff --git a/win32.h b/win32.h
index 5b18e3c..9ee95ef 100644
--- a/win32.h
+++ b/win32.h
@@ -30,7 +30,6 @@
=20
 /* location of executables */
 #define SYS_PATH_ENV_VAR_NAME "SystemRoot"  /* environmental variable name=
 that normally contains the system path */
-#define DEFAULT_WIN_SYS_PATH  "C:\\WINDOWS" /* --win-sys default value */
 #define NETSH_PATH_SUFFIX     "\\system32\\netsh.exe"
 #define WIN_ROUTE_PATH_SUFFIX "\\system32\\route.exe"
 #define WIN_IPCONFIG_PATH_SUFFIX "\\system32\\ipconfig.exe"
@@ -269,7 +268,6 @@ bool win_safe_filename (const char *fn);
=20
 /* add constant environmental variables needed by Windows */
 struct env_set;
-void env_set_add_win32 (struct env_set *es);
=20
 /* get and set the current windows system path */
 void set_win_sys_path (const char *newpath, struct env_set *es);
--=20
1.7.4.4



