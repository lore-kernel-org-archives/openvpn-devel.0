MIME-version: 1.0
Message-id: <ABFD7136C814469D83E59242302A854C@...139...>
From: Gisle Vanem <gvanem@...139...>
Date: Sat, 09 Apr 2011 14:10:07 +0200
Subject: [Openvpn-devel] [Patch] config-win32.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; CHARSET=US-ASCII; charset="US-ASCII"; format=flowed;
 reply-type=original
Content-Transfer-Encoding: 7bit
To: OpenVPN-dev <openvpn-devel@lists.sourceforge.net>

Since MingW for quite a long time (since 3.2 in 2008?) has defined 
'uint32_t' etc. in it's <stdint.h>, we need to guard against defining
them again. Ideally we should figure out in what version of MingW
this happened. But for now:

--- SVN-Latest\config-win32.h   Sat Apr 09 05:59:09 2011
+++ config-win32.h      Sat Apr 09 13:49:55 2011
@@ -258,6 +258,7 @@
 /* type to use in place of socklen_t if not defined */
 #define socklen_t unsigned int

+#ifndef __MINGW32__
 /* 32-bit unsigned type */
 #define uint32_t unsigned int

@@ -266,6 +267,7 @@

 /* 8-bit unsigned type */
 #define uint8_t unsigned char
+#endif

 /* Route command */
 #define ROUTE_PATH "route"

----------------

--gv

