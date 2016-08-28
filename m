From: Steffan Karger <steffan@...1856...>
Date: Sun, 28 Aug 2016 23:15:18 +0200
Message-Id: <1472418918-28566-1-git-send-email-steffan@...1856...>
In-Reply-To: <1472413323-21723-1-git-send-email-steffan@...1856...>
References: <1472413323-21723-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH v2] Drop gnu89/c89 support, switch to c99
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

Previously, we would use the compiler's default C version, which defaults
to gnu89 for GCC < 5, gnu11 for GCC > 5, and c11 for clang, but might even
differ per distro.

One of the reasons to accept the gnu89 default of GCC < 4.9, was that MSVC
didn't support c99.  But in MSVC 2015, MS finanally fixed that.

Having to support c89 in the codebase occasionally forces us to write less
readable code, for example by forcing all declaration to be at the starting
of a block (which includes 'for loop initial declarations').

Let's be clear about what standard we obey, and stop punishing ourselves
with c89/gnu89.  Let's switch the master branch to c99.

v2: don't try to detect pedantic mode based on __STRICT_ANSI__, since that
    will be defined when using -std=c99.  (We might want to remove this
    cripple-binary-if-pedantic all together later on, but I'm not pulling
    that into this patch.)

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac          | 3 ++-
 src/openvpn/syshead.h | 5 +----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9189c94..5e3ce01 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1125,10 +1125,11 @@ if test "${enable_pkcs11}" = "yes"; then
 	)
 fi
 
+CFLAGS="${CFLAGS} -std=c99"
 if test "${enable_pedantic}" = "yes"; then
 	enable_strict="yes"
 	CFLAGS="${CFLAGS} -pedantic"
-	test "${WIN32}" != "yes" && CFLAGS="${CFLAGS} -std=c99"
+	AC_DEFINE([PEDANTIC], [1], [Enable pedantic mode])
 fi
 if test "${enable_strict}" = "yes"; then
 	CFLAGS="${CFLAGS} -Wall -Wno-unused-parameter -Wno-unused-function"
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index c8391ca..e969ccf 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -384,16 +384,13 @@
  * Pedantic mode is meant to accomplish lint-style program checking,
  * not to build a working executable.
  */
-#ifdef __STRICT_ANSI__
-# define PEDANTIC 1
+#ifdef PEDANTIC
 # undef HAVE_CPP_VARARG_MACRO_GCC
 # undef HAVE_CPP_VARARG_MACRO_ISO
 # undef EMPTY_ARRAY_SIZE
 # define EMPTY_ARRAY_SIZE 1
 # undef inline
 # define inline
-#else
-# define PEDANTIC 0
 #endif
 
 /*
-- 
2.7.4


