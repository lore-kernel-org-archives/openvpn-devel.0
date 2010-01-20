Message-ID: <4B56CBFD.7080900@...1294...>
Date: Wed, 20 Jan 2010 10:25:17 +0100
From: Eike Lohmann <e.lohmann@...1294...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Crosscompile OpenVPN 2.1.1
Reply-To: e.lohmann@...1294...
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


Hello,

I am searching for the best way to compile OpenVPN 2.1.1 for Windows, I
have tried it on Windows with mingw+msys and on cygwin with the native
win32 option. Right now I am on Linux using the mingw crosscompiler and
could compile lzo2-03, openssl-0.9.8l, pkcs11-helper-1.07.

When I try to configure openvpn-2.1.1(./configure
--host=i586-mingw32msvc
--with-lzo-headers=../lzo-2.03/usr/local/include/lzo
--with-lzo-lib=../lzo-2.03/usr/local/lib) it stops everytime at:

configure: checking for LZO Library and Header files...
checking lzo/lzo1x.h usability... no
checking lzo/lzo1x.h presence... no
checking for lzo/lzo1x.h... no
checking lzo1x.h usability... yes
checking lzo1x.h presence... yes
checking for lzo1x.h... yes
checking for lzo1x_1_15_compress in -llzo... no
configure: error: LZO headers were found but LZO library was not found

lza installdir:
openvpn-2.1.1$ ls -la ../lzo-2.03/usr/local/lib
insgesamt 820
drwxr-xr-x 2  4096 2010-01-19 16:55 .
drwxr-xr-x 4  4096 2010-01-19 16:29 ..
-rw-r--r-- 1 826766 2010-01-19 16:55 liblzo2.a
-rwxr-xr-x 1 740 2010-01-19 16:55 liblzo2.la

What exactly is missing and how to build it?

Thanks and best Regards

Eike

