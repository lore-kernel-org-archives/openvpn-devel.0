Date: Sun, 7 Feb 2016 22:55:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160207215510.GB24952@...1296...>
References: <CAKuzo_gC70Sozt1BZyf6NhMgPi-NpDWR5G-_fcXx0GKk1_JVmg@...278...>
	<CAFHpkQFyVUfK_QLgou0559-MdWn1TD51xda9kf9vYtHuhB6seg@...278...>
	<20160207192752.GZ24952@...1296...>
	<CAFHpkQEpOn0OBHVjJjQJPazHw8a+OPncDKt5jJVSi6cKpzkeJQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A7YYZHk1c+9kt+kv"
Content-Disposition: inline
In-Reply-To: <CAFHpkQEpOn0OBHVjJjQJPazHw8a+OPncDKt5jJVSi6cKpzkeJQ@...278...>
Subject: Re: [Openvpn-devel] GUI repo
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

--A7YYZHk1c+9kt+kv
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 08, 2016 at 01:12:37AM +0500, ???????? ?????????????? wrote:
> there's still "Start OpenVPN directly"
>=20
> https://github.com/OpenVPN/openvpn-gui/blob/master/openvpn.c#L724
>=20
> in such case admin rights are still required for routes manipulation.

In this case, it would just not work.

There's basically four cases:

 - you have no admin rights and use the iservice -> works
 - you have admin rights and do not use the iservice -> works
 - you have no admin rights and use *tap* with no routes and no v6 -> works
 - it does not work

I do not see a real problem here.  If you do not want to use the iservice,
you need to either have admin rights or stick to tap, done.

> maybe we should release two installers (or make a checkbox in installer?)
>=20
> 1) regular mode (with highest priv manifest)
> 2) paranoya mode (without highest priv)
>=20
>=20
> those who really care will choose whatever they want to

Where would the benefit in refusing to use the iservice and sticking to
"highest priv manifest"?  All you get by doing this is "larger exposed
surface to exploitable bugs, as more code has to run with elevated privs"

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--A7YYZHk1c+9kt+kv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVre9PakuBuNlUUl1AQI8TwP/V9ZAyYQAbQGRbLkU5Rmjhg7jJwXA/VKt
Aq8GhedLpza5II3g9mottg7wOrpUANAYk0BqDY1ZihmYoEc6u9A0TQ+DadRNcWoc
KNsW/+1GIGsYmTvIcWyK7JiWKmtHzsbeVKwniRYd4Z2LBo+OHzrrNbCSoJrGiPFd
sKJ0FegluZw=
=9DJv
-----END PGP SIGNATURE-----

--A7YYZHk1c+9kt+kv--

