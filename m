Date: Wed, 16 Jan 2019 19:55:17 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20190116185517.GA61190@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
Subject: [Openvpn-devel] compile-time error in argv_testdriver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

for whatever reason my local FreeBSD build system never did cmocka
tests - now it does, and fails

cc -DHAVE_CONFIG_H -I. -I../../../../openvpn/tests/unit_tests/openvpn -I../=
../.. -I../../../include    -I../../../../openvpn/include -I/home/gert/src/=
openvpn-maint/test-build-master-fbsd/vendor/dist/include -I../../../../open=
vpn/src/openvpn -I../../../../openvpn/src/compat -Wall -Wno-unused-paramete=
r -Wno-unused-function -g -O2 -std=3Dc99 -MT argv_testdriver-argv.o -MD -MP=
 -MF .deps/argv_testdriver-argv.Tpo -c -o argv_testdriver-argv.o `test -f '=
../../../../openvpn/src/openvpn/argv.c' || echo '../../../../openvpn/tests/=
unit_tests/openvpn/'`../../../../openvpn/src/openvpn/argv.c
In file included from ../../../../openvpn/src/openvpn/argv.c:41:
In file included from ../../../../openvpn/src/openvpn/options.h:41:
In file included from ../../../../openvpn/src/openvpn/comp.h:122:
../../../../openvpn/src/openvpn/lzo.h:42:10: fatal error: 'lzo/lzoutil.h' f=
ile not found
#include <lzo/lzoutil.h>


on FreeBSD, this is in -I/usr/local/include, which is properly configured
(so OpenVPN builds nicely) and these include flags do not make it over
to the cmocka builds.

So, whoever understands this stuff :-) - it would be nice to see a patch
here.

Reproduction should be fairly easy - put lzo into a user-installed path,
remove it from the system, and build openvpn including cmocka...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcP34UAAoJEB2Cnv7KVigSDnoL/i7nLW92XNq0CmuyHqeDlT+C
jWTr5E9XBwhQFOKMy/xm8SUXsI+EYEdu0BRcQZMotrdrZoB1DAcbovo9doSf6PQW
2oPxPbtPt4qgCyfxbLmWdfQJTsBkD7H+cCS70V6d98cDi2+JWwzHKGfxGPKArEAA
TPQKPg2u20haJcF3IVfr8fF+KDaPBl8f6lBNDpQ1NccCWx8qzT6bRSOHQYsjbB8O
VHuvnE3L1+d1yFGOeQ1ZpFUiQRzs5DXx2jcmEKH8I43M0kTfHvv4RiyqhKgg83Nw
0QQHW7WKOTDAPwfoGhxXFnzR6uPtkZ6PyWnmNjZXqhrFGVXcO/Ur3C2R7OsLmEio
E/PjCiUVjxBIYG4pZHnPiHc8kMkx0ObNnD9/AosxZ8HfJWeLsmfGhIevNdap3NO2
aUW4gjpw8e4cRrm3w5Cbwf0nBvsGuj+OyelrD5ZelBs5xTHQIzmKVaGZDVfhICLj
KJOUUJUh5eOhMf0/ZlRttHDewHYl2NDvMBJNWwHkgw==
=TY+a
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--

