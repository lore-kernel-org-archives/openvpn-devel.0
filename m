Date: Mon, 18 Jun 2018 20:40:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180618184046.GG57262@...1296...>
References: <20180608052017.6696-3-a@...2181...>
 <20180613141213.5962-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Ksq4alxdE/AwthTb"
Content-Disposition: inline
In-Reply-To: <20180613141213.5962-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/8] windows: properly configure TAP
 driver when no IPv4 is configured
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

--Ksq4alxdE/AwthTb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 13, 2018 at 10:12:13PM +0800, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
>=20
> This patch ensures that the TAP driver on a windows host is still
> configured, even though no IPv4 has been provided.
>=20
> In this case the TAP driver ioctl will be invoked with a fake
> 0.0.0.0/0.0.0.0 IPv4 which will simply start the interface and
> get it to a working state.
>=20
> Trac: #208
> Signed-off-by: Antonio Quartulli <antonio@...515...>

I think this is good enough, though I haven't tested it yet (compile
and run).  Will do that tomorrow, before I merge & push.

Before I go ahead with it - Selva, are you fine with this version?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Ksq4alxdE/AwthTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbJ/yuAAoJEB2Cnv7KVigSX04L/AlY+wi0mc5UynbmvPIzODfW
igzu6JXAjvIwcCtzJ93kH9bSZmLLv/F7gCvZRaCTuatF9u9GTqMAZamFf8jbIJdS
ck1awLiPMzsP3Hsuror6YKvr+oCV/zqkEOlpAJXzYuXwPMjwAfqe2n8BQXhG85r8
LtJhG76c1DD+xf/KK4DDjSWQ/XW7eXLRJlGIHlUVRA7S4le7yCm/cAOhPEE6bwOV
HE+5pXpl0B1WVOtGV55hwhKJbB+htBpBJpczTV8rHfTBMNKRvE+dHyOBVrWj1x/l
4SoHHJZZagx0zW+9Jl4LGoEpvt/yoJ2oCdt/HqbVsj658fGViEvt7cImTh5QJmyg
0asq3jpaPwtA3sbFDymrdWe1LPpVZIW4QOJuCV/5MHY2HD5LqtbJd18EbpLHTa8K
Rosd7ZlKMI3dfCBYq61rnUNpLkOublisbBdpFC+LXg64aFndEoMNDFnaRXXkjcut
ahR29HHk5XJfHR1QFk3D2VzW42QkYUfcT9n562Yacg==
=qPZO
-----END PGP SIGNATURE-----

--Ksq4alxdE/AwthTb--

