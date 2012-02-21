From: Alon Bar-Lev <alon.barlev@...277...>
Date: Tue, 21 Feb 2012 03:22:35 +0200
Message-Id: <1329787361-26096-30-git-send-email-alon.barlev@...277...>
In-Reply-To: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 29/35] build: proper selinux detection and
	usage
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


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac            |   35 +++++++++++++++--------------------
 src/openvpn/Makefile.am |    1 +
 src/openvpn/init.c      |    4 ++--
 src/openvpn/options.c   |    6 +++---
 src/openvpn/options.h   |    2 +-
 src/openvpn/syshead.h   |    2 +-
 6 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/configure.ac b/configure.ac
index 8bc23cc..3ffa0ee 100644
--- a/configure.ac
+++ b/configure.ac
@@ -214,7 +214,7 @@ AC_ARG_ENABLE(
 
 AC_ARG_ENABLE(
 	[selinux],
-	[AS_HELP_STRING([--disable-selinux], [disable SELinux support])],
+	[AS_HELP_STRING([--enable-selinux], [enable SELinux support])],
 	,
 	[enable_selinux="no"]
 )
@@ -605,6 +605,13 @@ AC_CHECK_LIB(
 )
 AC_SUBST([SOCKETS_LIBS])
 
+AC_CHECK_LIB(
+	[selinux],
+	[setcon],
+	[SELINUX_LIBS="-lselinux"]
+)
+AC_SUBST([SELINUX_LIBS])
+
 case "${with_mem_check}" in
 	valgrind)
 		AC_CHECK_HEADER(
@@ -812,25 +819,6 @@ if test "${enable_crypto}" = "yes"; then
    fi
 fi
 
-dnl
-dnl check for SELinux library and headers
-dnl
-if test "${enable_selinux}" = "yes"; then
-	AC_CHECK_HEADER(
-		[selinux/selinux.h],
-		[AC_CHECK_LIB(
-			[selinux],
-			[setcon],
-			[
-				LIBS="${LIBS} -lselinux"
-				AC_DEFINE(HAVE_SETCON, 1, [SELinux support])
-			],
-			[AC_MSG_RESULT([SELinux library not found.])]
-		)],
-		[AC_MSG_ERROR([SELinux headers not found.])]
-	)
-fi
-
 dnl enable --x509-username-field feature if requested
 if test "${enable_x509_alt_username}" = "yes"; then
 	if test "${with_ssl_type}" = "polarssl" ; then
@@ -874,6 +862,12 @@ else
 	fi
 fi
 
+if test "${enable_selinux}" = "yes"; then
+	test -z "${SELINUX_LIBS}" && AC_MSG_ERROR([libselinux required but missing])
+	OPTIONAL_SELINUX_LIBS="${SELINUX_LIBS}"
+	AC_DEFINE([ENABLE_SELINUX], [1], [SELinux support])
+fi
+
 if test "${enable_pedantic}" = "yes"; then
 	enable_strict="yes"
 	CFLAGS="${CFLAGS} -ansi -pedantic"
@@ -900,6 +894,7 @@ AC_SUBST([TAP_WIN_MIN_MAJOR])
 AC_SUBST([TAP_WIN_MIN_MINOR])
 
 AC_SUBST([OPTIONAL_DL_LIBS])
+AC_SUBST([OPTIONAL_SELINUX_LIBS])
 
 AM_CONDITIONAL([WIN32], [test "${WIN32}" = "yes"])
 
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 4783574..7645e2f 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -97,6 +97,7 @@ openvpn_SOURCES = \
 	cryptoapi.h cryptoapi.c
 openvpn_LDADD = \
 	$(SOCKETS_LIBS) \
+	$(OPTIONAL_SELINUX_LIBS) \
 	$(OPTIONAL_DL_LIBS)
 if WIN32
 openvpn_SOURCES += openvpn_win32_resources.rc
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index fb8fe00..f2faef3 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1038,7 +1038,7 @@ do_uid_gid_chroot (struct context *c, bool no_delay)
 	mstats_open(c->options.memstats_fn);
 #endif
 
-#ifdef HAVE_SETCON
+#ifdef ENABLE_SELINUX
       /* Apply a SELinux context in order to restrict what OpenVPN can do
        * to _only_ what it is supposed to do after initialization is complete
        * (basically just network I/O operations). Doing it after chroot
@@ -2463,7 +2463,7 @@ do_option_warnings (struct context *c)
     msg (M_WARN, "WARNING: --ping should normally be used with --ping-restart or --ping-exit");
 
   if (o->username || o->groupname || o->chroot_dir
-#ifdef HAVE_SETCON
+#ifdef ENABLE_SELINUX
       || o->selinux_context
 #endif
       )
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8577dac..ff5bf08 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -316,7 +316,7 @@ static const char usage_message[] =
   "--user user     : Set UID to user after initialization.\n"
   "--group group   : Set GID to group after initialization.\n"
   "--chroot dir    : Chroot to this directory after initialization.\n"
-#ifdef HAVE_SETCON
+#ifdef ENABLE_SELINUX
   "--setcon context: Apply this SELinux context after initialization.\n"
 #endif
   "--cd dir        : Change to this directory before initialization.\n"
@@ -1477,7 +1477,7 @@ show_settings (const struct options *o)
   SHOW_STR (groupname);
   SHOW_STR (chroot_dir);
   SHOW_STR (cd_dir);
-#ifdef HAVE_SETCON
+#ifdef ENABLE_SELINUX
   SHOW_STR (selinux_context);
 #endif
   SHOW_STR (writepid);
@@ -4525,7 +4525,7 @@ add_option (struct options *options,
 	}
       options->cd_dir = p[1];
     }
-#ifdef HAVE_SETCON
+#ifdef ENABLE_SELINUX
   else if (streq (p[0], "setcon") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 6af4b3a..57b88b7 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -310,7 +310,7 @@ struct options
   const char *groupname;
   const char *chroot_dir;
   const char *cd_dir;
-#ifdef HAVE_SETCON
+#ifdef ENABLE_SELINUX
   char *selinux_context;
 #endif
   const char *writepid;
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 00b7bfc..745f944 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -174,7 +174,7 @@
 #include <sys/epoll.h>
 #endif
 
-#ifdef HAVE_SETCON
+#ifdef ENABLE_SELINUX
 #include <selinux/selinux.h>
 #endif
 
-- 
1.7.3.4


