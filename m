Date: Sat, 22 Apr 2017 13:29:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170422112928.GA30424@...1296...>
References: <20170413172609.29093-1-davids@...515...>
	<20170421220728.31867-1-davids@...515...>
	<258342e4-0ba9-cae0-0e23-88a4aab0eacc@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5LiOUhUlsRX0HDkW"
Content-Disposition: inline
In-Reply-To: <258342e4-0ba9-cae0-0e23-88a4aab0eacc@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v4] Fix broken ./configure on systems
 without openssl.pc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--5LiOUhUlsRX0HDkW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Apr 22, 2017 at 08:28:33AM +0200, Steffan Karger wrote:
> > v4 - Move the CFLAGS/LDFLAGS declarations before the manual
> >      version test; otherwise we're still testing the system install
> >      version
[..]
> This looks good now, ACK.

I'm not exactly sure what happened here in v4 - but now it's broken for
"just run configure, with no extra WITH_OPENSSL_* arguments" (on a system=20
without pkgconfig).  So, NAK, as annoying as you'll surely find me :-/

It does the version check just fine...

configure:16566: checking additionally if OpenSSL is available and version =
>=3D 1.
0.1
configure:16587: cc -c -g -O2 -std=3Dc99   conftest.c >&5
configure:16587: $? =3D 0
configure:16588: result: ok

... and then it tests for SSL_CTX_new, omitting the -lssl/-lcrypto bits:

configure:16601: checking for SSL_CTX_new
configure:16601: cc -o conftest -g -O2 -std=3Dc99    conftest.c   >&5
/var/tmp/conftest-e1c536.o: In function `main':
/home/gert/src/openvpn-maint/test-build-master-fbsd/conftest.c:193: undefin=
ed re
ference to `SSL_CTX_new'
cc: error: linker command failed with exit code 1 (use -v to see invocation)


... failing.

This is on FreeBSD 10.3, with the system libs, having pkg-config installed,=
=20
but no openssl.pc:

configure:16509: $PKG_CONFIG --exists --print-errors "libcrypto >=3D 1.0.1,=
 libssl
 >=3D 1.0.1"
Package libcrypto was not found in the pkg-config search path.
Perhaps you should add the directory containing `libcrypto.pc'
to the PKG_CONFIG_PATH environment variable
Package 'libcrypto', required by 'virtual:world', not found
Package 'libssl', required by 'virtual:world', not found

(not sure if this is related, but maybe the configure code path for
"pkg-config exists" is different from "no pkg-config found")


On Linux, with pkg-config + openssl.pc, it works fine:

configure:16601: checking for SSL_CTX_new
configure:16601: gcc -o conftest -g -O2 -std=3Dc99    conftest.c  -lcrypto =
-lssl
>&5
configure:16601: $? =3D 0
configure:16601: result: yes

(-lcrypto -lssl present, though I wonder why it's putting -lcrypto=20
first - dependency order should have -lssl first)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--5LiOUhUlsRX0HDkW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJY+z6XAAoJEB2Cnv7KVigSTwYL/igsCZubcK4lVgQyFGYc7EGM
n7S2dIJe2j3AmQLRH2l6lHx4GdAqVLYnsfeVpe65MpXU+lkSYozi6kPgdCt5xB2U
FOJaE1qMlNX4hL2OAeTifygfrtBH+s+y5VOzVSflBJXP+amHDoH2qgyKjKREoluC
GoTEb8RNdsdfqgYgeyFQdSXQM2514G/nbXbSUlgGz4VBYZUfsV/pbOlZb0SNrlmx
6Ac5Elr1b8VaE1fxqlmRRN+yeUhoYor3bsHxMzeEZ051KlzYe4qvx8zoXt+He9nr
0lmudqDD+Kg957iRGBBHfFs6J9N4KQV0LfJ+8LZ9ertmV0Jp984y4OtB6nZhyWYb
nFCkC0Aawcif0mQN2gxu+etDMwatFSRakS8dWj/wySZZZ1qsRltNWN3Onarsd9qb
xHUH21uKD/6cZC0eevWr/JDuc/Bv4ZwoBlYaNPu/XaLsn1UDi+0HvIqSOs4ws7el
4xKR0j0IpJ99Cp54YX2QTypNfJG7l08tx+ziJpz7Tw==
=xDI2
-----END PGP SIGNATURE-----

--5LiOUhUlsRX0HDkW--

