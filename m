From: Alon Bar-Lev <alon.barlev@...277...>
Date: Tue, 15 May 2012 01:42:03 +0300
Message-Id: <1337035323-27465-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH] build: integrate plugins build into core
	build
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

As disucssed[1], keep plugins in repository.

1, Proper automake/libtool build.

2. Move example plugins to samples/sample-plugins.

3. Plugins are installed at LIBDIR/openvpn/plugins.

[1] http://comments.gmane.org/gmane.network.openvpn.devel/6436

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac                            |   63 +++++++
 distro/rpm/openvpn.spec.in              |   47 +-----
 doc/Makefile.am                         |    5 +-
 doc/README.plugins                      |   47 +++++
 sample/Makefile.am                      |    1 +
 sample/sample-plugins/defer/README      |   16 ++
 sample/sample-plugins/defer/build       |   15 ++
 sample/sample-plugins/defer/simple.c    |  305 +++++++++++++++++++++++++++++++
 sample/sample-plugins/defer/simple.def  |    6 +
 sample/sample-plugins/defer/winbuild    |   18 ++
 sample/sample-plugins/log/build         |   15 ++
 sample/sample-plugins/log/log.c         |  184 +++++++++++++++++++
 sample/sample-plugins/log/log_v3.c      |  247 +++++++++++++++++++++++++
 sample/sample-plugins/log/winbuild      |   18 ++
 sample/sample-plugins/simple/README     |   16 ++
 sample/sample-plugins/simple/build      |   15 ++
 sample/sample-plugins/simple/simple.c   |  120 ++++++++++++
 sample/sample-plugins/simple/simple.def |    6 +
 sample/sample-plugins/simple/winbuild   |   18 ++
 src/Makefile.am                         |    5 +-
 src/plugins/Makefile.am                 |   15 ++
 src/plugins/README                      |   47 -----
 src/plugins/auth-pam/Makefile           |   32 ----
 src/plugins/auth-pam/Makefile.am        |   27 +++
 src/plugins/auth-pam/README             |   74 --------
 src/plugins/auth-pam/README.auth-pam    |   74 ++++++++
 src/plugins/auth-pam/auth-pam.c         |   18 +-
 src/plugins/auth-pam/auth-pam.exports   |    4 +
 src/plugins/auth-pam/pamdl.c            |    8 +-
 src/plugins/auth-pam/pamdl.h            |    4 +-
 src/plugins/defer/README                |   16 --
 src/plugins/defer/build                 |   15 --
 src/plugins/defer/simple.c              |  305 -------------------------------
 src/plugins/defer/simple.def            |    6 -
 src/plugins/defer/winbuild              |   18 --
 src/plugins/down-root/Makefile          |   18 --
 src/plugins/down-root/Makefile.am       |   23 +++
 src/plugins/down-root/README            |   29 ---
 src/plugins/down-root/README.down-root  |   29 +++
 src/plugins/down-root/down-root.c       |    6 +-
 src/plugins/down-root/down-root.exports |    4 +
 src/plugins/examples/README             |   16 --
 src/plugins/examples/build              |   15 --
 src/plugins/examples/log.c              |  184 -------------------
 src/plugins/examples/log_v3.c           |  247 -------------------------
 src/plugins/examples/simple.c           |  120 ------------
 src/plugins/examples/simple.def         |    6 -
 src/plugins/examples/winbuild           |   18 --
 48 files changed, 1317 insertions(+), 1228 deletions(-)
 create mode 100644 doc/README.plugins
 create mode 100644 sample/sample-plugins/defer/README
 create mode 100755 sample/sample-plugins/defer/build
 create mode 100644 sample/sample-plugins/defer/simple.c
 create mode 100755 sample/sample-plugins/defer/simple.def
 create mode 100755 sample/sample-plugins/defer/winbuild
 create mode 100755 sample/sample-plugins/log/build
 create mode 100644 sample/sample-plugins/log/log.c
 create mode 100644 sample/sample-plugins/log/log_v3.c
 create mode 100755 sample/sample-plugins/log/winbuild
 create mode 100644 sample/sample-plugins/simple/README
 create mode 100755 sample/sample-plugins/simple/build
 create mode 100644 sample/sample-plugins/simple/simple.c
 create mode 100755 sample/sample-plugins/simple/simple.def
 create mode 100755 sample/sample-plugins/simple/winbuild
 create mode 100644 src/plugins/Makefile.am
 delete mode 100644 src/plugins/README
 delete mode 100755 src/plugins/auth-pam/Makefile
 create mode 100644 src/plugins/auth-pam/Makefile.am
 delete mode 100644 src/plugins/auth-pam/README
 create mode 100644 src/plugins/auth-pam/README.auth-pam
 create mode 100644 src/plugins/auth-pam/auth-pam.exports
 delete mode 100644 src/plugins/defer/README
 delete mode 100755 src/plugins/defer/build
 delete mode 100644 src/plugins/defer/simple.c
 delete mode 100755 src/plugins/defer/simple.def
 delete mode 100755 src/plugins/defer/winbuild
 delete mode 100755 src/plugins/down-root/Makefile
 create mode 100644 src/plugins/down-root/Makefile.am
 delete mode 100644 src/plugins/down-root/README
 create mode 100644 src/plugins/down-root/README.down-root
 create mode 100644 src/plugins/down-root/down-root.exports
 delete mode 100644 src/plugins/examples/README
 delete mode 100755 src/plugins/examples/build
 delete mode 100644 src/plugins/examples/log.c
 delete mode 100644 src/plugins/examples/log_v3.c
 delete mode 100644 src/plugins/examples/simple.c
 delete mode 100755 src/plugins/examples/simple.def
 delete mode 100755 src/plugins/examples/winbuild

diff --git a/configure.ac b/configure.ac
index 4592727..c1fa12e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -194,6 +194,27 @@ AC_ARG_ENABLE(
 )
 
 AC_ARG_ENABLE(
+	[plugin-auth-pam],
+	[AS_HELP_STRING([--disable-plugin-auth-pam], [disable auth-pam plugin @<:@default=yes@:>@])],
+	,
+	[enable_plugin_auth_pam="yes"]
+)
+
+AC_ARG_ENABLE(
+	[plugin-down-root],
+	[AS_HELP_STRING([--disable-plugin-down-root], [disable down-root plugin @<:@default=yes@:>@])],
+	,
+	[enable_plugin_down_root="yes"]
+)
+
+AC_ARG_ENABLE(
+	[pam-dlopen],
+	[AS_HELP_STRING([--enable-pam-dlopen], [dlopen libpam @<:@default=no@:>@])],
+	,
+	[enable_pam_dlopen="no"]
+)
+
+AC_ARG_ENABLE(
 	[strict],
 	[AS_HELP_STRING([--enable-strict], [enable strict compiler warnings (debugging option) @<:@default=no@:>@])],
 	,
@@ -258,6 +279,14 @@ AC_ARG_WITH(
 	[with_crypto_library="openssl"]
 )
 
+AC_ARG_WITH(
+	[plugindir],
+	[AS_HELP_STRING([--with-plugindir], [plugin directory @<:@default=LIBDIR/openvpn@:>@])],
+	,
+	[with_plugindir="\$(libdir)/openvpn/plugins"]
+)
+
+
 AC_DEFINE_UNQUOTED([TARGET_ALIAS], ["${host}"], [A string representing our host])
 case "$host" in
 	*-*-linux*)
@@ -622,6 +651,16 @@ AC_CHECK_LIB(
 )
 AC_SUBST([SELINUX_LIBS])
 
+AC_ARG_VAR([LIBPAM_CFLAGS], [C compiler flags for libpam])
+AC_ARG_VAR([LIBPAM_LIBS], [linker flags for libpam])
+if test -z "${LIBPAM_LIBS}"; then
+	AC_CHECK_LIB(
+		[pam],
+		[pam_start],
+		[LIBPAM_LIBS="-lpam"]
+	)
+fi
+
 case "${with_mem_check}" in
 	valgrind)
 		AC_CHECK_HEADER(
@@ -871,6 +910,9 @@ if test "${enable_plugins}" = "yes"; then
 	OPTIONAL_DL_LIBS="${DL_LIBS}"
 	AC_DEFINE([ENABLE_PLUGIN], [1], [Enable systemd support])
 	test "${enable_eurephia}" = "yes" && AC_DEFINE([ENABLE_EUREPHIA], [1], [Enable support for the eurephia plug-in])
+else
+	enable_plugin_auth_pam="no"
+	enable_plugin_down_root="no"
 fi
 
 if test "${enable_iproute2}" = "yes"; then
@@ -922,6 +964,17 @@ if test "${WIN32}" = "yes"; then
 	test -z "${MAN2HTML}" && AC_MSG_ERROR([man2html is required for win32])
 fi
 
+if test "${enable_plugin_auth_pam}" = "yes"; then
+	PLUGIN_AUTH_PAM_CFLAGS="${LIBPAM_CFLAGS}"
+	if test "${enable_pam_dlopen}" = "yes"; then
+		AC_DEFINE([USE_PAM_DLOPEN], [1], [dlopen libpam])
+		PLUGIN_AUTH_PAM_LIBS="${DL_LIBS}"
+	else
+		test -z "${LIBPAM_LIBS}" && AC_MSG_ERROR([libpam required but missing])
+		PLUGIN_AUTH_PAM_LIBS="${LIBPAM_LIBS}"
+	fi
+fi
+
 CONFIGURE_DEFINES="`set | grep '^enable_.*=' ; set | grep '^with_.*='`"
 AC_DEFINE_UNQUOTED([CONFIGURE_DEFINES], ["`echo ${CONFIGURE_DEFINES}`"], [Configuration settings])
 
@@ -944,10 +997,17 @@ AC_SUBST([OPTIONAL_LZO_LIBS])
 AC_SUBST([OPTIONAL_PKCS11_HELPER_CFLAGS])
 AC_SUBST([OPTIONAL_PKCS11_HELPER_LIBS])
 
+AC_SUBST([PLUGIN_AUTH_PAM_CFLAGS])
+AC_SUBST([PLUGIN_AUTH_PAM_LIBS])
+
 AM_CONDITIONAL([WIN32], [test "${WIN32}" = "yes"])
 AM_CONDITIONAL([GIT_CHECKOUT], [test "${GIT_CHECKOUT}" = "yes"])
+AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test "${enable_plugin_auth_pam}" = "yes"])
+AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test "${enable_plugin_down_root}" = "yes"])
 
+plugindir="${with_plugindir}"
 sampledir="\$(docdir)/sample"
