Date: Fri, 22 Jun 2018 17:34:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180622153447.GN57262@...1296...>
References: <20180622102110.21888-1-a@...2181...>
 <CAKuzo_iAnVU=6bar7a6TLXOjWqMuNjLhiznD9oPBnpyGC4sfTg@...278...>
 <5858f87b-165f-f390-6769-938e5a43ce55@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vjt5mXJPvliG4SvL"
Content-Disposition: inline
In-Reply-To: <5858f87b-165f-f390-6769-938e5a43ce55@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] route: fix format string passed to
 argv_printf
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vjt5mXJPvliG4SvL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 22, 2018 at 10:48:30PM +0800, Antonio Quartulli wrote:
> However, if we believe supporting %lu can be more useful, I can do that.

I tend to add "%lu" to argv.c (which might eventually come back to bite
me, as there are still patches from Heiko pending wrt argv IIRC).

Since we make the same mistake again and again, we shouldn't cast around
it but just make it work :-) - and it's not a lot of extra code, nicely
isolated.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--vjt5mXJPvliG4SvL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbLRcWAAoJEB2Cnv7KVigSb0UMAKXpXuqNwQ0hNrrpzNWa+aT8
eLnEMZaBTeBOIvMxI+/bazmriGWlVjYBE1JHubNqNLG1Yfg0mb5XdURRrNVMca5w
vE7qNEAkwI5QCGWSD9+7Y3JE7eACoWWL2b2WE7MuJ2yZd8haDVNla1fLhZeTjKhb
nXyrFwOm/DCpytirpZUxrPwKFS1CM/tlU/E3n3LBUUpPpxHpCZFs7C7QVaO2LL3Y
RWjkrNFzxChOA0pC99tPhwe8tYLpTGGbHiHJ4vVnr6eJaJXd08WRoFeUvYVBMgmr
MFZGQltSQ9YTS6JqCOru7s78Iti5RMAisxi6Sx9vOUUxE1W/k53PPg8G5lFVpc9n
zL5GvmDzbK2RO/yh/OpelvP4Em8ITLdfGevw3WgS6fRvgCLpelq5aLMioqxj8tdz
qCcblD3qFYpQpdDwoca7n47BMEbCHgi6az5Dim8H80dj8I7Qe+MUkM0Wza1wkAmU
Jr4zkZEFwFj32i5p859aUx+ChICtYDik1XUu0gto7A==
=HBaN
-----END PGP SIGNATURE-----

--vjt5mXJPvliG4SvL--

