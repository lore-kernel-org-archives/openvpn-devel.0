From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Re: Openvpn future: probably certificate
 problems...
In-Reply-To: <41E927C0.4020500@...292...>
Message-ID: <Pine.LNX.4.58.0501151909400.20314@...41...>
References: <41E67DB4.6090504@...255...> <Pine.LNX.4.58.0501141932270.2801@...41...>
 <41E927C0.4020500@...292...>
MIME-Version: 1.0
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
Date: Sat Jan 15 18:12:15 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Peter 'Luna' Runestig <peter+openvpn@...292...>
Cc: Didier Conchaudron <didier@...255...>, Mathias Sundman <mathias@...209...>, openvpn-devel@lists.sourceforge.net

Looks like CERT_SYSTEM_STORE_USERS is undefined in the MinGW environment.

gcc -g -O2 -Wall -Wno-unused-function -Wno-unused-variable -mno-cygwin -I/c/src/
openssl-0.9.7e/include -I/c/src/lzo-1.08/include -c cryptoapi.c -o cryptoapi.o
cryptoapi.c: In function `SSL_CTX_use_CryptoAPI_certificate':
cryptoapi.c:366: `CERT_SYSTEM_STORE_USERS' undeclared (first use in this function)
cryptoapi.c:366: (Each undeclared identifier is reported only once
cryptoapi.c:366: for each function it appears in.)
make: *** [cryptoapi.o] Error 1

James

