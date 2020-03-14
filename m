From: Lev Stipakov <lstipakov@...277...>
Date: Sat, 14 Mar 2020 02:59:57 +0200
Message-Id: <20200314005957.20411-1-lstipakov@...277...>
In-Reply-To: <20200314123531.GD1431@...1296...>
References: <20200314123531.GD1431@...1296...>
Subject: [Openvpn-devel] [PATCH v3] Fix building with --enable-async-push in
 FreeBSD
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

This option can be used in FreedBSD with devel/libinotify
installed.

Detect presence of libinotify with pkgconf and use its word
to compile and link.

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---

 v3: use _CFLAGS from pkgconf to get include dir

 v2: use _LIBS from pkgcong instead of hardcoded -linotify
 

 configure.ac            | 26 +++++++++++++++++++++-----
 src/openvpn/Makefile.am |  4 +++-
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index a47ef3e7..4a86089b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1339,11 +1339,25 @@ if test "${enable_plugin_auth_pam}" = "yes"; then
 fi
 
 if test "${enable_async_push}" = "yes"; then
-	AC_CHECK_HEADERS(
-		[sys/inotify.h],
-		AC_DEFINE([ENABLE_ASYNC_PUSH], [1], [Enable async push]),
-		AC_MSG_ERROR([inotify.h not found.])
-	)
+	case "$host" in
+		*-*-freebsd*)
+			PKG_CHECK_MODULES(
+				[OPTIONAL_INOTIFY],
+				[libinotify],
+				[
+					AC_DEFINE([HAVE_SYS_INOTIFY_H]),
+					AC_DEFINE([ENABLE_ASYNC_PUSH], [1], [Enable async push])
+				],
+			)
+		;;
+		*)
+			AC_CHECK_HEADERS(
+				[sys/inotify.h],
+				AC_DEFINE([ENABLE_ASYNC_PUSH], [1], [Enable async push]),
+				AC_MSG_ERROR([inotify.h not found.])
+			)
+		;;
+	esac
 fi
 
 CONFIGURE_DEFINES="`set | grep '^enable_.*=' ; set | grep '^with_.*='`"
@@ -1370,6 +1384,8 @@ AC_SUBST([OPTIONAL_LZ4_LIBS])
 AC_SUBST([OPTIONAL_SYSTEMD_LIBS])
 AC_SUBST([OPTIONAL_PKCS11_HELPER_CFLAGS])
 AC_SUBST([OPTIONAL_PKCS11_HELPER_LIBS])
+AC_SUBST([OPTIONAL_INOTIFY_CFLAGS])
+AC_SUBST([OPTIONAL_INOTIFY_LIBS])
 
 AC_SUBST([PLUGIN_AUTH_PAM_CFLAGS])
 AC_SUBST([PLUGIN_AUTH_PAM_LIBS])
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 2ea47cda..f0e0ad23 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -28,6 +28,7 @@ AM_CFLAGS = \
 	$(OPTIONAL_LZO_CFLAGS) \
 	$(OPTIONAL_LZ4_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \
+	$(OPTIONAL_INOTIFY_CFLAGS) \
 	-DPLUGIN_LIBDIR=\"${plugindir}\"
 
 if WIN32
@@ -137,7 +138,8 @@ openvpn_LDADD = \
 	$(OPTIONAL_CRYPTO_LIBS) \
 	$(OPTIONAL_SELINUX_LIBS) \
 	$(OPTIONAL_SYSTEMD_LIBS) \
-	$(OPTIONAL_DL_LIBS)
+	$(OPTIONAL_DL_LIBS) \
+	$(OPTIONAL_INOTIFY_LIBS)
 if WIN32
 openvpn_SOURCES += openvpn_win32_resources.rc block_dns.c block_dns.h ring_buffer.c ring_buffer.h
 openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi
-- 
2.17.1


