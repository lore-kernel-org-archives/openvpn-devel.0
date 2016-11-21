Date: Mon, 21 Nov 2016 18:49:53 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161121174953.GM28918@...1296...>
References: <CAFHpkQEKrJqNB2ZmhAwKGebVb6SB75HpnWcrw_niSaALL_S4mA@...278...>
	<CAA1AbxJZL70qY=ivMvskeUapj0V_+z_LVnM2Zp2LxAJT4t62vA@...278...>
	<CAFHpkQEnATPgCyxsLW6bpC5Qr-Cdh=+4X4MRXxgUD+orKpq+EQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Brygnm5BDm5v4Mz2"
Content-Disposition: inline
In-Reply-To: <CAFHpkQEnATPgCyxsLW6bpC5Qr-Cdh=+4X4MRXxgUD+orKpq+EQ@...278...>
Subject: Re: [Openvpn-devel] https://travis-ci.org/OpenVPN/openvpn/builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Brygnm5BDm5v4Mz2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 21, 2016 at 10:31:45PM +0500, ???????? ?????????????? wrote:
> this line
>=20
> https://github.com/OpenVPN/openvpn/blob/master/tests/unit_tests/openvpn/M=
akefile.am#L17
>=20
> causes an error

GNU LD manpage says this is a trick to make it link "another function"
"--wrap parse_line" would make it link __wrap_parse_line() instead -=20
most likely because @d12fk provided a stub function that mocks the
result (or whatever).

Have not looked into this in more detail.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Brygnm5BDm5v4Mz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWDMzwKkuBuNlUUl1AQK+WgQAwC5WltAr88Fz/wk9YXVMElQeYaCYRFnT
xihIfQXjZxItddhqsSZ8+RVmZ4v2psT/cjwU7x8BYJEa2VHm6tst8xQba2u0Galx
jn9xhev1nwiFM27ey6+ykkKIIDp4QeWqv5OVNjWJ798UAMtFHvlUJIBHL6rdCuPx
MgalZAUOFbU=
=w7nL
-----END PGP SIGNATURE-----

--Brygnm5BDm5v4Mz2--

