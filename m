References: <c042fd01f62d707477c37e0298e303f1@...2482...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b49e6ca0-5ff5-5519-2078-87bd19225362@...2080...>
Date: Tue, 25 Dec 2018 00:59:34 +0100
MIME-Version: 1.0
In-Reply-To: <c042fd01f62d707477c37e0298e303f1@...2482...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="oWmw72ncIFLvWQprDNuMG8UhbNj2fZo9j"
Subject: Re: [Openvpn-devel] [PATCH] Fix error message when using RHEL init
 script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Richard van den Berg <richard@...2482...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oWmw72ncIFLvWQprDNuMG8UhbNj2fZo9j
Content-Type: multipart/mixed; boundary="yiFCFJKB5zUL8JFUhmxS2RrBJHWNWMIc2";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Richard van den Berg <richard@...2482...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b49e6ca0-5ff5-5519-2078-87bd19225362@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Fix error message when using RHEL init
 script
References: <c042fd01f62d707477c37e0298e303f1@...2482...>
In-Reply-To: <c042fd01f62d707477c37e0298e303f1@...2482...>

--yiFCFJKB5zUL8JFUhmxS2RrBJHWNWMIc2
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 21/12/2018 07:43, Richard van den Berg via Openvpn-devel wrote:
> In RHEL 7 /etc/sysconfig/network is no longer used (still there but empty=
).
> This results in the following error when openvpn starts:
>=20
> Dec 20 09:01:25 localhost openvpn: /etc/rc.d/init.d/openvpn: line 94: [: =
=3D:
> unary operator expected

Not related to this fix, but we really need to get rid of the distro/rpm
folder.  These init script should NOT be used on any systemd based systems =
at all.

The complete distro/rpm folder is essentially unmaintained, as the .spec fi=
le
here most likely breaks any modern packaging guidelines.  If you want the
proper maintained .spec file, look at the ones in the Fedora EPEL repositor=
y [0].

As we don't here much from the upstream SUSE package maintainers, I don't h=
ave
a good pointer for that RPM flavour.  But I presume their spec file is also
far better maintained than the one we ship here.


[0] <https://src.fedoraproject.org/rpms/openvpn/tree/epel7>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--yiFCFJKB5zUL8JFUhmxS2RrBJHWNWMIc2--

--oWmw72ncIFLvWQprDNuMG8UhbNj2fZo9j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJcIXLrAAoJEIbPlEyWcf3yBR4P/A81+u/dcCVUZ7QGtUamRBCt
OkD+Jg3JpBZXHpR2QXIrIN2gjwsU1Vu4beXKE5s3gYmiwa7YlRRDpr0suVoJ4WIH
kmpnTDE8zLTVF8jx5hzf9Psc8qK7a6iOh0cyDtfY49jY/evN13BerYLI9LU5NzIL
2UpBFIO0wQ7JrRjNKNDGFoGlnjjV1F/COtEX44ctTB0NdYfz9wB+3EXnoj/9tlhk
bR2Ij3TzMfW2aGDsUoWdVqw0fmLds+fiuVmXu/kkpnF78swQ0zVLUTaZ0wiQp+vI
8zHNXn5kseydiKgMd95mY1s0HeAAx9kj6zxMU2hJXQwkwkeew7+QZ2nrHqoBluRA
KegizXDHmwKA9NY5pIfhCL3MdY2XgYtffDu02sGYCX3Pe4j18zoYK/7pkmTDY4GW
IT/oPj62gS5pGsIoPM5j7w1GIY/ykBOFn4oT7ULoXGZrBgG0IFUVQdXaQxhj4gyR
avVocTGC0eSURRaNW1TK8GO/rCKwIVt+ufVb03z20/kXxkPsJx6D1NiDUoH4/dyn
JJHhGDSqE4xPJJ495zRntAcVzETjf9kdnd27bchhBAL+jJMpvXk0SnuSJ17FeMXp
WtNzl8/lzk6bL/CJgfu1Au7ku0e+WHutVkpQcijrRGdCMj86gQGw+Rdntv9tlFPS
BBqgaVyJ79i4+7OZl/pv
=Gna9
-----END PGP SIGNATURE-----

--oWmw72ncIFLvWQprDNuMG8UhbNj2fZo9j--

