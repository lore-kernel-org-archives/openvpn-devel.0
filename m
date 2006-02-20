From: Gisle Vanem <giva@...258...>
Message-id: <015401c63643$eaef2e10$0600000a@...139...>
MIME-version: 1.0
Subject: [Openvpn-devel] ieproxy.h and MingW
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
Date: Mon Feb 20 09:35:07 2006
Content-type: text/plain; charset="iso-8859-1"; format=flowed;
 reply-type=original
Content-Transfer-Encoding: 7bit
To: OpenVPN-dev <openvpn-devel@lists.sourceforge.net>

MingW (ver 3.7) doesn't have the "ieproxy.h" header. But it doesn't seem to
require it either since most types and prototypes are in <wininet.h>.
I patched proxy.c to make it build:

--- CVS-latest\proxy.c  Mon Dec 12 18:00:00 2005
+++ proxy.c     Mon Feb 20 18:05:32 2006
@@ -39,7 +39,7 @@
 #include "base64.h"
 #include "ntlm.h"

-#ifdef WIN32
+#if defined(WIN32) && !defined(__MINGW32__)
 #include "ieproxy.h"
 #endif

---------------

So if MingW doesn't need it, why should it be needed for MSVC.

--gv

