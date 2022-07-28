Date: Thu, 28 Jul 2022 15:51:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YuKUXQLahYG1bUh1@...1296...>
References: <20220625234150.3398864-1-arne@...1227...>
 <YuGKwNinYLarY5v/@greenie.muc.de>
 <472172bb-efba-eafc-3e78-51c112bcd722@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UXXOn3860fuyWLyY"
Content-Disposition: inline
In-Reply-To: <472172bb-efba-eafc-3e78-51c112bcd722@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 1/5] Extract update_session_cipher
 into standalone function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--UXXOn3860fuyWLyY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 28, 2022 at 03:47:53PM +0200, Arne Schwabe wrote:
> > Is that comment correct?  I can't find any "updating" here, only "check=
ing".
> >=20
> > What am I overlooking?
>=20
> It sets options->cipher sometimes but the name is misleading. I will=20
> rename to check_session_cipher

The "options->cipher setting" part is more "restore to config if
requested cipher is not allowed" - so that one I understood ;-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--UXXOn3860fuyWLyY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi4pRcAAoJEB2Cnv7KVigS5i4L/2s+kTxC2Iht5BhYOhmIJv3I
snB+4tXjntJatTcZFk79G6aRrawhimZJOGkD2i8djA/8ZqofDMpbBS7ANBS6TJeC
lNdIdXLBOCr4zl644+jLiE4Nvm+TvfoLJyILAzKYrJxyCJ7Q1T/t3rYEHghFblLE
4TQtKYRUQtNfFaGAijPkVXwiGzTNwMlYXzqoL3/X02b5BOtk0nm2J8ggpF3H5FsI
KzdiIRI/q+hP3ByBrKeja/iXFh+pRiYpEeYdTzwUftE7q2VgPeBk9RM0HxwSheZF
3GO/PWa0q+5/ZKulGj9NGdGVl8eIsBc1VAXpDKKxey1yJ1k8lah2tl/xCR5NC+wh
H8pCYHubHp/hi0D3p8fVZ4a5W8x6QmSlz6GEcu2TLZxW9peM+mR3hooCg2+SRFXV
Rrl5RapPJGhqTJKqWuPZ80GH2LpGt1Gr3CMc8LOCGNtbdgZUIk0/MrUwEA+DlCuZ
pkwm3hRnVd4GOaXSPqQ6tO/xGBhb7ttecZ9WmqD42Q==
=oeRv
-----END PGP SIGNATURE-----

--UXXOn3860fuyWLyY--

