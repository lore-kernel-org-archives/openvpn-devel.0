From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20050720092613.GA29615@...33...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
Subject: [Openvpn-devel] [PATCH 2/2] 2.0.1-rc6: support LZO 2.01 (liblzo.* -> liblzo2.*)
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
Date: Wed Jul 20 02:27:10 2005
To: openvpn-devel@lists.sourceforge.net

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached patch checks for liblzo2 if LZO v2 headers have been found,
to support LZO 2.01 and newer, which renamed the library to liblzo2.

This was tested on SUSE Linux 9.3 without LZO, with LZO 1.08, 2.00 and 2.01.

-- 
Matthias Andree

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openvpn-2.0.1-rc6.patch2"

--- ChangeLog~	2005-07-20 11:12:27.000000000 +0200
+++ ChangeLog	2005-07-20 11:17:44.000000000 +0200
@@ -5,6 +5,7 @@
 
 2005.XX.XX -- Version 2.0.1-rc7
 
+* Support LZO 2.01 which renamed its library to lzo2 (Matthias Andree).
 * Include linux/types.h before checking for linux/errqueue.h (Matthias
   Andree).
 
--- configure.ac~	2005-07-20 11:12:51.000000000 +0200
+++ configure.ac	2005-07-20 11:07:52.000000000 +0200
@@ -467,22 +467,29 @@
 if test "$LZO" = "yes"; then
    LZO_H=""
    AC_CHECKING([for LZO Library and Header files])
-   AC_CHECK_HEADER(lzo/lzo1x.h, 
-        [ LZO_H="2" ],
-	[ AC_CHECK_HEADER(lzo1x.h, [ LZO_H="1" ])]
+   AC_CHECK_HEADER(lzo/lzo1x.h,
+	[ LZO_H="2"
+	  lzolibs="lzo2 lzo"
+	  AC_DEFINE(LZO_HEADER_DIR, 1, [Use lzo/ directory prefix for LZO header files (for LZO 2.0)])
+	],
+	[ AC_CHECK_HEADER(lzo1x.h, [ LZO_H="1" ; lzolibs=lzo ]) ]
    )
 
    if test -n "$LZO_H"; then
-     AC_CHECK_LIB(lzo, lzo1x_1_15_compress,
-       [
-         OPENVPN_ADD_LIBS(-llzo)
-	 AC_DEFINE(USE_LZO, 1, [Use LZO compression library])
-	 if test "$LZO_H" = "2"; then
-	   AC_DEFINE(LZO_HEADER_DIR, 1, [Use lzo/ directory prefix for LZO header files (for LZO 2.0)])
-         fi
-       ],
-       [AC_MSG_ERROR([LZO headers were found but LZO library was not found])]
-     )
+     havelzolib=0
+     for i in $lzolibs ; do
+	if test $havelzolib = 1 ; then break ; fi
+	AC_CHECK_LIB($i, lzo1x_1_15_compress,
+          [
+	    OPENVPN_ADD_LIBS(-l$i)
+	    AC_DEFINE(USE_LZO, 1, [Use LZO compression library])
+	    havelzolib=1
+	  ]
+        )
+     done
+     if test $havelzolib = 0 ; then
+       AC_MSG_ERROR([LZO headers were found but LZO library was not found])
+     fi
    else
      AC_MSG_RESULT([LZO headers were not found])
      AC_MSG_RESULT([LZO library available from http://www.oberhumer.com/opensource/lzo/])

--EeQfGwPcQSOJBaQU--

