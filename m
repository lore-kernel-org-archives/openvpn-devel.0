From: Charles Duffy <cduffy@...294...>
In-Reply-To: <1100311165.30425.27.camel@...23...>
References: <1100311165.30425.27.camel@...23...>
Message-Id: <1100329858.30425.44.camel@...23...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Certificate Wizard cross-compilation autodetection
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Nov 12 23:12:01 2004
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
To: Vlada Macek <tuttle@...289...>
Cc: openvpn-devel@lists.sourceforge.net

The below patch to the My Certificate Wizard makefile attempts to
determine whether a cross-compiler is available, and uses it if
possible. I'd like to see it applied, such that both folks on win32 and
*nix can use the same makefile w/o needing to twiddle it after checkout.

I haven't tested it on native win32; if the CROSSFOUND variable's
determination doesn't work in your environment, I'd appreciate any
suggestions wrt a better approach.

Thanks!

(Like my other non-private changes, this is available via GNU Arch; it
can either be checked out or branched from my archive, or just browsed
via the web address below once these changes get pulled by
sourcecontrol.net).
http://archzoom.sourcecontrol.net/demo/cduffy@...311.../mycert--fixes--0.3


--- orig/Makefile
+++ mod/Makefile
@@ -15,14 +15,19 @@
 
 OBJS = mycert.o request.o misc.o mycert-res.o customize.o
 
+CROSSTGT := i586-mingw32msvc
+CROSSFOUND := $(shell which ${CROSSTGT}-gcc 2>/dev/null >/dev/null && echo YES || echo NO )
+
+ifeq (${CROSSFOUND},YES)
+  ## Cross-compiling
+  CC = ${CROSSTGT}-gcc
+  WINDRES = ${CROSSTGT}-windres
+else
+  ## For Windows using the mingw/msys environment
+  CC = gcc
+  WINDRES = windres
+endif
 
-## For Windows using the mingw/msys environment
-CC = gcc
-WINDRES = windres
-
-## Cross-compiling from Debian
-#CC = i586-mingw32msvc-gcc
-#WINDRES = i586-mingw32msvc-windres
 
 CFLAGS = -DREGULAR_EXPRESSIONS -O3 -Wall -Wno-unused-function -Wno-unused-variable -mno-cygwin
 LDFLAGS = -mwindows -s -leay32



