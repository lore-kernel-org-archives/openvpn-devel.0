From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 10 Jul 2024 18:02:38 +0200
Message-Id: <20240710160238.190189-1-frank@...2641...>
In-Reply-To: <gerrit.1715766485000.I1ef5f6f21f0135a628a63553c39515fa4549ce87@...2715...>
References: <gerrit.1715766485000.I1ef5f6f21f0135a628a63553c39515fa4549ce87@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Remove check for anonymous unions from
 configure and cmake config
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

From: Arne Schwabe <arne@...1227...>

Anonymous unions/structs are technically a custom GNU C99 feature but
was already widely supported by other compilers. With C11 this feature
has become a standard feature so all compilers nowadays support it.

Change-Id: I1ef5f6f21f0135a628a63553c39515fa4549ce87
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/588
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 720d679..18af5e9 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -65,9 +65,6 @@
 /* Enable --x509-username-field feature */
 #cmakedefine ENABLE_X509ALTUSERNAME
 
-/* Compiler supports anonymous unions */
-#define HAVE_ANONYMOUS_UNION_SUPPORT
-
 /* Define to 1 if you have the <arpa/inet.h> header file. */
 #cmakedefine HAVE_ARPA_INET_H 1
 
diff --git a/configure.ac b/configure.ac
index 555c97e..1f03f90 100644
--- a/configure.ac
+++ b/configure.ac
@@ -564,28 +564,6 @@
 	,
 	[[${SOCKET_INCLUDES}]]
 )
-AC_MSG_CHECKING([anonymous union support])
-AC_COMPILE_IFELSE(
-	[AC_LANG_PROGRAM(
-		[[
-			struct mystruct {
-			  union {
-			    int m1;
-			    char m2;
-			  };
-			};
-		]],
-		[[
-			struct mystruct s;
-			s.m1 = 1; s.m2 = 2;
-		]]
-	)],
-	[
-		AC_MSG_RESULT([yes])
-		AC_DEFINE([HAVE_ANONYMOUS_UNION_SUPPORT], [], [Compiler supports anonymous unions])
-	],
-	[AC_MSG_RESULT([no])]
-)
 
 saved_LDFLAGS="$LDFLAGS"
 LDFLAGS="$LDFLAGS -Wl,--wrap=exit"
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index bc58493..8b457d4 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -96,17 +96,7 @@
             uint8_t prefix[12];
             in_addr_t addr;     /* _network order_ IPv4 address */
         } v4mappedv6;
-    }
-#ifndef HAVE_ANONYMOUS_UNION_SUPPORT
-/* Wrappers to support compilers that do not grok anonymous unions */
-        mroute_union
-#define raw_addr mroute_union.raw_addr
-#define ether mroute_union.ether
-#define v4 mroute_union.v4
-#define v6 mroute_union.v6
-#define v4mappedv6 mroute_union.v4mappedv6
-#endif
-    ;
+    };
 };
 
 /* Double-check that struct packing works as expected */

