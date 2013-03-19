Date: Tue, 19 Mar 2013 13:35:01 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130319123501.GV953@...1296...>
References: <1363624652-7001-1-git-send-email-steffan.karger@...1435...>
	<1363624652-7001-2-git-send-email-steffan.karger@...1435...>
	<3973366.5Qu7FHKKCl@...1526...>
	<1CED409804E2164C8104F9E623B08B9013B8F531FC@...1436...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gU5RoU0MzIDcUgzM"
Content-Disposition: inline
In-Reply-To: <1CED409804E2164C8104F9E623B08B9013B8F531FC@...1436...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] PolarSSL-1.2 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--gU5RoU0MzIDcUgzM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 19, 2013 at 11:38:44AM +0100, Steffan Karger wrote:
> Sure. There's two options here: remove it from 1/5 and 'break' BF-CBC bet=
ween 1/5 and 4/5 (although BF wasn't supported by polar before 1.2 anyway),=
 or revert these changes in 4/5. I'd go for first option, since it delivers=
 cleaner patches. If no one objects, I'll send an updated patch this aftern=
oon.

I think that "option 1" is fine.  We'll apply these as a whole set, not
individually, so breaking "in between" is no concern :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--gU5RoU0MzIDcUgzM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUUhbdakuBuNlUUl1AQJyNwP/fw8k2/XPZJ1meYArz1wElwAZRTdLR1ed
OJd7mOcAxxogmRzGy+NXftrnYrttqbSozjXAUgAdwJJTFusp9t2NBk8itufGlfiq
6jHAE5JQn672HUOqdK7t9ybZEbyqGscbsnLurlLKrrcVa39uq7elLSkEYzRWxpk9
cdiRkMW5RcA=
=uRM6
-----END PGP SIGNATURE-----

--gU5RoU0MzIDcUgzM--

