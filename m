Date: Sun, 1 Apr 2018 17:34:22 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180401153422.GE69387@...1296...>
References: <20180401063058.23913-1-gert@...1296...>
 <CAKuzo_gRyd++KVmH=iGALbz0kjPiXLhK6DkAGA0Uu0mcV6RG8A@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="T7HNq/m++EF3pl6p"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gRyd++KVmH=iGALbz0kjPiXLhK6DkAGA0Uu0mcV6RG8A@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Depreciate IPv4-related options.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--T7HNq/m++EF3pl6p
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 01, 2018 at 10:19:37AM -0400, Selva Nair wrote:
> On Sun, Apr 1, 2018 at 2:30 AM, Gert Doering <gert@...1296...> wrote:
>=20
> > As discussed in trac #208 and on IRC with Antonio, OpenVPN 2.5 will
> > be IPv6-only.  Removal of IPv4-related code and options will dramatical=
ly
> > reduce code complexity, confusing options, bugs and user questions.
[..]
>=20
> Nice try :)

Hah, caught in the act ;-)

(Apologies to Jonathan for scaring you about new user support issues...)

Trac #208 is really about *enabling* IPv6-only mode (which does not work
today), but not about *mandating* IPv6-only / taking away IPv4.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--T7HNq/m++EF3pl6p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJawPv9AAoJEB2Cnv7KVigSAnQMAI2347q46jabaLOmhmoaDU+N
lQidIS2rzIm2rm521DR8ep4mOcSbknRwC9ypZhDNE5sN9zC66SrHlZF/Q5/LB4w9
2Au4eTWVJmDfs//XRDBd0dtduypfHG/w+4IMQM8cP8kCXzS+Bb2COMMbCzZpVuzP
R30E3q3Uo9zt+SNn76UFBGShLru3HlMIxVBgBT3Dv2zdx3e1MRmkDPqeLMvjZno7
ZnhqryYJ5w8KwQw8Eok42oL/GnwXawh52aX1RjY2625pe5CbpxGULGV62aSlgO/L
itBiIPdib6MN+iRDsli/ckWn1sc6Z6rfwSWsQ0eUJH2lFegu036lAkNqDFSA/NXU
Wx7f+bd96VLX2dIWMqQ2oRr8zG+b6PCyj2/WKJnLqbfFcX6rs+OCOLphYpgpWwLu
0gloPOd+fJMWa8hYrRM6iqovpq6H1A2mRDsCF+ECDjUTnCqpIpa7zGZbmGe32HeF
sveYUydKjvVVDseZ6t+XstOU4ZBFgKoec3HelWRHtg==
=aN/E
-----END PGP SIGNATURE-----

--T7HNq/m++EF3pl6p--

