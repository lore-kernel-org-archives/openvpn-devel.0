Message-ID: <517F0CE5.6050507@...95...>
Date: Tue, 30 Apr 2013 02:14:29 +0200
From: "spockyf@...95..." <spockyf@...95...>
MIME-Version: 1.0
Subject: [Openvpn-devel] openvpn-gui build error (cross-compile for Windows)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi all together,

I stuck trying to build Openvpn for Windows under Debian wheezy. I use
the openvpn-build git-repo and installed all packages and dependencies
mentioned in the README files.
The Problem always occurs when the build-script tries to build
openvpn-gui. Here the essential output:

#:~openvpn-build/generic{master}$ IMAGEROOT=`pwd`/image-win64
CHOST=x86_64-w64-mingw32 CBUILD=x86_64-pc-linux-gnu ./build
...
x86_64-w64-mingw32-gcc -std=gnu99 -DHAVE_CONFIG_H -I.
-I/home/felix/repositories/openvpn-build/generic/image-win64/openvpn/include
-D_UNICODE -DWIN32_LEAN_AND_MEAN -D_WIN32_WINNT=NTDDI_WINXP -municode
-pedantic -Wall -Wextra -MT proxy.o -MD -MP -MF .deps/proxy.Tpo -c -o
proxy.o proxy.c
proxy.c: In function 'QueryWindowsProxySettings':
proxy.c:417:23: error: 'WINHTTP_AUTO_DETECT_TYPE_DHCP' undeclared (first
use in this function)
proxy.c:417:23: note: each undeclared identifier is reported only once
for each function it appears in
proxy.c:417:55: error: 'WINHTTP_AUTO_DETECT_TYPE_DNS_A' undeclared
(first use in this function)
proxy.c:438:32: error: 'WINHTTP_AUTOPROXY_CONFIG_URL' undeclared (first
use in this function)
proxy.c:448:21: warning: passing argument 1 of 'GlobalFree' discards
'const' qualifier from pointer target type [enabled by default]
/usr/lib/gcc/x86_64-w64-mingw32/4.6/../../../../x86_64-w64-mingw32/include/winbase.h:1132:29:
note: expected 'HGLOBAL' but argument is of type 'LPCWSTR'
proxy.c:449:27: warning: assignment discards 'const' qualifier from
pointer target type [enabled by default]
proxy.c: In function 'OnProxy':
proxy.c:591:5: warning: ISO C does not support the '%S' ms_printf format
[-Wformat]
proxy.c:591:5: warning: ISO C does not support the '%S' ms_printf format
[-Wformat]
make[1]: *** [proxy.o] Error 1
make[1]: *** Waiting for unfinished jobs....
mv -f .deps/options.Tpo .deps/options.Po
mv -f .deps/passphrase.Tpo .deps/passphrase.Po
make[1]: Leaving directory
`/home/felix/repositories/openvpn-build/generic/tmp/openvpn-gui-3'
make: *** [install-strip] Error 2
FATAL: make openvpn-gui

In the first place I tried openvpn-gui-2, but there was the same error.

I appreciate any help on that issue.
If there is some output missing or something else I can provide, then
just tell me. :-)

Best regards,
Felix
---
University of Paderborn

