From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:11:44 +0200
Message-Id: <1330546342-17794-15-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 14/52] build: rename plugin directory to
	plugins
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>

This to avoid conflit with plugin.c rules

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 Makefile.am                   |    3 +-
 openvpn.spec.in               |   16 +-
 plugin/README                 |   47 ---
 plugin/auth-pam/.svnignore    |    1 -
 plugin/auth-pam/Makefile      |   30 --
 plugin/auth-pam/README        |   74 ----
 plugin/auth-pam/auth-pam.c    |  804 -----------------------------------------
 plugin/auth-pam/pamdl.c       |  180 ---------
 plugin/auth-pam/pamdl.h       |    7 -
 plugin/defer/README           |   16 -
 plugin/defer/build            |   14 -
 plugin/defer/simple.c         |  305 ----------------
 plugin/defer/simple.def       |    6 -
 plugin/defer/winbuild         |   18 -
 plugin/down-root/Makefile     |   17 -
 plugin/down-root/README       |   29 --
 plugin/down-root/down-root.c  |  553 ----------------------------
 plugin/examples/README        |   16 -
 plugin/examples/build         |   14 -
 plugin/examples/log.c         |  184 ----------
 plugin/examples/log_v3.c      |  249 -------------
 plugin/examples/simple.c      |  120 ------
 plugin/examples/simple.def    |    6 -
 plugin/examples/winbuild      |   18 -
 plugins/README                |   47 +++
 plugins/auth-pam/.svnignore   |    1 +
 plugins/auth-pam/Makefile     |   30 ++
 plugins/auth-pam/README       |   74 ++++
 plugins/auth-pam/auth-pam.c   |  804 +++++++++++++++++++++++++++++++++++++++++
 plugins/auth-pam/pamdl.c      |  180 +++++++++
 plugins/auth-pam/pamdl.h      |    7 +
 plugins/defer/README          |   16 +
 plugins/defer/build           |   14 +
 plugins/defer/simple.c        |  305 ++++++++++++++++
 plugins/defer/simple.def      |    6 +
 plugins/defer/winbuild        |   18 +
 plugins/down-root/Makefile    |   17 +
 plugins/down-root/README      |   29 ++
 plugins/down-root/down-root.c |  553 ++++++++++++++++++++++++++++
 plugins/examples/README       |   16 +
 plugins/examples/build        |   14 +
 plugins/examples/log.c        |  184 ++++++++++
 plugins/examples/log_v3.c     |  249 +++++++++++++
 plugins/examples/simple.c     |  120 ++++++
 plugins/examples/simple.def   |    6 +
 plugins/examples/winbuild     |   18 +
 46 files changed, 2717 insertions(+), 2718 deletions(-)
 delete mode 100644 plugin/README
 delete mode 100644 plugin/auth-pam/.svnignore
 delete mode 100755 plugin/auth-pam/Makefile
 delete mode 100644 plugin/auth-pam/README
 delete mode 100644 plugin/auth-pam/auth-pam.c
 delete mode 100644 plugin/auth-pam/pamdl.c
 delete mode 100644 plugin/auth-pam/pamdl.h
 delete mode 100644 plugin/defer/README
 delete mode 100755 plugin/defer/build
 delete mode 100644 plugin/defer/simple.c
 delete mode 100755 plugin/defer/simple.def
 delete mode 100755 plugin/defer/winbuild
 delete mode 100755 plugin/down-root/Makefile
 delete mode 100644 plugin/down-root/README
 delete mode 100644 plugin/down-root/down-root.c
 delete mode 100644 plugin/examples/README
 delete mode 100755 plugin/examples/build
 delete mode 100644 plugin/examples/log.c
 delete mode 100644 plugin/examples/log_v3.c
 delete mode 100644 plugin/examples/simple.c
 delete mode 100755 plugin/examples/simple.def
 delete mode 100755 plugin/examples/winbuild
 create mode 100644 plugins/README
 create mode 100644 plugins/auth-pam/.svnignore
 create mode 100755 plugins/auth-pam/Makefile
 create mode 100644 plugins/auth-pam/README
 create mode 100644 plugins/auth-pam/auth-pam.c
 create mode 100644 plugins/auth-pam/pamdl.c
 create mode 100644 plugins/auth-pam/pamdl.h
 create mode 100644 plugins/defer/README
 create mode 100755 plugins/defer/build
 create mode 100644 plugins/defer/simple.c
 create mode 100755 plugins/defer/simple.def
 create mode 100755 plugins/defer/winbuild
 create mode 100755 plugins/down-root/Makefile
 create mode 100644 plugins/down-root/README
 create mode 100644 plugins/down-root/down-root.c
 create mode 100644 plugins/examples/README
 create mode 100755 plugins/examples/build
 create mode 100644 plugins/examples/log.c
 create mode 100644 plugins/examples/log_v3.c
 create mode 100644 plugins/examples/simple.c
 create mode 100755 plugins/examples/simple.def
 create mode 100755 plugins/examples/winbuild

diff --git a/Makefile.am b/Makefile.am
index 26b80f3..a1c210e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -24,7 +24,6 @@
 #
 
 LDADD = @LIBOBJS@
-.PHONY: plugin
 
 # This option prevents autoreconf from overriding our COPYING and
 # INSTALL targets:
@@ -49,7 +48,7 @@ EXTRA_DIST = \
 	tap-win32 \
 	contrib \
 	debug \
-	plugin \
+	plugins \
 	win
 
 SUBDIRS = \
diff --git a/openvpn.spec.in b/openvpn.spec.in
index c42e7c6..9a45c79 100644
--- a/openvpn.spec.in
+++ b/openvpn.spec.in
@@ -103,13 +103,13 @@ and portability to most major OS platforms.
 %__make
 
 # Build down-root plugin
-pushd plugin/down-root
+pushd plugins/down-root
 %__make
 popd
 
 # Build auth-pam plugin
 %if %{build_auth_pam}
-pushd plugin/auth-pam
+pushd plugins/auth-pam
 %__make
 popd
 %endif
@@ -153,16 +153,16 @@ popd
 # Install the plugins
 #
 
-%__mkdir_p %{buildroot}%{_datadir}/%{name}/plugin/lib
+%__mkdir_p %{buildroot}%{_datadir}/%{name}/plugins/lib
 
 for pi in auth-pam down-root; do
-  %__mv -f plugin/$pi/README plugin/README.$pi
-  if [ -e plugin/$pi/openvpn-$pi.so ]; then
-    %__install -c -m 755 plugin/$pi/openvpn-$pi.so %{buildroot}%{_datadir}/openvpn/plugin/lib/openvpn-$pi.so
+  %__mv -f plugins/$pi/README plugins/README.$pi
+  if [ -e plugins/$pi/openvpn-$pi.so ]; then
+    %__install -c -m 755 plugins/$pi/openvpn-$pi.so %{buildroot}%{_datadir}/openvpn/plugins/lib/openvpn-$pi.so
   fi
 done
 
-%__mv -f plugin/README plugin/README.plugins
+%__mv -f plugins/README plugins/README.plugins
 
 #
 # Clean section
@@ -222,7 +222,7 @@ fi
 %endif
 
 # Install extra %doc stuff
-%doc contrib/ easy-rsa/ sample-*/ plugin/README.*
+%doc contrib/ easy-rsa/ sample-*/ plugins/README.*
 
 %changelog
 * Thu Jul 30 2009 David Sommerseth <dazo@...384...>
