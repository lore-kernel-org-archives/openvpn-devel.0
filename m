Date: Mon, 1 Jan 2024 09:17:51 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZZJ1Lya6SNfUxl2S@...1296...>
References: <20231231174151.26780-1-gert@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7P+j7z671eND+KyI"
Content-Disposition: inline
In-Reply-To: <20231231174151.26780-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] OpenSolaris: teach
 get_default_gateway() to get HWADDR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--7P+j7z671eND+KyI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 31, 2023 at 06:41:51PM +0100, Gert Doering wrote:
> In the context of gerrit/454 it was uncovered that the existing
> code never worked on OpenSolaris anyway because no AF_LINK
> addresses are returned.  Debugging this, it was found that
> SIOCGIFHWADDR exists instead, and "man if_tcp" claims "should
> behave in a manner compatible with Linux".
>=20
> So, copied and adjusted the linux code, and it works...

Self-NAK.  I found a more interesting route out of this madness.

(This patch itself is fine, but OpenBSD is still not working, and I
think I found a way with less #ifdef... stay tuned)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--7P+j7z671eND+KyI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJlknUvAAoJEB2Cnv7KVigSm5gL/2ZYO3JXRCupdHvXrKGeIk8o
EBJFe4ylJB+w/+1Wbv7IIObHfqEQtmiNnGmFzP+ik2RwN4nYXSKglSYiQqBI9j9w
kAAkLiOo8aij4cN/kTCQ4t/00RF2Pui84DaudqbhcoiWYVVm2Gj3cPm59uCWPVEV
672SmOdIn3d18ZgYOg9H5hC28AOVCbYwW3qzsYMMAVMLXt/FcuqVr6OzIQU+cum0
/DOjrdAFM3N8avGI/LqyX+ocHOGaRUnplQnhDkerdVw+FKEV7aOeBgYrYQ7Mgq12
aUawzqyKoOQvtMZ9Hv7P1j/twPnqL4+J3RW051yGEbFBNWJgz5qRQlj7M9iUVrpm
I/5P0URPLhvl20zXo2qkjHM+qz6fgMtTD68ZMXRliDDVPyF4AF0feas2C+r7VXJu
R6ArnfH4B+nRvTz9rrgHwUupgvBCqXbJbZPDwU8qt+ATiSGjY1PTj309h4Fy64H/
CIXXUC+PCF5yT4vvlujfinZZT/YvJ97hCC8vIOr5Nw==
=0WW3
-----END PGP SIGNATURE-----

--7P+j7z671eND+KyI--

