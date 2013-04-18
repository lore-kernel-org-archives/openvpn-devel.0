Message-ID: <5170496A.6000000@...1737...>
Date: Thu, 18 Apr 2013 20:28:42 +0100
From: Ed W <lists@...1737...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Support for libsodium?
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
To: openvpn-devel@lists.sourceforge.net

Hi, given the new abstractions to support PolarSSL, what 
interest/resistance would there be to supporting libsodium?
     https://github.com/jedisct1/libsodium

For reference, the NaCL library comes from Daniel Bernstein, and is a 
reference implementation of some crypto primitives in a kind of high 
level library format.  The crypto support is deliberately constrained 
(elliptic curves, poly1305, salsa20), but the library is in turn quite 
high level which it is hoped reduces the possibility for coding and 
implementation errors. All of the choices are currently sensible and 
sane and the algorithms are peer reviewed

Libsodium is an attempt to take the NaCL library and make it generally 
available across a wide range of architectures.

Of particular interest is the use of curve25519 as public key algorithm, 
it has extremely short signatures/keys, no known patent issues, decent 
speed and of course elliptic curves have shown greater resistance to 
cryptanalysis over the last few decades.

The motivation would be an even simpler and easier to peer review crypto 
library than PolarSSL (plus it's fast and easy to code with, and I 
particularly like the very short public keys/sigs)

Thanks for your thoughts

Ed W

