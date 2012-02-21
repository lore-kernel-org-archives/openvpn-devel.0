From: Alon Bar-Lev <alon.barlev@...277...>
Date: Tue, 21 Feb 2012 03:22:33 +0200
Message-Id: <1329787361-26096-28-git-send-email-alon.barlev@...277...>
In-Reply-To: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 27/35] build: properly detect and use socket
	libs
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
 configure.ac            |   27 +++++++++++++++++----------
 src/openvpn/Makefile.am |    3 ++-
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/configure.ac b/configure.ac
index e893d8d..d18e2b0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -428,16 +428,6 @@ if test "${WIN32}" != "yes"; then
 		[[${SOCKET_INCLUDES}]]
 	)
 
-	AC_CHECK_DECLS(
-		[SO_MARK],
-		,
-		,
-		[[${SOCKET_INCLUDES}]]
-	)
-
-	AC_SEARCH_LIBS([socket], [socket])
-	AC_SEARCH_LIBS([inet_ntoa], [nsl])
-	AC_SEARCH_LIBS([gethostbyname], [resolv nsl])
 	AC_FUNC_FORK
 fi
 
@@ -599,6 +589,23 @@ AC_CHECK_LIB(
 )
 AC_SUBST([DL_LIBS])
 
+AC_CHECK_LIB(
+	[nsl],
+	[inet_ntoa],
+	[SOCKETS_LIBS="${SOCKETS_LIBS} -lnsl"]
+)
+AC_CHECK_LIB(
+	[socket],
+	[socket],
+	[SOCKETS_LIBS="${SOCKETS_LIBS} -lsocket"]
+)
+AC_CHECK_LIB(
+	[resolv],
+	[gethostbyname],
+	[SOCKETS_LIBS="${SOCKETS_LIBS} -lresolv"]
+)
+AC_SUBST([SOCKETS_LIBS])
+
 case "${with_mem_check}" in
 	valgrind)
 		AC_CHECK_HEADER(
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index cc00e27..4783574 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -96,8 +96,9 @@ openvpn_SOURCES = \
 	win32.h win32.c \
 	cryptoapi.h cryptoapi.c
 openvpn_LDADD = \
+	$(SOCKETS_LIBS) \
 	$(OPTIONAL_DL_LIBS)
 if WIN32
 openvpn_SOURCES += openvpn_win32_resources.rc
-openvpn_LDADD = -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lshell32
+openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lshell32
 endif
-- 
1.7.3.4