+AC_SUBST([plugindir])
 AC_SUBST([sampledir])
 
 AC_CONFIG_FILES([
@@ -964,6 +1024,9 @@ AC_CONFIG_FILES([
 	src/compat/Makefile
 	src/openvpn/Makefile
 	src/openvpnserv/Makefile
+	src/plugins/Makefile
+	src/plugins/auth-pam/Makefile
+	src/plugins/down-root/Makefile
 	tests/Makefile
 	sample/Makefile
 	doc/Makefile
diff --git a/distro/rpm/openvpn.spec.in b/distro/rpm/openvpn.spec.in
index 3c316bf..20a8c89 100644
--- a/distro/rpm/openvpn.spec.in
+++ b/distro/rpm/openvpn.spec.in
@@ -83,13 +83,6 @@ Development support for OpenVPN.
 %endif
 
 #
-# Should we build the auth-pam module?
-#
-
-%define build_auth_pam 1
-%{?without_pam:%define build_auth_pam 0}
-
-#
 # Other definitions
 #
 
@@ -108,20 +101,9 @@ Development support for OpenVPN.
 	--docdir="%{_docdir}/%{name}-%{version}" \
 	%{?with_password_save:--enable-password-save} \
 	%{!?without_lzo:--enable-lzo} \
-	%{?with_pkcs11:--enable-pkcs11}
-%__make
-
-# Build down-root plugin
-pushd src/plugins/down-root
+	%{?with_pkcs11:--enable-pkcs11} \
+	%{?without_pam:--disable-plugin-auth-pam}
 %__make
-popd
-
-# Build auth-pam plugin
-%if %{build_auth_pam}
-pushd src/plugins/auth-pam
-%__make
-popd
-%endif
 
 #
 # Installation section
@@ -143,29 +125,8 @@ popd
 # Install /etc/openvpn
 %__install -c -d -m 755 "%{buildroot}/etc/%{name}"
 
-#
-# Build /usr/share/openvpn
-#
-
-%__mkdir_p %{buildroot}%{_datadir}/%{name}
-
-#
-# Install the plugins
-#
-
-%__mkdir_p "%{buildroot}%{_datadir}/%{name}/plugins/lib"
-
-for pi in auth-pam down-root; do
-  %__mv -f src/plugins/$pi/README src/plugins/README.$pi
-  if [ -e src/plugins/$pi/openvpn-$pi.so ]; then
-    %__install -c -m 755 src/plugins/$pi/openvpn-$pi.so "%{buildroot}%{_datadir}/openvpn/plugins/lib/openvpn-$pi.so"
-  fi
-done
-
-%__mv -f src/plugins/README src/plugins/README.plugins
-
 # Install extra %doc stuff
-cp -r AUTHORS ChangeLog NEWS contrib/ sample/ src/plugins/README.* \
+cp -r AUTHORS ChangeLog NEWS contrib/ sample/ \
 	"%{buildroot}/%{_docdir}/%{name}-%{version}"
 
 #
@@ -218,7 +179,7 @@ fi
 %defattr(-,root,root)
 %{_mandir}
 %{_sbindir}/%{name}
-%{_datadir}/%{name}
+%{_libdir}/%{name}
 %{_docdir}/%{name}-%{version}
 %dir /etc/%{name}
 %if "%{VENDOR}" == "SuSE"
diff --git a/doc/Makefile.am b/doc/Makefile.am
index 46687b2..d33e1ed 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -17,8 +17,11 @@ CLEANFILES = openvpn.8.html
 dist_doc_DATA = \
 	management-notes.txt
 
+dist_noinst_DATA = \
+	README.plugins
+
 if WIN32
-dist_noinst_DATA = openvpn.8
+dist_noinst_DATA += openvpn.8
 nodist_html_DATA = openvpn.8.html
 openvpn.8.html: $(srcdir)/openvpn.8
 	$(MAN2HTML) < $(srcdir)/openvpn.8 > openvpn.8.html
diff --git a/doc/README.plugins b/doc/README.plugins
new file mode 100644
index 0000000..6e490c5
--- /dev/null
+++ b/doc/README.plugins
@@ -0,0 +1,47 @@
+OpenVPN Plugins
+---------------
+
+Starting with OpenVPN 2.0-beta17, compiled plugin modules are
+supported on any *nix OS which includes libdl or on Windows.
+One or more modules may be loaded into OpenVPN using
+the --plugin directive, and each plugin module is capable of
+intercepting any of the script callbacks which OpenVPN supports:
+
+(1) up
+(2) down
+(3) route-up
+(4) ipchange
+(5) tls-verify
+(6) auth-user-pass-verify
+(7) client-connect
+(8) client-disconnect
+(9) learn-address
+
+See the openvpn-plugin.h file in the top-level directory of the
+OpenVPN source distribution for more detailed information
+on the plugin interface.
+
+Included Plugins
+----------------
+
+auth-pam -- Authenticate using PAM and a split privilege
+            execution model which functions even if
+            root privileges or the execution environment
+            have been altered with --user/--group/--chroot.
+            Tested on Linux only.
+
+down-root -- Enable the running of down scripts with root privileges
+             even if --user/--group/--chroot have been used
+             to drop root privileges or change the execution
+             environment.  Not applicable on Windows.
+
+examples -- A simple example that demonstrates a portable
+            plugin, i.e. one which can be built for *nix
+            or Windows from the same source.
+
+Building Plugins
+----------------
+
+cd to the top-level directory of a plugin, and use the
+"make" command to build it.  The examples plugin is
+built using a build script, not a makefile.
diff --git a/sample/Makefile.am b/sample/Makefile.am
index 8e35bfc..be30c88 100644
--- a/sample/Makefile.am
+++ b/sample/Makefile.am
@@ -13,6 +13,7 @@ MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
 EXTRA_DIST = \
+	sample-plugins \
 	sample-config-files \
 	sample-windows \
 	sample-keys \
diff --git a/sample/sample-plugins/defer/README b/sample/sample-plugins/defer/README
new file mode 100644
index 0000000..d8990f8
--- /dev/null
+++ b/sample/sample-plugins/defer/README
@@ -0,0 +1,16 @@
+OpenVPN plugin examples.
+
+Examples provided:
+
+simple.c -- using the --auth-user-pass-verify callback,
+            test deferred authentication.
+
+To build:
+
+  ./build simple (Linux/BSD/etc.)
+  ./winbuild simple (MinGW on Windows)
+
+To use in OpenVPN, add to config file:
+
+  plugin simple.so (Linux/BSD/etc.)
+  plugin simple.dll (MinGW on Windows)
diff --git a/sample/sample-plugins/defer/build b/sample/sample-plugins/defer/build
new file mode 100755
index 0000000..0612c08
--- /dev/null
+++ b/sample/sample-plugins/defer/build
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+#
+# Build an OpenVPN plugin module on *nix.  The argument should
+# be the base name of the C source file (without the .c).
+#
+
+# This directory is where we will look for openvpn-plugin.h
+CPPFLAGS="${CPPFLAGS:--I../../../include}"
+
+CC="${CC:-gcc}"
+CFLAGS="${CFLAGS:--O2 -Wall -g}"
+
+$CC $CPPFLAGS $CFLAGS -fPIC -c $1.c && \
+$CC $CFLAGS -fPIC -shared ${LDFLAS} -Wl,-soname,$1.so -o $1.so $1.o -lc
diff --git a/sample/sample-plugins/defer/simple.c b/sample/sample-plugins/defer/simple.c
new file mode 100644
index 0000000..6539865
--- /dev/null
+++ b/sample/sample-plugins/defer/simple.c
@@ -0,0 +1,305 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
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
+/*
+ * This file implements a simple OpenVPN plugin module which
+ * will test deferred authentication and packet filtering.
+ * 
+ * Will run on Windows or *nix.
+ *
+ * Sample usage:
+ *
+ * setenv test_deferred_auth 20
+ * setenv test_packet_filter 10
+ * plugin plugin/defer/simple.so
+ *
+ * This will enable deferred authentication to occur 20
+ * seconds after the normal TLS authentication process,
+ * and will cause a packet filter file to be generated 10
+ * seconds after the initial TLS negotiation, using
+ * {common-name}.pf as the source.
+ *
+ * Sample packet filter configuration:
+ *
+ * [CLIENTS DROP]
+ * +otherclient
+ * [SUBNETS DROP]
+ * +10.0.0.0/8
+ * -10.10.0.8
+ * [END]
+ *
+ * See the README file for build instructions.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+
+#include "openvpn-plugin.h"
+
+/* bool definitions */
+#define bool int
+#define true 1
+#define false 0
+
+/*
+ * Our context, where we keep our state.
+ */
+
+struct plugin_context {
+  int test_deferred_auth;
+  int test_packet_filter;
+};
+
+struct plugin_per_client_context {
+  int n_calls;
+  bool generated_pf_file;
+};
+
+/*
+ * Given an environmental variable name, search
+ * the envp array for its value, returning it
+ * if found or NULL otherwise.
+ */
+static const char *
+get_env (const char *name, const char *envp[])
+{
+  if (envp)
+    {
+      int i;
+      const int namelen = strlen (name);
+      for (i = 0; envp[i]; ++i)
+	{
+	  if (!strncmp (envp[i], name, namelen))
+	    {
+	      const char *cp = envp[i] + namelen;
+	      if (*cp == '=')
+		return cp + 1;
+	    }
+	}
+    }
+  return NULL;
+}
+
+/* used for safe printf of possible NULL strings */
+static const char *
+np (const char *str)
+{
+  if (str)
+    return str;
+  else
+    return "[NULL]";
+}
+
+static int
+atoi_null0 (const char *str)
+{
+  if (str)
+    return atoi (str);
+  else
+    return 0;
+}
+
+OPENVPN_EXPORT openvpn_plugin_handle_t
+openvpn_plugin_open_v1 (unsigned int *type_mask, const char *argv[], const char *envp[])
+{
+  struct plugin_context *context;
+
+  printf ("FUNC: openvpn_plugin_open_v1\n");
+
+  /*
+   * Allocate our context
+   */
+  context = (struct plugin_context *) calloc (1, sizeof (struct plugin_context));
+
+  context->test_deferred_auth = atoi_null0 (get_env ("test_deferred_auth", envp));
+  printf ("TEST_DEFERRED_AUTH %d\n", context->test_deferred_auth);
+
+  context->test_packet_filter = atoi_null0 (get_env ("test_packet_filter", envp));
+  printf ("TEST_PACKET_FILTER %d\n", context->test_packet_filter);
+
+  /*
+   * Which callbacks to intercept.
+   */
+  *type_mask =
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_UP) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_DOWN) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_ROUTE_UP) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_IPCHANGE) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_TLS_VERIFY) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_CLIENT_CONNECT_V2) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_CLIENT_DISCONNECT) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_LEARN_ADDRESS) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_TLS_FINAL) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_ENABLE_PF);
+
+  return (openvpn_plugin_handle_t) context;
+}
+
+static int
+auth_user_pass_verify (struct plugin_context *context, struct plugin_per_client_context *pcc, const char *argv[], const char *envp[])
+{
+  if (context->test_deferred_auth)
+    {
+      /* get username/password from envp string array */
+      const char *username = get_env ("username", envp);
+      const char *password = get_env ("password", envp);
+
+      /* get auth_control_file filename from envp string array*/
+      const char *auth_control_file = get_env ("auth_control_file", envp);
+
+      printf ("DEFER u='%s' p='%s' acf='%s'\n",
+	      np(username),
+	      np(password),
+	      np(auth_control_file));
+
+      /* Authenticate asynchronously in n seconds */
+      if (auth_control_file)
+	{
+	  char buf[256];
+	  int auth = 2;
+	  sscanf (username, "%d", &auth);
+	  snprintf (buf, sizeof(buf), "( sleep %d ; echo AUTH %s %d ; echo %d >%s ) &",
+		    context->test_deferred_auth,
+		    auth_control_file,
+		    auth,
+		    pcc->n_calls < auth,
+		    auth_control_file);
+	  printf ("%s\n", buf);
+	  system (buf);
+	  pcc->n_calls++;
+	  return OPENVPN_PLUGIN_FUNC_DEFERRED;
+	}
+      else
+	return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+  else
+    return OPENVPN_PLUGIN_FUNC_SUCCESS;
+}
+
+static int
+tls_final (struct plugin_context *context, struct plugin_per_client_context *pcc, const char *argv[], const char *envp[])
+{
+  if (context->test_packet_filter)
+    {
+      if (!pcc->generated_pf_file)
+	{
+	  const char *pff = get_env ("pf_file", envp);
+	  const char *cn = get_env ("username", envp);
+	  if (pff && cn)
+	    {
+	      char buf[256];
+	      snprintf (buf, sizeof(buf), "( sleep %d ; echo PF %s/%s ; cp \"%s.pf\" \"%s\" ) &",
+			context->test_packet_filter, cn, pff, cn, pff);
+	      printf ("%s\n", buf);
+	      system (buf);
+	      pcc->generated_pf_file = true;
+	      return OPENVPN_PLUGIN_FUNC_SUCCESS;
+	    }
+	  else
+	    return OPENVPN_PLUGIN_FUNC_ERROR;
+	}
+      else
+	return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+  else
+    return OPENVPN_PLUGIN_FUNC_SUCCESS;
+}
+
+OPENVPN_EXPORT int
+openvpn_plugin_func_v2 (openvpn_plugin_handle_t handle,
+			const int type,
+			const char *argv[],
+			const char *envp[],
+			void *per_client_context,
+			struct openvpn_plugin_string_list **return_list)
+{
+  struct plugin_context *context = (struct plugin_context *) handle;
+  struct plugin_per_client_context *pcc = (struct plugin_per_client_context *) per_client_context;
+  switch (type)
+    {
+    case OPENVPN_PLUGIN_UP:
+      printf ("OPENVPN_PLUGIN_UP\n");
+      return OPENVPN_PLUGIN_FUNC_SUCCESS;
+    case OPENVPN_PLUGIN_DOWN:
+      printf ("OPENVPN_PLUGIN_DOWN\n");
+      return OPENVPN_PLUGIN_FUNC_SUCCESS;
+    case OPENVPN_PLUGIN_ROUTE_UP:
+      printf ("OPENVPN_PLUGIN_ROUTE_UP\n");
+      return OPENVPN_PLUGIN_FUNC_SUCCESS;
+    case OPENVPN_PLUGIN_IPCHANGE:
+      printf ("OPENVPN_PLUGIN_IPCHANGE\n");
+      return OPENVPN_PLUGIN_FUNC_SUCCESS;
+    case OPENVPN_PLUGIN_TLS_VERIFY:
+      printf ("OPENVPN_PLUGIN_TLS_VERIFY\n");
+      return OPENVPN_PLUGIN_FUNC_SUCCESS;
+    case OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY:
+      printf ("OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY\n");
+      return auth_user_pass_verify (context, pcc, argv, envp);
+    case OPENVPN_PLUGIN_CLIENT_CONNECT_V2:
+      printf ("OPENVPN_PLUGIN_CLIENT_CONNECT_V2\n");
+      return OPENVPN_PLUGIN_FUNC_SUCCESS;
+    case OPENVPN_PLUGIN_CLIENT_DISCONNECT:
+      printf ("OPENVPN_PLUGIN_CLIENT_DISCONNECT\n");
+      return OPENVPN_PLUGIN_FUNC_SUCCESS;
+    case OPENVPN_PLUGIN_LEARN_ADDRESS:
+      printf ("OPENVPN_PLUGIN_LEARN_ADDRESS\n");
+      return OPENVPN_PLUGIN_FUNC_SUCCESS;
+    case OPENVPN_PLUGIN_TLS_FINAL:
+      printf ("OPENVPN_PLUGIN_TLS_FINAL\n");
+      return tls_final (context, pcc, argv, envp);
+    case OPENVPN_PLUGIN_ENABLE_PF:
+      printf ("OPENVPN_PLUGIN_ENABLE_PF\n");
+      if (context->test_packet_filter)
+	return OPENVPN_PLUGIN_FUNC_SUCCESS;
+      else
+	return OPENVPN_PLUGIN_FUNC_ERROR;
+    default:
+      printf ("OPENVPN_PLUGIN_?\n");
+      return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+}
+
+OPENVPN_EXPORT void *
+openvpn_plugin_client_constructor_v1 (openvpn_plugin_handle_t handle)
+{
+  printf ("FUNC: openvpn_plugin_client_constructor_v1\n");
+  return calloc (1, sizeof (struct plugin_per_client_context));
+}
+
+OPENVPN_EXPORT void
+openvpn_plugin_client_destructor_v1 (openvpn_plugin_handle_t handle, void *per_client_context)
+{
+  printf ("FUNC: openvpn_plugin_client_destructor_v1\n");
+  free (per_client_context);
+}
+
+OPENVPN_EXPORT void
+openvpn_plugin_close_v1 (openvpn_plugin_handle_t handle)
+{
+  struct plugin_context *context = (struct plugin_context *) handle;
+  printf ("FUNC: openvpn_plugin_close_v1\n");
+  free (context);
+}
diff --git a/sample/sample-plugins/defer/simple.def b/sample/sample-plugins/defer/simple.def
new file mode 100755
index 0000000..a87507d
--- /dev/null
+++ b/sample/sample-plugins/defer/simple.def
@@ -0,0 +1,6 @@
+LIBRARY   OpenVPN_PLUGIN_SAMPLE
+DESCRIPTION "Sample OpenVPN plug-in module."
+EXPORTS
+   openvpn_plugin_open_v1   @1
+   openvpn_plugin_func_v1   @2
+   openvpn_plugin_close_v1  @3
diff --git a/sample/sample-plugins/defer/winbuild b/sample/sample-plugins/defer/winbuild
new file mode 100755
index 0000000..82927d9
--- /dev/null
+++ b/sample/sample-plugins/defer/winbuild
@@ -0,0 +1,18 @@
+#
+# Build an OpenVPN plugin module on Windows/MinGW.
+# The argument should be the base name of the C source file
+# (without the .c).
+#
+
+# This directory is where we will look for openvpn-plugin.h
+INCLUDE="-I../../../build"
+
+CC_FLAGS="-O2 -Wall"
+
+gcc -DBUILD_DLL $CC_FLAGS $INCLUDE -c $1.c
+gcc --disable-stdcall-fixup -mdll -DBUILD_DLL -o junk.tmp -Wl,--base-file,base.tmp $1.o
+rm junk.tmp
+dlltool --dllname $1.dll --base-file base.tmp --output-exp temp.exp --input-def $1.def
+rm base.tmp
+gcc --enable-stdcall-fixup -mdll -DBUILD_DLL -o $1.dll $1.o -Wl,temp.exp
+rm temp.exp
diff --git a/sample/sample-plugins/log/build b/sample/sample-plugins/log/build
new file mode 100755
index 0000000..bbb05f7
--- /dev/null
+++ b/sample/sample-plugins/log/build
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+#
+# Build an OpenVPN plugin module on *nix.  The argument should
+# be the base name of the C source file (without the .c).
+#
+
+# This directory is where we will look for openvpn-plugin.h
+CPPFLAGS="${CPPFLAGS:--I../../..}"
+
+CC="${CC:-gcc}"
+CFLAGS="${CFLAGS:--O2 -Wall -g}"
+
+$CC $CPPFLAGS $CFLAGS -fPIC -c $1.c && \
+$CC $CFLAGS -fPIC -shared $LDFLAGS -Wl,-soname,$1.so -o $1.so $1.o -lc
diff --git a/sample/sample-plugins/log/log.c b/sample/sample-plugins/log/log.c
new file mode 100644
index 0000000..1cc4650
--- /dev/null
+++ b/sample/sample-plugins/log/log.c
@@ -0,0 +1,184 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
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
+/*
+ * This plugin is similar to simple.c, except it also logs extra information
+ * to stdout for every plugin method called by OpenVPN.
+ *
+ * See the README file for build instructions.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+
+#include "openvpn-plugin.h"
+
+/*
+ * Our context, where we keep our state.
+ */
+struct plugin_context {
+  const char *username;
+  const char *password;
+};
+
+/*
+ * Given an environmental variable name, search
+ * the envp array for its value, returning it
+ * if found or NULL otherwise.
+ */
+static const char *
+get_env (const char *name, const char *envp[])
+{
+  if (envp)
+    {
+      int i;
+      const int namelen = strlen (name);
+      for (i = 0; envp[i]; ++i)
+	{
+	  if (!strncmp (envp[i], name, namelen))
+	    {
+	      const char *cp = envp[i] + namelen;
+	      if (*cp == '=')
+		return cp + 1;
+	    }
+	}
+    }
+  return NULL;
+}
+
+OPENVPN_EXPORT openvpn_plugin_handle_t
+openvpn_plugin_open_v1 (unsigned int *type_mask, const char *argv[], const char *envp[])
+{
+  struct plugin_context *context;
+
+  /*
+   * Allocate our context
+   */
+  context = (struct plugin_context *) calloc (1, sizeof (struct plugin_context));
+
+  /*
+   * Set the username/password we will require.
+   */
+  context->username = "foo";
+  context->password = "bar";
+
+  /*
+   * Which callbacks to intercept.
+   */
+  *type_mask =
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_UP) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_DOWN) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_ROUTE_UP) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_IPCHANGE) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_TLS_VERIFY) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_CLIENT_CONNECT_V2) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_CLIENT_DISCONNECT) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_LEARN_ADDRESS) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_TLS_FINAL);
+
+  return (openvpn_plugin_handle_t) context;
+}
+
+void
+show (const int type, const char *argv[], const char *envp[])
+{
+  size_t i;
+  switch (type)
+    {
+    case OPENVPN_PLUGIN_UP:
+      printf ("OPENVPN_PLUGIN_UP\n");
+      break;
+    case OPENVPN_PLUGIN_DOWN:
+      printf ("OPENVPN_PLUGIN_DOWN\n");
+      break;
+    case OPENVPN_PLUGIN_ROUTE_UP:
+      printf ("OPENVPN_PLUGIN_ROUTE_UP\n");
+      break;
+    case OPENVPN_PLUGIN_IPCHANGE:
+      printf ("OPENVPN_PLUGIN_IPCHANGE\n");
+      break;
+    case OPENVPN_PLUGIN_TLS_VERIFY:
+      printf ("OPENVPN_PLUGIN_TLS_VERIFY\n");
+      break;
+    case OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY:
+      printf ("OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY\n");
+      break;
+    case OPENVPN_PLUGIN_CLIENT_CONNECT_V2:
+      printf ("OPENVPN_PLUGIN_CLIENT_CONNECT_V2\n");
+      break;
+    case OPENVPN_PLUGIN_CLIENT_DISCONNECT:
+      printf ("OPENVPN_PLUGIN_CLIENT_DISCONNECT\n");
+      break;
+    case OPENVPN_PLUGIN_LEARN_ADDRESS:
+      printf ("OPENVPN_PLUGIN_LEARN_ADDRESS\n");
+      break;
+    case OPENVPN_PLUGIN_TLS_FINAL:
+      printf ("OPENVPN_PLUGIN_TLS_FINAL\n");
+      break;
+    default:
+      printf ("OPENVPN_PLUGIN_?\n");
+      break;
+    }
+
+  printf ("ARGV\n");
+  for (i = 0; argv[i] != NULL; ++i)
+    printf ("%d '%s'\n", (int)i, argv[i]);
+
+  printf ("ENVP\n");
+  for (i = 0; envp[i] != NULL; ++i)
+    printf ("%d '%s'\n", (int)i, envp[i]);
+}
+
+OPENVPN_EXPORT int
+openvpn_plugin_func_v1 (openvpn_plugin_handle_t handle, const int type, const char *argv[], const char *envp[])
+{
+  struct plugin_context *context = (struct plugin_context *) handle;
+
+  show (type, argv, envp);
+
+  /* check entered username/password against what we require */
+  if (type == OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)
+    {
+      /* get username/password from envp string array */
+      const char *username = get_env ("username", envp);
+      const char *password = get_env ("password", envp);
+
+      if (username && !strcmp (username, context->username)
+	  && password && !strcmp (password, context->password))
+	return OPENVPN_PLUGIN_FUNC_SUCCESS;
+      else
+	return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+  else
+    return OPENVPN_PLUGIN_FUNC_SUCCESS;
+}
+
+OPENVPN_EXPORT void
+openvpn_plugin_close_v1 (openvpn_plugin_handle_t handle)
+{
+  struct plugin_context *context = (struct plugin_context *) handle;
+  free (context);
+}
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
new file mode 100644
index 0000000..742c756
--- /dev/null
+++ b/sample/sample-plugins/log/log_v3.c
@@ -0,0 +1,247 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2009 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010 David Sommerseth <dazo@...384...>
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
+/*
+ * This plugin is similar to simple.c, except it also logs extra information
+ * to stdout for every plugin method called by OpenVPN.  The only difference
+ * between this (log_v3.c) and log.c is that this module uses the v3 plug-in
+ * API.
+ *
+ * See the README file for build instructions.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+
+#define ENABLE_SSL
+
+#include "openvpn-plugin.h"
+
+/*
+ * Our context, where we keep our state.
+ */
+struct plugin_context {
+  const char *username;
+  const char *password;
+};
+
+/*
+ * Given an environmental variable name, search
+ * the envp array for its value, returning it
+ * if found or NULL otherwise.
+ */
+static const char *
+get_env (const char *name, const char *envp[])
+{
+  if (envp)
+    {
+      int i;
+      const int namelen = strlen (name);
+      for (i = 0; envp[i]; ++i)
+	{
+	  if (!strncmp (envp[i], name, namelen))
+	    {
+	      const char *cp = envp[i] + namelen;
+	      if (*cp == '=')
+		return cp + 1;
+	    }
+	}
+    }
+  return NULL;
+}
+
+OPENVPN_EXPORT int
+openvpn_plugin_open_v3 (const int v3structver,
+                        struct openvpn_plugin_args_open_in const *args,
+                        struct openvpn_plugin_args_open_return *ret)
+{
+  struct plugin_context *context = NULL;
+
+  /* Check that we are API compatible */
+  if( v3structver != OPENVPN_PLUGINv3_STRUCTVER ) {
+    return OPENVPN_PLUGIN_FUNC_ERROR;
+  }
+
+  /*  Which callbacks to intercept.  */
+  ret->type_mask =
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_UP) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_DOWN) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_ROUTE_UP) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_IPCHANGE) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_TLS_VERIFY) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_CLIENT_CONNECT_V2) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_CLIENT_DISCONNECT) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_LEARN_ADDRESS) |
+    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_TLS_FINAL);
+
+
+  /* Allocate our context */
+  context = (struct plugin_context *) calloc (1, sizeof (struct plugin_context));
+
+  /* Set the username/password we will require. */
+  context->username = "foo";
+  context->password = "bar";
+
+  /* Point the global context handle to our newly created context */
+  ret->handle = (void *) context;
+
+  return OPENVPN_PLUGIN_FUNC_SUCCESS;
+}
+
+void
+show (const int type, const char *argv[], const char *envp[])
+{
+  size_t i;
+  switch (type)
+    {
+    case OPENVPN_PLUGIN_UP:
+      printf ("OPENVPN_PLUGIN_UP\n");
+      break;
+    case OPENVPN_PLUGIN_DOWN:
+      printf ("OPENVPN_PLUGIN_DOWN\n");
+      break;
+    case OPENVPN_PLUGIN_ROUTE_UP:
+      printf ("OPENVPN_PLUGIN_ROUTE_UP\n");
+      break;
+    case OPENVPN_PLUGIN_IPCHANGE:
+      printf ("OPENVPN_PLUGIN_IPCHANGE\n");
+      break;
+    case OPENVPN_PLUGIN_TLS_VERIFY:
+      printf ("OPENVPN_PLUGIN_TLS_VERIFY\n");
+      break;
+    case OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY:
+      printf ("OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY\n");
+      break;
+    case OPENVPN_PLUGIN_CLIENT_CONNECT_V2:
+      printf ("OPENVPN_PLUGIN_CLIENT_CONNECT_V2\n");
+      break;
+    case OPENVPN_PLUGIN_CLIENT_DISCONNECT:
+      printf ("OPENVPN_PLUGIN_CLIENT_DISCONNECT\n");
+      break;
+    case OPENVPN_PLUGIN_LEARN_ADDRESS:
+      printf ("OPENVPN_PLUGIN_LEARN_ADDRESS\n");
+      break;
+    case OPENVPN_PLUGIN_TLS_FINAL:
+      printf ("OPENVPN_PLUGIN_TLS_FINAL\n");
+      break;
+    default:
+      printf ("OPENVPN_PLUGIN_?\n");
+      break;
+    }
+
+  printf ("ARGV\n");
+  for (i = 0; argv[i] != NULL; ++i)
+    printf ("%d '%s'\n", (int)i, argv[i]);
+
+  printf ("ENVP\n");
+  for (i = 0; envp[i] != NULL; ++i)
+    printf ("%d '%s'\n", (int)i, envp[i]);
+}
+
+static void
+x509_print_info (X509 *x509crt)
+{
+  int i, n;
+  int fn_nid;
+  ASN1_OBJECT *fn;
+  ASN1_STRING *val;
+  X509_NAME *x509_name;
+  X509_NAME_ENTRY *ent;
+  const char *objbuf;
+  unsigned char *buf;
+
+  x509_name = X509_get_subject_name (x509crt);
+  n = X509_NAME_entry_count (x509_name);
+  for (i = 0; i < n; ++i)
+    {
+      ent = X509_NAME_get_entry (x509_name, i);
+      if (!ent)
+	continue;
+      fn = X509_NAME_ENTRY_get_object (ent);
+      if (!fn)
+	continue;
+      val = X509_NAME_ENTRY_get_data (ent);
+      if (!val)
+	continue;
+      fn_nid = OBJ_obj2nid (fn);
+      if (fn_nid == NID_undef)
+	continue;
+      objbuf = OBJ_nid2sn (fn_nid);
+      if (!objbuf)
+	continue;
+      buf = (unsigned char *)1; /* bug in OpenSSL 0.9.6b ASN1_STRING_to_UTF8 requires this workaround */
+      if (ASN1_STRING_to_UTF8 (&buf, val) <= 0)
+	continue;
+
+      printf("X509 %s: %s\n", objbuf, (char *)buf);
+      OPENSSL_free (buf);
+    }
+}
+
+
+
+OPENVPN_EXPORT int
+openvpn_plugin_func_v3 (const int version,
+                        struct openvpn_plugin_args_func_in const *args,
+                        struct openvpn_plugin_args_func_return *retptr)
+{
+  struct plugin_context *context = (struct plugin_context *) args->handle;
+
+  printf("\nopenvpn_plugin_func_v3() :::::>> ");
+  show (args->type, args->argv, args->envp);
+
+  /* Dump some X509 information if we're in the TLS_VERIFY phase */
+  if ((args->type == OPENVPN_PLUGIN_TLS_VERIFY) && args->current_cert ) {
+    printf("---- X509 Subject information ----\n");
+    printf("Certificate depth: %i\n", args->current_cert_depth);
+    x509_print_info(args->current_cert);
+    printf("----------------------------------\n");
+  }
+
+  /* check entered username/password against what we require */
+  if (args->type == OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)
+    {
+      /* get username/password from envp string array */
+      const char *username = get_env ("username", args->envp);
+      const char *password = get_env ("password", args->envp);
+
+      if (username && !strcmp (username, context->username)
+	  && password && !strcmp (password, context->password))
+	return OPENVPN_PLUGIN_FUNC_SUCCESS;
+      else
+	return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+  else
+    return OPENVPN_PLUGIN_FUNC_SUCCESS;
+}
+
+OPENVPN_EXPORT void
+openvpn_plugin_close_v1 (openvpn_plugin_handle_t handle)
+{
+  struct plugin_context *context = (struct plugin_context *) handle;
+  free (context);
+}
diff --git a/sample/sample-plugins/log/winbuild b/sample/sample-plugins/log/winbuild
new file mode 100755
index 0000000..decf05f
--- /dev/null
+++ b/sample/sample-plugins/log/winbuild
@@ -0,0 +1,18 @@
+#
+# Build an OpenVPN plugin module on Windows/MinGW.
+# The argument should be the base name of the C source file
+# (without the .c).
+#
+
+# This directory is where we will look for openvpn-plugin.h
+INCLUDE="-I../../../include"
+
+CC_FLAGS="-O2 -Wall"
+
+gcc -DBUILD_DLL $CC_FLAGS $INCLUDE -c $1.c
+gcc --disable-stdcall-fixup -mdll -DBUILD_DLL -o junk.tmp -Wl,--base-file,base.tmp $1.o
+rm junk.tmp
+dlltool --dllname $1.dll --base-file base.tmp --output-exp temp.exp --input-def $1.def
+rm base.tmp
+gcc --enable-stdcall-fixup -mdll -DBUILD_DLL -o $1.dll $1.o -Wl,temp.exp
+rm temp.exp
diff --git a/sample/sample-plugins/simple/README b/sample/sample-plugins/simple/README
new file mode 100644
index 0000000..4400cd3
--- /dev/null
+++ b/sample/sample-plugins/simple/README
@@ -0,0 +1,16 @@
+OpenVPN plugin examples.
+
+Examples provided:
+
+simple.c -- using the --auth-user-pass-verify callback, verify
+            that the username/password is "foo"/"bar".
+
+To build:
+
+  ./build simple (Linux/BSD/etc.)
+  ./winbuild simple (MinGW on Windows)
+
+To use in OpenVPN, add to config file:
+
+  plugin simple.so (Linux/BSD/etc.)
+  plugin simple.dll (MinGW on Windows)
diff --git a/sample/sample-plugins/simple/build b/sample/sample-plugins/simple/build
new file mode 100755
index 0000000..bbb05f7
--- /dev/null
+++ b/sample/sample-plugins/simple/build
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+#
+# Build an OpenVPN plugin module on *nix.  The argument should
+# be the base name of the C source file (without the .c).
+#
+
+# This directory is where we will look for openvpn-plugin.h
+CPPFLAGS="${CPPFLAGS:--I../../..}"
+
+CC="${CC:-gcc}"
+CFLAGS="${CFLAGS:--O2 -Wall -g}"
+
+$CC $CPPFLAGS $CFLAGS -fPIC -c $1.c && \
+$CC $CFLAGS -fPIC -shared $LDFLAGS -Wl,-soname,$1.so -o $1.so $1.o -lc
diff --git a/sample/sample-plugins/simple/simple.c b/sample/sample-plugins/simple/simple.c
new file mode 100644
index 0000000..f26d89f
--- /dev/null
+++ b/sample/sample-plugins/simple/simple.c
@@ -0,0 +1,120 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
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
+/*
+ * This file implements a simple OpenVPN plugin module which
+ * will examine the username/password provided by a client,
+ * and make an accept/deny determination.  Will run
+ * on Windows or *nix.
+ *
+ * See the README file for build instructions.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+
+#include "openvpn-plugin.h"
+
+/*
+ * Our context, where we keep our state.
+ */
+struct plugin_context {
+  const char *username;
+  const char *password;
+};
+
+/*
+ * Given an environmental variable name, search
+ * the envp array for its value, returning it
+ * if found or NULL otherwise.
+ */
+static const char *
+get_env (const char *name, const char *envp[])
+{
+  if (envp)
+    {
+      int i;
+      const int namelen = strlen (name);
+      for (i = 0; envp[i]; ++i)
+	{
+	  if (!strncmp (envp[i], name, namelen))
+	    {
+	      const char *cp = envp[i] + namelen;
+	      if (*cp == '=')
+		return cp + 1;
+	    }
+	}
+    }
+  return NULL;
+}
+
+OPENVPN_EXPORT openvpn_plugin_handle_t
+openvpn_plugin_open_v1 (unsigned int *type_mask, const char *argv[], const char *envp[])
+{
+  struct plugin_context *context;
+
+  /*
+   * Allocate our context
+   */
+  context = (struct plugin_context *) calloc (1, sizeof (struct plugin_context));
+
+  /*
+   * Set the username/password we will require.
+   */
+  context->username = "foo";
+  context->password = "bar";
+
+  /*
+   * We are only interested in intercepting the
+   * --auth-user-pass-verify callback.
+   */
+  *type_mask = OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY);
+
+  return (openvpn_plugin_handle_t) context;
+}
+
+OPENVPN_EXPORT int
+openvpn_plugin_func_v1 (openvpn_plugin_handle_t handle, const int type, const char *argv[], const char *envp[])
+{
+  struct plugin_context *context = (struct plugin_context *) handle;
+
+  /* get username/password from envp string array */
+  const char *username = get_env ("username", envp);
+  const char *password = get_env ("password", envp);
+
+  /* check entered username/password against what we require */
+  if (username && !strcmp (username, context->username)
+      && password && !strcmp (password, context->password))
+    return OPENVPN_PLUGIN_FUNC_SUCCESS;
+  else
+    return OPENVPN_PLUGIN_FUNC_ERROR;
+}
+
+OPENVPN_EXPORT void
+openvpn_plugin_close_v1 (openvpn_plugin_handle_t handle)
+{
+  struct plugin_context *context = (struct plugin_context *) handle;
+  free (context);
+}
diff --git a/sample/sample-plugins/simple/simple.def b/sample/sample-plugins/simple/simple.def
new file mode 100755
index 0000000..a87507d
--- /dev/null
+++ b/sample/sample-plugins/simple/simple.def
@@ -0,0 +1,6 @@
+LIBRARY   OpenVPN_PLUGIN_SAMPLE
+DESCRIPTION "Sample OpenVPN plug-in module."
+EXPORTS
+   openvpn_plugin_open_v1   @1
+   openvpn_plugin_func_v1   @2
+   openvpn_plugin_close_v1  @3
diff --git a/sample/sample-plugins/simple/winbuild b/sample/sample-plugins/simple/winbuild
new file mode 100755
index 0000000..decf05f
--- /dev/null
+++ b/sample/sample-plugins/simple/winbuild
@@ -0,0 +1,18 @@
+#
+# Build an OpenVPN plugin module on Windows/MinGW.
+# The argument should be the base name of the C source file
+# (without the .c).
+#
+
+# This directory is where we will look for openvpn-plugin.h
+INCLUDE="-I../../../include"
+
+CC_FLAGS="-O2 -Wall"
+
+gcc -DBUILD_DLL $CC_FLAGS $INCLUDE -c $1.c
+gcc --disable-stdcall-fixup -mdll -DBUILD_DLL -o junk.tmp -Wl,--base-file,base.tmp $1.o
+rm junk.tmp
+dlltool --dllname $1.dll --base-file base.tmp --output-exp temp.exp --input-def $1.def
+rm base.tmp
+gcc --enable-stdcall-fixup -mdll -DBUILD_DLL -o $1.dll $1.o -Wl,temp.exp
+rm temp.exp
diff --git a/src/Makefile.am b/src/Makefile.am
index b894977..c04468a 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -12,7 +12,4 @@
 MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
