Date: Sat, 4 Feb 2023 15:36:15 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y95tX0ib9yHiUdBz@...1296...>
References: <20230128223421.2207802-1-selva.nair@...277...>
 <20230128223421.2207802-5-selva.nair@...277...>
 <Y9pTdgI+T90r6PBz@...2685...>
 <CAKuzo_jCb_tcMY6b1MeHJXLQ37cHDcpOSUttKqT9fFuzNL0w5Q@...278...>
 <CAKuzo_jPnumze9KSWA6ywKh-rH3=vrtDZPtWVK-FGrwjgcv=mA@...278...>
 <5fbbea42-096a-f9e9-f230-ccc526e973e2@...1227...>
 <CAKuzo_jTyEnq9-MwT8XePMby7yNXzN-auwx8osYSx16nC-z8zA@...278...>
 <1e9a8fb5-22e3-847a-6bcd-98ce8e3f893c@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fp/Y/8J/tI2pf5fV"
Content-Disposition: inline
In-Reply-To: <1e9a8fb5-22e3-847a-6bcd-98ce8e3f893c@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 4/4] cryptoapi.c: simplify parsing of
 thumbprint hex string
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel@lists.sourceforge.net

--fp/Y/8J/tI2pf5fV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Feb 04, 2023 at 02:22:30PM +0100, Arne Schwabe wrote:
> Even though I think that adding Cmake as=20
> unsupported build method is a good idea. This would allow others to have=
=20
> the same option/advantages like me that prefer cmake to=20
> autoconf/automake, this also does not seem to have a consensus, so I=20
> just maintain it for myself in my branch.

I do not object to having "something cmake based" available for those
that find it beneficial.  I just do not want to move over completely,
as I think on unix/linux, autoconf does a good job and *for me* cmake
just adds complications.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--fp/Y/8J/tI2pf5fV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJj3m1fAAoJEB2Cnv7KVigS12cMAJYVrUlDcsIM4qFCDPiLKs3h
7jEqw94uwRQ1ZBaOXvpn3EFYSjcyT3HcgWTS6XTjwETfiUXueAn+5BvuyRgAdIEl
DWBUefs/F8uezezv7VDi0BIZm1DfC7wn9YZtPIakd76yPDOJfNJ7BVLX/zRfeeS0
HIQ2OUqkhKF8tYF6RZWYu8fGuvVE4U2L2BtyWZ6a+kyXwRDRmKTpqAfTgnxdURxS
gJr1Mjwxi8k/HlKaF5pW5Y6gTvM50EHVfjKhp2BdVCCDGKnHTaY5E4Wpq9S8dz4/
j5hvYXjbKKmXpIqwIFvJYD+X/Rg8hgXQOdZy1BlVCqSLFVV6ml/gb8X/2QOBgAtc
SSYnACU4NHWiha5E49KgYGRleR9m+q2AGz0NJBhX60zw/oBeEUMtyIajKFv0QkLo
U/SLxInRgwX94SrqaHMTUET0A1ne4HPCJbC1IH/X0mvL7/uFexlYA5hGJTL8O6F8
yfOKIcsdWM6/kJQHnzPpDfOVxOcEEyVemFRtv9Ff1w==
=WxxN
-----END PGP SIGNATURE-----

--fp/Y/8J/tI2pf5fV--

