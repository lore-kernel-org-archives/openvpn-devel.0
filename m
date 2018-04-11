Date: Wed, 11 Apr 2018 09:48:30 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180411074829.GJ69387@...1296...>
References: <20180401131615.12567-1-a@...2181...>
 <e3d48a12-7f25-1ec0-ad7a-52c1330f43c0@...2181...>
 <20180411091542.39c8c01d@...1799...>
 <5299586c-24cb-d2ff-c12d-404b4a139377@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UXm1vU+X4IBWGr3e"
Content-Disposition: inline
In-Reply-To: <5299586c-24cb-d2ff-c12d-404b4a139377@...2181...>
Subject: Re: [Openvpn-devel] [RFC 0/4] add netlink support for Linux: update
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Christian Hesse <list@...1798...>, David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

--UXm1vU+X4IBWGr3e
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Apr 11, 2018 at 03:43:11PM +0800, Antonio Quartulli wrote:
> However, what I imagine is that each distribution, when deciding what
> library to use (sitnl vs iproute2), will also decide which of the
> provided unit files to ship (if we have multiple precompiled files).

This is how I envisioned how the alternatives would look like - if
you compile yourself, it's your own responsibility, but for the distro=20
maintainers, they need to ensure that different pieces match.

> Or our Makefile should generate the right ones based on the
> --enable-iproute2 switch (maybe this is what you meant with templates?).

That would be an interesting idea :-) - not sure it's worth the extra
complications, though.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--UXm1vU+X4IBWGr3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJazb3NAAoJEB2Cnv7KVigSIfwL/2GxoL1gGTasjHwR45ETXAvW
sV9qf8DfGVl4wZ69glJ18i+Z110TkhtUcduYPR1Lok3ya/LMMJxVgQoZaQJU86YK
x0AIb/brbp0rzjzxdPIRZSBGbsVPJRZzQDDXDjDdMaJyffniOQpSYUmCwaYfr3fn
2ESThNmWvVJOgQaaJWeX/mPuOMl199ZBFteZNMYdVE3jGxFI9CaiwpvuwrfAqao2
VXRWHFx0PmqB1PhjvJq8rbQZWdHRZJxPOxYGK42Dff/PDqhZUW2COVZCKD8lL9aW
3s0vkvD/FwtYfHfNRvN39cU22xjk1Qwv1s/HSmPdaI6qA4+QOlF7519KxNzQy4+S
1uiDttXuGycaaMZFdh2L7FN3i0Ny4dxrIVwLO+aklfEdnQ/78r6NzZbNt4AMxWgg
v+S4P/3pM7CDA1mstD8jMS6douS3zMae1PtbUgRTUSZZEi66ply0r2tmPHnaTOfS
tSe3zRB7+a7HvAYpqsz9NBEN6vZd9k7QsSvdG8Xfcg==
=ERPQ
-----END PGP SIGNATURE-----

--UXm1vU+X4IBWGr3e--