-EXTRA_DIST = \
-	plugins
-
-SUBDIRS = compat openvpn openvpnserv
+SUBDIRS = compat openvpn openvpnserv plugins
diff --git a/src/plugins/Makefile.am b/src/plugins/Makefile.am
new file mode 100644
index 0000000..17b72b9
--- /dev/null
+++ b/src/plugins/Makefile.am
@@ -0,0 +1,15 @@
+#
+#  OpenVPN -- An application to securely tunnel IP networks
+#             over a single UDP port, with support for SSL/TLS-based
+#             session authentication and key exchange,
+#             packet encryption, packet authentication, and
+#             packet compression.
+#
+#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
+#
+
+MAINTAINERCLEANFILES = \
+	$(srcdir)/Makefile.in
+
+SUBDIRS = auth-pam down-root
diff --git a/src/plugins/README b/src/plugins/README
deleted file mode 100644
index 6e490c5..0000000
--- a/src/plugins/README
+++ /dev/null
@@ -1,47 +0,0 @@
-OpenVPN Plugins
----------------
-
-Starting with OpenVPN 2.0-beta17, compiled plugin modules are
-supported on any *nix OS which includes libdl or on Windows.
-One or more modules may be loaded into OpenVPN using
-the --plugin directive, and each plugin module is capable of
-intercepting any of the script callbacks which OpenVPN supports:
-
-(1) up
-(2) down
-(3) route-up
-(4) ipchange
-(5) tls-verify
-(6) auth-user-pass-verify
-(7) client-connect
-(8) client-disconnect
-(9) learn-address
-
-See the openvpn-plugin.h file in the top-level directory of the
-OpenVPN source distribution for more detailed information
-on the plugin interface.
-
-Included Plugins
-----------------
-
-auth-pam -- Authenticate using PAM and a split privilege
-            execution model which functions even if
-            root privileges or the execution environment
-            have been altered with --user/--group/--chroot.
-            Tested on Linux only.
-
-down-root -- Enable the running of down scripts with root privileges
-             even if --user/--group/--chroot have been used
-             to drop root privileges or change the execution
-             environment.  Not applicable on Windows.
-
-examples -- A simple example that demonstrates a portable
-            plugin, i.e. one which can be built for *nix
-            or Windows from the same source.
-
-Building Plugins
-----------------
-
-cd to the top-level directory of a plugin, and use the
-"make" command to build it.  The examples plugin is
-built using a build script, not a makefile.
diff --git a/src/plugins/auth-pam/Makefile b/src/plugins/auth-pam/Makefile
deleted file mode 100755
index c0b9c79..0000000
--- a/src/plugins/auth-pam/Makefile
+++ /dev/null
@@ -1,32 +0,0 @@
-#
-# Build the OpenVPN auth-pam plugin module.
-#
-
-# If PAM modules are not linked against libpam.so, set DLOPEN_PAM to 1. This
-# must be done on SUSE 9.1, at least.
-DLOPEN_PAM=0
-
-ifeq ($(DLOPEN_PAM),1)
-	LIBPAM=-ldl
-else
-	LIBPAM=-lpam
-endif
-
-# This directory is where we will look for openvpn-plugin.h
-CPPFLAGS=-I../../../include
-
-CC=gcc
-CFLAGS=-O2 -Wall
-DEFS = -DDLOPEN_PAM=$(DLOPEN_PAM)
-
-openvpn-auth-pam.so : auth-pam.o pamdl.o
-	$(CC) $(CFLAGS) -fPIC -shared $(LDFLAGS) -Wl,-soname,openvpn-auth-pam.so -o openvpn-auth-pam.so auth-pam.o pamdl.o -lc $(LIBPAM)
-
-auth-pam.o : auth-pam.c pamdl.h
-	$(CC) $(CPPFLAGS) $(CFLAGS) $(DEFS) -fPIC -c auth-pam.c
-
-pamdl.o : pamdl.c pamdl.h
-	$(CC) $(CPPFLAGS) $(CFLAGS) $(DEFS) -fPIC -c pamdl.c
-
-clean :
-	-rm -f *.o *.so
diff --git a/src/plugins/auth-pam/Makefile.am b/src/plugins/auth-pam/Makefile.am
new file mode 100644
index 0000000..701a749
--- /dev/null
+++ b/src/plugins/auth-pam/Makefile.am
@@ -0,0 +1,27 @@
+#
+#  OpenVPN (TM) PAM Auth Plugin -- OpenVPN Plugin
+#
+#  Copyright (C) 2012      Alon Bar-Lev <alon.barlev@...277...>
+#
+
+MAINTAINERCLEANFILES = \
+	$(srcdir)/Makefile.in
+
+AM_CFLAGS = \
+	-I$(top_srcdir)/include
+	$(PLUGIN_AUTH_PAM_CFLAGS)
+
+if ENABLE_PLUGIN_AUTH_PAM
+plugin_LTLIBRARIES = openvpn-plugin-auth-pam.la
+dist_doc_DATA = README.auth-pam
+endif
+
+openvpn_plugin_auth_pam_la_SOURCES = \
+	auth-pam.c \
+	pamdl.c  pamdl.h \
+	auth-pam.exports
+openvpn_plugin_auth_pam_la_LIBADD = \
+	$(PLUGIN_AUTH_PAM_LIBS)
+openvpn_plugin_auth_pam_la_LDFLAGS = $(AM_LDFLAGS) \
+	-export-symbols "$(srcdir)/auth-pam.exports" \
+	-module -shared -avoid-version -no-undefined
diff --git a/src/plugins/auth-pam/README b/src/plugins/auth-pam/README
deleted file mode 100644
index e123690..0000000
--- a/src/plugins/auth-pam/README
+++ /dev/null
@@ -1,74 +0,0 @@
-openvpn-auth-pam
-
-SYNOPSIS
-
-The openvpn-auth-pam module implements username/password
-authentication via PAM, and essentially allows any authentication
-method supported by PAM (such as LDAP, RADIUS, or Linux Shadow
-passwords) to be used with OpenVPN.  While PAM supports
-username/password authentication, this can be combined with X509
-certificates to provide two indepedent levels of authentication.
-
-This module uses a split privilege execution model which will
-function even if you drop openvpn daemon privileges using the user,
-group, or chroot directives.
-
-BUILD
-
-To build openvpn-auth-pam, you will need to have the pam-devel
-package installed.
-
-Build with the "make" command.  The module will be named
-openvpn-auth-pam.so
-
-USAGE
-
-To use this plugin module, add to your OpenVPN config file:
-
-  plugin openvpn-auth-pam.so service-type
-
-The required service-type parameter corresponds to
-the PAM service definition file usually found
-in /etc/pam.d.
-
-This plugin also supports the usage of a list of name/value
-pairs to answer PAM module queries.
-
-For example:
-
-  plugin openvpn-auth-pam.so "login login USERNAME password PASSWORD"
-
-tells auth-pam to (a) use the "login" PAM module, (b) answer a
-"login" query with the username given by the OpenVPN client, and
-(c) answer a "password" query with the password given by the
-OpenVPN client.  This provides flexibility in dealing with the different
-types of query strings which different PAM modules might generate.
-For example, suppose you were using a PAM module called
-"test" which queried for "name" rather than "login":
-
-  plugin openvpn-auth-pam.so "test name USERNAME password PASSWORD"
-
-While "USERNAME" "COMMONNAME" and "PASSWORD" are special strings which substitute
-to client-supplied values, it is also possible to name literal values
-to use as PAM module query responses.  For example, suppose that the
-login module queried for a third parameter, "domain" which
-is to be answered with the constant value "mydomain.com":
-
-  plugin openvpn-auth-pam.so "login login USERNAME password PASSWORD domain mydomain.com"
-
-The following OpenVPN directives can also influence
-the operation of this plugin:
-
-  client-cert-not-required
-  username-as-common-name
-
-Run OpenVPN with --verb 7 or higher to get debugging output from
-this plugin, including the list of queries presented by the
-underlying PAM module.  This is a useful debugging tool to figure
-out which queries a given PAM module is making, so that you can
-craft the appropriate plugin directive to answer it.
-
-CAVEATS
-
-This module will only work on *nix systems which support PAM,
-not Windows.
diff --git a/src/plugins/auth-pam/README.auth-pam b/src/plugins/auth-pam/README.auth-pam
new file mode 100644
index 0000000..e123690
--- /dev/null
+++ b/src/plugins/auth-pam/README.auth-pam
@@ -0,0 +1,74 @@
+openvpn-auth-pam
+
+SYNOPSIS
+
+The openvpn-auth-pam module implements username/password
+authentication via PAM, and essentially allows any authentication
+method supported by PAM (such as LDAP, RADIUS, or Linux Shadow
+passwords) to be used with OpenVPN.  While PAM supports
+username/password authentication, this can be combined with X509
+certificates to provide two indepedent levels of authentication.
+
+This module uses a split privilege execution model which will
+function even if you drop openvpn daemon privileges using the user,
+group, or chroot directives.
+
+BUILD
+
+To build openvpn-auth-pam, you will need to have the pam-devel
+package installed.
+
+Build with the "make" command.  The module will be named
+openvpn-auth-pam.so
+
+USAGE
+
+To use this plugin module, add to your OpenVPN config file:
+
+  plugin openvpn-auth-pam.so service-type
+
+The required service-type parameter corresponds to
+the PAM service definition file usually found
+in /etc/pam.d.
+
+This plugin also supports the usage of a list of name/value
+pairs to answer PAM module queries.
+
+For example:
+
+  plugin openvpn-auth-pam.so "login login USERNAME password PASSWORD"
+
+tells auth-pam to (a) use the "login" PAM module, (b) answer a
+"login" query with the username given by the OpenVPN client, and
+(c) answer a "password" query with the password given by the
+OpenVPN client.  This provides flexibility in dealing with the different
+types of query strings which different PAM modules might generate.
+For example, suppose you were using a PAM module called
+"test" which queried for "name" rather than "login":
+
+  plugin openvpn-auth-pam.so "test name USERNAME password PASSWORD"
+
+While "USERNAME" "COMMONNAME" and "PASSWORD" are special strings which substitute
+to client-supplied values, it is also possible to name literal values
+to use as PAM module query responses.  For example, suppose that the
+login module queried for a third parameter, "domain" which
+is to be answered with the constant value "mydomain.com":
+
+  plugin openvpn-auth-pam.so "login login USERNAME password PASSWORD domain mydomain.com"
+
+The following OpenVPN directives can also influence
+the operation of this plugin:
+
+  client-cert-not-required
+  username-as-common-name
+
+Run OpenVPN with --verb 7 or higher to get debugging output from
+this plugin, including the list of queries presented by the
+underlying PAM module.  This is a useful debugging tool to figure
+out which queries a given PAM module is making, so that you can
+craft the appropriate plugin directive to answer it.
+
+CAVEATS
+
+This module will only work on *nix systems which support PAM,
+not Windows.
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index e52f632..bd71792 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -26,12 +26,14 @@
  * OpenVPN plugin module to do PAM authentication using a split
  * privilege model.
  */
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
 
