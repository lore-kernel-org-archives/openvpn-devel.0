From: Gisle Vanem <giva@...258...>
Message-id: <0c1201c51386$cef07e20$0600000a@...139...>
MIME-version: 1.0
Subject: [Openvpn-devel] Small slash patch
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
Date: Tue Feb 15 09:52:20 2005
Content-type: text/plain; charset="iso-8859-1"; format=flowed;
 reply-type=original
Content-Transfer-Encoding: 7bit
To: OpenVPN-dev <openvpn-devel@lists.sourceforge.net>

Using '\' in #include<> messes up the dependency generation (gcc -MM ..).
Or at least MingW's make doesn't like it. So could you please use Unix slashes.

--- CVS-latest\cryptoapi.c      Sun Nov 28 18:22:01 2004
+++ cryptoapi.c Sun Jan 23 09:31:06 2005
@@ -32,8 +32,8 @@
 #include <stdio.h>
 #include <ctype.h>
 #include <assert.h>
-#include <openssl\ssl.h>
-#include <openssl\err.h>
+#include <openssl/ssl.h>
+#include <openssl/err.h>

 #ifdef __MINGW32_VERSION
 /* MinGW w32api is incomplete when it comes to CryptoAPI, as per version 3.1

--gv

