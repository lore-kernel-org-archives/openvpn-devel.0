Message-ID: <70f41ba20707101219v306db6edk8762ec86996e743@...278...>
Date: Tue, 10 Jul 2007 12:19:22 -0700
From: snowcrash+openvpn <schneecrash+openvpn@...277...>
Sender: schneecrash@...277...
MIME-Version: 1.0
Subject: [Openvpn-devel] socklen_t type error resulting from uint8_t
	duplicate typedef on osx. help?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

hi,

i'm building openvpn-2.1_rc4 on osx 10.4.10.

currently,

 ./configure \
 --prefix=/usr/local/openvpn \
 --enable-pthread \
 --disable-password-save \
 --with-ssl-headers=/usr/local/ssl/include/openssl/ \
 --with-ssl-lib=/usr/local/ssl/lib/ \
 --with-lzo-headers=/usr/local/include/lzo \
 --with-lzo-lib=/usr/local/lib \
 --with-ifconfig-path=/sbin/ifconfig \
 --with-route-path=/sbin/route

fails at,

...
checking for socklen_t equivalent... configure: error: Cannot find a
type to use in place of socklen_t


poking around in

	config.log

socklen-related errors 1st appear,

 ...
 configure:7574: result: 0
 configure:7660: checking for socklen_t
 configure:7692: gcc -c -g -O2  -I/usr/local/ssl/include/openssl/
-I/usr/local/include/lzo -I. -no-cpp-precomp conftest.c >&5
 In file included from /usr/include/sys/_endian.h:88,
				  from /usr/include/ppc/endian.h:107,
				  from /usr/include/machine/endian.h:30,
				  from /usr/include/sys/types.h:75,
				  from conftest.c:69:
 /usr/lib/gcc/powerpc-apple-darwin8/4.0.1/include/stdint.h:34: error:
duplicate 'unsigned'
 /usr/lib/gcc/powerpc-apple-darwin8/4.0.1/include/stdint.h:34: error:
two or more data types in declaration specifiers
 /usr/lib/gcc/powerpc-apple-darwin8/4.0.1/include/stdint.h:39: error:
duplicate 'unsigned'
 /usr/lib/gcc/powerpc-apple-darwin8/4.0.1/include/stdint.h:39: error:
both 'short' and 'char' in declaration specifiers
 /usr/lib/gcc/powerpc-apple-darwin8/4.0.1/include/stdint.h:44: error:
duplicate 'unsigned'
 In file included from conftest.c:69:
 /usr/include/sys/types.h:120: error: two or more data types in
declaration specifiers
 /usr/include/sys/types.h:120: error: two or more data types in
declaration specifiers
 configure:7698: $? = 1
 configure: failed program was:
 | /* confdefs.h.  */
 | #define PACKAGE_NAME "OpenVPN"
 | #define PACKAGE_TARNAME "openvpn"
 ...

 which , looking @:

  /usr/lib/gcc/powerpc-apple-darwin8/4.0.1/include/stdint.h:34

	...
	#ifndef _UINT8_T
	#define _UINT8_T
34:	typedef unsigned char         uint8_t;
	#endif /*_UINT8_T */
	...

doesn't, in fact, look like a prob with socklen_t ...

any suggestions here?

thanks!

