From: Roy Marples <uberlord@...594...>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ow5MEGt4S2ZE7Do"
Message-Id: <200604051130.00196.uberlord@...594...>
Subject: [Openvpn-devel] [PATCH] Enable compliation under Darwin
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
Date: Wed Apr  5 03:31:02 2006
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

--Boundary-00=_ow5MEGt4S2ZE7Do
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi List!

Attached is a patch we use in Gentoo (well, the only patch) that allows 
compilation on on ppc-macos (Darwin). I don't have this platform myself, but 
our ppc-macos users seem to need it, so I'm submitting it for upstream 
inclusion.

Thanks!

-- 
Roy Marples <uberlord@...594...>
Gentoo Linux Developer

--Boundary-00=_ow5MEGt4S2ZE7Do
Content-Type: text/x-diff;
  charset="us-ascii";
  name="openvpn-2.0.4-darwin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="openvpn-2.0.4-darwin.patch"

--- openvpn-2.0.4/plugin/down-root/Makefile.orig	2005-11-02 20:25:40.000000000 +0100
+++ openvpn-2.0.4/plugin/down-root/Makefile	2005-11-02 20:31:53.000000000 +0100
@@ -7,11 +7,22 @@
 
 CC_FLAGS=-O2 -Wall
 
+ifeq ($(USERLAND),Darwin)
+	LIBNAME=dylib
+else
+	LIBNAME=so
+endif
+
+lib : down-root.$(LIBNAME)
+
 down-root.so : down-root.o
 	gcc ${CC_FLAGS} -fPIC -shared -Wl,-soname,openvpn-down-root.so -o openvpn-down-root.so down-root.o -lc
 
+down-root.dylib : down-root.o
+	gcc ${CC_FLAGS} -dynamiclib -install_name openvpn-down-root.dylib -o openvpn-down-root.dylib down-root.o -lc
+
 down-root.o : down-root.c
 	gcc ${CC_FLAGS} -fPIC -c ${INCLUDE} down-root.c
 
 clean :
-	rm -f *.o *.so
+	rm -f *.o *.so *.dylib

--Boundary-00=_ow5MEGt4S2ZE7Do--

