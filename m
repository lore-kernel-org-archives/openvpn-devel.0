From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 12 Mar 2020 05:03:23 +0200
Message-Id: <20200312030323.19293-1-lstipakov@...277...>
In-Reply-To: <20200312020135.20510-1-lstipakov@...277...>
References: <20200312020135.20510-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH v2] Fix building with --enable-async-push in
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

Detect presence of libinotify and link with its _LIBS variable.

Trac #1256

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 
 v2: use PKG_CHECK_MODULES instead of hardcoded -linotify

 configure.ac            | 9 +++++++++
 src/openvpn/Makefile.am | 3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index a47ef3e7..085e7b69 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1344,6 +1344,14 @@ if test "${enable_async_push}" = "yes"; then
 		AC_DEFINE([ENABLE_ASYNC_PUSH], [1], [Enable async push]),
 		AC_MSG_ERROR([inotify.h not found.])
 	)
+	case "$host" in
+		*-*-freebsd*)
+			PKG_CHECK_MODULES(
+				[OPTIONAL_INOTIFY],
+				[libinotify]
+			)
+		;;
+	esac
 fi
 
 CONFIGURE_DEFINES="`set | grep '^enable_.*=' ; set | grep '^with_.*='`"
@@ -1370,6 +1378,7 @@ AC_SUBST([OPTIONAL_LZ4_LIBS])
 AC_SUBST([OPTIONAL_SYSTEMD_LIBS])
 AC_SUBST([OPTIONAL_PKCS11_HELPER_CFLAGS])
 AC_SUBST([OPTIONAL_PKCS11_HELPER_LIBS])
+AC_SUBST([OPTIONAL_INOTIFY_LIBS])
 
 AC_SUBST([PLUGIN_AUTH_PAM_CFLAGS])
 AC_SUBST([PLUGIN_AUTH_PAM_LIBS])
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 2ea47cda..b924014d 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -137,7 +137,8 @@ openvpn_LDADD = \
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


