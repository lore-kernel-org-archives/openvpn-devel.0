MIME-version: 1.0
Message-id: <A6E7264D7DC743ADA5DB898E03F6B624@...139...>
From: Gisle Vanem <gvanem@...139...>
Date: Sat, 09 Apr 2011 14:56:52 +0200
Subject: Re: [Openvpn-devel] [Patch] config-win32.h (actually
	win/config-win32.h.in)
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

Sorry for the noise. I just discovered you've switchd to Git since I was involved
with OpenVPN. With the SVN-repo still there, I wrongfully assumed that was the
trunk (latest top) of developement. Here is an updated patch:

--- Git-latest\win\config.h.in  Sat Apr 09 14:25:58 2011
+++ win\config.h.in     Sat Apr 09 14:51:55 2011
@@ -26,6 +26,9 @@
  * Configuration header for Win32 using the MSVC environment.
  */

+#ifndef OPENVPN_CONFIG_H
+#define OPENVPN_CONFIG_H
+
 #include <windows.h>
 #include <winsock2.h>
 #include "autodefs.h" /* machine generated */
@@ -274,6 +277,7 @@
 /* type to use in place of socklen_t if not defined */
 #define socklen_t unsigned int

+#ifndef __MINGW32__
 /* 32-bit unsigned type */
 #define uint32_t unsigned int

@@ -282,6 +286,7 @@

 /* 8-bit unsigned type */
 #define uint8_t unsigned char
+#endif

 /* Route command */
 #define ROUTE_PATH "route"
@@ -314,3 +319,5 @@
 #define HAVE_CPP_VARARG_MACRO_ISO 1
 #endif
 #endif
+
+#endif  /* OPENVPN_CONFIG_H */

---------------

The above header-guard makes service-win32/openvpnserv.c compile
since config.h is included twice for this file.

--gv




