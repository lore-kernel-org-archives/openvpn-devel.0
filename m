Date: Mon, 24 Aug 2020 21:15:58 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200824191558.GA64437@...1296...>
References: <20200814145153.12895-1-arne@...1227...>
 <202008232001.07NK1TX4034925@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <202008232001.07NK1TX4034925@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Refactor
 key_state_export_keying_material functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

this commit seems to require a more recent mbedTLS version - it fails
a number of my buildslaves with

gcc -DHAVE_CONFIG_H -I. -I../.. -I../../include  -I../../include  -I../../s=
rc/compat            -DPLUGIN_LIBDIR=3D\"/usr/local/lib/openvpn/plugins\"  =
-Wall -Wno-unused-parameter -Wno-unused-function -Wno-stringop-truncation -=
g -O2 -std=3Dc99 -MT auth_token.o -MD -MP -MF .deps/auth_token.Tpo -c -o au=
th_token.o auth_token.c
In file included from ssl_backend.h:41:0,
                 from ssl_common.h:38,
                 from ssl.h:43,
                 from openvpn.h:31,
                 from auth_token.c:12:
ssl_mbedtls.h:90:5: error: unknown type name 'mbedtls_tls_prf_types'
     mbedtls_tls_prf_types tls_prf_type;
     ^

- I think it *should* fail the configure phase if mbedTLS is too old,
and clearly specify which version is required now (we have a check, but
it's fairly unspecific, and only says "mbed TLS 2.y.z required").

I've opened a trac ticket to track this

  https://community.openvpn.net/openvpn/ticket/1319

gert


On Sun, Aug 23, 2020 at 10:01:29PM +0200, Gert Doering wrote:
> Your patch has been applied to the master branch.
>=20
> I have no idea what this all does (and not enough brain power to develop
> interest in finding out :-/ ) but if Steffan says it's good, so it is.
>=20
> Also, t_client agrees :-)
>=20
> commit 10abd656a3ae279cea7344055ce23637b7a62f6b (master)
> Author: Arne Schwabe
> Date:   Fri Aug 14 16:51:53 2020 +0200
>=20
>      Refactor key_state_export_keying_material functions
>=20
>      Signed-off-by: Arne Schwabe <arne@...1227...>
>      Signed-off-by: Arne Schwabe <arne@...1227...>
>      Acked-by: Steffan Karger <steffan@...1856...>
>      Message-Id: <20200814145153.12895-1-arne@...1227...>
>      URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg20739.html
>      Signed-off-by: Gert Doering <gert@...1296...>
>=20
>=20
> --
> kind regards,
>=20
> Gert Doering
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfRBHtAAoJEB2Cnv7KVigSrtEL/1MkJ6Cp+Y8F1ND24gtePxNW
/YIyk6AwfHyhqUKHdrbQeUaepfUfibbFxMNsdM6lRU4D1PQr3GgQ8415YzRSzeha
VZzCy3GP0aYeMqE+xH/ewu7As2UlPEuTXIxeuKI1BaiYEajovSI/ZhclW0fqNVgD
i0klV/uGywHv/YD+bK/IwPvIHGoEbmf3kJnn1J0r7mQGjzz2ntDxQYwgxA3Y76Td
O9t/VNvn1sEAqigWcAlVE2q+hK+rSEtOjUQpFWeuklo5OboKL6EInpHjbIRKbAqQ
AYvAlTC2DyMk8JfMLKcDGQK6VTlbh2DRVuTnnlB5avd+c5t26beEgvAtRbwaPNbj
BIwylxgv/erlDVLOch6vPkk3O5Xf15XMDG4yFaRNJ2N2jUFi76rM0u9fIRd7KmPj
Xz8ldJtzFCgCTNskWXP31LG0Et6QO/p6Q1Im+HvGyYFQWz7YSpcZjKBEZouIaV35
bPphgZXEcIMc/cR8vjl5DynroOx3QiDxdOwrg/N/WA==
=5aP6
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--

