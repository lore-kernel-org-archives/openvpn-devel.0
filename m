From: zeeshaan <xeshaan@...293...>
Message-ID: <loom.20041014T173717-97@...171...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Compilation Problem of =?utf-8?b?b3BlbnZwbi0yLjBfYmV0YTEx?=
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
Date: Thu Oct 14 08:53:10 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi, 

I am trying to compile the OpenVpn in windows but no success, 

i have installed Mingw,Msys i have opensssl and lzo libraries source also but 

i have set path for openssl and lzo in makefile.w32 
as 

OPENSSL = /f/openssl-0.9.7d
LZO = /f/lzo-1.08

because both are at f:/openssl-0.9.7d and f:/lzo-1.08


when i try to compile the source through mingw by applying command 

Make -f makefile.w32 

i get errors as 

gcc -g -O2 -Wall -Wno-unused-function -Wno-unused-variable -mno-cygwin -
If:/openssl-0.9.7d/include -If:/lzo-1.08/include -c crypto.c -o crypto.o 
In file included from crypto.c:36: 
crypto.h:102: parse error before '*' token 
crypto.h: In function `EVP_CipherInit_ov': 
crypto.h:104: warning: implicit declaration of function `EVP_CipherInit' 
crypto.h:104: `ctx' undeclared (first use in this function) 
crypto.h:104: (Each undeclared identifier is reported only once 
crypto.h:104: for each function it appears in.) 
crypto.h:104: `type' undeclared (first use in this function) 
crypto.h:104: `key' undeclared (first use in this function) 
crypto.h:104: `iv' undeclared (first use in this function) 
crypto.h:104: `enc' undeclared (first use in this function) 
crypto.h: At top level: 
crypto.h:109: parse error before '*' token 
crypto.h: In function `EVP_CipherUpdate_ov': 
crypto.h:111: warning: implicit declaration of function `EVP_CipherUpdate' 
crypto.h:111: `ctx' undeclared (first use in this function) 
crypto.h:111: `out' undeclared (first use in this function) 
crypto.h:111: `outl' undeclared (first use in this function) 
crypto.h:111: `in' undeclared (first use in this function) 
crypto.h:111: `inl' undeclared (first use in this function) 
crypto.h: At top level: 
crypto.h:190: warning: type defaults to `int' in declaration of `EVP_CIPHER' 
crypto.h:190: warning: no semicolon at end of struct or union 
........ 
.......... 
....... 




do anybody know wat is the problem? 

looking for a quick response.. 

Regards, 
ZEE


