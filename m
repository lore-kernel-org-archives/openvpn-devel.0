Date: Thu, 20 Dec 2012 12:03:47 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20121220110347.GQ22465@...1296...>
References: <20121217220355.GB23292@...1794...>
	<20121219212619.GN22465@...1296...>
	<20121219221305.GS23292@...1794...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7TMozD3Tun2T/vWz"
Content-Disposition: inline
In-Reply-To: <20121219221305.GS23292@...1794...>
Subject: Re: [Openvpn-devel] Fixing "passtos" on !Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jeremie Le Hen <jeremie@...1793...>
Cc: openvpn-devel@lists.sourceforge.net

--7TMozD3Tun2T/vWz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 19, 2012 at 11:13:05PM +0100, Jeremie Le Hen wrote:
> > so I'd propose to #ifdef it differently, patch appended.
>=20
> Your patch looks fine to me.  I went that way because I grep'ed the
> source for TARGET_ and saw similar occurences of what I did, though each
> part contained more lines :).

Yeah, some of the existing bits are seriously ugly... :)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--7TMozD3Tun2T/vWz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUNLwk6kuBuNlUUl1AQLyfAQAlePfDayakqYrhfcl1wZ4GaG8dOUevnrv
IgMx44d6PHfgAGu/mhbd7i6s0hE5IpTCBcAENTNx8GUZdVV6Nqkp0/dnlvY7X/Mu
ipBUMcXouvsnU8yNABNTottc4hV4khimw7cwq267ly0UUCKSPgHtufi+wPHdmpuO
6llHMSVVb/o=
=8EPg
-----END PGP SIGNATURE-----

--7TMozD3Tun2T/vWz--

