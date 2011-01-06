From: Matthias Andree <matthias.andree@...68...>
Date: Thu,  6 Jan 2011 18:08:35 +0100
Message-Id: <1294333715-28771-3-git-send-email-matthias.andree@...68...>
In-Reply-To: <4D1CFF2B.6030006@...68...>
References: <4D1CFF2B.6030006@...68...>
Subject: [Openvpn-devel] [PATCH 2/2] Hook auth-pam and down-root to the
	build.
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
Cc: Matthias Andree <matthias.andree@...68...>

This includes autoconf checks so we only build auth-pam on systems that have
security/pam_appl.h
---
 Makefile.am   |   16 ++++++++++++++++
 configure.ac  |   10 ++++++++++
 m4/README     |    3 +++
 plugin/README |   13 +++++++------
 4 files changed, 36 insertions(+), 6 deletions(-)
 create mode 100644 m4/README

diff --git a/Makefile.am b/Makefile.am
index ad0f7e3..3918cf7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -29,6 +29,8 @@ LDADD = @LIBOBJS@
 # INSTALL targets:
 AUTOMAKE_OPTIONS = foreign
 
+ACLOCAL_AMFLAGS = -I m4
+
 MAINTAINERCLEANFILES = \
 	config.log config.status \
 	$(srcdir)/Makefile.in \
@@ -141,6 +143,20 @@ openvpn_SOURCES = \
 	win32.h win32.c \
 	cryptoapi.h cryptoapi.c
 
+# building default plugins
+pkglib_LTLIBRARIES =	down-root.la
+if HAVE_PAM
+pkglib_LTLIBRARIES +=	auth-pam.la
+endif
+libtoolmoduleflags =	-module -avoid-version
+down_root_la_SOURCES =	plugin/down-root/down-root.c
+down_root_la_LDFLAGS =	$(libtoolmoduleflags)
+
+auth_pam_la_SOURCES =	plugin/auth-pam/auth-pam.c \
+			plugin/auth-pam/pamdl.h \
+			plugin/auth-pam/pamdl.c
+auth_pam_la_LIBADD =	-lpam
+auth_pam_la_LDFLAGS =	$(libtoolmoduleflags)
 
 dist-hook:
 	cd $(distdir) && for i in $(EXTRA_DIST) $(SUBDIRS) ; do find $$i -name .svn -type d -prune -exec rm -rf '{}' ';' ; rm -f `find $$i -type f | grep -E '(^|\/)\.?\#|\~$$|\.s?o$$'` ; done
diff --git a/configure.ac b/configure.ac
index 529abd3..f6280cd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -29,6 +29,7 @@ m4_include(version.m4)
 AC_INIT([OpenVPN], [PRODUCT_VERSION], [openvpn-users@lists.sourceforge.net], [openvpn])
 AM_CONFIG_HEADER(config.h)
 AC_CONFIG_SRCDIR(syshead.h)
+AC_CONFIG_MACRO_DIR([m4])
 
 dnl Guess host type.
 AC_CANONICAL_HOST
@@ -332,6 +333,11 @@ dnl Checks for programs.
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_PROG_GCC_TRADITIONAL
+LT_INIT([disable-static])
+dnl we need to dlopen() things, later, we might
+dnl look into libltdl stuff that can possibly link the plugin
+dnl statically, but I suppose that takes changes to plugin.? code,
+dnl too.  -- Matthias Andree, 2011-01-06
 
 if test "${WIN32}" = "yes"; then
 	AC_ARG_VAR([MAN2HTML], [man2html utility])
@@ -373,7 +379,9 @@ if test "${WIN32}" != "yes"; then
 		 netinet/tcp.h arpa/inet.h dnl
 		 netdb.h sys/uio.h linux/if_tun.h linux/sockios.h dnl
 		 linux/types.h sys/poll.h sys/epoll.h err.h dnl
+		 security/pam_appl.h dnl
    )
+
    AC_CHECK_HEADERS(net/if.h,,,
 		 [#ifdef HAVE_SYS_TYPES_H
 		  # include <sys/types.h>
@@ -416,6 +424,8 @@ if test "${WIN32}" != "yes"; then
 	])
 fi
 
+AM_CONDITIONAL(HAVE_PAM, test "$ac_cv_header_security_pam_appl_h" = yes)
+
 AC_CACHE_SAVE
 
 dnl check that in_addr_t is defined
diff --git a/m4/README b/m4/README
new file mode 100644
index 0000000..8f83679
--- /dev/null
+++ b/m4/README
@@ -0,0 +1,3 @@
+This directory is empty in the Git repository and gets
+populated by libtoolize (which is usually run automatically from
+autoreconf).
diff --git a/plugin/README b/plugin/README
index 6e490c5..7f8d805 100644
--- a/plugin/README
+++ b/plugin/README
@@ -2,8 +2,8 @@ OpenVPN Plugins
 ---------------
 
 Starting with OpenVPN 2.0-beta17, compiled plugin modules are
-supported on any *nix OS which includes libdl or on Windows.
-One or more modules may be loaded into OpenVPN using
+supported on any *nix OS which includes libdl, or on Windows.
+   One or more modules may be loaded into OpenVPN using
 the --plugin directive, and each plugin module is capable of
 intercepting any of the script callbacks which OpenVPN supports:
 
@@ -28,7 +28,7 @@ auth-pam -- Authenticate using PAM and a split privilege
             execution model which functions even if
             root privileges or the execution environment
             have been altered with --user/--group/--chroot.
-            Tested on Linux only.
+            Tested on Linux only.  
 
 down-root -- Enable the running of down scripts with root privileges
              even if --user/--group/--chroot have been used
@@ -42,6 +42,7 @@ examples -- A simple example that demonstrates a portable
 Building Plugins
 ----------------
 
-cd to the top-level directory of a plugin, and use the
-"make" command to build it.  The examples plugin is
-built using a build script, not a makefile.
+The auth-pam and down-root modules are built as part of the regular
+OpenVPN build.  Other than that, cd to the top-level directory of a
+plugin, and use the "make" command to build it.  The examples plugin is
+built using a build script, not a Makefile.
-- 
1.7.1


