From: Alon Bar-Lev <alon.barlev@...277...>
Date: Mon, 26 Mar 2012 23:26:36 +0200
Message-Id: <1332797200-9295-3-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
References: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
Subject: [Openvpn-devel] [PATCH 2/6] build: tap: search for tap header
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

Windows and solaris has something in common, in both
the tap header is external. So make the Windows tap-windows.h
search common to all platform.

Display an error if we cannot find tap header.

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac            |   32 ++++++++++++++++----------------
 src/openvpn/Makefile.am |    2 +-
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/configure.ac b/configure.ac
index b0dcdb7..d217343 100644
--- a/configure.ac
+++ b/configure.ac
@@ -365,11 +365,9 @@ AC_CHECK_HEADERS([ \
 AC_CHECK_HEADERS([ \
 	sys/time.h sys/un.h sys/ioctl.h sys/stat.h \
 	sys/mman.h sys/file.h \
-	unistd.h signal.h libgen.h \
+	unistd.h signal.h libgen.h stropts.h \
 	syslog.h pwd.h grp.h \
-	net/if_tun.h net/tun/if_tun.h stropts.h \
-	sys/sockio.h \
-	sys/uio.h linux/if_tun.h linux/sockios.h \
+	sys/sockio.h sys/uio.h linux/sockios.h \
 	linux/types.h sys/poll.h sys/epoll.h err.h \
 ])
 
@@ -586,6 +584,20 @@ else
 fi
 LIBS="${old_LIBS}"
 
+AC_ARG_VAR([TAP_CFLAGS], [C compiler flags for tap])
+old_CFLAGS="${CFLAGS}"
+CFLAGS="${CFLAGS} ${TAP_CFLAGS}"
+AC_CHECK_HEADERS(
+	[ \
+		net/if_tun.h net/tun/if_tun.h \
+		linux/if_tun.h \
+		tap-windows.h \
+	],
+	[have_tap_header="yes"]
+)
+CFLAGS="${old_CFLAGS}"
+test "${have_tap_header}" = "yes" || AC_MSG_ERROR([no tap header could be found])
+
 AC_CHECK_LIB(
 	[selinux],
 	[setcon],
@@ -672,18 +684,6 @@ PKG_CHECK_MODULES(
 	)]
 )
 
-AC_ARG_VAR([TAP_WINDOWS_CFLAGS], [C compiler flags for TAP-Windows])
-if test "${WIN32}" = "yes"; then
-	old_CFLAGS="${CFLAGS}"
-	CFLAGS="${CFLAGS} ${TAP_WINDOWS_CFLAGS}"
-	AC_CHECK_HEADERS(
-		[tap-windows.h],
-		,
-		[AC_MSG_ERROR([tap-windows.h is required but missing])]
-	)
-	CFLAGS="${old_CFLAGS}"
-fi
-
 if test "${have_openssl_crypto}" = "yes"; then
 	saved_CFLAGS="${CFLAGS}"
 	saved_LIBS="${LIBS}"
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 1410021..01ff732 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -22,7 +22,7 @@ INCLUDES = \
 	-I$(top_srcdir)/src/compat
 
 AM_CFLAGS = \
-	$(TAP_WINDOWS_CFLAGS) \
+	$(TAP_CFLAGS) \
 	$(OPTIONAL_CRYPTO_CFLAGS) \
 	$(OPTIONAL_LZO_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS)
-- 
1.7.3.4