diff --git a/plugin/README b/plugin/README
deleted file mode 100644
index 6e490c5..0000000
--- a/plugin/README
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
diff --git a/plugin/auth-pam/.svnignore b/plugin/auth-pam/.svnignore
deleted file mode 100644
index 140f8cf..0000000
--- a/plugin/auth-pam/.svnignore
+++ /dev/null
@@ -1 +0,0 @@
-*.so
diff --git a/plugin/auth-pam/Makefile b/plugin/auth-pam/Makefile
deleted file mode 100755
index e69fe3f..0000000
--- a/plugin/auth-pam/Makefile
+++ /dev/null
@@ -1,30 +0,0 @@
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
-INCLUDE=-I../..
-
-CC_FLAGS=-O2 -Wall -DDLOPEN_PAM=$(DLOPEN_PAM)
-
-openvpn-auth-pam.so : auth-pam.o pamdl.o
-	gcc ${CC_FLAGS} -fPIC -shared -Wl,-soname,openvpn-auth-pam.so -o openvpn-auth-pam.so auth-pam.o pamdl.o -lc $(LIBPAM)
-
-auth-pam.o : auth-pam.c pamdl.h
-	gcc ${CC_FLAGS} -fPIC -c ${INCLUDE} auth-pam.c
-
-pamdl.o : pamdl.c pamdl.h
-	gcc ${CC_FLAGS} -fPIC -c ${INCLUDE} pamdl.c
-
-clean :
-	rm -f *.o *.so
diff --git a/plugin/auth-pam/README b/plugin/auth-pam/README
deleted file mode 100644
index e123690..0000000
--- a/plugin/auth-pam/README
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
diff --git a/plugin/auth-pam/auth-pam.c b/plugin/auth-pam/auth-pam.c
deleted file mode 100644
index e52f632..0000000
--- a/plugin/auth-pam/auth-pam.c
+++ /dev/null
@@ -1,804 +0,0 @@
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
- * OpenVPN plugin module to do PAM authentication using a split
- * privilege model.
- */
-
-#if DLOPEN_PAM
-#include <dlfcn.h>
-#include "pamdl.h"
-#else
-#include <security/pam_appl.h>
-#endif
-
-#include <stdio.h>
-#include <string.h>
-#include <ctype.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <sys/wait.h>
-#include <fcntl.h>
-#include <signal.h>
-#include <syslog.h>
-
-#include "openvpn-plugin.h"
-
-#define DEBUG(verb) ((verb) >= 4)
-
-/* Command codes for foreground -> background communication */
-#define COMMAND_VERIFY 0
-#define COMMAND_EXIT   1
-
-/* Response codes for background -> foreground communication */
-#define RESPONSE_INIT_SUCCEEDED   10
-#define RESPONSE_INIT_FAILED      11
-#define RESPONSE_VERIFY_SUCCEEDED 12
-#define RESPONSE_VERIFY_FAILED    13
-
-/*
- * Plugin state, used by foreground
- */
-struct auth_pam_context
-{
-  /* Foreground's socket to background process */
-  int foreground_fd;
-
-  /* Process ID of background process */
-  pid_t background_pid;
-
-  /* Verbosity level of OpenVPN */
-  int verb;
-};
-
-/*
- * Name/Value pairs for conversation function.
- * Special Values:
- *
- *  "USERNAME" -- substitute client-supplied username
- *  "PASSWORD" -- substitute client-specified password
- *  "COMMONNAME" -- substitute client certificate common name
- */
-
-#define N_NAME_VALUE 16
-
-struct name_value {
-  const char *name;
-  const char *value;
-};
-
-struct name_value_list {
-  int len;
-  struct name_value data[N_NAME_VALUE];
-};
-
-/*
- * Used to pass the username/password
- * to the PAM conversation function.
- */
-struct user_pass {
-  int verb;
-
-  char username[128];
-  char password[128];
-  char common_name[128];
-
-  const struct name_value_list *name_value_list;
-};
-
-/* Background process function */
-static void pam_server (int fd, const char *service, int verb, const struct name_value_list *name_value_list);
-
-/*  Read 'tosearch', replace all occurences of 'searchfor' with 'replacewith' and return
- *  a pointer to the NEW string.  Does not modify the input strings.  Will not enter an
- *  infinite loop with clever 'searchfor' and 'replacewith' strings.
- *  Daniel Johnson - Progman2000@...1085... / djohnson@...1167...
- */
-static char *
-searchandreplace(const char *tosearch, const char *searchfor, const char *replacewith)
-{
-  const char *searching=tosearch;
-  char *scratch;
-  char temp[strlen(tosearch)*10];
-  temp[0]=0;
-
-  if (!tosearch || !searchfor || !replacewith) return 0;
-  if (!strlen(tosearch) || !strlen(searchfor) || !strlen(replacewith)) return 0;
-
-  scratch = strstr(searching,searchfor);
-  if (!scratch) return strdup(tosearch);
-
-  while (scratch) {
-    strncat(temp,searching,scratch-searching);
-    strcat(temp,replacewith);
-
-    searching=scratch+strlen(searchfor);
-    scratch = strstr(searching,searchfor);
-  }
-  return strdup(temp);
-}
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
-/*
- * Return the length of a string array
- */
-static int
-string_array_len (const char *array[])
-{
-  int i = 0;
-  if (array)
-    {
-      while (array[i])
-	++i;
-    }
-  return i;
-}
-
-/*
- * Socket read/write functions.
- */
-
-static int
-recv_control (int fd)
-{
-  unsigned char c;
-  const ssize_t size = read (fd, &c, sizeof (c));
-  if (size == sizeof (c))
-    return c;
-  else
-    {
-      /*fprintf (stderr, "AUTH-PAM: DEBUG recv_control.read=%d\n", (int)size);*/
-      return -1;
-    }
-}
-
-static int
-send_control (int fd, int code)
-{
-  unsigned char c = (unsigned char) code;
-  const ssize_t size = write (fd, &c, sizeof (c));
-  if (size == sizeof (c))
-    return (int) size;
-  else
-    return -1;
-}
-
-static int
-recv_string (int fd, char *buffer, int len)
-{
-  if (len > 0)
-    {
-      ssize_t size;
-      memset (buffer, 0, len);
-      size = read (fd, buffer, len);
-      buffer[len-1] = 0;
-      if (size >= 1)
-	return (int)size;
-    }
-  return -1;
-}
-
-static int
-send_string (int fd, const char *string)
-{
-  const int len = strlen (string) + 1;
-  const ssize_t size = write (fd, string, len);
-  if (size == len)
-    return (int) size;
-  else
-    return -1;
-}
-
-#ifdef DO_DAEMONIZE
-
-/*
- * Daemonize if "daemon" env var is true.
- * Preserve stderr across daemonization if
- * "daemon_log_redirect" env var is true.
- */
-static void
-daemonize (const char *envp[])
-{
-  const char *daemon_string = get_env ("daemon", envp);
-  if (daemon_string && daemon_string[0] == '1')
-    {
-      const char *log_redirect = get_env ("daemon_log_redirect", envp);
-      int fd = -1;
-      if (log_redirect && log_redirect[0] == '1')
-	fd = dup (2);
-      if (daemon (0, 0) < 0)
-	{
-	  fprintf (stderr, "AUTH-PAM: daemonization failed\n");
-	}
-      else if (fd >= 3)
-	{
-	  dup2 (fd, 2);
-	  close (fd);
-	}
-    }
-}
-
-#endif
-
-/*
- * Close most of parent's fds.
- * Keep stdin/stdout/stderr, plus one
- * other fd which is presumed to be
- * our pipe back to parent.
- * Admittedly, a bit of a kludge,
- * but posix doesn't give us a kind
- * of FD_CLOEXEC which will stop
- * fds from crossing a fork().
- */
-static void
-close_fds_except (int keep)
-{
-  int i;
-  closelog ();
-  for (i = 3; i <= 100; ++i)
-    {
-      if (i != keep)
-	close (i);
-    }
-}
-
-/*
- * Usually we ignore signals, because our parent will
- * deal with them.
- */
-static void
-set_signals (void)
-{
-  signal (SIGTERM, SIG_DFL);
-
-  signal (SIGINT, SIG_IGN);
-  signal (SIGHUP, SIG_IGN);
-  signal (SIGUSR1, SIG_IGN);
-  signal (SIGUSR2, SIG_IGN);
-  signal (SIGPIPE, SIG_IGN);
-}
-
-/*
- * Return 1 if query matches match.
- */
-static int
-name_value_match (const char *query, const char *match)
-{
-  while (!isalnum (*query))
-    {
-      if (*query == '\0')
-	return 0;
-      ++query;
-    }
-  return strncasecmp (match, query, strlen (match)) == 0;
-}
-
-OPENVPN_EXPORT openvpn_plugin_handle_t
-openvpn_plugin_open_v1 (unsigned int *type_mask, const char *argv[], const char *envp[])
-{
-  pid_t pid;
-  int fd[2];
-
-  struct auth_pam_context *context;
-  struct name_value_list name_value_list;
-
-  const int base_parms = 2;
-
-  /*
-   * Allocate our context
-   */
-  context = (struct auth_pam_context *) calloc (1, sizeof (struct auth_pam_context));
-  if (!context)
-    goto error;
-  context->foreground_fd = -1;
-
-  /*
-   * Intercept the --auth-user-pass-verify callback.
-   */
-  *type_mask = OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY);
-
-  /*
-   * Make sure we have two string arguments: the first is the .so name,
-   * the second is the PAM service type.
-   */
-  if (string_array_len (argv) < base_parms)
-    {
-      fprintf (stderr, "AUTH-PAM: need PAM service parameter\n");
-      goto error;
-    }
-
-  /*
-   * See if we have optional name/value pairs to match against
-   * PAM module queried fields in the conversation function.
-   */
-  name_value_list.len = 0;
-  if (string_array_len (argv) > base_parms)
-    {
-      const int nv_len = string_array_len (argv) - base_parms;
-      int i;
-
-      if ((nv_len & 1) == 1 || (nv_len / 2) > N_NAME_VALUE)
-	{
-	  fprintf (stderr, "AUTH-PAM: bad name/value list length\n");
-	  goto error;
-	}
-
-      name_value_list.len = nv_len / 2;
-      for (i = 0; i < name_value_list.len; ++i)
-	{
-	  const int base = base_parms + i * 2;
-	  name_value_list.data[i].name = argv[base];
-	  name_value_list.data[i].value = argv[base+1];
-	}
-    }
-
-  /*
-   * Get verbosity level from environment
-   */
-  {
-    const char *verb_string = get_env ("verb", envp);
-    if (verb_string)
-      context->verb = atoi (verb_string);
-  }
-
-  /*
-   * Make a socket for foreground and background processes
-   * to communicate.
-   */
-  if (socketpair (PF_UNIX, SOCK_DGRAM, 0, fd) == -1)
-    {
-      fprintf (stderr, "AUTH-PAM: socketpair call failed\n");
-      goto error;
-    }
-
-  /*
-   * Fork off the privileged process.  It will remain privileged
-   * even after the foreground process drops its privileges.
-   */
-  pid = fork ();
-
-  if (pid)
-    {
-      int status;
-
-      /*
-       * Foreground Process
-       */
-
-      context->background_pid = pid;
-
-      /* close our copy of child's socket */
-      close (fd[1]);
-
-      /* don't let future subprocesses inherit child socket */
-      if (fcntl (fd[0], F_SETFD, FD_CLOEXEC) < 0)
-	fprintf (stderr, "AUTH-PAM: Set FD_CLOEXEC flag on socket file descriptor failed\n");
-
-      /* wait for background child process to initialize */
-      status = recv_control (fd[0]);
-      if (status == RESPONSE_INIT_SUCCEEDED)
-	{
-	  context->foreground_fd = fd[0];
-	  return (openvpn_plugin_handle_t) context;
-	}
-    }
-  else
-    {
-      /*
-       * Background Process
-       */
-
-      /* close all parent fds except our socket back to parent */
-      close_fds_except (fd[1]);
-
-      /* Ignore most signals (the parent will receive them) */
-      set_signals ();
-
-#ifdef DO_DAEMONIZE
-      /* Daemonize if --daemon option is set. */
-      daemonize (envp);
-#endif
-
-      /* execute the event loop */
-      pam_server (fd[1], argv[1], context->verb, &name_value_list);
-
-      close (fd[1]);
-
-      exit (0);
-      return 0; /* NOTREACHED */
-    }
-
- error:
-  if (context)
-    free (context);
-  return NULL;
-}
-
-OPENVPN_EXPORT int
-openvpn_plugin_func_v1 (openvpn_plugin_handle_t handle, const int type, const char *argv[], const char *envp[])
-{
-  struct auth_pam_context *context = (struct auth_pam_context *) handle;
-
-  if (type == OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY && context->foreground_fd >= 0)
-    {
-      /* get username/password from envp string array */
-      const char *username = get_env ("username", envp);
-      const char *password = get_env ("password", envp);
-      const char *common_name = get_env ("common_name", envp) ? get_env ("common_name", envp) : "";
-
-      if (username && strlen (username) > 0 && password)
-	{
-	  if (send_control (context->foreground_fd, COMMAND_VERIFY) == -1
-	      || send_string (context->foreground_fd, username) == -1
-	      || send_string (context->foreground_fd, password) == -1
-             || send_string (context->foreground_fd, common_name) == -1)
-	    {
-	      fprintf (stderr, "AUTH-PAM: Error sending auth info to background process\n");
-	    }
-	  else
-	    {
-	      const int status = recv_control (context->foreground_fd);
-	      if (status == RESPONSE_VERIFY_SUCCEEDED)
-		return OPENVPN_PLUGIN_FUNC_SUCCESS;
-	      if (status == -1)
-		fprintf (stderr, "AUTH-PAM: Error receiving auth confirmation from background process\n");
-	    }
-	}
-    }
-  return OPENVPN_PLUGIN_FUNC_ERROR;
-}
-
-OPENVPN_EXPORT void
-openvpn_plugin_close_v1 (openvpn_plugin_handle_t handle)
-{
-  struct auth_pam_context *context = (struct auth_pam_context *) handle;
-
-  if (DEBUG (context->verb))
-    fprintf (stderr, "AUTH-PAM: close\n");
-
-  if (context->foreground_fd >= 0)
-    {
-      /* tell background process to exit */
-      if (send_control (context->foreground_fd, COMMAND_EXIT) == -1)
-	fprintf (stderr, "AUTH-PAM: Error signaling background process to exit\n");
-
-      /* wait for background process to exit */
-      if (context->background_pid > 0)
-	waitpid (context->background_pid, NULL, 0);
-
-      close (context->foreground_fd);
-      context->foreground_fd = -1;
-    }
-
-  free (context);
-}
-
-OPENVPN_EXPORT void
-openvpn_plugin_abort_v1 (openvpn_plugin_handle_t handle)
-{
-  struct auth_pam_context *context = (struct auth_pam_context *) handle;
-
-  /* tell background process to exit */
-  if (context && context->foreground_fd >= 0)
-    {
-      send_control (context->foreground_fd, COMMAND_EXIT);
-      close (context->foreground_fd);
-      context->foreground_fd = -1;
-    }
-}
-
-/*
- * PAM conversation function
- */
-static int
-my_conv (int n, const struct pam_message **msg_array,
-	 struct pam_response **response_array, void *appdata_ptr)
-{
-  const struct user_pass *up = ( const struct user_pass *) appdata_ptr;
-  struct pam_response *aresp;
-  int i;
-  int ret = PAM_SUCCESS;
-
-  *response_array = NULL;
-
-  if (n <= 0 || n > PAM_MAX_NUM_MSG)
-    return (PAM_CONV_ERR);
-  if ((aresp = calloc (n, sizeof *aresp)) == NULL)
-    return (PAM_BUF_ERR);
-
-  /* loop through each PAM-module query */
-  for (i = 0; i < n; ++i)
-    {
-      const struct pam_message *msg = msg_array[i];
-      aresp[i].resp_retcode = 0;
-      aresp[i].resp = NULL;
-
-      if (DEBUG (up->verb))
-	{
-	  fprintf (stderr, "AUTH-PAM: BACKGROUND: my_conv[%d] query='%s' style=%d\n",
-		   i,
-		   msg->msg ? msg->msg : "NULL",
-		   msg->msg_style);
-	}
-
-      if (up->name_value_list && up->name_value_list->len > 0)
-	{
-	  /* use name/value list match method */
-	  const struct name_value_list *list = up->name_value_list;
-	  int j;
-
-	  /* loop through name/value pairs */
-	  for (j = 0; j < list->len; ++j)
-	    {
-	      const char *match_name = list->data[j].name;
-	      const char *match_value = list->data[j].value;
-
-	      if (name_value_match (msg->msg, match_name))
-		{
-		  /* found name/value match */
-		  aresp[i].resp = NULL;
-
-		  if (DEBUG (up->verb))
-		    fprintf (stderr, "AUTH-PAM: BACKGROUND: name match found, query/match-string ['%s', '%s'] = '%s'\n",
-			     msg->msg,
-			     match_name,
-			     match_value);
-
-		  if (strstr(match_value, "USERNAME"))
-		    aresp[i].resp = searchandreplace(match_value, "USERNAME", up->username);
-		  else if (strstr(match_value, "PASSWORD"))
-		    aresp[i].resp = searchandreplace(match_value, "PASSWORD", up->password);
-		  else if (strstr(match_value, "COMMONNAME"))
-		    aresp[i].resp = searchandreplace(match_value, "COMMONNAME", up->common_name);
-		  else
-		    aresp[i].resp = strdup (match_value);
-
-		  if (aresp[i].resp == NULL)
-		    ret = PAM_CONV_ERR;
-		  break;
-		}
-	    }
-
-	  if (j == list->len)
-	    ret = PAM_CONV_ERR;
-	}
-      else
-	{
-	  /* use PAM_PROMPT_ECHO_x hints */
-	  switch (msg->msg_style)
-	    {
-	    case PAM_PROMPT_ECHO_OFF:
-	      aresp[i].resp = strdup (up->password);
-	      if (aresp[i].resp == NULL)
-		ret = PAM_CONV_ERR;
-	      break;
-
-	    case PAM_PROMPT_ECHO_ON:
-	      aresp[i].resp = strdup (up->username);
-	      if (aresp[i].resp == NULL)
-		ret = PAM_CONV_ERR;
-	      break;
-
-	    case PAM_ERROR_MSG:
-	    case PAM_TEXT_INFO:
-	      break;
-
-	    default:
-	      ret = PAM_CONV_ERR;
-	      break;
-	    }
-	}
-    }
-
-  if (ret == PAM_SUCCESS)
-    *response_array = aresp;
-  return ret;
-}
-
-/*
- * Return 1 if authenticated and 0 if failed.
- * Called once for every username/password
- * to be authenticated.
- */
-static int
-pam_auth (const char *service, const struct user_pass *up)
-{
-  struct pam_conv conv;
-  pam_handle_t *pamh = NULL;
-  int status = PAM_SUCCESS;
-  int ret = 0;
-  const int name_value_list_provided = (up->name_value_list && up->name_value_list->len > 0);
-
-  /* Initialize PAM */
-  conv.conv = my_conv;
-  conv.appdata_ptr = (void *)up;
-  status = pam_start (service, name_value_list_provided ? NULL : up->username, &conv, &pamh);
-  if (status == PAM_SUCCESS)
-    {
-      /* Call PAM to verify username/password */
-      status = pam_authenticate(pamh, 0);
-      if (status == PAM_SUCCESS)
-	status = pam_acct_mgmt (pamh, 0);
-      if (status == PAM_SUCCESS)
-	ret = 1;
-
-      /* Output error message if failed */
-      if (!ret)
-	{
-	  fprintf (stderr, "AUTH-PAM: BACKGROUND: user '%s' failed to authenticate: %s\n",
-		   up->username,
-		   pam_strerror (pamh, status));
-	}
-
-      /* Close PAM */
-      pam_end (pamh, status);      
-    }
-
-  return ret;
-}
-
-/*
- * Background process -- runs with privilege.
- */
-static void
-pam_server (int fd, const char *service, int verb, const struct name_value_list *name_value_list)
-{
-  struct user_pass up;
-  int command;
-#if DLOPEN_PAM
-  static const char pam_so[] = "libpam.so";
-#endif
-
-  /*
-   * Do initialization
-   */
-  if (DEBUG (verb))
-    fprintf (stderr, "AUTH-PAM: BACKGROUND: INIT service='%s'\n", service);
-
-#if DLOPEN_PAM
-  /*
-   * Load PAM shared object
-   */
-  if (!dlopen_pam (pam_so))
-    {
-      fprintf (stderr, "AUTH-PAM: BACKGROUND: could not load PAM lib %s: %s\n", pam_so, dlerror());
-      send_control (fd, RESPONSE_INIT_FAILED);
-      goto done;
-    }
-#endif
-
-  /*
-   * Tell foreground that we initialized successfully
-   */
-  if (send_control (fd, RESPONSE_INIT_SUCCEEDED) == -1)
-    {
-      fprintf (stderr, "AUTH-PAM: BACKGROUND: write error on response socket [1]\n");
-      goto done;
-    }
-
-  /*
-   * Event loop
-   */
-  while (1)
-    {
-      memset (&up, 0, sizeof (up));
-      up.verb = verb;
-      up.name_value_list = name_value_list;
-
-      /* get a command from foreground process */
-      command = recv_control (fd);
-
-      if (DEBUG (verb))
-	fprintf (stderr, "AUTH-PAM: BACKGROUND: received command code: %d\n", command);
-
-      switch (command)
-	{
-	case COMMAND_VERIFY:
-	  if (recv_string (fd, up.username, sizeof (up.username)) == -1
-	      || recv_string (fd, up.password, sizeof (up.password)) == -1
-	      || recv_string (fd, up.common_name, sizeof (up.common_name)) == -1)
-	    {
-	      fprintf (stderr, "AUTH-PAM: BACKGROUND: read error on command channel: code=%d, exiting\n",
-		       command);
-	      goto done;
-	    }
-
-	  if (DEBUG (verb))
-	    {
-#if 0
-	      fprintf (stderr, "AUTH-PAM: BACKGROUND: USER/PASS: %s/%s\n",
-		       up.username, up.password);
-#else
-	      fprintf (stderr, "AUTH-PAM: BACKGROUND: USER: %s\n", up.username);
-#endif
-	    }
-
-	  if (pam_auth (service, &up)) /* Succeeded */
-	    {
-	      if (send_control (fd, RESPONSE_VERIFY_SUCCEEDED) == -1)
-		{
-		  fprintf (stderr, "AUTH-PAM: BACKGROUND: write error on response socket [2]\n");
-		  goto done;
-		}
-	    }
-	  else /* Failed */
-	    {
-	      if (send_control (fd, RESPONSE_VERIFY_FAILED) == -1)
-		{
-		  fprintf (stderr, "AUTH-PAM: BACKGROUND: write error on response socket [3]\n");
-		  goto done;
-		}
-	    }
-	  break;
-
-	case COMMAND_EXIT:
-	  goto done;
-
-	case -1:
-	  fprintf (stderr, "AUTH-PAM: BACKGROUND: read error on command channel\n");
-	  goto done;
-
-	default:
-	  fprintf (stderr, "AUTH-PAM: BACKGROUND: unknown command code: code=%d, exiting\n",
-		   command);
-	  goto done;
-	}
-    }
- done:
-
-#if DLOPEN_PAM
-  dlclose_pam ();
-#endif
-  if (DEBUG (verb))
-    fprintf (stderr, "AUTH-PAM: BACKGROUND: EXIT\n");
-
-  return;
-}
diff --git a/plugin/auth-pam/pamdl.c b/plugin/auth-pam/pamdl.c
deleted file mode 100644
index 8636a8e..0000000
--- a/plugin/auth-pam/pamdl.c
+++ /dev/null
@@ -1,180 +0,0 @@
-#if DLOPEN_PAM
-/*
- * If you want to dynamically load libpam using dlopen() or something,
- * then dlopen( ' this shared object ' ); It takes care of exporting
- * the right symbols to any modules loaded by libpam.
- *
- * Modified by JY for use with openvpn-pam-auth
- */
-
-#include <stdio.h>
-#include <dlfcn.h>
-#include <security/pam_appl.h>
-
-#include "pamdl.h"
-
-static void *libpam_h = NULL;
-
-#define RESOLVE_PAM_FUNCTION(x, y, z, err) \
-    { \
-        union { const void *tpointer; y (*fn) z ; } fptr; \
-	fptr.tpointer = dlsym(libpam_h, #x); real_##x = fptr.fn; \
-	if (real_##x == NULL) { \
-	    fprintf (stderr, "PAMDL: unable to resolve '%s': %s\n", #x, dlerror()); \
-	    return err; \
-	} \
-    }
-
-int
-dlopen_pam (const char *so)
-{
-  if (libpam_h == NULL)
-    {
-      libpam_h = dlopen(so, RTLD_GLOBAL|RTLD_NOW);
-    }
-  return libpam_h != NULL;
-}
-
-void
-dlclose_pam (void)
-{
-  if (libpam_h != NULL)
-    {
-      dlclose(libpam_h);
-      libpam_h = NULL;
-    }
-}
-
-int pam_start(const char *service_name, const char *user,
-	      const struct pam_conv *pam_conversation,
-	      pam_handle_t **pamh)
-{
-    int (*real_pam_start)(const char *, const char *,
-				 const struct pam_conv *,
-				 pam_handle_t **);
-    RESOLVE_PAM_FUNCTION(pam_start, int, (const char *, const char *,
-					  const struct pam_conv *,
-					  pam_handle_t **), PAM_ABORT);
-    return real_pam_start(service_name, user, pam_conversation, pamh);
-}
-
-int pam_end(pam_handle_t *pamh, int pam_status)
-{
-    int (*real_pam_end)(pam_handle_t *, int);
-    RESOLVE_PAM_FUNCTION(pam_end, int, (pam_handle_t *, int), PAM_ABORT);
-    return real_pam_end(pamh, pam_status);
-}
-
-int pam_set_item(pam_handle_t *pamh, int item_type, const void *item)
-{
-    int (*real_pam_set_item)(pam_handle_t *, int, const void *);
-    RESOLVE_PAM_FUNCTION(pam_set_item, int,
-			 (pam_handle_t *, int, const void *), PAM_ABORT);
-    return real_pam_set_item(pamh, item_type, item);
-}
-
-int pam_get_item(pam_handle_t *pamh, int item_type, const void **item)
-{
-    int (*real_pam_get_item)(const pam_handle_t *, int, const void **);
-    RESOLVE_PAM_FUNCTION(pam_get_item, int,
-			 (const pam_handle_t *, int, const void **),
-			 PAM_ABORT);
-    return real_pam_get_item(pamh, item_type, item);
-}
-
-int pam_fail_delay(pam_handle_t *pamh, unsigned int musec_delay)
-{
-    int (*real_pam_fail_delay)(pam_handle_t *, unsigned int);
-    RESOLVE_PAM_FUNCTION(pam_fail_delay, int, (pam_handle_t *, unsigned int),
-			 PAM_ABORT);
-    return real_pam_fail_delay(pamh, musec_delay);
-}
-
-typedef const char * const_char_pointer;
-
-const_char_pointer pam_strerror(pam_handle_t *pamh, int errnum)
-{
-    const_char_pointer (*real_pam_strerror)(pam_handle_t *, int);
-    RESOLVE_PAM_FUNCTION(pam_strerror, const_char_pointer,
-			 (pam_handle_t *, int), NULL);
-    return real_pam_strerror(pamh, errnum);
-}
-
-int pam_putenv(pam_handle_t *pamh, const char *name_value)
-{
-    int (*real_pam_putenv)(pam_handle_t *, const char *);
-    RESOLVE_PAM_FUNCTION(pam_putenv, int, (pam_handle_t *, const char *),
-			 PAM_ABORT);
-    return real_pam_putenv(pamh, name_value);
-}
-
-const_char_pointer pam_getenv(pam_handle_t *pamh, const char *name)
-{
-    const_char_pointer (*real_pam_getenv)(pam_handle_t *, const char *);
-    RESOLVE_PAM_FUNCTION(pam_getenv, const_char_pointer,
-			 (pam_handle_t *, const char *), NULL);
-    return real_pam_getenv(pamh, name);
-}
-
-typedef char ** char_ppointer;
-char_ppointer pam_getenvlist(pam_handle_t *pamh)
-{
-    char_ppointer (*real_pam_getenvlist)(pam_handle_t *);
-    RESOLVE_PAM_FUNCTION(pam_getenvlist, char_ppointer, (pam_handle_t *),
-			 NULL);
-    return real_pam_getenvlist(pamh);
-}
-
-/* Authentication management */
-
-int pam_authenticate(pam_handle_t *pamh, int flags)
-{
-    int (*real_pam_authenticate)(pam_handle_t *, int);
-    RESOLVE_PAM_FUNCTION(pam_authenticate, int, (pam_handle_t *, int),
-			 PAM_ABORT);
-    return real_pam_authenticate(pamh, flags);
-}
-
-int pam_setcred(pam_handle_t *pamh, int flags)
-{
-    int (*real_pam_setcred)(pam_handle_t *, int);
-    RESOLVE_PAM_FUNCTION(pam_setcred, int, (pam_handle_t *, int), PAM_ABORT);
-    return real_pam_setcred(pamh, flags);
-}
-
-/* Account Management API's */
-
-int pam_acct_mgmt(pam_handle_t *pamh, int flags)
-{
-    int (*real_pam_acct_mgmt)(pam_handle_t *, int);
-    RESOLVE_PAM_FUNCTION(pam_acct_mgmt, int, (pam_handle_t *, int), PAM_ABORT);
-    return real_pam_acct_mgmt(pamh, flags);
-}
-
-/* Session Management API's */
-
-int pam_open_session(pam_handle_t *pamh, int flags)
-{
-    int (*real_pam_open_session)(pam_handle_t *, int);
-    RESOLVE_PAM_FUNCTION(pam_open_session, int, (pam_handle_t *, int),
-			 PAM_ABORT);
-    return real_pam_open_session(pamh, flags);
-}
-
-int pam_close_session(pam_handle_t *pamh, int flags)
-{
-    int (*real_pam_close_session)(pam_handle_t *, int);
-    RESOLVE_PAM_FUNCTION(pam_close_session, int, (pam_handle_t *, int),
-			 PAM_ABORT);
-    return real_pam_close_session(pamh, flags);
-}
-
-/* Password Management API's */
-
-int pam_chauthtok(pam_handle_t *pamh, int flags)
-{
-    int (*real_pam_chauthtok)(pam_handle_t *, int);
-    RESOLVE_PAM_FUNCTION(pam_chauthtok, int, (pam_handle_t *, int), PAM_ABORT);
-    return real_pam_chauthtok(pamh, flags);
-}
-#endif
diff --git a/plugin/auth-pam/pamdl.h b/plugin/auth-pam/pamdl.h
deleted file mode 100644
index b10b035..0000000
--- a/plugin/auth-pam/pamdl.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#if DLOPEN_PAM
-#include <security/pam_appl.h>
-
-/* Dynamically load and unload the PAM library */
-int dlopen_pam (const char *so);
-void dlclose_pam (void);
-#endif
diff --git a/plugin/defer/README b/plugin/defer/README
deleted file mode 100644
index d8990f8..0000000
--- a/plugin/defer/README
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
diff --git a/plugin/defer/build b/plugin/defer/build
deleted file mode 100755
index 5907afa..0000000
--- a/plugin/defer/build
+++ /dev/null
@@ -1,14 +0,0 @@
-#!/bin/sh
-
-#
-# Build an OpenVPN plugin module on *nix.  The argument should
-# be the base name of the C source file (without the .c).
-#
-
-# This directory is where we will look for openvpn-plugin.h
-INCLUDE="-I../.."
-
-CC_FLAGS="-O2 -Wall -g"
-
-gcc $CC_FLAGS -fPIC -c $INCLUDE $1.c && \
-gcc $CC_FLAGS -fPIC -shared -Wl,-soname,$1.so -o $1.so $1.o -lc
diff --git a/plugin/defer/simple.c b/plugin/defer/simple.c
deleted file mode 100644
index 6539865..0000000
--- a/plugin/defer/simple.c
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
diff --git a/plugin/defer/simple.def b/plugin/defer/simple.def
deleted file mode 100755
index a87507d..0000000
--- a/plugin/defer/simple.def
+++ /dev/null
@@ -1,6 +0,0 @@
-LIBRARY   OpenVPN_PLUGIN_SAMPLE
-DESCRIPTION "Sample OpenVPN plug-in module."
-EXPORTS
-   openvpn_plugin_open_v1   @1
-   openvpn_plugin_func_v1   @2
-   openvpn_plugin_close_v1  @3
diff --git a/plugin/defer/winbuild b/plugin/defer/winbuild
deleted file mode 100755
index 97e724a..0000000
--- a/plugin/defer/winbuild
+++ /dev/null
@@ -1,18 +0,0 @@
-#
-# Build an OpenVPN plugin module on Windows/MinGW.
-# The argument should be the base name of the C source file
-# (without the .c).
-#
-
-# This directory is where we will look for openvpn-plugin.h
-INCLUDE="-I.."
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
diff --git a/plugin/down-root/Makefile b/plugin/down-root/Makefile
deleted file mode 100755
index 5ce4ffb..0000000
--- a/plugin/down-root/Makefile
+++ /dev/null
@@ -1,17 +0,0 @@
-#
-# Build the OpenVPN down-root plugin module.
-#
-
-# This directory is where we will look for openvpn-plugin.h
-INCLUDE=-I../..
-
-CC_FLAGS=-O2 -Wall
-
-down-root.so : down-root.o
-	gcc ${CC_FLAGS} -fPIC -shared -Wl,-soname,openvpn-down-root.so -o openvpn-down-root.so down-root.o -lc
-
-down-root.o : down-root.c
-	gcc ${CC_FLAGS} -fPIC -c ${INCLUDE} down-root.c
-
-clean :
-	rm -f *.o *.so
diff --git a/plugin/down-root/README b/plugin/down-root/README
deleted file mode 100644
index d337ffe..0000000
--- a/plugin/down-root/README
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
diff --git a/plugin/down-root/down-root.c b/plugin/down-root/down-root.c
deleted file mode 100644
index fced23b..0000000
--- a/plugin/down-root/down-root.c
+++ /dev/null
@@ -1,553 +0,0 @@
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
- * OpenVPN plugin module to do privileged down-script execution.
- */
-
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <sys/wait.h>
-#include <fcntl.h>
-#include <signal.h>
-#include <syslog.h>
-
-#include "openvpn-plugin.h"
-
-#define DEBUG(verb) ((verb) >= 7)
-
-/* Command codes for foreground -> background communication */
-#define COMMAND_RUN_SCRIPT 0
-#define COMMAND_EXIT       1
-
-/* Response codes for background -> foreground communication */
-#define RESPONSE_INIT_SUCCEEDED   10
-#define RESPONSE_INIT_FAILED      11
-#define RESPONSE_SCRIPT_SUCCEEDED 12
-#define RESPONSE_SCRIPT_FAILED    13
-
-/* Background process function */
-static void down_root_server (const int fd, char *command, const char *argv[], const char *envp[], const int verb);
-
-/*
- * Plugin state, used by foreground
- */
-struct down_root_context
-{
-  /* Foreground's socket to background process */
-  int foreground_fd;
-
-  /* Process ID of background process */
-  pid_t background_pid;
-
-  /* Verbosity level of OpenVPN */
-  int verb;
-
-  /* down command */
-  char *command;
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
-/*
- * Return the length of a string array
- */
-static int
-string_array_len (const char *array[])
-{
-  int i = 0;
-  if (array)
-    {
-      while (array[i])
-	++i;
-    }
-  return i;
-}
-
-/*
- * Socket read/write functions.
- */
-
-static int
-recv_control (int fd)
-{
-  unsigned char c;
-  const ssize_t size = read (fd, &c, sizeof (c));
-  if (size == sizeof (c))
-    return c;
-  else
-    return -1;
-}
-
-static int
-send_control (int fd, int code)
-{
-  unsigned char c = (unsigned char) code;
-  const ssize_t size = write (fd, &c, sizeof (c));
-  if (size == sizeof (c))
-    return (int) size;
-  else
-    return -1;
-}
-
-/*
- * Daemonize if "daemon" env var is true.
- * Preserve stderr across daemonization if
- * "daemon_log_redirect" env var is true.
- */
-static void
-daemonize (const char *envp[])
-{
-  const char *daemon_string = get_env ("daemon", envp);
-  if (daemon_string && daemon_string[0] == '1')
-    {
-      const char *log_redirect = get_env ("daemon_log_redirect", envp);
-      int fd = -1;
-      if (log_redirect && log_redirect[0] == '1')
-	fd = dup (2);
-      if (daemon (0, 0) < 0)
-	{
-	  fprintf (stderr, "DOWN-ROOT: daemonization failed\n");
-	}
-      else if (fd >= 3)
-	{
-	  dup2 (fd, 2);
-	  close (fd);
-	}
-    }
-}
-
-/*
- * Close most of parent's fds.
- * Keep stdin/stdout/stderr, plus one
- * other fd which is presumed to be
- * our pipe back to parent.
- * Admittedly, a bit of a kludge,
- * but posix doesn't give us a kind
- * of FD_CLOEXEC which will stop
- * fds from crossing a fork().
- */
-static void
-close_fds_except (int keep)
-{
-  int i;
-  closelog ();
-  for (i = 3; i <= 100; ++i)
-    {
-      if (i != keep)
-	close (i);
-    }
-}
-
-/*
- * Usually we ignore signals, because our parent will
- * deal with them.
- */
-static void
-set_signals (void)
-{
-  signal (SIGTERM, SIG_DFL);
-
-  signal (SIGINT, SIG_IGN);
-  signal (SIGHUP, SIG_IGN);
-  signal (SIGUSR1, SIG_IGN);
-  signal (SIGUSR2, SIG_IGN);
-  signal (SIGPIPE, SIG_IGN);
-}
-
-/*
- * convert system() return into a success/failure value
- */
-int
-system_ok (int stat)
-{
-#ifdef WIN32
-  return stat == 0;
-#else
-  return stat != -1 && WIFEXITED (stat) && WEXITSTATUS (stat) == 0;
-#endif
-}
-
-static char *
-build_command_line (const char *argv[])
-{
-  int size = 0;
-  int n = 0;
-  int i;
-  char *string;
-
-  /* precompute size */
-  if (argv)
-    {
-      for (i = 0; argv[i]; ++i)
-	{
-	  size += (strlen (argv[i]) + 1); /* string length plus trailing space */
-	  ++n;
-	}
-    }
-  ++size;                                 /* for null terminator */
-
-  /* allocate memory */
-  string = (char *) malloc (size);
-  if (!string)
-    {
-      fprintf (stderr, "DOWN-ROOT: out of memory\n");
-      exit (1);
-    }
-  string[0] = '\0';
-
-  /* build string */
-  for (i = 0; i < n; ++i)
-    {
-      strcat (string, argv[i]);
-      if (i + 1 < n)
-	strcat (string, " ");
-    }
-  return string;
-}
-
-static void
-free_context (struct down_root_context *context)
-{
-  if (context)
-    {
-      if (context->command)
-	free (context->command);
-      free (context);
-    }
-}
-
-OPENVPN_EXPORT openvpn_plugin_handle_t
-openvpn_plugin_open_v1 (unsigned int *type_mask, const char *argv[], const char *envp[])
-{
-  struct down_root_context *context;
-
-  /*
-   * Allocate our context
-   */
-  context = (struct down_root_context *) calloc (1, sizeof (struct down_root_context));
-  if (!context)
-    goto error;
-  context->foreground_fd = -1;
-
-  /*
-   * Intercept the --up and --down callbacks
-   */
-  *type_mask = OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_UP) | OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_DOWN);
-
-  /*
-   * Make sure we have two string arguments: the first is the .so name,
-   * the second is the script command.
-   */
-  if (string_array_len (argv) < 2)
-    {
-      fprintf (stderr, "DOWN-ROOT: need down script command\n");
-      goto error;
-    }
-
-  /*
-   * Save our argument in context
-   */
-  context->command = build_command_line (&argv[1]);
-
-  /*
-   * Get verbosity level from environment
-   */
-  {
-    const char *verb_string = get_env ("verb", envp);
-    if (verb_string)
-      context->verb = atoi (verb_string);
-  }
-
-  return (openvpn_plugin_handle_t) context;
-
- error:
-  free_context (context);
-  return NULL;
-}
-
-OPENVPN_EXPORT int
-openvpn_plugin_func_v1 (openvpn_plugin_handle_t handle, const int type, const char *argv[], const char *envp[])
-{
-  struct down_root_context *context = (struct down_root_context *) handle;
-
-  if (type == OPENVPN_PLUGIN_UP && context->foreground_fd == -1) /* fork off a process to hold onto root */
-    {
-      pid_t pid;
-      int fd[2];
-
-      /*
-       * Make a socket for foreground and background processes
-       * to communicate.
-       */
-      if (socketpair (PF_UNIX, SOCK_DGRAM, 0, fd) == -1)
-	{
-	  fprintf (stderr, "DOWN-ROOT: socketpair call failed\n");
-	  return OPENVPN_PLUGIN_FUNC_ERROR;
-	}
-
-      /*
-       * Fork off the privileged process.  It will remain privileged
-       * even after the foreground process drops its privileges.
-       */
-      pid = fork ();
-
-      if (pid)
-	{
-	  int status;
-
-	  /*
-	   * Foreground Process
-	   */
-
-	  context->background_pid = pid;
-
-	  /* close our copy of child's socket */
-	  close (fd[1]);
-
-	  /* don't let future subprocesses inherit child socket */
-	  if (fcntl (fd[0], F_SETFD, FD_CLOEXEC) < 0)
-	    fprintf (stderr, "DOWN-ROOT: Set FD_CLOEXEC flag on socket file descriptor failed\n");
-
-	  /* wait for background child process to initialize */
-	  status = recv_control (fd[0]);
-	  if (status == RESPONSE_INIT_SUCCEEDED)
-	    {
-	      context->foreground_fd = fd[0];
-	      return OPENVPN_PLUGIN_FUNC_SUCCESS;
-	    }
-	}
-      else
-	{
-	  /*
-	   * Background Process
-	   */
-
-	  /* close all parent fds except our socket back to parent */
-	  close_fds_except (fd[1]);
-
-	  /* Ignore most signals (the parent will receive them) */
-	  set_signals ();
-
-	  /* Daemonize if --daemon option is set. */
-	  daemonize (envp);
-
-	  /* execute the event loop */
-	  down_root_server (fd[1], context->command, argv, envp, context->verb);
-
-	  close (fd[1]);
-	  exit (0);
-	  return 0; /* NOTREACHED */
-	}
-    }
-  else if (type == OPENVPN_PLUGIN_DOWN && context->foreground_fd >= 0)
-    {
-      if (send_control (context->foreground_fd, COMMAND_RUN_SCRIPT) == -1)
-	{
-	  fprintf (stderr, "DOWN-ROOT: Error sending script execution signal to background process\n");
-	}
-      else
-	{
-	  const int status = recv_control (context->foreground_fd);
-	  if (status == RESPONSE_SCRIPT_SUCCEEDED)
-	    return OPENVPN_PLUGIN_FUNC_SUCCESS;
-	  if (status == -1)
-	    fprintf (stderr, "DOWN-ROOT: Error receiving script execution confirmation from background process\n");
-	}
-    }
-  return OPENVPN_PLUGIN_FUNC_ERROR;
-}
-
-OPENVPN_EXPORT void
-openvpn_plugin_close_v1 (openvpn_plugin_handle_t handle)
-{
-  struct down_root_context *context = (struct down_root_context *) handle;
-
-  if (DEBUG (context->verb))
-    fprintf (stderr, "DOWN-ROOT: close\n");
-
-  if (context->foreground_fd >= 0)
-    {
-      /* tell background process to exit */
-      if (send_control (context->foreground_fd, COMMAND_EXIT) == -1)
-	fprintf (stderr, "DOWN-ROOT: Error signaling background process to exit\n");
-
-      /* wait for background process to exit */
-      if (context->background_pid > 0)
-	waitpid (context->background_pid, NULL, 0);
-
-      close (context->foreground_fd);
-      context->foreground_fd = -1;
-    }
-
-  free_context (context);
-}
-
-OPENVPN_EXPORT void
-openvpn_plugin_abort_v1 (openvpn_plugin_handle_t handle)
-{
-  struct down_root_context *context = (struct down_root_context *) handle;
-
-  if (context && context->foreground_fd >= 0)
-    {
-      /* tell background process to exit */
-      send_control (context->foreground_fd, COMMAND_EXIT);
-      close (context->foreground_fd);
-      context->foreground_fd = -1;
-    }
-}
-
-/*
- * Background process -- runs with privilege.
- */
-static void
-down_root_server (const int fd, char *command, const char *argv[], const char *envp[], const int verb)
-{
-  const char *p[3];
-  char *command_line = NULL;
-  char *argv_cat = NULL;
-  int i;
-
-  /*
-   * Do initialization
-   */
-  if (DEBUG (verb))
-    fprintf (stderr, "DOWN-ROOT: BACKGROUND: INIT command='%s'\n", command);
-
-  /*
-   * Tell foreground that we initialized successfully
-   */
-  if (send_control (fd, RESPONSE_INIT_SUCCEEDED) == -1)
-    {
-      fprintf (stderr, "DOWN-ROOT: BACKGROUND: write error on response socket [1]\n");
-      goto done;
-    }
-
-  /*
-   * Build command line
-   */
-  if (string_array_len (argv) >= 2)
-    argv_cat = build_command_line (&argv[1]);
-  else
-    argv_cat = build_command_line (NULL);
-  p[0] = command;
-  p[1] = argv_cat;
-  p[2] = NULL;
-  command_line = build_command_line (p);
-
-  /*
-   * Save envp in environment
-   */
-  for (i = 0; envp[i]; ++i)
-    {
-      putenv ((char *)envp[i]);
-    }
-
-  /*
-   * Event loop
-   */
-  while (1)
-    {
-      int command_code;
-      int status;
-
-      /* get a command from foreground process */
-      command_code = recv_control (fd);
-
-      if (DEBUG (verb))
-	fprintf (stderr, "DOWN-ROOT: BACKGROUND: received command code: %d\n", command_code);
-
-      switch (command_code)
-	{
-	case COMMAND_RUN_SCRIPT:
-	  status = system (command_line);
-	  if (system_ok (status)) /* Succeeded */
-	    {
-	      if (send_control (fd, RESPONSE_SCRIPT_SUCCEEDED) == -1)
-		{
-		  fprintf (stderr, "DOWN-ROOT: BACKGROUND: write error on response socket [2]\n");
-		  goto done;
-		}
-	    }
-	  else /* Failed */
-	    {
-	      if (send_control (fd, RESPONSE_SCRIPT_FAILED) == -1)
-		{
-		  fprintf (stderr, "DOWN-ROOT: BACKGROUND: write error on response socket [3]\n");
-		  goto done;
-		}
-	    }
-	  break;
-
-	case COMMAND_EXIT:
-	  goto done;
-
-	case -1:
-	  fprintf (stderr, "DOWN-ROOT: BACKGROUND: read error on command channel\n");
-	  goto done;
-
-	default:
-	  fprintf (stderr, "DOWN-ROOT: BACKGROUND: unknown command code: code=%d, exiting\n",
-		   command_code);
-	  goto done;
-	}
-    }
-
- done:
-  if (argv_cat)
-    free (argv_cat);
-  if (command_line)
-    free (command_line);
-  if (DEBUG (verb))
-    fprintf (stderr, "DOWN-ROOT: BACKGROUND: EXIT\n");
-
-  return;
-}
diff --git a/plugin/examples/README b/plugin/examples/README
deleted file mode 100644
index 4400cd3..0000000
--- a/plugin/examples/README
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
diff --git a/plugin/examples/build b/plugin/examples/build
deleted file mode 100755
index 5907afa..0000000
--- a/plugin/examples/build
+++ /dev/null
@@ -1,14 +0,0 @@
-#!/bin/sh
-
-#
-# Build an OpenVPN plugin module on *nix.  The argument should
-# be the base name of the C source file (without the .c).
-#
-
-# This directory is where we will look for openvpn-plugin.h
-INCLUDE="-I../.."
-
-CC_FLAGS="-O2 -Wall -g"
-
-gcc $CC_FLAGS -fPIC -c $INCLUDE $1.c && \
-gcc $CC_FLAGS -fPIC -shared -Wl,-soname,$1.so -o $1.so $1.o -lc
diff --git a/plugin/examples/log.c b/plugin/examples/log.c
deleted file mode 100644
index 1cc4650..0000000
--- a/plugin/examples/log.c
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
diff --git a/plugin/examples/log_v3.c b/plugin/examples/log_v3.c
deleted file mode 100644
index 187c592..0000000
--- a/plugin/examples/log_v3.c
+++ /dev/null
@@ -1,249 +0,0 @@
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
-#define USE_SSL
-#define USE_OPENSSL
-#include "ssl_verify_openssl.h"
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
diff --git a/plugin/examples/simple.c b/plugin/examples/simple.c
deleted file mode 100644
index f26d89f..0000000
--- a/plugin/examples/simple.c
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
diff --git a/plugin/examples/simple.def b/plugin/examples/simple.def
deleted file mode 100755
index a87507d..0000000
--- a/plugin/examples/simple.def
+++ /dev/null
@@ -1,6 +0,0 @@
-LIBRARY   OpenVPN_PLUGIN_SAMPLE
-DESCRIPTION "Sample OpenVPN plug-in module."
-EXPORTS
-   openvpn_plugin_open_v1   @1
-   openvpn_plugin_func_v1   @2
-   openvpn_plugin_close_v1  @3
diff --git a/plugin/examples/winbuild b/plugin/examples/winbuild
deleted file mode 100755
index 97e724a..0000000
--- a/plugin/examples/winbuild
+++ /dev/null
@@ -1,18 +0,0 @@
-#
-# Build an OpenVPN plugin module on Windows/MinGW.
-# The argument should be the base name of the C source file
-# (without the .c).
-#
-
-# This directory is where we will look for openvpn-plugin.h
-INCLUDE="-I.."
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
diff --git a/plugins/README b/plugins/README
new file mode 100644
index 0000000..6e490c5
--- /dev/null
+++ b/plugins/README
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
diff --git a/plugins/auth-pam/.svnignore b/plugins/auth-pam/.svnignore
new file mode 100644
index 0000000..140f8cf
--- /dev/null
+++ b/plugins/auth-pam/.svnignore
@@ -0,0 +1 @@
+*.so
diff --git a/plugins/auth-pam/Makefile b/plugins/auth-pam/Makefile
new file mode 100755
index 0000000..e69fe3f
--- /dev/null
+++ b/plugins/auth-pam/Makefile
@@ -0,0 +1,30 @@
+#
+# Build the OpenVPN auth-pam plugin module.
+#
+
+# If PAM modules are not linked against libpam.so, set DLOPEN_PAM to 1. This
+# must be done on SUSE 9.1, at least.
+DLOPEN_PAM=0
+
+ifeq ($(DLOPEN_PAM),1)
+	LIBPAM=-ldl
+else
+	LIBPAM=-lpam
+endif
+
+# This directory is where we will look for openvpn-plugin.h
+INCLUDE=-I../..
+
+CC_FLAGS=-O2 -Wall -DDLOPEN_PAM=$(DLOPEN_PAM)
+
+openvpn-auth-pam.so : auth-pam.o pamdl.o
+	gcc ${CC_FLAGS} -fPIC -shared -Wl,-soname,openvpn-auth-pam.so -o openvpn-auth-pam.so auth-pam.o pamdl.o -lc $(LIBPAM)
+
+auth-pam.o : auth-pam.c pamdl.h
+	gcc ${CC_FLAGS} -fPIC -c ${INCLUDE} auth-pam.c
+
+pamdl.o : pamdl.c pamdl.h
+	gcc ${CC_FLAGS} -fPIC -c ${INCLUDE} pamdl.c
+
+clean :
+	rm -f *.o *.so
diff --git a/plugins/auth-pam/README b/plugins/auth-pam/README
new file mode 100644
index 0000000..e123690
--- /dev/null
+++ b/plugins/auth-pam/README
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
diff --git a/plugins/auth-pam/auth-pam.c b/plugins/auth-pam/auth-pam.c
new file mode 100644
index 0000000..e52f632
--- /dev/null
+++ b/plugins/auth-pam/auth-pam.c
@@ -0,0 +1,804 @@
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
+ * OpenVPN plugin module to do PAM authentication using a split
+ * privilege model.
+ */
+
+#if DLOPEN_PAM
+#include <dlfcn.h>
+#include "pamdl.h"
+#else
+#include <security/pam_appl.h>
+#endif
+
+#include <stdio.h>
+#include <string.h>
+#include <ctype.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/wait.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <syslog.h>
+
+#include "openvpn-plugin.h"
+
+#define DEBUG(verb) ((verb) >= 4)
+
+/* Command codes for foreground -> background communication */
+#define COMMAND_VERIFY 0
+#define COMMAND_EXIT   1
+
+/* Response codes for background -> foreground communication */
+#define RESPONSE_INIT_SUCCEEDED   10
+#define RESPONSE_INIT_FAILED      11
+#define RESPONSE_VERIFY_SUCCEEDED 12
+#define RESPONSE_VERIFY_FAILED    13
+
+/*
+ * Plugin state, used by foreground
+ */
+struct auth_pam_context
+{
+  /* Foreground's socket to background process */
+  int foreground_fd;
+
+  /* Process ID of background process */
+  pid_t background_pid;
+
+  /* Verbosity level of OpenVPN */
+  int verb;
+};
+
+/*
+ * Name/Value pairs for conversation function.
+ * Special Values:
+ *
+ *  "USERNAME" -- substitute client-supplied username
+ *  "PASSWORD" -- substitute client-specified password
+ *  "COMMONNAME" -- substitute client certificate common name
+ */
+
+#define N_NAME_VALUE 16
+
+struct name_value {
+  const char *name;
+  const char *value;
+};
+
+struct name_value_list {
+  int len;
+  struct name_value data[N_NAME_VALUE];
+};
+
+/*
+ * Used to pass the username/password
+ * to the PAM conversation function.
+ */
+struct user_pass {
+  int verb;
+
+  char username[128];
+  char password[128];
+  char common_name[128];
+
+  const struct name_value_list *name_value_list;
+};
+
+/* Background process function */
+static void pam_server (int fd, const char *service, int verb, const struct name_value_list *name_value_list);
+
+/*  Read 'tosearch', replace all occurences of 'searchfor' with 'replacewith' and return
+ *  a pointer to the NEW string.  Does not modify the input strings.  Will not enter an
+ *  infinite loop with clever 'searchfor' and 'replacewith' strings.
+ *  Daniel Johnson - Progman2000@...1085... / djohnson@...1167...
+ */
+static char *
+searchandreplace(const char *tosearch, const char *searchfor, const char *replacewith)
+{
+  const char *searching=tosearch;
+  char *scratch;
+  char temp[strlen(tosearch)*10];
+  temp[0]=0;
+
+  if (!tosearch || !searchfor || !replacewith) return 0;
+  if (!strlen(tosearch) || !strlen(searchfor) || !strlen(replacewith)) return 0;
+
+  scratch = strstr(searching,searchfor);
+  if (!scratch) return strdup(tosearch);
+
+  while (scratch) {
+    strncat(temp,searching,scratch-searching);
+    strcat(temp,replacewith);
+
+    searching=scratch+strlen(searchfor);
+    scratch = strstr(searching,searchfor);
+  }
+  return strdup(temp);
+}
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
+/*
+ * Return the length of a string array
+ */
+static int
+string_array_len (const char *array[])
+{
+  int i = 0;
+  if (array)
+    {
+      while (array[i])
+	++i;
+    }
+  return i;
+}
+
+/*
+ * Socket read/write functions.
+ */
+
+static int
+recv_control (int fd)
+{
+  unsigned char c;
+  const ssize_t size = read (fd, &c, sizeof (c));
+  if (size == sizeof (c))
+    return c;
+  else
+    {
+      /*fprintf (stderr, "AUTH-PAM: DEBUG recv_control.read=%d\n", (int)size);*/
+      return -1;
+    }
+}
+
+static int
+send_control (int fd, int code)
+{
+  unsigned char c = (unsigned char) code;
+  const ssize_t size = write (fd, &c, sizeof (c));
+  if (size == sizeof (c))
+    return (int) size;
+  else
+    return -1;
+}
+
+static int
+recv_string (int fd, char *buffer, int len)
+{
+  if (len > 0)
+    {
+      ssize_t size;
+      memset (buffer, 0, len);
+      size = read (fd, buffer, len);
+      buffer[len-1] = 0;
+      if (size >= 1)
+	return (int)size;
+    }
+  return -1;
+}
+
+static int
+send_string (int fd, const char *string)
+{
+  const int len = strlen (string) + 1;
+  const ssize_t size = write (fd, string, len);
+  if (size == len)
+    return (int) size;
+  else
+    return -1;
+}
+
+#ifdef DO_DAEMONIZE
+
+/*
+ * Daemonize if "daemon" env var is true.
+ * Preserve stderr across daemonization if
+ * "daemon_log_redirect" env var is true.
+ */
+static void
+daemonize (const char *envp[])
+{
+  const char *daemon_string = get_env ("daemon", envp);
+  if (daemon_string && daemon_string[0] == '1')
+    {
+      const char *log_redirect = get_env ("daemon_log_redirect", envp);
+      int fd = -1;
+      if (log_redirect && log_redirect[0] == '1')
+	fd = dup (2);
+      if (daemon (0, 0) < 0)
+	{
+	  fprintf (stderr, "AUTH-PAM: daemonization failed\n");
+	}
+      else if (fd >= 3)
+	{
+	  dup2 (fd, 2);
+	  close (fd);
+	}
+    }
+}
+
+#endif
+
+/*
+ * Close most of parent's fds.
+ * Keep stdin/stdout/stderr, plus one
+ * other fd which is presumed to be
+ * our pipe back to parent.
+ * Admittedly, a bit of a kludge,
+ * but posix doesn't give us a kind
+ * of FD_CLOEXEC which will stop
+ * fds from crossing a fork().
+ */
+static void
+close_fds_except (int keep)
+{
+  int i;
+  closelog ();
+  for (i = 3; i <= 100; ++i)
+    {
+      if (i != keep)
+	close (i);
+    }
+}
+
+/*
+ * Usually we ignore signals, because our parent will
+ * deal with them.
+ */
+static void
+set_signals (void)
+{
+  signal (SIGTERM, SIG_DFL);
+
+  signal (SIGINT, SIG_IGN);
+  signal (SIGHUP, SIG_IGN);
+  signal (SIGUSR1, SIG_IGN);
+  signal (SIGUSR2, SIG_IGN);
+  signal (SIGPIPE, SIG_IGN);
+}
+
+/*
+ * Return 1 if query matches match.
+ */
+static int
+name_value_match (const char *query, const char *match)
+{
+  while (!isalnum (*query))
+    {
+      if (*query == '\0')
+	return 0;
+      ++query;
+    }
+  return strncasecmp (match, query, strlen (match)) == 0;
+}
+
+OPENVPN_EXPORT openvpn_plugin_handle_t
+openvpn_plugin_open_v1 (unsigned int *type_mask, const char *argv[], const char *envp[])
+{
+  pid_t pid;
+  int fd[2];
+
+  struct auth_pam_context *context;
+  struct name_value_list name_value_list;
+
+  const int base_parms = 2;
+
+  /*
+   * Allocate our context
+   */
+  context = (struct auth_pam_context *) calloc (1, sizeof (struct auth_pam_context));
+  if (!context)
+    goto error;
+  context->foreground_fd = -1;
+
+  /*
+   * Intercept the --auth-user-pass-verify callback.
+   */
+  *type_mask = OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY);
+
+  /*
+   * Make sure we have two string arguments: the first is the .so name,
+   * the second is the PAM service type.
+   */
+  if (string_array_len (argv) < base_parms)
+    {
+      fprintf (stderr, "AUTH-PAM: need PAM service parameter\n");
+      goto error;
+    }
+
+  /*
+   * See if we have optional name/value pairs to match against
+   * PAM module queried fields in the conversation function.
+   */
+  name_value_list.len = 0;
+  if (string_array_len (argv) > base_parms)
+    {
+      const int nv_len = string_array_len (argv) - base_parms;
+      int i;
+
+      if ((nv_len & 1) == 1 || (nv_len / 2) > N_NAME_VALUE)
+	{
+	  fprintf (stderr, "AUTH-PAM: bad name/value list length\n");
+	  goto error;
+	}
+
+      name_value_list.len = nv_len / 2;
+      for (i = 0; i < name_value_list.len; ++i)
+	{
+	  const int base = base_parms + i * 2;
+	  name_value_list.data[i].name = argv[base];
+	  name_value_list.data[i].value = argv[base+1];
+	}
+    }
+
+  /*
+   * Get verbosity level from environment
+   */
+  {
+    const char *verb_string = get_env ("verb", envp);
+    if (verb_string)
+      context->verb = atoi (verb_string);
+  }
+
+  /*
+   * Make a socket for foreground and background processes
+   * to communicate.
+   */
+  if (socketpair (PF_UNIX, SOCK_DGRAM, 0, fd) == -1)
+    {
+      fprintf (stderr, "AUTH-PAM: socketpair call failed\n");
+      goto error;
+    }
+
+  /*
+   * Fork off the privileged process.  It will remain privileged
+   * even after the foreground process drops its privileges.
+   */
+  pid = fork ();
+
+  if (pid)
+    {
+      int status;
+
+      /*
+       * Foreground Process
+       */
+
+      context->background_pid = pid;
+
+      /* close our copy of child's socket */
+      close (fd[1]);
+
+      /* don't let future subprocesses inherit child socket */
+      if (fcntl (fd[0], F_SETFD, FD_CLOEXEC) < 0)
+	fprintf (stderr, "AUTH-PAM: Set FD_CLOEXEC flag on socket file descriptor failed\n");
+
+      /* wait for background child process to initialize */
+      status = recv_control (fd[0]);
+      if (status == RESPONSE_INIT_SUCCEEDED)
+	{
+	  context->foreground_fd = fd[0];
+	  return (openvpn_plugin_handle_t) context;
+	}
+    }
+  else
+    {
+      /*
+       * Background Process
+       */
+
+      /* close all parent fds except our socket back to parent */
+      close_fds_except (fd[1]);
+
+      /* Ignore most signals (the parent will receive them) */
+      set_signals ();
+
+#ifdef DO_DAEMONIZE
+      /* Daemonize if --daemon option is set. */
+      daemonize (envp);
+#endif
+
+      /* execute the event loop */
+      pam_server (fd[1], argv[1], context->verb, &name_value_list);
+
+      close (fd[1]);
+
+      exit (0);
+      return 0; /* NOTREACHED */
+    }
+
+ error:
+  if (context)
+    free (context);
+  return NULL;
+}
+
+OPENVPN_EXPORT int
+openvpn_plugin_func_v1 (openvpn_plugin_handle_t handle, const int type, const char *argv[], const char *envp[])
+{
+  struct auth_pam_context *context = (struct auth_pam_context *) handle;
+
+  if (type == OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY && context->foreground_fd >= 0)
+    {
+      /* get username/password from envp string array */
+      const char *username = get_env ("username", envp);
+      const char *password = get_env ("password", envp);
+      const char *common_name = get_env ("common_name", envp) ? get_env ("common_name", envp) : "";
+
+      if (username && strlen (username) > 0 && password)
+	{
+	  if (send_control (context->foreground_fd, COMMAND_VERIFY) == -1
+	      || send_string (context->foreground_fd, username) == -1
+	      || send_string (context->foreground_fd, password) == -1
+             || send_string (context->foreground_fd, common_name) == -1)
+	    {
+	      fprintf (stderr, "AUTH-PAM: Error sending auth info to background process\n");
+	    }
+	  else
+	    {
+	      const int status = recv_control (context->foreground_fd);
+	      if (status == RESPONSE_VERIFY_SUCCEEDED)
+		return OPENVPN_PLUGIN_FUNC_SUCCESS;
+	      if (status == -1)
+		fprintf (stderr, "AUTH-PAM: Error receiving auth confirmation from background process\n");
+	    }
+	}
+    }
+  return OPENVPN_PLUGIN_FUNC_ERROR;
+}
+
+OPENVPN_EXPORT void
+openvpn_plugin_close_v1 (openvpn_plugin_handle_t handle)
+{
+  struct auth_pam_context *context = (struct auth_pam_context *) handle;
+
+  if (DEBUG (context->verb))
+    fprintf (stderr, "AUTH-PAM: close\n");
+
+  if (context->foreground_fd >= 0)
+    {
+      /* tell background process to exit */
+      if (send_control (context->foreground_fd, COMMAND_EXIT) == -1)
+	fprintf (stderr, "AUTH-PAM: Error signaling background process to exit\n");
+
+      /* wait for background process to exit */
+      if (context->background_pid > 0)
+	waitpid (context->background_pid, NULL, 0);
+
+      close (context->foreground_fd);
+      context->foreground_fd = -1;
+    }
+
+  free (context);
+}
+
+OPENVPN_EXPORT void
+openvpn_plugin_abort_v1 (openvpn_plugin_handle_t handle)
+{
+  struct auth_pam_context *context = (struct auth_pam_context *) handle;
+
+  /* tell background process to exit */
+  if (context && context->foreground_fd >= 0)
+    {
+      send_control (context->foreground_fd, COMMAND_EXIT);
+      close (context->foreground_fd);
+      context->foreground_fd = -1;
+    }
+}
+
+/*
+ * PAM conversation function
+ */
+static int
+my_conv (int n, const struct pam_message **msg_array,
+	 struct pam_response **response_array, void *appdata_ptr)
+{
+  const struct user_pass *up = ( const struct user_pass *) appdata_ptr;
+  struct pam_response *aresp;
+  int i;
+  int ret = PAM_SUCCESS;
+
+  *response_array = NULL;
+
+  if (n <= 0 || n > PAM_MAX_NUM_MSG)
+    return (PAM_CONV_ERR);
+  if ((aresp = calloc (n, sizeof *aresp)) == NULL)
+    return (PAM_BUF_ERR);
+
+  /* loop through each PAM-module query */
+  for (i = 0; i < n; ++i)
+    {
+      const struct pam_message *msg = msg_array[i];
+      aresp[i].resp_retcode = 0;
+      aresp[i].resp = NULL;
+
+      if (DEBUG (up->verb))
+	{
+	  fprintf (stderr, "AUTH-PAM: BACKGROUND: my_conv[%d] query='%s' style=%d\n",
+		   i,
+		   msg->msg ? msg->msg : "NULL",
+		   msg->msg_style);
+	}
+
+      if (up->name_value_list && up->name_value_list->len > 0)
+	{
+	  /* use name/value list match method */
+	  const struct name_value_list *list = up->name_value_list;
+	  int j;
+
+	  /* loop through name/value pairs */
+	  for (j = 0; j < list->len; ++j)
+	    {
+	      const char *match_name = list->data[j].name;
+	      const char *match_value = list->data[j].value;
+
+	      if (name_value_match (msg->msg, match_name))
+		{
+		  /* found name/value match */
+		  aresp[i].resp = NULL;
+
+		  if (DEBUG (up->verb))
+		    fprintf (stderr, "AUTH-PAM: BACKGROUND: name match found, query/match-string ['%s', '%s'] = '%s'\n",
+			     msg->msg,
+			     match_name,
+			     match_value);
+
+		  if (strstr(match_value, "USERNAME"))
+		    aresp[i].resp = searchandreplace(match_value, "USERNAME", up->username);
+		  else if (strstr(match_value, "PASSWORD"))
+		    aresp[i].resp = searchandreplace(match_value, "PASSWORD", up->password);
+		  else if (strstr(match_value, "COMMONNAME"))
+		    aresp[i].resp = searchandreplace(match_value, "COMMONNAME", up->common_name);
+		  else
+		    aresp[i].resp = strdup (match_value);
+
+		  if (aresp[i].resp == NULL)
+		    ret = PAM_CONV_ERR;
+		  break;
+		}
+	    }
+
+	  if (j == list->len)
+	    ret = PAM_CONV_ERR;
+	}
+      else
+	{
+	  /* use PAM_PROMPT_ECHO_x hints */
+	  switch (msg->msg_style)
+	    {
+	    case PAM_PROMPT_ECHO_OFF:
+	      aresp[i].resp = strdup (up->password);
+	      if (aresp[i].resp == NULL)
+		ret = PAM_CONV_ERR;
+	      break;
+
+	    case PAM_PROMPT_ECHO_ON:
+	      aresp[i].resp = strdup (up->username);
+	      if (aresp[i].resp == NULL)
+		ret = PAM_CONV_ERR;
+	      break;
+
+	    case PAM_ERROR_MSG:
+	    case PAM_TEXT_INFO:
+	      break;
+
+	    default:
+	      ret = PAM_CONV_ERR;
+	      break;
+	    }
+	}
+    }
+
+  if (ret == PAM_SUCCESS)
+    *response_array = aresp;
+  return ret;
+}
+
+/*
+ * Return 1 if authenticated and 0 if failed.
+ * Called once for every username/password
+ * to be authenticated.
+ */
+static int
+pam_auth (const char *service, const struct user_pass *up)
+{
+  struct pam_conv conv;
+  pam_handle_t *pamh = NULL;
+  int status = PAM_SUCCESS;
+  int ret = 0;
+  const int name_value_list_provided = (up->name_value_list && up->name_value_list->len > 0);
+
+  /* Initialize PAM */
+  conv.conv = my_conv;
+  conv.appdata_ptr = (void *)up;
+  status = pam_start (service, name_value_list_provided ? NULL : up->username, &conv, &pamh);
+  if (status == PAM_SUCCESS)
+    {
+      /* Call PAM to verify username/password */
+      status = pam_authenticate(pamh, 0);
+      if (status == PAM_SUCCESS)
+	status = pam_acct_mgmt (pamh, 0);
+      if (status == PAM_SUCCESS)
+	ret = 1;
+
+      /* Output error message if failed */
+      if (!ret)
+	{
+	  fprintf (stderr, "AUTH-PAM: BACKGROUND: user '%s' failed to authenticate: %s\n",
+		   up->username,
+		   pam_strerror (pamh, status));
+	}
+
+      /* Close PAM */
+      pam_end (pamh, status);      
+    }
+
+  return ret;
+}
+
+/*
+ * Background process -- runs with privilege.
+ */
+static void
+pam_server (int fd, const char *service, int verb, const struct name_value_list *name_value_list)
+{
+  struct user_pass up;
+  int command;
+#if DLOPEN_PAM
+  static const char pam_so[] = "libpam.so";
+#endif
+
+  /*
+   * Do initialization
+   */
+  if (DEBUG (verb))
+    fprintf (stderr, "AUTH-PAM: BACKGROUND: INIT service='%s'\n", service);
+
+#if DLOPEN_PAM
+  /*
+   * Load PAM shared object
+   */
+  if (!dlopen_pam (pam_so))
+    {
+      fprintf (stderr, "AUTH-PAM: BACKGROUND: could not load PAM lib %s: %s\n", pam_so, dlerror());
+      send_control (fd, RESPONSE_INIT_FAILED);
+      goto done;
+    }
+#endif
+
+  /*
+   * Tell foreground that we initialized successfully
+   */
+  if (send_control (fd, RESPONSE_INIT_SUCCEEDED) == -1)
+    {
+      fprintf (stderr, "AUTH-PAM: BACKGROUND: write error on response socket [1]\n");
+      goto done;
+    }
+
+  /*
+   * Event loop
+   */
+  while (1)
+    {
+      memset (&up, 0, sizeof (up));
+      up.verb = verb;
+      up.name_value_list = name_value_list;
+
+      /* get a command from foreground process */
+      command = recv_control (fd);
+
+      if (DEBUG (verb))
+	fprintf (stderr, "AUTH-PAM: BACKGROUND: received command code: %d\n", command);
+
+      switch (command)
+	{
+	case COMMAND_VERIFY:
+	  if (recv_string (fd, up.username, sizeof (up.username)) == -1
+	      || recv_string (fd, up.password, sizeof (up.password)) == -1
+	      || recv_string (fd, up.common_name, sizeof (up.common_name)) == -1)
+	    {
+	      fprintf (stderr, "AUTH-PAM: BACKGROUND: read error on command channel: code=%d, exiting\n",
+		       command);
+	      goto done;
+	    }
+
+	  if (DEBUG (verb))
+	    {
+#if 0
+	      fprintf (stderr, "AUTH-PAM: BACKGROUND: USER/PASS: %s/%s\n",
+		       up.username, up.password);
+#else
+	      fprintf (stderr, "AUTH-PAM: BACKGROUND: USER: %s\n", up.username);
+#endif
+	    }
+
+	  if (pam_auth (service, &up)) /* Succeeded */
+	    {
+	      if (send_control (fd, RESPONSE_VERIFY_SUCCEEDED) == -1)
+		{
+		  fprintf (stderr, "AUTH-PAM: BACKGROUND: write error on response socket [2]\n");
+		  goto done;
+		}
+	    }
+	  else /* Failed */
+	    {
+	      if (send_control (fd, RESPONSE_VERIFY_FAILED) == -1)
+		{
+		  fprintf (stderr, "AUTH-PAM: BACKGROUND: write error on response socket [3]\n");
+		  goto done;
+		}
+	    }
+	  break;
+
+	case COMMAND_EXIT:
+	  goto done;
+
+	case -1:
+	  fprintf (stderr, "AUTH-PAM: BACKGROUND: read error on command channel\n");
+	  goto done;
+
+	default:
+	  fprintf (stderr, "AUTH-PAM: BACKGROUND: unknown command code: code=%d, exiting\n",
+		   command);
+	  goto done;
+	}
+    }
+ done:
+
+#if DLOPEN_PAM
+  dlclose_pam ();
+#endif
+  if (DEBUG (verb))
+    fprintf (stderr, "AUTH-PAM: BACKGROUND: EXIT\n");
+
+  return;
+}
diff --git a/plugins/auth-pam/pamdl.c b/plugins/auth-pam/pamdl.c
new file mode 100644
index 0000000..8636a8e
--- /dev/null
+++ b/plugins/auth-pam/pamdl.c
@@ -0,0 +1,180 @@
+#if DLOPEN_PAM
+/*
+ * If you want to dynamically load libpam using dlopen() or something,
+ * then dlopen( ' this shared object ' ); It takes care of exporting
+ * the right symbols to any modules loaded by libpam.
+ *
+ * Modified by JY for use with openvpn-pam-auth
+ */
+
+#include <stdio.h>
+#include <dlfcn.h>
+#include <security/pam_appl.h>
+
+#include "pamdl.h"
+
+static void *libpam_h = NULL;
+
+#define RESOLVE_PAM_FUNCTION(x, y, z, err) \
+    { \
+        union { const void *tpointer; y (*fn) z ; } fptr; \
+	fptr.tpointer = dlsym(libpam_h, #x); real_##x = fptr.fn; \
+	if (real_##x == NULL) { \
+	    fprintf (stderr, "PAMDL: unable to resolve '%s': %s\n", #x, dlerror()); \
+	    return err; \
+	} \
+    }
+
+int
+dlopen_pam (const char *so)
+{
+  if (libpam_h == NULL)
+    {
+      libpam_h = dlopen(so, RTLD_GLOBAL|RTLD_NOW);
+    }
+  return libpam_h != NULL;
+}
+
+void
+dlclose_pam (void)
+{
+  if (libpam_h != NULL)
+    {
+      dlclose(libpam_h);
+      libpam_h = NULL;
+    }
+}
+
+int pam_start(const char *service_name, const char *user,
+	      const struct pam_conv *pam_conversation,
+	      pam_handle_t **pamh)
+{
+    int (*real_pam_start)(const char *, const char *,
+				 const struct pam_conv *,
+				 pam_handle_t **);
+    RESOLVE_PAM_FUNCTION(pam_start, int, (const char *, const char *,
+					  const struct pam_conv *,
+					  pam_handle_t **), PAM_ABORT);
+    return real_pam_start(service_name, user, pam_conversation, pamh);
+}
+
+int pam_end(pam_handle_t *pamh, int pam_status)
+{
+    int (*real_pam_end)(pam_handle_t *, int);
+    RESOLVE_PAM_FUNCTION(pam_end, int, (pam_handle_t *, int), PAM_ABORT);
+    return real_pam_end(pamh, pam_status);
+}
+
+int pam_set_item(pam_handle_t *pamh, int item_type, const void *item)
+{
+    int (*real_pam_set_item)(pam_handle_t *, int, const void *);
+    RESOLVE_PAM_FUNCTION(pam_set_item, int,
+			 (pam_handle_t *, int, const void *), PAM_ABORT);
+    return real_pam_set_item(pamh, item_type, item);
+}
+
+int pam_get_item(pam_handle_t *pamh, int item_type, const void **item)
+{
+    int (*real_pam_get_item)(const pam_handle_t *, int, const void **);
+    RESOLVE_PAM_FUNCTION(pam_get_item, int,
+			 (const pam_handle_t *, int, const void **),
+			 PAM_ABORT);
+    return real_pam_get_item(pamh, item_type, item);
+}
+
+int pam_fail_delay(pam_handle_t *pamh, unsigned int musec_delay)
+{
+    int (*real_pam_fail_delay)(pam_handle_t *, unsigned int);
+    RESOLVE_PAM_FUNCTION(pam_fail_delay, int, (pam_handle_t *, unsigned int),
+			 PAM_ABORT);
+    return real_pam_fail_delay(pamh, musec_delay);
+}
+
+typedef const char * const_char_pointer;
+
+const_char_pointer pam_strerror(pam_handle_t *pamh, int errnum)
+{
+    const_char_pointer (*real_pam_strerror)(pam_handle_t *, int);
+    RESOLVE_PAM_FUNCTION(pam_strerror, const_char_pointer,
+			 (pam_handle_t *, int), NULL);
+    return real_pam_strerror(pamh, errnum);
+}
+
+int pam_putenv(pam_handle_t *pamh, const char *name_value)
+{
+    int (*real_pam_putenv)(pam_handle_t *, const char *);
+    RESOLVE_PAM_FUNCTION(pam_putenv, int, (pam_handle_t *, const char *),
+			 PAM_ABORT);
+    return real_pam_putenv(pamh, name_value);
+}
+
+const_char_pointer pam_getenv(pam_handle_t *pamh, const char *name)
+{
+    const_char_pointer (*real_pam_getenv)(pam_handle_t *, const char *);
+    RESOLVE_PAM_FUNCTION(pam_getenv, const_char_pointer,
+			 (pam_handle_t *, const char *), NULL);
+    return real_pam_getenv(pamh, name);
+}
+
+typedef char ** char_ppointer;
+char_ppointer pam_getenvlist(pam_handle_t *pamh)
+{
+    char_ppointer (*real_pam_getenvlist)(pam_handle_t *);
+    RESOLVE_PAM_FUNCTION(pam_getenvlist, char_ppointer, (pam_handle_t *),
+			 NULL);
+    return real_pam_getenvlist(pamh);
+}
+
+/* Authentication management */
+
+int pam_authenticate(pam_handle_t *pamh, int flags)
+{
+    int (*real_pam_authenticate)(pam_handle_t *, int);
+    RESOLVE_PAM_FUNCTION(pam_authenticate, int, (pam_handle_t *, int),
+			 PAM_ABORT);
+    return real_pam_authenticate(pamh, flags);
+}
+
+int pam_setcred(pam_handle_t *pamh, int flags)
+{
+    int (*real_pam_setcred)(pam_handle_t *, int);
+    RESOLVE_PAM_FUNCTION(pam_setcred, int, (pam_handle_t *, int), PAM_ABORT);
+    return real_pam_setcred(pamh, flags);
+}
+
+/* Account Management API's */
+
+int pam_acct_mgmt(pam_handle_t *pamh, int flags)
+{
+    int (*real_pam_acct_mgmt)(pam_handle_t *, int);
+    RESOLVE_PAM_FUNCTION(pam_acct_mgmt, int, (pam_handle_t *, int), PAM_ABORT);
+    return real_pam_acct_mgmt(pamh, flags);
+}
+
+/* Session Management API's */
+
+int pam_open_session(pam_handle_t *pamh, int flags)
+{
+    int (*real_pam_open_session)(pam_handle_t *, int);
+    RESOLVE_PAM_FUNCTION(pam_open_session, int, (pam_handle_t *, int),
+			 PAM_ABORT);
+    return real_pam_open_session(pamh, flags);
+}
+
+int pam_close_session(pam_handle_t *pamh, int flags)
+{
+    int (*real_pam_close_session)(pam_handle_t *, int);
+    RESOLVE_PAM_FUNCTION(pam_close_session, int, (pam_handle_t *, int),
+			 PAM_ABORT);
+    return real_pam_close_session(pamh, flags);
+}
+
+/* Password Management API's */
+
+int pam_chauthtok(pam_handle_t *pamh, int flags)
+{
+    int (*real_pam_chauthtok)(pam_handle_t *, int);
+    RESOLVE_PAM_FUNCTION(pam_chauthtok, int, (pam_handle_t *, int), PAM_ABORT);
+    return real_pam_chauthtok(pamh, flags);
+}
+#endif
diff --git a/plugins/auth-pam/pamdl.h b/plugins/auth-pam/pamdl.h
new file mode 100644
index 0000000..b10b035
--- /dev/null
+++ b/plugins/auth-pam/pamdl.h
@@ -0,0 +1,7 @@
+#if DLOPEN_PAM
+#include <security/pam_appl.h>
+
+/* Dynamically load and unload the PAM library */
+int dlopen_pam (const char *so);
+void dlclose_pam (void);
+#endif
diff --git a/plugins/defer/README b/plugins/defer/README
new file mode 100644
index 0000000..d8990f8
--- /dev/null
+++ b/plugins/defer/README
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
diff --git a/plugins/defer/build b/plugins/defer/build
new file mode 100755
index 0000000..5907afa
--- /dev/null
+++ b/plugins/defer/build
@@ -0,0 +1,14 @@
+#!/bin/sh
+
+#
+# Build an OpenVPN plugin module on *nix.  The argument should
+# be the base name of the C source file (without the .c).
+#
+
+# This directory is where we will look for openvpn-plugin.h
+INCLUDE="-I../.."
+
+CC_FLAGS="-O2 -Wall -g"
+
+gcc $CC_FLAGS -fPIC -c $INCLUDE $1.c && \
+gcc $CC_FLAGS -fPIC -shared -Wl,-soname,$1.so -o $1.so $1.o -lc
diff --git a/plugins/defer/simple.c b/plugins/defer/simple.c
new file mode 100644
index 0000000..6539865
--- /dev/null
+++ b/plugins/defer/simple.c
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
diff --git a/plugins/defer/simple.def b/plugins/defer/simple.def
new file mode 100755
index 0000000..a87507d
--- /dev/null
+++ b/plugins/defer/simple.def
@@ -0,0 +1,6 @@
+LIBRARY   OpenVPN_PLUGIN_SAMPLE
+DESCRIPTION "Sample OpenVPN plug-in module."
+EXPORTS
+   openvpn_plugin_open_v1   @1
+   openvpn_plugin_func_v1   @2
+   openvpn_plugin_close_v1  @3
diff --git a/plugins/defer/winbuild b/plugins/defer/winbuild
new file mode 100755
index 0000000..97e724a
--- /dev/null
+++ b/plugins/defer/winbuild
@@ -0,0 +1,18 @@
+#
+# Build an OpenVPN plugin module on Windows/MinGW.
+# The argument should be the base name of the C source file
+# (without the .c).
+#
+
+# This directory is where we will look for openvpn-plugin.h
+INCLUDE="-I.."
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
diff --git a/plugins/down-root/Makefile b/plugins/down-root/Makefile
new file mode 100755
index 0000000..5ce4ffb
--- /dev/null
+++ b/plugins/down-root/Makefile
@@ -0,0 +1,17 @@
+#
+# Build the OpenVPN down-root plugin module.
+#
+
+# This directory is where we will look for openvpn-plugin.h
+INCLUDE=-I../..
+
+CC_FLAGS=-O2 -Wall
+
+down-root.so : down-root.o
+	gcc ${CC_FLAGS} -fPIC -shared -Wl,-soname,openvpn-down-root.so -o openvpn-down-root.so down-root.o -lc
+
+down-root.o : down-root.c
+	gcc ${CC_FLAGS} -fPIC -c ${INCLUDE} down-root.c
+
+clean :
+	rm -f *.o *.so
diff --git a/plugins/down-root/README b/plugins/down-root/README
new file mode 100644
index 0000000..d337ffe
--- /dev/null
+++ b/plugins/down-root/README
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
diff --git a/plugins/down-root/down-root.c b/plugins/down-root/down-root.c
new file mode 100644
index 0000000..fced23b
--- /dev/null
+++ b/plugins/down-root/down-root.c
@@ -0,0 +1,553 @@
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
+ * OpenVPN plugin module to do privileged down-script execution.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/wait.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <syslog.h>
+
+#include "openvpn-plugin.h"
+
+#define DEBUG(verb) ((verb) >= 7)
+
+/* Command codes for foreground -> background communication */
+#define COMMAND_RUN_SCRIPT 0
+#define COMMAND_EXIT       1
+
+/* Response codes for background -> foreground communication */
+#define RESPONSE_INIT_SUCCEEDED   10
+#define RESPONSE_INIT_FAILED      11
+#define RESPONSE_SCRIPT_SUCCEEDED 12
+#define RESPONSE_SCRIPT_FAILED    13
+
+/* Background process function */
+static void down_root_server (const int fd, char *command, const char *argv[], const char *envp[], const int verb);
+
+/*
+ * Plugin state, used by foreground
+ */
+struct down_root_context
+{
+  /* Foreground's socket to background process */
+  int foreground_fd;
+
+  /* Process ID of background process */
+  pid_t background_pid;
+
+  /* Verbosity level of OpenVPN */
+  int verb;
+
+  /* down command */
+  char *command;
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
+/*
+ * Return the length of a string array
+ */
+static int
+string_array_len (const char *array[])
+{
+  int i = 0;
+  if (array)
+    {
+      while (array[i])
+	++i;
+    }
+  return i;
+}
+
+/*
+ * Socket read/write functions.
+ */
+
+static int
+recv_control (int fd)
+{
+  unsigned char c;
+  const ssize_t size = read (fd, &c, sizeof (c));
+  if (size == sizeof (c))
+    return c;
+  else
+    return -1;
+}
+
+static int
+send_control (int fd, int code)
+{
+  unsigned char c = (unsigned char) code;
+  const ssize_t size = write (fd, &c, sizeof (c));
+  if (size == sizeof (c))
+    return (int) size;
+  else
+    return -1;
+}
+
+/*
+ * Daemonize if "daemon" env var is true.
+ * Preserve stderr across daemonization if
+ * "daemon_log_redirect" env var is true.
+ */
+static void
+daemonize (const char *envp[])
+{
+  const char *daemon_string = get_env ("daemon", envp);
+  if (daemon_string && daemon_string[0] == '1')
+    {
+      const char *log_redirect = get_env ("daemon_log_redirect", envp);
+      int fd = -1;
+      if (log_redirect && log_redirect[0] == '1')
+	fd = dup (2);
+      if (daemon (0, 0) < 0)
+	{
+	  fprintf (stderr, "DOWN-ROOT: daemonization failed\n");
+	}
+      else if (fd >= 3)
+	{
+	  dup2 (fd, 2);
+	  close (fd);
+	}
+    }
+}
+
+/*
+ * Close most of parent's fds.
+ * Keep stdin/stdout/stderr, plus one
+ * other fd which is presumed to be
+ * our pipe back to parent.
+ * Admittedly, a bit of a kludge,
+ * but posix doesn't give us a kind
+ * of FD_CLOEXEC which will stop
+ * fds from crossing a fork().
+ */
+static void
+close_fds_except (int keep)
+{
+  int i;
+  closelog ();
+  for (i = 3; i <= 100; ++i)
+    {
+      if (i != keep)
+	close (i);
+    }
+}
+
+/*
+ * Usually we ignore signals, because our parent will
+ * deal with them.
+ */
+static void
+set_signals (void)
+{
+  signal (SIGTERM, SIG_DFL);
+
+  signal (SIGINT, SIG_IGN);
+  signal (SIGHUP, SIG_IGN);
+  signal (SIGUSR1, SIG_IGN);
+  signal (SIGUSR2, SIG_IGN);
+  signal (SIGPIPE, SIG_IGN);
+}
+
+/*
+ * convert system() return into a success/failure value
+ */
+int
+system_ok (int stat)
+{
+#ifdef WIN32
+  return stat == 0;
+#else
+  return stat != -1 && WIFEXITED (stat) && WEXITSTATUS (stat) == 0;
+#endif
+}
+
+static char *
+build_command_line (const char *argv[])
+{
+  int size = 0;
+  int n = 0;
+  int i;
+  char *string;
+
+  /* precompute size */
+  if (argv)
+    {
+      for (i = 0; argv[i]; ++i)
+	{
+	  size += (strlen (argv[i]) + 1); /* string length plus trailing space */
+	  ++n;
+	}
+    }
+  ++size;                                 /* for null terminator */
+
+  /* allocate memory */
+  string = (char *) malloc (size);
+  if (!string)
+    {
+      fprintf (stderr, "DOWN-ROOT: out of memory\n");
+      exit (1);
+    }
+  string[0] = '\0';
+
+  /* build string */
+  for (i = 0; i < n; ++i)
+    {
+      strcat (string, argv[i]);
+      if (i + 1 < n)
+	strcat (string, " ");
+    }
+  return string;
+}
+
+static void
+free_context (struct down_root_context *context)
+{
+  if (context)
+    {
+      if (context->command)
+	free (context->command);
+      free (context);
+    }
+}
+
+OPENVPN_EXPORT openvpn_plugin_handle_t
+openvpn_plugin_open_v1 (unsigned int *type_mask, const char *argv[], const char *envp[])
+{
+  struct down_root_context *context;
+
+  /*
+   * Allocate our context
+   */
+  context = (struct down_root_context *) calloc (1, sizeof (struct down_root_context));
+  if (!context)
+    goto error;
+  context->foreground_fd = -1;
+
+  /*
+   * Intercept the --up and --down callbacks
+   */
+  *type_mask = OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_UP) | OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_DOWN);
+
+  /*
+   * Make sure we have two string arguments: the first is the .so name,
+   * the second is the script command.
+   */
+  if (string_array_len (argv) < 2)
+    {
+      fprintf (stderr, "DOWN-ROOT: need down script command\n");
+      goto error;
+    }
+
+  /*
+   * Save our argument in context
+   */
+  context->command = build_command_line (&argv[1]);
+
+  /*
+   * Get verbosity level from environment
+   */
+  {
+    const char *verb_string = get_env ("verb", envp);
+    if (verb_string)
+      context->verb = atoi (verb_string);
+  }
+
+  return (openvpn_plugin_handle_t) context;
+
+ error:
+  free_context (context);
+  return NULL;
+}
+
+OPENVPN_EXPORT int
+openvpn_plugin_func_v1 (openvpn_plugin_handle_t handle, const int type, const char *argv[], const char *envp[])
+{
+  struct down_root_context *context = (struct down_root_context *) handle;
+
+  if (type == OPENVPN_PLUGIN_UP && context->foreground_fd == -1) /* fork off a process to hold onto root */
+    {
+      pid_t pid;
+      int fd[2];
+
+      /*
+       * Make a socket for foreground and background processes
+       * to communicate.
+       */
+      if (socketpair (PF_UNIX, SOCK_DGRAM, 0, fd) == -1)
+	{
+	  fprintf (stderr, "DOWN-ROOT: socketpair call failed\n");
+	  return OPENVPN_PLUGIN_FUNC_ERROR;
+	}
+
+      /*
+       * Fork off the privileged process.  It will remain privileged
+       * even after the foreground process drops its privileges.
+       */
+      pid = fork ();
+
+      if (pid)
+	{
+	  int status;
+
+	  /*
+	   * Foreground Process
+	   */
+
+	  context->background_pid = pid;
+
+	  /* close our copy of child's socket */
+	  close (fd[1]);
+
+	  /* don't let future subprocesses inherit child socket */
+	  if (fcntl (fd[0], F_SETFD, FD_CLOEXEC) < 0)
+	    fprintf (stderr, "DOWN-ROOT: Set FD_CLOEXEC flag on socket file descriptor failed\n");
+
+	  /* wait for background child process to initialize */
+	  status = recv_control (fd[0]);
+	  if (status == RESPONSE_INIT_SUCCEEDED)
+	    {
+	      context->foreground_fd = fd[0];
+	      return OPENVPN_PLUGIN_FUNC_SUCCESS;
+	    }
+	}
+      else
+	{
+	  /*
+	   * Background Process
+	   */
+
+	  /* close all parent fds except our socket back to parent */
+	  close_fds_except (fd[1]);
+
+	  /* Ignore most signals (the parent will receive them) */
+	  set_signals ();
+
+	  /* Daemonize if --daemon option is set. */
+	  daemonize (envp);
+
+	  /* execute the event loop */
+	  down_root_server (fd[1], context->command, argv, envp, context->verb);
+
+	  close (fd[1]);
+	  exit (0);
+	  return 0; /* NOTREACHED */
+	}
+    }
+  else if (type == OPENVPN_PLUGIN_DOWN && context->foreground_fd >= 0)
+    {
+      if (send_control (context->foreground_fd, COMMAND_RUN_SCRIPT) == -1)
+	{
+	  fprintf (stderr, "DOWN-ROOT: Error sending script execution signal to background process\n");
+	}
+      else
+	{
+	  const int status = recv_control (context->foreground_fd);
+	  if (status == RESPONSE_SCRIPT_SUCCEEDED)
+	    return OPENVPN_PLUGIN_FUNC_SUCCESS;
+	  if (status == -1)
+	    fprintf (stderr, "DOWN-ROOT: Error receiving script execution confirmation from background process\n");
+	}
+    }
+  return OPENVPN_PLUGIN_FUNC_ERROR;
+}
+
+OPENVPN_EXPORT void
+openvpn_plugin_close_v1 (openvpn_plugin_handle_t handle)
+{
+  struct down_root_context *context = (struct down_root_context *) handle;
+
+  if (DEBUG (context->verb))
+    fprintf (stderr, "DOWN-ROOT: close\n");
+
+  if (context->foreground_fd >= 0)
+    {
+      /* tell background process to exit */
+      if (send_control (context->foreground_fd, COMMAND_EXIT) == -1)
+	fprintf (stderr, "DOWN-ROOT: Error signaling background process to exit\n");
+
+      /* wait for background process to exit */
+      if (context->background_pid > 0)
+	waitpid (context->background_pid, NULL, 0);
+
+      close (context->foreground_fd);
+      context->foreground_fd = -1;
+    }
+
+  free_context (context);
+}
+
+OPENVPN_EXPORT void
+openvpn_plugin_abort_v1 (openvpn_plugin_handle_t handle)
+{
+  struct down_root_context *context = (struct down_root_context *) handle;
+
+  if (context && context->foreground_fd >= 0)
+    {
+      /* tell background process to exit */
+      send_control (context->foreground_fd, COMMAND_EXIT);
+      close (context->foreground_fd);
+      context->foreground_fd = -1;
+    }
+}
+
+/*
+ * Background process -- runs with privilege.
+ */
+static void
+down_root_server (const int fd, char *command, const char *argv[], const char *envp[], const int verb)
+{
+  const char *p[3];
+  char *command_line = NULL;
+  char *argv_cat = NULL;
+  int i;
+
+  /*
+   * Do initialization
+   */
+  if (DEBUG (verb))
+    fprintf (stderr, "DOWN-ROOT: BACKGROUND: INIT command='%s'\n", command);
+
+  /*
+   * Tell foreground that we initialized successfully
+   */
+  if (send_control (fd, RESPONSE_INIT_SUCCEEDED) == -1)
+    {
+      fprintf (stderr, "DOWN-ROOT: BACKGROUND: write error on response socket [1]\n");
+      goto done;
+    }
+
+  /*
+   * Build command line
+   */
+  if (string_array_len (argv) >= 2)
+    argv_cat = build_command_line (&argv[1]);
+  else
+    argv_cat = build_command_line (NULL);
+  p[0] = command;
+  p[1] = argv_cat;
+  p[2] = NULL;
+  command_line = build_command_line (p);
+
+  /*
+   * Save envp in environment
+   */
+  for (i = 0; envp[i]; ++i)
+    {
+      putenv ((char *)envp[i]);
+    }
+
+  /*
+   * Event loop
+   */
+  while (1)
+    {
+      int command_code;
+      int status;
+
+      /* get a command from foreground process */
+      command_code = recv_control (fd);
+
+      if (DEBUG (verb))
+	fprintf (stderr, "DOWN-ROOT: BACKGROUND: received command code: %d\n", command_code);
+
+      switch (command_code)
+	{
+	case COMMAND_RUN_SCRIPT:
+	  status = system (command_line);
+	  if (system_ok (status)) /* Succeeded */
+	    {
+	      if (send_control (fd, RESPONSE_SCRIPT_SUCCEEDED) == -1)
+		{
+		  fprintf (stderr, "DOWN-ROOT: BACKGROUND: write error on response socket [2]\n");
+		  goto done;
+		}
+	    }
+	  else /* Failed */
+	    {
+	      if (send_control (fd, RESPONSE_SCRIPT_FAILED) == -1)
+		{
+		  fprintf (stderr, "DOWN-ROOT: BACKGROUND: write error on response socket [3]\n");
+		  goto done;
+		}
+	    }
+	  break;
+
+	case COMMAND_EXIT:
+	  goto done;
+
+	case -1:
+	  fprintf (stderr, "DOWN-ROOT: BACKGROUND: read error on command channel\n");
+	  goto done;
+
+	default:
+	  fprintf (stderr, "DOWN-ROOT: BACKGROUND: unknown command code: code=%d, exiting\n",
+		   command_code);
+	  goto done;
+	}
+    }
+
+ done:
+  if (argv_cat)
+    free (argv_cat);
+  if (command_line)
+    free (command_line);
+  if (DEBUG (verb))
+    fprintf (stderr, "DOWN-ROOT: BACKGROUND: EXIT\n");
+
+  return;
+}
diff --git a/plugins/examples/README b/plugins/examples/README
new file mode 100644
index 0000000..4400cd3
--- /dev/null
+++ b/plugins/examples/README
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
diff --git a/plugins/examples/build b/plugins/examples/build
new file mode 100755
index 0000000..5907afa
--- /dev/null
+++ b/plugins/examples/build
@@ -0,0 +1,14 @@
+#!/bin/sh
+
+#
+# Build an OpenVPN plugin module on *nix.  The argument should
+# be the base name of the C source file (without the .c).
+#
+
+# This directory is where we will look for openvpn-plugin.h
+INCLUDE="-I../.."
+
+CC_FLAGS="-O2 -Wall -g"
+
+gcc $CC_FLAGS -fPIC -c $INCLUDE $1.c && \
+gcc $CC_FLAGS -fPIC -shared -Wl,-soname,$1.so -o $1.so $1.o -lc
diff --git a/plugins/examples/log.c b/plugins/examples/log.c
new file mode 100644
index 0000000..1cc4650
--- /dev/null
+++ b/plugins/examples/log.c
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
diff --git a/plugins/examples/log_v3.c b/plugins/examples/log_v3.c
new file mode 100644
index 0000000..187c592
--- /dev/null
+++ b/plugins/examples/log_v3.c
@@ -0,0 +1,249 @@
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
+#define USE_SSL
+#define USE_OPENSSL
+#include "ssl_verify_openssl.h"
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
diff --git a/plugins/examples/simple.c b/plugins/examples/simple.c
new file mode 100644
index 0000000..f26d89f
--- /dev/null
+++ b/plugins/examples/simple.c
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
diff --git a/plugins/examples/simple.def b/plugins/examples/simple.def
new file mode 100755
index 0000000..a87507d
--- /dev/null
+++ b/plugins/examples/simple.def
@@ -0,0 +1,6 @@
+LIBRARY   OpenVPN_PLUGIN_SAMPLE
+DESCRIPTION "Sample OpenVPN plug-in module."
+EXPORTS
+   openvpn_plugin_open_v1   @1
+   openvpn_plugin_func_v1   @2
+   openvpn_plugin_close_v1  @3
diff --git a/plugins/examples/winbuild b/plugins/examples/winbuild
new file mode 100755
index 0000000..97e724a
--- /dev/null
+++ b/plugins/examples/winbuild
@@ -0,0 +1,18 @@
+#
+# Build an OpenVPN plugin module on Windows/MinGW.
+# The argument should be the base name of the C source file
+# (without the .c).
+#
+
+# This directory is where we will look for openvpn-plugin.h
+INCLUDE="-I.."
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
-- 
1.7.3.4


