From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20030219204918.GD18493@...33...>
References: <20030219181048.GA21087@...33...> <Pine.LNX.4.44.0302191128560.12503-100000@...41...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.44.0302191128560.12503-100000@...41...>
Subject: [Openvpn-devel] First half of macro-vs-function hacks (was: Pre-1.3.3 beta available for testing)
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Feb 19 12:50:07 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Jim,

this is the configure.ac part of the variadic macro test patch, it seems
to work OK and cache the results.

I have added also some unrelated AC_CACHE_SAVE (supported since autoconf
2.13) to checkpoint the cache should some later test fail, so the user
can more quickly pick up when she typed "./configure -C".

This patch is against my previous one, so if it fails, try patch -F1 or
-F2 to narrow the context patch looks at. If that doesn't help, I can
send the whole file or a patch against current CVS.

Feel free to try it. To my astonishment, the SUNpro WorkShop compiler
seems to know ISO C99 but not the GCC-style variadic macros. I'll
investigate some more and might refine this test.

diff -u configure.ac configure.ac
--- configure.ac	19 Feb 2003 15:04:00 -0000
+++ configure.ac	19 Feb 2003 20:39:54 -0000
@@ -148,6 +148,38 @@
 AC_TYPE_UID_T
 AC_HEADER_TIME
 
+dnl See if the compiler supports variadic macros
+dnl GCC-style
+AC_MSG_CHECKING(if your preprocessor supports GCC-style variadic macros)
+AC_CACHE_VAL(openvpn_cv_c_varmac_gcc,
+AC_COMPILE_IFELSE([[
+		   #include <stdio.h>
+		   #define mymac(first, second...) printf(first, ## second)
+		   main() { mymac("%s", "test"); }
+		   ]],
+		   [openvpn_cv_c_varmac_gcc=yes],
+		   [openvpn_cv_c_varmac_gcc=no]))
+AC_MSG_RESULT($openvpn_cv_c_varmac_gcc)
+if test $openvpn_cv_c_varmac_gcc = yes ; then
+    AC_DEFINE(OPENVPN_VARMAC_GCC, [1], [Define to 1 if your preprocessor supports GCC-style variadic macros.])
+fi
+
+dnl ISO C99-style
+AC_MSG_CHECKING(if your preprocessor supports ISO C99 variadic macros)
+AC_CACHE_VAL(openvpn_cv_c_varmac_isoc99,
+AC_COMPILE_IFELSE([[
+		   #include <stdio.h>
+		   #define mymac(first, ...) printf(first, __VA_ARGS__)
+		   main() { mymac("%s", "test"); }
+		   ]],
+		   [openvpn_cv_c_varmac_isoc99=yes],
+		   [openvpn_cv_c_varmac_isoc99=no]))
+AC_MSG_RESULT($openvpn_cv_c_varmac_isoc99)
+if test $openvpn_cv_c_varmac_isoc99 = yes ; then
+    AC_DEFINE(OPENVPN_VARMAC_ISOC99, [1], [Define to 1 if your preprocessor supports ISO C99 variadic macros.])
+fi
+AC_CACHE_SAVE
+
 dnl Check for more header files.
 AC_HEADER_SYS_WAIT
 AC_CHECK_HEADERS(sys/time.h)
@@ -184,6 +216,7 @@
 AC_CHECK_HEADERS(netdb.h)
 AC_CHECK_HEADERS(sys/uio.h)
 AC_CHECK_HEADERS(linux/if_tun.h)
+AC_CACHE_SAVE
 
 dnl check that in_addr_t is defined
 AC_CHECK_TYPE(
@@ -220,6 +253,7 @@
 	[AC_DEFINE(HAVE_IOVEC, 1, [struct iovec needed for IPv6 support])],
 	[],
 	[#include "syshead.h"])
+AC_CACHE_SAVE
 
 dnl check for other types
 TYPE_SOCKLEN_T
@@ -257,6 +291,7 @@
 AC_CHECK_FUNCS(readv)
 AC_CHECK_FUNCS(writev)
 AC_CHECK_FUNCS(setsockopt)
+AC_CACHE_SAVE
 
 dnl Required library functions
 AC_FUNC_MEMCMP

