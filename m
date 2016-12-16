References: <f5ca3f0f-dd01-e82e-b339-68f5791e0928@...1435...>
	<20161216182659.18194-1-jm@...1926...>
	<dfbcd54a-29c2-d8e5-1200-66f217832063@...1435...>
	<44d2e307-1954-de7f-9979-68728de900b3@...1926...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <efa5d95d-9622-f80d-42fb-c676679b7308@...1856...>
Date: Fri, 16 Dec 2016 23:33:13 +0100
MIME-Version: 1.0
In-Reply-To: <44d2e307-1954-de7f-9979-68728de900b3@...1926...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QbmVDG0cV4I3u8Fu46EQPmEtIe8ClPJ53"
Subject: Re: [Openvpn-devel] [PATCH] Build with a few -Werror= flags if the
 compiler supports them
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QbmVDG0cV4I3u8Fu46EQPmEtIe8ClPJ53
Content-Type: multipart/mixed; boundary="LmGiiWK9g8NCVbfjs4aRQIGcwH3QeqXB3";
	protected-headers="v1"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <efa5d95d-9622-f80d-42fb-c676679b7308@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Build with a few -Werror= flags if the
	compiler supports them
References: <f5ca3f0f-dd01-e82e-b339-68f5791e0928@...1435...>
	<20161216182659.18194-1-jm@...1926...>
	<dfbcd54a-29c2-d8e5-1200-66f217832063@...1435...>
	<44d2e307-1954-de7f-9979-68728de900b3@...1926...>
In-Reply-To: <44d2e307-1954-de7f-9979-68728de900b3@...1926...>

--LmGiiWK9g8NCVbfjs4aRQIGcwH3QeqXB3
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable



On 16-12-16 23:16, Julien Muchembled wrote:
> Le 12/16/16 =E0 21:52, Steffan Karger a =E9crit :
>>> +AX_CHECK_COMPILE_FLAG([ -Werror=3Dimplicit ], [
>>> +    CFLAGS_EXTRA=3D"$CFLAGS_EXTRA -Werror=3Dimplicit"
>>> +])
>>> +AX_CHECK_COMPILE_FLAG([ -Werror=3Dformat -Werror=3Dformat-security ], [
>>> +    CFLAGS_EXTRA=3D"$CFLAGS_EXTRA -Werror=3Dformat -Werror=3Dformat-se=
curity"
>>> +])
>>> +
>>
>> Shouldn't there be a CFLAGS=3D"${CFLAGS} ${CFLAGS_EXTRA}" somewhere?  Or
>> just use CFLAGS directly, instead of _EXTRA.  Without that, I don't see
>> the flags appear in the make output.
>=20
> (how did I miss that?) anyway, there's also
>   https://fossies.org/linux/alsa-lib/m4/attributes.m4
>=20
> bigger, GPL2+, and it defines macros that simply append to CFLAGS (e.g. C=
C_CHECK_CFLAG_APPEND)
>=20
>=20
> BTW, instead of failing on these 3 specific warnings, we could go the opp=
osite way, since -Wall is quite silent. I suggest:
>=20
>   -Wall -Wno-unused -Wno-pointer-sign -Werror -Wno-error=3Dstrict-aliasin=
g -Werror=3Dformat-security

I like this, we could then get rid of the --enable-strict configure
option.  But I would want to test this in the master branch first to see
what else we need.  I for example also need:

-Wno-error=3Dmissing-braces, because clang still wrongfully warns about
using =3D { 0 } to zero-initialize structs (fixed just recently in gcc)

-Wno-error=3Dduplicate-decl-specifier, to be able to compile against
pkcs11-helper

I reckon there will be more stuff that fails.

Also, is -Werror=3Dformat-security needed (instead of -Wformat-security)
if we already have -Werror?

-Steffan


--LmGiiWK9g8NCVbfjs4aRQIGcwH3QeqXB3--

--QbmVDG0cV4I3u8Fu46EQPmEtIe8ClPJ53
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYVGu+AAoJEJgCyj0AftKIn4wH/1e0H0QkMjGgUGy5az0kK18f
AO4WhCkTraOtr5PZUAYADr/LyPgrwEFxowuVhoiIjp0GxNsvub/WSoWnBf3kLzEc
yC1BeLytsd2IlEJ38z6p6Ri406nu9mEma7tCHzVIo5TzQ5gW7mAz3cnkJHzZqcux
4c8XArxxZV6o0DErDaCjI3HhW71fxP+aggA32L1FM9gp0gg6JYeJY3FJi8/VA8Ta
aY31gXYBehcJMJLwQd4/Oq9CPXXBd/x8r+BoDL4ifA5FuvEXtwyBo3K+hlsnkQRJ
MAvsXt2sB5/BCaCcsAVgwIPSKrfGeEwRRZtLLU/tEqOlkkA3cuY9dkBOylRCwNw=
=86YA
-----END PGP SIGNATURE-----

--QbmVDG0cV4I3u8Fu46EQPmEtIe8ClPJ53--