-#if DLOPEN_PAM
-#include <dlfcn.h>
-#include "pamdl.h"
-#else
 #include <security/pam_appl.h>
+
+#ifdef USE_PAM_DLOPEN
+#include "pamdl.h"
 #endif
 
 #include <stdio.h>
@@ -46,7 +48,7 @@
 #include <signal.h>
 #include <syslog.h>
 
-#include "openvpn-plugin.h"
+#include <openvpn-plugin.h>
 
 #define DEBUG(verb) ((verb) >= 4)
 
@@ -693,7 +695,7 @@ pam_server (int fd, const char *service, int verb, const struct name_value_list
 {
   struct user_pass up;
   int command;
-#if DLOPEN_PAM
+#ifdef USE_PAM_DLOPEN
   static const char pam_so[] = "libpam.so";
 #endif
 
@@ -703,7 +705,7 @@ pam_server (int fd, const char *service, int verb, const struct name_value_list
   if (DEBUG (verb))
     fprintf (stderr, "AUTH-PAM: BACKGROUND: INIT service='%s'\n", service);
 
-#if DLOPEN_PAM
+#ifdef USE_PAM_DLOPEN
   /*
    * Load PAM shared object
    */
@@ -794,7 +796,7 @@ pam_server (int fd, const char *service, int verb, const struct name_value_list
     }
  done:
 
-#if DLOPEN_PAM
+#ifdef USE_PAM_DLOPEN
   dlclose_pam ();
 #endif
   if (DEBUG (verb))
diff --git a/src/plugins/auth-pam/auth-pam.exports b/src/plugins/auth-pam/auth-pam.exports
new file mode 100644
index 0000000..b07937c
--- /dev/null
+++ b/src/plugins/auth-pam/auth-pam.exports
@@ -0,0 +1,4 @@
+openvpn_plugin_open_v1
+openvpn_plugin_func_v1
+openvpn_plugin_close_v1
+openvpn_plugin_abort_v1
diff --git a/src/plugins/auth-pam/pamdl.c b/src/plugins/auth-pam/pamdl.c
index 8636a8e..26e9821 100644
--- a/src/plugins/auth-pam/pamdl.c
+++ b/src/plugins/auth-pam/pamdl.c
@@ -1,4 +1,8 @@
-#if DLOPEN_PAM
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#ifdef USE_PAM_DLOPEN
 /*
  * If you want to dynamically load libpam using dlopen() or something,
  * then dlopen( ' this shared object ' ); It takes care of exporting
@@ -73,7 +77,7 @@ int pam_set_item(pam_handle_t *pamh, int item_type, const void *item)
     return real_pam_set_item(pamh, item_type, item);
 }
 
-int pam_get_item(pam_handle_t *pamh, int item_type, const void **item)
+int pam_get_item(const pam_handle_t *pamh, int item_type, const void **item)
 {
     int (*real_pam_get_item)(const pam_handle_t *, int, const void **);
     RESOLVE_PAM_FUNCTION(pam_get_item, int,
diff --git a/src/plugins/auth-pam/pamdl.h b/src/plugins/auth-pam/pamdl.h
index b10b035..12ba068 100644
--- a/src/plugins/auth-pam/pamdl.h
+++ b/src/plugins/auth-pam/pamdl.h
@@ -1,6 +1,4 @@
-#if DLOPEN_PAM
-#include <security/pam_appl.h>
-
+#ifdef USE_PAM_DLOPEN
 /* Dynamically load and unload the PAM library */
 int dlopen_pam (const char *so);
 void dlclose_pam (void);
diff --git a/src/plugins/defer/README b/src/plugins/defer/README
deleted file mode 100644
index d8990f8..0000000
--- a/src/plugins/defer/README
+++ /dev/null
@@ -1,16 +0,0 @@
-OpenVPN plugin examples.
-
-Examples provided:
-
-simple.c -- using the --auth-user-pass-verify callback,
-            test deferred authentication.
-
-To build:
-
-  ./build simple (Linux/BSD/etc.)
-  ./winbuild simple (MinGW on Windows)
-
-To use in OpenVPN, add to config file:
-
-  plugin simple.so (Linux/BSD/etc.)
-  plugin simple.dll (MinGW on Windows)
diff --git a/src/plugins/defer/build b/src/plugins/defer/build
deleted file mode 100755
index 0612c08..0000000
--- a/src/plugins/defer/build
+++ /dev/null
@@ -1,15 +0,0 @@
-#!/bin/sh
-
-#
-# Build an OpenVPN plugin module on *nix.  The argument should
-# be the base name of the C source file (without the .c).
-#
-
-# This directory is where we will look for openvpn-plugin.h
-CPPFLAGS="${CPPFLAGS:--I../../../include}"
-
-CC="${CC:-gcc}"
-CFLAGS="${CFLAGS:--O2 -Wall -g}"
-
-$CC $CPPFLAGS $CFLAGS -fPIC -c $1.c && \
-$CC $CFLAGS -fPIC -shared ${LDFLAS} -Wl,-soname,$1.so -o $1.so $1.o -lc
diff --git a/src/plugins/defer/simple.c b/src/plugins/defer/simple.c
deleted file mode 100644
index 6539865..0000000
--- a/src/plugins/defer/simple.c
+++ /dev/null
@@ -1,305 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-/*
- * This file implements a simple OpenVPN plugin module which
- * will test deferred authentication and packet filtering.
- * 
- * Will run on Windows or *nix.
- *
- * Sample usage:
- *
- * setenv test_deferred_auth 20
- * setenv test_packet_filter 10
- * plugin plugin/defer/simple.so
- *
- * This will enable deferred authentication to occur 20
- * seconds after the normal TLS authentication process,
- * and will cause a packet filter file to be generated 10
- * seconds after the initial TLS negotiation, using
- * {common-name}.pf as the source.
- *
- * Sample packet filter configuration:
- *
- * [CLIENTS DROP]
- * +otherclient
- * [SUBNETS DROP]
- * +10.0.0.0/8
- * -10.10.0.8
- * [END]
- *
- * See the README file for build instructions.
- */
-
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-
-#include "openvpn-plugin.h"
-
-/* bool definitions */
-#define bool int
-#define true 1
-#define false 0
-
-/*
- * Our context, where we keep our state.
- */
-
-struct plugin_context {
-  int test_deferred_auth;
-  int test_packet_filter;
-};
-
-struct plugin_per_client_context {
-  int n_calls;
-  bool generated_pf_file;
-};
-
-/*
- * Given an environmental variable name, search
- * the envp array for its value, returning it
- * if found or NULL otherwise.
- */
-static const char *
-get_env (const char *name, const char *envp[])
-{
-  if (envp)
-    {
-      int i;
-      const int namelen = strlen (name);
-      for (i = 0; envp[i]; ++i)
-	{
-	  if (!strncmp (envp[i], name, namelen))
-	    {
-	      const char *cp = envp[i] + namelen;
-	      if (*cp == '=')
-		return cp + 1;
-	    }
-	}
-    }
-  return NULL;
-}
-
-/* used for safe printf of possible NULL strings */
-static const char *
-np (const char *str)
-{
-  if (str)
-    return str;
-  else
-    return "[NULL]";
-}
-
-static int
-atoi_null0 (const char *str)
-{
-  if (str)
-    return atoi (str);
-  else
-    return 0;
-}
-
-OPENVPN_EXPORT openvpn_plugin_handle_t
-openvpn_plugin_open_v1 (unsigned int *type_mask, const char *argv[], const char *envp[])
-{
-  struct plugin_context *context;
-
-  printf ("FUNC: openvpn_plugin_open_v1\n");
-
-  /*
-   * Allocate our context
-   */
-  context = (struct plugin_context *) calloc (1, sizeof (struct plugin_context));
-
-  context->test_deferred_auth = atoi_null0 (get_env ("test_deferred_auth", envp));
-  printf ("TEST_DEFERRED_AUTH %d\n", context->test_deferred_auth);
-
-  context->test_packet_filter = atoi_null0 (get_env ("test_packet_filter", envp));
-  printf ("TEST_PACKET_FILTER %d\n", context->test_packet_filter);
-
-  /*
-   * Which callbacks to intercept.
-   */
-  *type_mask =
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_UP) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_DOWN) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_ROUTE_UP) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_IPCHANGE) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_TLS_VERIFY) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_CLIENT_CONNECT_V2) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_CLIENT_DISCONNECT) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_LEARN_ADDRESS) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_TLS_FINAL) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_ENABLE_PF);
-
-  return (openvpn_plugin_handle_t) context;
-}
-
-static int
-auth_user_pass_verify (struct plugin_context *context, struct plugin_per_client_context *pcc, const char *argv[], const char *envp[])
-{
-  if (context->test_deferred_auth)
-    {
-      /* get username/password from envp string array */
-      const char *username = get_env ("username", envp);
-      const char *password = get_env ("password", envp);
-
-      /* get auth_control_file filename from envp string array*/
-      const char *auth_control_file = get_env ("auth_control_file", envp);
-
-      printf ("DEFER u='%s' p='%s' acf='%s'\n",
-	      np(username),
-	      np(password),
-	      np(auth_control_file));
-
-      /* Authenticate asynchronously in n seconds */
-      if (auth_control_file)
-	{
-	  char buf[256];
-	  int auth = 2;
-	  sscanf (username, "%d", &auth);
-	  snprintf (buf, sizeof(buf), "( sleep %d ; echo AUTH %s %d ; echo %d >%s ) &",
-		    context->test_deferred_auth,
-		    auth_control_file,
-		    auth,
-		    pcc->n_calls < auth,
-		    auth_control_file);
-	  printf ("%s\n", buf);
-	  system (buf);
-	  pcc->n_calls++;
-	  return OPENVPN_PLUGIN_FUNC_DEFERRED;
-	}
-      else
-	return OPENVPN_PLUGIN_FUNC_ERROR;
-    }
-  else
-    return OPENVPN_PLUGIN_FUNC_SUCCESS;
-}
-
-static int
-tls_final (struct plugin_context *context, struct plugin_per_client_context *pcc, const char *argv[], const char *envp[])
-{
-  if (context->test_packet_filter)
-    {
-      if (!pcc->generated_pf_file)
-	{
-	  const char *pff = get_env ("pf_file", envp);
-	  const char *cn = get_env ("username", envp);
-	  if (pff && cn)
-	    {
-	      char buf[256];
-	      snprintf (buf, sizeof(buf), "( sleep %d ; echo PF %s/%s ; cp \"%s.pf\" \"%s\" ) &",
-			context->test_packet_filter, cn, pff, cn, pff);
-	      printf ("%s\n", buf);
-	      system (buf);
-	      pcc->generated_pf_file = true;
-	      return OPENVPN_PLUGIN_FUNC_SUCCESS;
-	    }
-	  else
-	    return OPENVPN_PLUGIN_FUNC_ERROR;
-	}
-      else
-	return OPENVPN_PLUGIN_FUNC_ERROR;
-    }
-  else
-    return OPENVPN_PLUGIN_FUNC_SUCCESS;
-}
-
-OPENVPN_EXPORT int
-openvpn_plugin_func_v2 (openvpn_plugin_handle_t handle,
-			const int type,
-			const char *argv[],
-			const char *envp[],
-			void *per_client_context,
-			struct openvpn_plugin_string_list **return_list)
-{
-  struct plugin_context *context = (struct plugin_context *) handle;
-  struct plugin_per_client_context *pcc = (struct plugin_per_client_context *) per_client_context;
-  switch (type)
-    {
-    case OPENVPN_PLUGIN_UP:
-      printf ("OPENVPN_PLUGIN_UP\n");
-      return OPENVPN_PLUGIN_FUNC_SUCCESS;
-    case OPENVPN_PLUGIN_DOWN:
-      printf ("OPENVPN_PLUGIN_DOWN\n");
-      return OPENVPN_PLUGIN_FUNC_SUCCESS;
-    case OPENVPN_PLUGIN_ROUTE_UP:
-      printf ("OPENVPN_PLUGIN_ROUTE_UP\n");
-      return OPENVPN_PLUGIN_FUNC_SUCCESS;
-    case OPENVPN_PLUGIN_IPCHANGE:
-      printf ("OPENVPN_PLUGIN_IPCHANGE\n");
-      return OPENVPN_PLUGIN_FUNC_SUCCESS;
-    case OPENVPN_PLUGIN_TLS_VERIFY:
-      printf ("OPENVPN_PLUGIN_TLS_VERIFY\n");
-      return OPENVPN_PLUGIN_FUNC_SUCCESS;
-    case OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY:
-      printf ("OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY\n");
-      return auth_user_pass_verify (context, pcc, argv, envp);
-    case OPENVPN_PLUGIN_CLIENT_CONNECT_V2:
-      printf ("OPENVPN_PLUGIN_CLIENT_CONNECT_V2\n");
-      return OPENVPN_PLUGIN_FUNC_SUCCESS;
-    case OPENVPN_PLUGIN_CLIENT_DISCONNECT:
-      printf ("OPENVPN_PLUGIN_CLIENT_DISCONNECT\n");
-      return OPENVPN_PLUGIN_FUNC_SUCCESS;
-    case OPENVPN_PLUGIN_LEARN_ADDRESS:
-      printf ("OPENVPN_PLUGIN_LEARN_ADDRESS\n");
-      return OPENVPN_PLUGIN_FUNC_SUCCESS;
-    case OPENVPN_PLUGIN_TLS_FINAL:
-      printf ("OPENVPN_PLUGIN_TLS_FINAL\n");
-      return tls_final (context, pcc, argv, envp);
-    case OPENVPN_PLUGIN_ENABLE_PF:
-      printf ("OPENVPN_PLUGIN_ENABLE_PF\n");
-      if (context->test_packet_filter)
-	return OPENVPN_PLUGIN_FUNC_SUCCESS;
-      else
-	return OPENVPN_PLUGIN_FUNC_ERROR;
-    default:
-      printf ("OPENVPN_PLUGIN_?\n");
-      return OPENVPN_PLUGIN_FUNC_ERROR;
-    }
-}
-
-OPENVPN_EXPORT void *
-openvpn_plugin_client_constructor_v1 (openvpn_plugin_handle_t handle)
-{
-  printf ("FUNC: openvpn_plugin_client_constructor_v1\n");
-  return calloc (1, sizeof (struct plugin_per_client_context));
-}
-
-OPENVPN_EXPORT void
-openvpn_plugin_client_destructor_v1 (openvpn_plugin_handle_t handle, void *per_client_context)
-{
-  printf ("FUNC: openvpn_plugin_client_destructor_v1\n");
-  free (per_client_context);
-}
-
-OPENVPN_EXPORT void
-openvpn_plugin_close_v1 (openvpn_plugin_handle_t handle)
-{
-  struct plugin_context *context = (struct plugin_context *) handle;
-  printf ("FUNC: openvpn_plugin_close_v1\n");
-  free (context);
-}
diff --git a/src/plugins/defer/simple.def b/src/plugins/defer/simple.def
deleted file mode 100755
index a87507d..0000000
--- a/src/plugins/defer/simple.def
+++ /dev/null
@@ -1,6 +0,0 @@
-LIBRARY   OpenVPN_PLUGIN_SAMPLE
-DESCRIPTION "Sample OpenVPN plug-in module."
-EXPORTS
-   openvpn_plugin_open_v1   @1
-   openvpn_plugin_func_v1   @2
-   openvpn_plugin_close_v1  @3
diff --git a/src/plugins/defer/winbuild b/src/plugins/defer/winbuild
deleted file mode 100755
index 82927d9..0000000
--- a/src/plugins/defer/winbuild
+++ /dev/null
@@ -1,18 +0,0 @@
-#
-# Build an OpenVPN plugin module on Windows/MinGW.
-# The argument should be the base name of the C source file
-# (without the .c).
-#
-
-# This directory is where we will look for openvpn-plugin.h
-INCLUDE="-I../../../build"
-
-CC_FLAGS="-O2 -Wall"
-
-gcc -DBUILD_DLL $CC_FLAGS $INCLUDE -c $1.c
-gcc --disable-stdcall-fixup -mdll -DBUILD_DLL -o junk.tmp -Wl,--base-file,base.tmp $1.o
-rm junk.tmp
-dlltool --dllname $1.dll --base-file base.tmp --output-exp temp.exp --input-def $1.def
-rm base.tmp
-gcc --enable-stdcall-fixup -mdll -DBUILD_DLL -o $1.dll $1.o -Wl,temp.exp
-rm temp.exp
diff --git a/src/plugins/down-root/Makefile b/src/plugins/down-root/Makefile
deleted file mode 100755
index e66c99a..0000000
--- a/src/plugins/down-root/Makefile
+++ /dev/null
@@ -1,18 +0,0 @@
-#
-# Build the OpenVPN down-root plugin module.
-#
-
-# This directory is where we will look for openvpn-plugin.h
-CPPFLAGS=-I../../../include
-
-CC=gcc
-CFLAGS=-O2 -Wall
-
-down-root.so : down-root.o
-	$(CC) $(CFLAGS) -fPIC -shared $(LDFLAGS) -Wl,-soname,openvpn-down-root.so -o openvpn-down-root.so down-root.o -lc
-
-down-root.o : down-root.c
-	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c down-root.c
-
-clean :
-	-rm -f *.o *.so
diff --git a/src/plugins/down-root/Makefile.am b/src/plugins/down-root/Makefile.am
new file mode 100644
index 0000000..064aa30
--- /dev/null
+++ b/src/plugins/down-root/Makefile.am
@@ -0,0 +1,23 @@
+#
+#  OpenVPN (TM) Down Root Plugin -- OpenVPN Plugin
+#
+#  Copyright (C) 2012      Alon Bar-Lev <alon.barlev@...277...>
+#
+
+MAINTAINERCLEANFILES = \
+	$(srcdir)/Makefile.in
+
+AM_CFLAGS = \
+	-I$(top_srcdir)/include
+
+if ENABLE_PLUGIN_DOWN_ROOT
+plugin_LTLIBRARIES = openvpn-plugin-down-root.la
+dist_doc_DATA = README.down-root
+endif
+
+openvpn_plugin_down_root_la_SOURCES = \
+	down-root.c \
+	down-root.exports
+openvpn_plugin_down_root_la_LDFLAGS = $(AM_LDFLAGS) \
+	-export-symbols "$(srcdir)/down-root.exports" \
+	-module -shared -avoid-version -no-undefined
diff --git a/src/plugins/down-root/README b/src/plugins/down-root/README
deleted file mode 100644
index d337ffe..0000000
--- a/src/plugins/down-root/README
+++ /dev/null
@@ -1,29 +0,0 @@
-down-root -- an OpenVPN Plugin Module
-
-SYNOPSIS
-
-The down-root module allows an OpenVPN configuration to
-call a down script with root privileges, even when privileges
-have been dropped using --user/--group/--chroot.
-
-This module uses a split privilege execution model which will
-fork() before OpenVPN drops root privileges, at the point where
-the --up script is usually called.  The module will then remain
-in a wait state until it receives a message from OpenVPN via
-pipe to execute the down script.  Thus, the down script will be
-run in the same execution environment as the up script.
-
-BUILD
-
-Build this module with the "make" command.  The plugin
-module will be named openvpn-down-root.so
-
-USAGE
-
-To use this module, add to your OpenVPN config file:
-
-  plugin openvpn-down-root.so "command ..."
-
-CAVEATS
-
-This module will only work on *nix systems, not Windows.
diff --git a/src/plugins/down-root/README.down-root b/src/plugins/down-root/README.down-root
new file mode 100644
index 0000000..d337ffe
--- /dev/null
+++ b/src/plugins/down-root/README.down-root
@@ -0,0 +1,29 @@
+down-root -- an OpenVPN Plugin Module
+
+SYNOPSIS
+
+The down-root module allows an OpenVPN configuration to
+call a down script with root privileges, even when privileges
+have been dropped using --user/--group/--chroot.
+
+This module uses a split privilege execution model which will
+fork() before OpenVPN drops root privileges, at the point where
+the --up script is usually called.  The module will then remain
+in a wait state until it receives a message from OpenVPN via
+pipe to execute the down script.  Thus, the down script will be
+run in the same execution environment as the up script.
+
+BUILD
+
+Build this module with the "make" command.  The plugin
+module will be named openvpn-down-root.so
+
+USAGE
+
+To use this module, add to your OpenVPN config file:
+
+  plugin openvpn-down-root.so "command ..."
+
+CAVEATS
+
+This module will only work on *nix systems, not Windows.
diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
index fced23b..d51d0e5 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -26,6 +26,10 @@
  * OpenVPN plugin module to do privileged down-script execution.
  */
 
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
@@ -37,7 +41,7 @@
 #include <signal.h>
 #include <syslog.h>
 
