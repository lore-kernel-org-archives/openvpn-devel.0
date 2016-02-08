Date: Mon, 8 Feb 2016 08:42:38 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160208074238.GE24952@...1296...>
References: <CAKuzo_gX4qwZg01UR2k=_g1yEY93z3wc1LiyqTXn=WBm3aZvwQ@...278...>
	<20160207215605.GC24952@...1296...>
	<CAFHpkQEzCUDpHgRZhxYqTBUkvSe7ra5-CiS06Auzke+6vB=dkg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w/hSYHrkFqoLN049"
Content-Disposition: inline
In-Reply-To: <CAFHpkQEzCUDpHgRZhxYqTBUkvSe7ra5-CiS06Auzke+6vB=dkg@...278...>
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

--w/hSYHrkFqoLN049
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 08, 2016 at 08:35:54AM +0500, ???????? ?????????????? wrote:
> I have one question regarding that.
> when we deployed openvpn, we used to supply our users a config file witho=
ut
> "nobind" keyword.
>=20
> it worked for most of our users, however, those who needed 2 or more vpn
> connections complained that "port already bind". so, we added "nobind" to
> client config files and people become happy.
>=20
> what about that PR. there might be cases when
>=20
> 1) interactive service installed
> 2) user is administrator
>=20
> how many openvpn processes will be running ? how many of them will attempt
> to bind to 1194 ?

You still seem to misunderstand what iservice does - iservice does not
automatically run "thousands of OpenVPN processes".  It will do what the
GUI tells it to.

So if it does not work without iservice because GUI tries to start two
jobs with "bind 1194", it will not work with iservice either - no=20
difference here.  First bind will succeed, second one will not.

What is "first" depends on what the GUI starts first - it's all controlled
by the GUI, the service does not start anything on its own.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--w/hSYHrkFqoLN049
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVrhG7qkuBuNlUUl1AQLLegQAqZcayZ6bYAbTFe077+n+Oby/JJQtI799
oIu3T7i7kgBpM6p+dY7gOgf7h6PX7H6oQcs/+9UWDQ0lJLEA55XTsCUas2tLHwEJ
r/97h66n+c3ffwf72A1S0dn0r2Jw3TuZoF8IFc05jpzQwN+4hQi3E+jWy5qf0Dnn
Qb2zdiXcPEU=
=27SH
-----END PGP SIGNATURE-----

--w/hSYHrkFqoLN049--

