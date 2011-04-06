From: David Sommerseth <davids@...1347...>
Date: Wed,  6 Apr 2011 18:10:22 +0200
Message-Id: <1302106222-10256-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Change the default --tmp-dir path to a more
	suitable path
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

In commit 4e1cc5f6dda22e9 the create_temp_filename() function was
reviewed and hardened, which in the end renamed this function to
create_temp_file() in commit 495e3cec5d156.

With these changes it became more evident that OpenVPN needs a directory
where it can create temporary files.  The create_temp_file() will create
such files f.ex. if --client-connect or --plugin which makes use of
the OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY hook, such as openvpn-auth-pam.so.

When this happens, OpenVPN will normally create these files in the directory
OpenVPN was started.  In many cases, this will fail due to restricted access.
By using --tmp-dir and pointing it to a directory writeable to the user
running OpenVPN, it works again.

This patch makes OpenVPN use a more suitable temproary directory by default,
instead of the current working directory.  On non-Windows platforms this
default value is set to '/tmp', but can be modified at compile-time by
running ./configure --with-tmp-dir-path=<TEMP DIR PATH>.  On Windows, it
will look up %TEMP% and %TMP% first, and if that doesn't give any clues, it
will fallback to C:\WINDOWS\Temp in the end.

In any cases, this default value can be overridden in the configuration
file by using the --tmp-dir option, as before.

To check what the default is at runime, you can see this easily by doing
this:

      $ ./openvpn --verb 4 --dev tun | grep tmp_dir

Signed-off-by: David Sommerseth <davids@...1347...>
Tested-by: Jan Just Keijser <janjust@...1147...>
---
 configure.ac    |   11 +++++++++++
 options.c       |   15 +++++++++++----
 win/config.h.in |    3 +++
 win32.c         |   19 +++++++++++++++++++
 win32.h         |    3 +++
 5 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index e0847bc..a9f022e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -279,6 +279,11 @@ AC_ARG_WITH(netstat-path,
 )
 AC_DEFINE_UNQUOTED(NETSTAT_PATH, "$NETSTAT", [Path to netstat tool])
 
+AC_ARG_WITH(tmp-dir-path,
+   [  --with-tmp-dir-path=PATH  Default tmp-dir to use when not configured (unset defaults to /tmp)],
+   [TMPDIRPATH="$withval"]
+)
+
 AC_ARG_WITH(mem-check,
    [  --with-mem-check=TYPE  Build with debug memory checking, TYPE = dmalloc or valgrind],
    [MEMCHECK="$withval"]
@@ -566,6 +571,12 @@ LDFLAGS="$LDFLAGS -Wl,--fatal-warnings"
 AC_CHECK_FUNC(epoll_create, AC_DEFINE(HAVE_EPOLL_CREATE, 1, [epoll_create function is defined]))
 LDFLAGS="$OLDLDFLAGS"
 
+dnl set the default temporary directory
+if test -z "$TMPDIRPATH"; then
+   TMPDIRPATH="/tmp"
+fi
+AC_DEFINE_UNQUOTED(DEFAULT_TMPDIR, "$TMPDIRPATH", [Default --tmp-dir])
+
 dnl
 dnl check for valgrind tool
 dnl
diff --git a/options.c b/options.c
index 36e8393..0b91657 100644
--- a/options.c
+++ b/options.c
@@ -766,11 +766,20 @@ init_options (struct options *o, const bool init_gc)
 #ifdef ENABLE_X509ALTUSERNAME
   o->x509_username_field = X509_USERNAME_FIELD_DEFAULT;
 #endif
-#endif
-#endif
+#endif /* USE_SSL */
+#endif /* USE_CRYPTO */
 #ifdef ENABLE_PKCS11
   o->pkcs11_pin_cache_period = -1;
 #endif			/* ENABLE_PKCS11 */
+
+  /* Set default --tmp-dir */
+#ifdef WIN32
+  /* On Windows, find temp dir via enviroment variables */
+  o->tmp_dir = win_get_tempdir();
+#else
+  /* Non-windows platforms have this value defined via ./configure */
+  o->tmp_dir = DEFAULT_TMPDIR;
+#endif /* WIN32 */
 }
 
 void
@@ -1916,8 +1925,6 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	msg (M_USAGE, "--client-connect requires --mode server");
       if (options->client_disconnect_script)
 	msg (M_USAGE, "--client-disconnect requires --mode server");
-      if (options->tmp_dir)
-	msg (M_USAGE, "--tmp-dir requires --mode server");
       if (options->client_config_dir || options->ccd_exclusive)
 	msg (M_USAGE, "--client-config-dir/--ccd-exclusive requires --mode server");
       if (options->enable_c2c)
diff --git a/win/config.h.in b/win/config.h.in
index fb349d0..abf71d2 100644
--- a/win/config.h.in
+++ b/win/config.h.in
@@ -286,6 +286,9 @@ typedef unsigned long in_addr_t;
 /* Route command */
 #define ROUTE_PATH "route"
 
+/* Default temporary directory, if not found via getenv() */
+#define DEFAULT_TMPDIR "C:\\WINDOWS\\Temp"   /* FIXME: Should be configurable */
+
 #ifdef _MSC_VER
 /* MSVC++ hacks */
 #pragma warning(disable:4244) // conversion from 'foo' to 'bar', possible loss of data
diff --git a/win32.c b/win32.c
index 7c9901e..c9eb184 100644
--- a/win32.c
+++ b/win32.c
@@ -1093,4 +1093,23 @@ env_set_add_win32 (struct env_set *es)
   set_win_sys_path (DEFAULT_WIN_SYS_PATH, es);
 }
 
+
+const char *
+win_get_tempdir()
+{
+  static char *tmpdir = NULL;
+
+  /* Try to use %TEMP% or %TMP% */
+  tmpdir = getenv("TEMP");
+  if( !tmpdir ) {
+    tmpdir = getenv("TMP");
+  }
+  if( !tmpdir ) {
+    /* Warn if we're using a hard coded path */
+    msg (M_WARN, "Could not find %TEMP% or %TMP% environment variables.  "
+         "Falling back to %s.  Consider to use --tmp-dir", DEFAULT_TMPDIR);
+    tmpdir = DEFAULT_TMPDIR;
+  }
+  return tmpdir;
+}
 #endif
diff --git a/win32.h b/win32.h
index fcc3062..b6a162e 100644
--- a/win32.h
+++ b/win32.h
@@ -270,5 +270,8 @@ char *get_win_sys_path (void);
 /* call self in a subprocess */
 void fork_to_self (const char *cmdline);
 
+/* Find temporary directory */
+const char *win_get_tempdir();
+
 #endif
 #endif
-- 
1.7.4


