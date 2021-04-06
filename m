Date: Tue, 6 Apr 2021 13:14:29 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210406111429.GY976@...1296...>
References: <E1lSJph-0004I0-FL@...2479...>
 <8b081dd5-2c1d-c71b-8af0-d4c886e4260e@...1227...>
 <E1lTjOz-0003I1-MM@...2479...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7M+7dvBGnz3GwBQc"
Content-Disposition: inline
In-Reply-To: <E1lTjOz-0003I1-MM@...2479...>
Subject: Re: [Openvpn-devel] [PATCH] Change CTR DRBG update function call to
 new mbedtls 2.16.0 API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Maximilian Fillinger <maximilian.fillinger@...2507...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--7M+7dvBGnz3GwBQc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 06, 2021 at 10:55:52AM +0000, Maximilian Fillinger wrote:
> > This change will break compilation with anything that is < 2.16.0.
>=20
> This function is deprecated in 2.16. I don't mind keeping this change to
> OpenVPN-NL for now, but for future reference, what's the best solution
> when a new version of mbedtls removes the function?

It's still available in 2.26.0...  so when they decide to really remove
it, we'll have to see

 - what is the oldest mbedtls version we aim to support

 - if that is "2.16 or later", we can just apply the change as is

 - if that is "before 2.16", we need to add compat code - either
   #ifdef on mbedTLS version (if possible), or adding function detection
   to configure.ac (as we do for OpenSSL).  Both is somewhat annoying.


Now... what *is* the oldest mbedtls version we should reasonably support?

For OpenSSL, we're stuck to 1.0.2 for the time being as that's still
the primary (and bugfix-backported) version on FreeBSD 11 and on RHEL
versions still supported.  For mbedTLS I have no idea.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--7M+7dvBGnz3GwBQc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgbEBmAAoJEB2Cnv7KVigSdg0L/0aOfmq1Tj6ueygPGiBIlrat
56f2Pk+Am+Ui5xPfS3EZ6HQSJ4UfMBe/T1Zf7XCHlct1fwx4VWXToEvZBSS98QUg
NasM+ISY4ch4kuXlqrcHOlczu97b7cahYH2TJsZB94xAU3E0RiZ08ClpTh3Euakz
4yP4DDVNJkI8c9Gw5m89v/5xDKfCDIg0bSS22s+/D9vm5NVnpCSiJeoby8BYkTvI
18m7cx8R9Y6Cqn0WSFyGX/7RQfi+iECGtcSG94F8GvS/G7H7IAZbF16qknA/aDMf
NsqxS2GT0TqTuN6pdlr2tZFUyhQbCdp/gr6kUoHlsCZc2bzHDlaZkr1aphJwk3s0
aIihe5OIiHnwMfL8cqg+/ExKDAZqkhtamIAgtJaO2zG8KDJ6a0wAVuWEN7vahMhD
EzpEsY+bvNQ4O2tkmvq70WdGxvcP2PWGtsmQTm5zQ92/dvZTVd6/vnv0Ufoh2zay
XLNQjDxPJI7OQm6+Li7shDhAc0KJnjNmsFc228Amjg==
=pEtJ
-----END PGP SIGNATURE-----

--7M+7dvBGnz3GwBQc--

