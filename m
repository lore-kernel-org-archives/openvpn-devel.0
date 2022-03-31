Date: Thu, 31 Mar 2022 13:34:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YkWRq/k7YDEvr2m+@greenie.muc.de>
References: <20220329192934.1415-1-timo@...2669...>
 <20220330205536.139-1-timo@...2669...>
 <9564ba11-d626-4e60-fa2f-979c114b95c2@...277...>
 <d18f61d5-3f4d-b6b1-2a57-d2b2ff9b7a25@...2080...>
 <YkWKTthhlLISLXbl@...1296...>
 <8c17e977-98b8-64f7-56fa-42fc2cb5f787@...2669...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="icR+damZ8+Lxl/sW"
Content-Disposition: inline
In-Reply-To: <8c17e977-98b8-64f7-56fa-42fc2cb5f787@...2669...>
Subject: Re: [Openvpn-devel] [PATCH v2] Retain CAP_NET_ADMIN when dropping
 privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Timo Rothenpieler <timo@...2669...>
Cc: Gert Doering <gert@...1296...>, David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

--icR+damZ8+Lxl/sW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 31, 2022 at 01:29:28PM +0200, Timo Rothenpieler wrote:
> That's exactly what the patch does.

Which I very much like :-)  (I said that on IRC already, repeating here
for the list archive)

> Only difference is that for sitnl, to avoid breaking existing setups, it=
=20
> will fall back to the old approach of switching user if the capability=20
> retaining approach failed.

I'm a bit undecided if this is really something to worry about... but
then, in an existing and working systemd environment with reduced
capabilities it might break setups going 2.5 -> 2.6, so maybe "being
careful about things" is the better way :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--icR+damZ8+Lxl/sW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiRZGrAAoJEB2Cnv7KVigSlt8L/j/+0Drty9mXH4H68+jSuq1L
XY/kx3jo9yLsRQwjRTLWfl/ZE7OB78XrtJR1+mwUgtMjE+9f2Orvv5ODiwnT9CSr
z1fUWMTtKTSjJCzOHPa5fQCuT7QUQ2kpOjnzDU2k07vD2RwOuSEp72fSblV1/cP2
TzVYriFDWAiHICA0/sY00uBHIq35MfI9u0tcHu7rmV2+ZM6jU5cDMhXHgFY7RDcH
LjI8ejmeDE4Ik1oKcToPkUKo0+3+TyO005QJGMmjIgCV6utgcvRc4R6LfQeXhAXM
TrCIVYl15itALIMqJCWt4F9eYuHnltlqkfgazx5km3X9q8dLv+NNeyOoGfoVnHJD
eKLjkMT5KJ2pPdabMqKwXE7i1dEXm2x8tA3JZTMQuSpvP3GWuwnZ0dYCJGdTN6xC
vCD5iu7W9qfo5RH4OljwFS3avfbaIGWrG7iaSdLNbZ4KviCFMGgWAsPGiG0sNOrf
n3hBgNrRQfPkFisPlhK218aTJG4pDcNm2u1/B0oLrg==
=QNYf
-----END PGP SIGNATURE-----

--icR+damZ8+Lxl/sW--

