Date: Wed, 29 Jun 2016 10:11:09 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160629081109.GU78279@...1296...>
References: <CAFHpkQGrube6hF3+hab3NdNhcifjV15ZSefdUWCcXJPg_CApKw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tVmo9FyGdCe4F4YN"
Content-Disposition: inline
In-Reply-To: <CAFHpkQGrube6hF3+hab3NdNhcifjV15ZSefdUWCcXJPg_CApKw@...278...>
Subject: Re: [Openvpn-devel] git master: no more WinXP ?
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

--tVmo9FyGdCe4F4YN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 29, 2016 at 01:05:17PM +0500, ???????? ?????????????? wrote:
> I'm trying to install openvpn git master on WinXP, no luck, it complains =
on
> missing fwpuclnt.dll
>=20
> there's no such dll in WinXP (and it is not possible to supply dll within
> installer)
>=20
> https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/Makefile.am#L1=
30
>=20
> however, I do not see, where it is called in code.
> what is it for ?

XP is no longer supported by git master / 2.4

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--tVmo9FyGdCe4F4YN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV3OCnakuBuNlUUl1AQKkmwP+O9By+W7l39k6K/kZ65p8rtbuojdXp3dY
V4rO6MH7LZ13mk5JMgwYlGkqVIzZ2xAoHSnCplDAJ0TQfSbj1dUqkh0n/7bEbI51
MFd4Ch+J93dA0Dxy+1O8nV5arLvWHB2d1nOSH16aB1JFPRanMbrbScAAHLuuGOd9
2krAzJbZbVw=
=4MIw
-----END PGP SIGNATURE-----

--tVmo9FyGdCe4F4YN--