-#include "openvpn-plugin.h"
+#include <openvpn-plugin.h>
 
 #define DEBUG(verb) ((verb) >= 7)
 
diff --git a/src/plugins/down-root/down-root.exports b/src/plugins/down-root/down-root.exports
new file mode 100644
index 0000000..b07937c
--- /dev/null
+++ b/src/plugins/down-root/down-root.exports
@@ -0,0 +1,4 @@
+openvpn_plugin_open_v1
+openvpn_plugin_func_v1
+openvpn_plugin_close_v1
+openvpn_plugin_abort_v1
diff --git a/src/plugins/examples/README b/src/plugins/examples/README
deleted file mode 100644
index 4400cd3..0000000
--- a/src/plugins/examples/README
+++ /dev/null
@@ -1,16 +0,0 @@
-OpenVPN plugin examples.
-
-Examples provided:
-
-simple.c -- using the --auth-user-pass-verify callback, verify
-            that the username/password is "foo"/"bar".
-
-To build:
-
-  ./build simple (Linux/BSD/etc.)
-  ./winbuild simple (MinGW on Windows)
-
-To use in OpenVPN, add to config file:
-
-  plugin simple.so (Linux/BSD/etc.)
-  plugin simple.dll (MinGW on Windows)
diff --git a/src/plugins/examples/build b/src/plugins/examples/build
deleted file mode 100755
index bbb05f7..0000000
--- a/src/plugins/examples/build
+++ /dev/null
@@ -1,15 +0,0 @@
-#!/bin/sh
-
-#
-# Build an OpenVPN plugin module on *nix.  The argument should
-# be the base name of the C source file (without the .c).
-#
-
-# This directory is where we will look for openvpn-plugin.h
-CPPFLAGS="${CPPFLAGS:--I../../..}"
-
-CC="${CC:-gcc}"
-CFLAGS="${CFLAGS:--O2 -Wall -g}"
-
-$CC $CPPFLAGS $CFLAGS -fPIC -c $1.c && \
-$CC $CFLAGS -fPIC -shared $LDFLAGS -Wl,-soname,$1.so -o $1.so $1.o -lc
diff --git a/src/plugins/examples/log.c b/src/plugins/examples/log.c
deleted file mode 100644
index 1cc4650..0000000
--- a/src/plugins/examples/log.c
+++ /dev/null
@@ -1,184 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-/*
- * This plugin is similar to simple.c, except it also logs extra information
- * to stdout for every plugin method called by OpenVPN.
- *
- * See the README file for build instructions.
- */
-
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-
-#include "openvpn-plugin.h"
-
-/*
- * Our context, where we keep our state.
- */
-struct plugin_context {
-  const char *username;
-  const char *password;
-};
-
-/*
- * Given an environmental variable name, search
- * the envp array for its value, returning it
- * if found or NULL otherwise.
- */
-static const char *
-get_env (const char *name, const char *envp[])
-{
-  if (envp)
-    {
-      int i;
-      const int namelen = strlen (name);
-      for (i = 0; envp[i]; ++i)
-	{
-	  if (!strncmp (envp[i], name, namelen))
-	    {
-	      const char *cp = envp[i] + namelen;
-	      if (*cp == '=')
-		return cp + 1;
-	    }
-	}
-    }
-  return NULL;
-}
-
-OPENVPN_EXPORT openvpn_plugin_handle_t
-openvpn_plugin_open_v1 (unsigned int *type_mask, const char *argv[], const char *envp[])
-{
-  struct plugin_context *context;
-
-  /*
-   * Allocate our context
-   */
-  context = (struct plugin_context *) calloc (1, sizeof (struct plugin_context));
-
-  /*
-   * Set the username/password we will require.
-   */
-  context->username = "foo";
-  context->password = "bar";
-
-  /*
-   * Which callbacks to intercept.
-   */
-  *type_mask =
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_UP) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_DOWN) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_ROUTE_UP) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_IPCHANGE) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_TLS_VERIFY) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_CLIENT_CONNECT_V2) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_CLIENT_DISCONNECT) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_LEARN_ADDRESS) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_TLS_FINAL);
-
-  return (openvpn_plugin_handle_t) context;
-}
-
-void
-show (const int type, const char *argv[], const char *envp[])
-{
-  size_t i;
-  switch (type)
-    {
-    case OPENVPN_PLUGIN_UP:
-      printf ("OPENVPN_PLUGIN_UP\n");
-      break;
-    case OPENVPN_PLUGIN_DOWN:
-      printf ("OPENVPN_PLUGIN_DOWN\n");
-      break;
-    case OPENVPN_PLUGIN_ROUTE_UP:
-      printf ("OPENVPN_PLUGIN_ROUTE_UP\n");
-      break;
-    case OPENVPN_PLUGIN_IPCHANGE:
-      printf ("OPENVPN_PLUGIN_IPCHANGE\n");
-      break;
-    case OPENVPN_PLUGIN_TLS_VERIFY:
-      printf ("OPENVPN_PLUGIN_TLS_VERIFY\n");
-      break;
-    case OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY:
-      printf ("OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY\n");
-      break;
-    case OPENVPN_PLUGIN_CLIENT_CONNECT_V2:
-      printf ("OPENVPN_PLUGIN_CLIENT_CONNECT_V2\n");
-      break;
-    case OPENVPN_PLUGIN_CLIENT_DISCONNECT:
-      printf ("OPENVPN_PLUGIN_CLIENT_DISCONNECT\n");
-      break;
-    case OPENVPN_PLUGIN_LEARN_ADDRESS:
-      printf ("OPENVPN_PLUGIN_LEARN_ADDRESS\n");
-      break;
-    case OPENVPN_PLUGIN_TLS_FINAL:
-      printf ("OPENVPN_PLUGIN_TLS_FINAL\n");
-      break;
-    default:
-      printf ("OPENVPN_PLUGIN_?\n");
-      break;
-    }
-
-  printf ("ARGV\n");
-  for (i = 0; argv[i] != NULL; ++i)
-    printf ("%d '%s'\n", (int)i, argv[i]);
-
-  printf ("ENVP\n");
-  for (i = 0; envp[i] != NULL; ++i)
-    printf ("%d '%s'\n", (int)i, envp[i]);
-}
-
-OPENVPN_EXPORT int
-openvpn_plugin_func_v1 (openvpn_plugin_handle_t handle, const int type, const char *argv[], const char *envp[])
-{
-  struct plugin_context *context = (struct plugin_context *) handle;
-
-  show (type, argv, envp);
-
-  /* check entered username/password against what we require */
-  if (type == OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)
-    {
-      /* get username/password from envp string array */
-      const char *username = get_env ("username", envp);
-      const char *password = get_env ("password", envp);
-
-      if (username && !strcmp (username, context->username)
-	  && password && !strcmp (password, context->password))
-	return OPENVPN_PLUGIN_FUNC_SUCCESS;
-      else
-	return OPENVPN_PLUGIN_FUNC_ERROR;
-    }
-  else
-    return OPENVPN_PLUGIN_FUNC_SUCCESS;
-}
-
-OPENVPN_EXPORT void
-openvpn_plugin_close_v1 (openvpn_plugin_handle_t handle)
-{
-  struct plugin_context *context = (struct plugin_context *) handle;
-  free (context);
-}
diff --git a/src/plugins/examples/log_v3.c b/src/plugins/examples/log_v3.c
deleted file mode 100644
index 742c756..0000000
--- a/src/plugins/examples/log_v3.c
+++ /dev/null
@@ -1,247 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2009 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010 David Sommerseth <dazo@...384...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-/*
- * This plugin is similar to simple.c, except it also logs extra information
- * to stdout for every plugin method called by OpenVPN.  The only difference
- * between this (log_v3.c) and log.c is that this module uses the v3 plug-in
- * API.
- *
- * See the README file for build instructions.
- */
-
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-
-#define ENABLE_SSL
-
-#include "openvpn-plugin.h"
-
-/*
- * Our context, where we keep our state.
- */
-struct plugin_context {
-  const char *username;
-  const char *password;
-};
-
-/*
- * Given an environmental variable name, search
- * the envp array for its value, returning it
- * if found or NULL otherwise.
- */
-static const char *
-get_env (const char *name, const char *envp[])
-{
-  if (envp)
-    {
-      int i;
-      const int namelen = strlen (name);
-      for (i = 0; envp[i]; ++i)
-	{
-	  if (!strncmp (envp[i], name, namelen))
-	    {
-	      const char *cp = envp[i] + namelen;
-	      if (*cp == '=')
-		return cp + 1;
-	    }
-	}
-    }
-  return NULL;
-}
-
-OPENVPN_EXPORT int
-openvpn_plugin_open_v3 (const int v3structver,
-                        struct openvpn_plugin_args_open_in const *args,
-                        struct openvpn_plugin_args_open_return *ret)
-{
-  struct plugin_context *context = NULL;
-
-  /* Check that we are API compatible */
-  if( v3structver != OPENVPN_PLUGINv3_STRUCTVER ) {
-    return OPENVPN_PLUGIN_FUNC_ERROR;
-  }
-
-  /*  Which callbacks to intercept.  */
-  ret->type_mask =
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_UP) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_DOWN) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_ROUTE_UP) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_IPCHANGE) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_TLS_VERIFY) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_CLIENT_CONNECT_V2) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_CLIENT_DISCONNECT) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_LEARN_ADDRESS) |
-    OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_TLS_FINAL);
-
-
-  /* Allocate our context */
-  context = (struct plugin_context *) calloc (1, sizeof (struct plugin_context));
-
-  /* Set the username/password we will require. */
-  context->username = "foo";
-  context->password = "bar";
-
-  /* Point the global context handle to our newly created context */
-  ret->handle = (void *) context;
-
-  return OPENVPN_PLUGIN_FUNC_SUCCESS;
-}
-
-void
-show (const int type, const char *argv[], const char *envp[])
-{
-  size_t i;
-  switch (type)
-    {
-    case OPENVPN_PLUGIN_UP:
-      printf ("OPENVPN_PLUGIN_UP\n");
-      break;
-    case OPENVPN_PLUGIN_DOWN:
-      printf ("OPENVPN_PLUGIN_DOWN\n");
-      break;
-    case OPENVPN_PLUGIN_ROUTE_UP:
-      printf ("OPENVPN_PLUGIN_ROUTE_UP\n");
-      break;
-    case OPENVPN_PLUGIN_IPCHANGE:
-      printf ("OPENVPN_PLUGIN_IPCHANGE\n");
-      break;
-    case OPENVPN_PLUGIN_TLS_VERIFY:
-      printf ("OPENVPN_PLUGIN_TLS_VERIFY\n");
-      break;
-    case OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY:
-      printf ("OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY\n");
-      break;
-    case OPENVPN_PLUGIN_CLIENT_CONNECT_V2:
-      printf ("OPENVPN_PLUGIN_CLIENT_CONNECT_V2\n");
-      break;
-    case OPENVPN_PLUGIN_CLIENT_DISCONNECT:
-      printf ("OPENVPN_PLUGIN_CLIENT_DISCONNECT\n");
-      break;
-    case OPENVPN_PLUGIN_LEARN_ADDRESS:
-      printf ("OPENVPN_PLUGIN_LEARN_ADDRESS\n");
-      break;
-    case OPENVPN_PLUGIN_TLS_FINAL:
-      printf ("OPENVPN_PLUGIN_TLS_FINAL\n");
-      break;
-    default:
-      printf ("OPENVPN_PLUGIN_?\n");
-      break;
-    }
-
-  printf ("ARGV\n");
-  for (i = 0; argv[i] != NULL; ++i)
-    printf ("%d '%s'\n", (int)i, argv[i]);
-
-  printf ("ENVP\n");
-  for (i = 0; envp[i] != NULL; ++i)
-    printf ("%d '%s'\n", (int)i, envp[i]);
-}
-
-static void
-x509_print_info (X509 *x509crt)
-{
-  int i, n;
-  int fn_nid;
-  ASN1_OBJECT *fn;
-  ASN1_STRING *val;
-  X509_NAME *x509_name;
-  X509_NAME_ENTRY *ent;
-  const char *objbuf;
-  unsigned char *buf;
-
-  x509_name = X509_get_subject_name (x509crt);
-  n = X509_NAME_entry_count (x509_name);
-  for (i = 0; i < n; ++i)
-    {
-      ent = X509_NAME_get_entry (x509_name, i);
-      if (!ent)
-	continue;
-      fn = X509_NAME_ENTRY_get_object (ent);
-      if (!fn)
-	continue;
-      val = X509_NAME_ENTRY_get_data (ent);
-      if (!val)
-	continue;
-      fn_nid = OBJ_obj2nid (fn);
-      if (fn_nid == NID_undef)
-	continue;
-      objbuf = OBJ_nid2sn (fn_nid);
-      if (!objbuf)
-	continue;
-      buf = (unsigned char *)1; /* bug in OpenSSL 0.9.6b ASN1_STRING_to_UTF8 requires this workaround */
-      if (ASN1_STRING_to_UTF8 (&buf, val) <= 0)
-	continue;
-
-      printf("X509 %s: %s\n", objbuf, (char *)buf);
-      OPENSSL_free (buf);
-    }
-}
-
-
-
-OPENVPN_EXPORT int
-openvpn_plugin_func_v3 (const int version,
-                        struct openvpn_plugin_args_func_in const *args,
-                        struct openvpn_plugin_args_func_return *retptr)
-{
-  struct plugin_context *context = (struct plugin_context *) args->handle;
-
-  printf("\nopenvpn_plugin_func_v3() :::::>> ");
-  show (args->type, args->argv, args->envp);
-
-  /* Dump some X509 information if we're in the TLS_VERIFY phase */
-  if ((args->type == OPENVPN_PLUGIN_TLS_VERIFY) && args->current_cert ) {
-    printf("---- X509 Subject information ----\n");
-    printf("Certificate depth: %i\n", args->current_cert_depth);
-    x509_print_info(args->current_cert);
-    printf("----------------------------------\n");
-  }
-
-  /* check entered username/password against what we require */
-  if (args->type == OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)
-    {
-      /* get username/password from envp string array */
-      const char *username = get_env ("username", args->envp);
-      const char *password = get_env ("password", args->envp);
-
-      if (username && !strcmp (username, context->username)
-	  && password && !strcmp (password, context->password))
-	return OPENVPN_PLUGIN_FUNC_SUCCESS;
-      else
-	return OPENVPN_PLUGIN_FUNC_ERROR;
-    }
-  else
-    return OPENVPN_PLUGIN_FUNC_SUCCESS;
-}
-
-OPENVPN_EXPORT void
-openvpn_plugin_close_v1 (openvpn_plugin_handle_t handle)
-{
-  struct plugin_context *context = (struct plugin_context *) handle;
-  free (context);
-}
diff --git a/src/plugins/examples/simple.c b/src/plugins/examples/simple.c
deleted file mode 100644
index f26d89f..0000000
--- a/src/plugins/examples/simple.c
+++ /dev/null
@@ -1,120 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-/*
- * This file implements a simple OpenVPN plugin module which
- * will examine the username/password provided by a client,
- * and make an accept/deny determination.  Will run
- * on Windows or *nix.
- *
- * See the README file for build instructions.
- */
-
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-
-#include "openvpn-plugin.h"
-
-/*
- * Our context, where we keep our state.
- */
-struct plugin_context {
-  const char *username;
-  const char *password;
-};
-
-/*
- * Given an environmental variable name, search
- * the envp array for its value, returning it
- * if found or NULL otherwise.
- */
-static const char *
-get_env (const char *name, const char *envp[])
-{
-  if (envp)
-    {
-      int i;
-      const int namelen = strlen (name);
-      for (i = 0; envp[i]; ++i)
-	{
-	  if (!strncmp (envp[i], name, namelen))
-	    {
-	      const char *cp = envp[i] + namelen;
-	      if (*cp == '=')
-		return cp + 1;
-	    }
-	}
-    }
-  return NULL;
-}
-
-OPENVPN_EXPORT openvpn_plugin_handle_t
-openvpn_plugin_open_v1 (unsigned int *type_mask, const char *argv[], const char *envp[])
-{
-  struct plugin_context *context;
-
-  /*
-   * Allocate our context
-   */
-  context = (struct plugin_context *) calloc (1, sizeof (struct plugin_context));
-
-  /*
-   * Set the username/password we will require.
-   */
-  context->username = "foo";
-  context->password = "bar";
-
-  /*
-   * We are only interested in intercepting the
-   * --auth-user-pass-verify callback.
-   */
-  *type_mask = OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY);
-
-  return (openvpn_plugin_handle_t) context;
-}
-
-OPENVPN_EXPORT int
-openvpn_plugin_func_v1 (openvpn_plugin_handle_t handle, const int type, const char *argv[], const char *envp[])
-{
-  struct plugin_context *context = (struct plugin_context *) handle;
-
-  /* get username/password from envp string array */
-  const char *username = get_env ("username", envp);
-  const char *password = get_env ("password", envp);
-
-  /* check entered username/password against what we require */
-  if (username && !strcmp (username, context->username)
-      && password && !strcmp (password, context->password))
-    return OPENVPN_PLUGIN_FUNC_SUCCESS;
-  else
-    return OPENVPN_PLUGIN_FUNC_ERROR;
-}
-
-OPENVPN_EXPORT void
-openvpn_plugin_close_v1 (openvpn_plugin_handle_t handle)
-{
-  struct plugin_context *context = (struct plugin_context *) handle;
-  free (context);
-}
diff --git a/src/plugins/examples/simple.def b/src/plugins/examples/simple.def
deleted file mode 100755
index a87507d..0000000
--- a/src/plugins/examples/simple.def
+++ /dev/null
@@ -1,6 +0,0 @@
-LIBRARY   OpenVPN_PLUGIN_SAMPLE
-DESCRIPTION "Sample OpenVPN plug-in module."
-EXPORTS
-   openvpn_plugin_open_v1   @1
-   openvpn_plugin_func_v1   @2
-   openvpn_plugin_close_v1  @3
diff --git a/src/plugins/examples/winbuild b/src/plugins/examples/winbuild
deleted file mode 100755
index decf05f..0000000
--- a/src/plugins/examples/winbuild
+++ /dev/null
@@ -1,18 +0,0 @@
-#
-# Build an OpenVPN plugin module on Windows/MinGW.
-# The argument should be the base name of the C source file
-# (without the .c).
-#
-
-# This directory is where we will look for openvpn-plugin.h
-INCLUDE="-I../../../include"
-
-CC_FLAGS="-O2 -Wall"
-
-gcc -DBUILD_DLL $CC_FLAGS $INCLUDE -c $1.c
-gcc --disable-stdcall-fixup -mdll -DBUILD_DLL -o junk.tmp -Wl,--base-file,base.tmp $1.o
-rm junk.tmp
-dlltool --dllname $1.dll --base-file base.tmp --output-exp temp.exp --input-def $1.def
-rm base.tmp
-gcc --enable-stdcall-fixup -mdll -DBUILD_DLL -o $1.dll $1.o -Wl,temp.exp
-rm temp.exp
-- 
1.7.3.4


