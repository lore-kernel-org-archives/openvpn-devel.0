References: <CAFHpkQHK_VtPoEbWzno+z5C67tYfo3fZNi5ibLgaPpXE5-o5Ug@...278...>
	<412be705-14ff-4f00-93cb-9478487400c7@...515...>
	<CAFHpkQF=gXiT309bV8AWkw86fDd3fN0-RpHkH8cqsMWaG744eQ@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <d03a8315-715f-1987-5224-f6d1174e296a@...2080...>
Date: Mon, 21 Nov 2016 13:59:15 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQF=gXiT309bV8AWkw86fDd3fN0-RpHkH8cqsMWaG744eQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="bSwe0rWq4v4hD54wXXJovjiKBOAhFXq4n"
Subject: Re: [Openvpn-devel] multi language / unicode installer
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bSwe0rWq4v4hD54wXXJovjiKBOAhFXq4n
Content-Type: multipart/mixed; boundary="PEh4V6I97T565G8i5BRuHBiE8uu7gInAA";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
	=?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <d03a8315-715f-1987-5224-f6d1174e296a@...2080...>
Subject: Re: [Openvpn-devel] multi language / unicode installer
References: <CAFHpkQHK_VtPoEbWzno+z5C67tYfo3fZNi5ibLgaPpXE5-o5Ug@...278...>
	<412be705-14ff-4f00-93cb-9478487400c7@...515...>
	<CAFHpkQF=gXiT309bV8AWkw86fDd3fN0-RpHkH8cqsMWaG744eQ@...278...>
In-Reply-To: <CAFHpkQF=gXiT309bV8AWkw86fDd3fN0-RpHkH8cqsMWaG744eQ@...278...>

--PEh4V6I97T565G8i5BRuHBiE8uu7gInAA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 21/11/16 12:58, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
>=20
>=20
> 2016-11-21 16:51 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...=20
> <mailto:samuli@...515...>>:
>=20
> Il 21/11/2016 13:32, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
>=20
> Hello,
>=20
> I see different languages in openvpn.nsi, for example
>=20
> https://github.com/OpenVPN/openvpn-build/blob/master/windows-nsis/openvpn=
.nsi#L97
>
>=20
<https://github.com/OpenVPN/openvpn-build/blob/master/windows-nsis/openvpn.=
nsi#L97>
>=20
>=20
> we roll our own installer using nsis-2.50-unicode, and I'm not sure
> it is available for Linux. but I guess there might be some interest
> from community to have multilanguage installer (for, example, even
> for openvpn-nl).
>=20
> can we switch to "unicode" nsis and start translating openvpn.nsi
> ?
>=20
>=20
> I think having proper internationalization (i18n) support would be=20
> good to have. We will just have to ensure that openvpn-build is=20
> capable of handling it. As for NSIS version availability: I have
> not checked what is the latest NSIS version available for *NIX, but
> I suspect it is the same as for Windows - we're speaking of a
> single project, not two separate ones, right?
>=20
>=20
> actually, there're 3 nsis
>=20
> 1) nsis-2.46 from nsis.sf.net <http://nsis.sf.net> (I guess it
> cames on Linux, no unicode support) 2) http://www.scratchpaper.com/
> (nsis unicode) 3) nsis 3.0 from http://nsis.sf.net (which I haven't
> seen on Linux)
>=20
> currently, openvpn-build just uses makensis, but it does not check
> its version. if we decide to switch to unicode, it should also
> perform such check

Yes, and it could just run the .nsi file through iconv to convert it
to the proper/expected charset and then kickoff makensis using the
converted file - if we end up using a no-unicode supported nsis when
cross-building Windows builds.

I agree it makes a lot of sense to move towards UTF-8.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--PEh4V6I97T565G8i5BRuHBiE8uu7gInAA--

--bSwe0rWq4v4hD54wXXJovjiKBOAhFXq4n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYMu+jAAoJEIbPlEyWcf3yk9YP/jN+3nddO0iE9zoCcU/W2Z49
n8BeXoOBoNQMIS5CNiQeK4u2ca1vMJIQsoMo9cLWy+8Q5Tk6v2dvwZtGw+TKbwVd
oQYTgD95c2h0DZFH0be3Hzj0+YMdZrNGQhXjE80wCc8oTDKqzqCc58T0QQmbaMRO
2Cf8riYe04cw1dr3irn+F8sO5SutpnUvrrvNdMS3CVt2AqUsoADvLqB+CNCpD3W1
b+nyRBjQ48/k6ZJmzM87ZJl3YnV57teba0iFlS9x1wG/JM89anZ7cId31z3bWncX
8SZP9ZfYyPqBdoQM3biHdnBgdgC56LsRQFZbakaYHJqQRLtANU4C/8WUxEFE4SQE
7f1W7BZ1F+jEl7vJH5D8/B9SDfhgrJEWggN3b7tjKceVcs1FE6Txm+70Feb8DN75
nl7n4mRZXu+L1TyxyEBNEoWmn5pET+Fp8f1sYIQW2QRyZEOxEnYc5+ycd5uEZklx
SGHt9AIpy1X7Bz60mW5LwW7M6wcnLd2R7ausgpJTeB7GyrOUfr3lxb+GQ9Dk6sj8
D3/peNVY+ZubvmooGafjDuw0da7mpYiFx1n8/AubOm8cZzW5R/jvqrEP/ryHN6lx
0dIgoRIVHBV1wXJpXwgBlh+dWGAfmJDJHC5OC0zqaLaQuaUou25dnYeBh74p9GK9
5beqDPPbk8KRby7VTyv/
=FGh0
-----END PGP SIGNATURE-----

--bSwe0rWq4v4hD54wXXJovjiKBOAhFXq4n--

