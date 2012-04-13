Message-ID: <4F883775.6020809@...515...>
Date: Fri, 13 Apr 2012 17:25:57 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Build failure on "master" when using PolarSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

HI,

I tested building OpenVPN with PolarSSL support on our buildslaves

- Debian 6 i386 (PolarSSL 1.1.1)
- CentOS 6 amd64 (PolarSSL 1.1.1)
- Ubuntu 10.04 amd64 (PolarSSL 1.1.0)

All used the following build flags:

--with-crypto-library=3Dpolarssl --enable-crypto --enable-ssl

All gave the same error:

gcc -DHAVE_CONFIG_H -I. -I../.. -I../../include -I../../src/compat       -g=
 -O2 -MT ssl_polarssl.o -MD -MP -MF .deps/ssl_polarssl.Tpo -c -o ssl_polars=
sl.o ssl_polarssl.c
ssl_polarssl.c: In function 'key_state_ssl_init':
ssl_polarssl.c:520: error: 'havege_rand' undeclared (first use in this func=
tion)
ssl_polarssl.c:520: error: (Each undeclared identifier is reported only once
ssl_polarssl.c:520: error: for each function it appears in.)

Any clues? There were no traces of earlier PolarSSL installations on any
of the buildslaves.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


