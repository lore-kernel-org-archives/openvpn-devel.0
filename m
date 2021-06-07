Date: Mon, 7 Jun 2021 09:38:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210607073802.GW976@...1296...>
References: <20210513064416.212-1-lstipakov@...277...>
 <CAKuzo_hfQifKQGxX9zUNv861mjiiiPxJw+me-iPf_ZkgNJovvg@...278...>
 <CAGyAFMVsxv8fRFJD+zivivR9ugtJQoxCrf3_XF9f+eaetF8wyQ@...278...>
 <CAKuzo_jCE7zsxU64+20A28PuWoBDQawOHgGotiYJJ1XsyxsF_A@...278...>
 <CAGyAFMUGwv6r-xxjw0te4P-a8k2aJ0zxPmegZ5eDDbx7yLxZSQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="DKPFFISdOghEqT12"
Content-Disposition: inline
In-Reply-To: <CAGyAFMUGwv6r-xxjw0te4P-a8k2aJ0zxPmegZ5eDDbx7yLxZSQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] contrib/vcpkg-ports: add pkcs11-helper
 port
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DKPFFISdOghEqT12
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 07, 2021 at 10:34:36AM +0300, Lev Stipakov wrote:
>  3) do nothing and have those ports as part of openvpn repo. vcpkg
> supports "ports-overlay" , so
> I see nothing wrong or "hacky" with this approach. I see you point
> about having dependencies build scripts
> as part of openvpn repo. However in this case script is fairly trivial
> and mostly consists of boilerplate code:
>=20
> https://github.com/lstipakov/openvpn/blob/dco180521/contrib/vcpkg-ports/p=
kcs11-helper/portfile.cmake
>=20
> To my understanding this part of openvpn is fairly static, so I don't
> expect much maintenance burden for it, if any. In any case I
> volunteer to take care of it.

For now, this sounds like the easiest way forward...

>  4) submit pkcs11-helper and ovpn-dco-win ports to vcpkg upstream and
> then remove those from openvpn.

... and when the dust has settled, move here...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--DKPFFISdOghEqT12
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgvczZAAoJEB2Cnv7KVigS7iQMAIJ4m/cCnvC6bo20xzEWkqLG
6K8gzqRnDNJQJohsPHQRX/R9YnY0269iGtQSJOhqesQhSgOJVcucy+FsheGCw3CX
p907rPoX0gQYcNvUxILrypEt8J8pRxXb7/Oz2T+VFptEO0vz3wuREy4DNKrbvPGg
ZOX4ZfFL2cQZtFrl3Ouc5xZPF4UHlEuECFhpt7gA3Y2o6OGTuTVh1pnrOe9vyiNP
a5P3kJep8yrgG7umgGHlB8Ug2EsvbDhEsj9QNRYLrd9GIRoZuR0pcp8ARW4FolI/
L3ElCA56/3PeVlWO4REE+Pxm0lzG+2ngZdJ461+hovBZgSmQd8PpOSFwqSn/1grU
uDCh3F/8NCWVCO50DrSnKcPISbUtGZt+IWKn+ModrR5DROorZ97i64GMIb5oslWT
uhoUdAwzrVh9jFBnQResRjiqp9+FZjf6NfMojbxOSiId5KwHmHE6+okDfjMs5BlI
kfEiU+9EsdyP5IKWS6tdS4kVDuq8gtfmFrT5Dv7tYQ==
=Z131
-----END PGP SIGNATURE-----

--DKPFFISdOghEqT12--

