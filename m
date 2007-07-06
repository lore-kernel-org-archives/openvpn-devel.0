From: "John" <jknappers-argentia@...160...>
Date: Fri, 6 Jul 2007 12:17:58 +0200
Message-ID: <f6l4sm$vdk$1@...165...>
Sender: news <news@...165...>
Subject: [Openvpn-devel] build Openvpn 2.1RC4 on Windows failure (Repost,
	no answer in openvpn.user group.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I'm reposting this question in openvpn.devel because no one responded in 
openvpn.user to my question.
If the build procedure has changed between RC1 and RC4, can anybody explain 
how to build OpenVPN 2.1RC4 on Windows?
make -f makefile.w32 was the the way that worked until RC1...

Thanx in advance,
John

I'm trying to build Openvpn-2.1RC4 on Windows and it failed.

C:\msys\1.0\src\openvpn-2.1_rc4>make -f makefile.w32
gcc -g -O2 -Wall -Wno-unused-function -Wno-unused-variable -mno-cygwin -I/c/msys
/1.0/src/openssl-0.9.7l/include -I/c/msys/1.0/src/lzo-2.02/include -c
base64.c -
o base64.o
In file included from base64.c:35:
config-win32.h:38:27: autodefs/defs.h: No such file or directory
make: *** [base64.o] Error 1

Config-win32.h is calling autodefs/defs.h.  But autodefs/defs.h is not
present in the source tree.
#include "autodefs/defs.h" was not present in RC1 which build successfully.

Removing the the offending line from Config-win32.h coursed the build to
fail later on:

C:\msys\1.0\src\openvpn-2.1_rc4>make -f makefile.w32
gcc -g -O2 -Wall -Wno-unused-function -Wno-unused-variable -mno-cygwin -I/c/msys
/1.0/src/openssl-0.9.7l/include -I/c/msys/1.0/src/lzo-2.02/include -c
base64.c -
o base64.o
gcc -g -O2 -Wall -Wno-unused-function -Wno-unused-variable -mno-cygwin -I/c/msys
/1.0/src/openssl-0.9.7l/include -I/c/msys/1.0/src/lzo-2.02/include -c
buffer.c -
o buffer.o
gcc -g -O2 -Wall -Wno-unused-function -Wno-unused-variable -mno-cygwin -I/c/msys
/1.0/src/openssl-0.9.7l/include -I/c/msys/1.0/src/lzo-2.02/include -c
crypto.c -
o crypto.o
crypto.c: In function `get_cipher':
crypto.c:418: error: syntax error before "PRODUCT_NAME"
crypto.c:418: error: `PRODUCT_NAME' undeclared (first use in this function)
crypto.c:418: error: (Each undeclared identifier is reported only once
crypto.c:418: error: for each function it appears in.)
crypto.c: In function `get_md':
crypto.c:434: error: syntax error before "PRODUCT_NAME"
crypto.c:434: error: `PRODUCT_NAME' undeclared (first use in this function)
crypto.c: In function `init_key_type':
crypto.c:529: error: syntax error before "PRODUCT_NAME"
crypto.c:529: error: `PRODUCT_NAME' undeclared (first use in this function)
crypto.c: In function `test_crypto':
crypto.c:867: error: syntax error before "PRODUCT_NAME"
crypto.c:867: error: `PRODUCT_NAME' undeclared (first use in this function)
crypto.c:903: error: syntax error before string constant
crypto.c: In function `get_tls_handshake_key':
crypto.c:947: error: syntax error before "PRODUCT_NAME"
crypto.c:947: error: `PRODUCT_NAME' undeclared (first use in this function)
crypto.c: At top level:
crypto.c:994: error: syntax error before "PRODUCT_NAME"
crypto.c:995: error: syntax error before "PRODUCT_NAME"
crypto.c: In function `write_key_file':
crypto.c:1301: error: syntax error before "PRODUCT_NAME"
crypto.c: In function `must_have_n_keys':
crypto.c:1327: error: syntax error before "PRODUCT_UNIX_NAME"
crypto.c:1327: error: `PRODUCT_UNIX_NAME' undeclared (first use in this
function
)
crypto.c: In function `show_available_ciphers':
crypto.c:1475: error: syntax error before "PRODUCT_NAME"
crypto.c: In function `show_available_digests':
crypto.c:1510: error: syntax error before "PRODUCT_NAME"
make: *** [crypto.o] Error 1

Can anybody explain what I''m missing and what's  why going wrong.

Regards,

John







-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/ 




