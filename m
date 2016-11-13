From: Steffan Karger <steffan@...1856...>
Date: Sun, 13 Nov 2016 19:03:23 +0100
Message-Id: <1479060203-4472-1-git-send-email-steffan@...1856...>
In-Reply-To: <20161113154337.GA6684@...1296...>
References: <20161113154337.GA6684@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix builds on compilers without anonymous
	union support
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

The "Don't dereference type-punned pointers" patch introduced an anonymous
union, which older compilers do not support (or refuse to support when
-std=c99 is defined).  Add a configure check, and some wrapper defines to
repair builds on those compilers.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac         | 34 ++++++++++++++++++++++++++++------
 src/openvpn/mroute.h | 12 +++++++++++-
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index 357ba29..bba29b2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -390,6 +390,12 @@ AC_DEFINE_UNQUOTED([IPROUTE_PATH], ["$IPROUTE"], [Path to iproute tool])
 AC_DEFINE_UNQUOTED([ROUTE_PATH], ["$ROUTE"], [Path to route tool])
 AC_DEFINE_UNQUOTED([SYSTEMD_ASK_PASSWORD_PATH], ["$SYSTEMD_ASK_PASSWORD"], [Path to systemd-ask-password tool])
 
+# Set -std=c99 unless user already specified a -std=
+case "${CFLAGS}" in
+  *-std=*) ;;
+  *)       CFLAGS="${CFLAGS} -std=c99" ;;
+esac
+
 #
 # Libtool
 #
@@ -547,6 +553,28 @@ AC_CHECK_DECLS(
 	,
 	[[${SOCKET_INCLUDES}]]
 )
+AC_CHECKING([anonymous union support])
+AC_COMPILE_IFELSE(
+	[AC_LANG_PROGRAM(
+		[[
+			struct mystruct {
+			  union {
+			    int m1;
+			    char m2;
+			  };
+			};
+		]],
+		[[
+			struct mystruct s;
+			s.m1 = 1; s.m2 = 2;
+		]]
+	)],
+	[
+		AC_MSG_RESULT([yes])
+		AC_DEFINE([HAVE_ANONYMOUS_UNION_SUPPORT], [], [Compiler supports anonymous unions])
+	],
+	[AC_MSG_RESULT([no])]
+)
 
 dnl We emulate signals in Windows
 AC_CHECK_DECLS(
@@ -1142,12 +1170,6 @@ if test "${enable_pkcs11}" = "yes"; then
 	)
 fi
 
-# Set -std=c99 unless user already specified a -std=
-case "${CFLAGS}" in
-  *-std=*) ;;
-  *)       CFLAGS="${CFLAGS} -std=c99" ;;
-esac
-
 if test "${enable_pedantic}" = "yes"; then
 	enable_strict="yes"
 	CFLAGS="${CFLAGS} -pedantic"
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 5fe17e7..8f7a064 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -96,7 +96,17 @@ struct mroute_addr {
       uint8_t prefix[12];
       in_addr_t addr;		/* _network order_ IPv4 address */
     } v4mappedv6;
-  };
+  }
+#ifndef HAVE_ANONYMOUS_UNION_SUPPORT
+/* Wrappers to support compilers that do not grok anonymous unions */
+  mroute_union
+#define raw_addr mroute_union.raw_addr
+#define eth_addr mroute_union.eth_addr
+#define v4 mroute_union.v4
+#define v6 mroute_union.v6
+#define v4mappedv6 mroute_union.v4mappedv6
+#endif
+  ;
 };
 
 /* Double-check that struct packing works as expected */
-- 
2.7.4


