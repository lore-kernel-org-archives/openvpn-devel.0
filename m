Date: Wed, 19 Jun 2024 11:44:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZnKodXfUYfL5LUlJ@...1296...>
References: <20240618120219.5053-1-gert@...1296...>
 <202406181630.45IGU5vu098122@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4Sd5uMp4901um1oz"
Content-Disposition: inline
In-Reply-To: <202406181630.45IGU5vu098122@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: mbedtls: Remove support for
 old TLS versions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

--4Sd5uMp4901um1oz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

this breaks *all* client connects on my server testbed.  No matter if
2.2 or 2.5 client, when building with mbedtls (2.28.7), the resulting
binary refuses ALL incoming connection with

Jun 19 10:21:44 gentoo tap-udp-p2mp[1723]: 2001:608:0:814::f000:16 tls_vers=
ion_to_ssl_version: invalid or unsupported TLS version 1
Jun 19 10:21:44 gentoo tap-tcp-p2p[1770]: tls_version_to_ssl_version: inval=
id or unsupported TLS version 1
Jun 19 10:21:59 gentoo tun-tcp-p2mp[1708]: tls_version_to_ssl_version: inva=
lid or unsupported TLS version 1
Jun 19 10:22:32 gentoo tun-udp-p2mp[1713]: 194.97.140.21:49229 tls_version_=
to_ssl_version: invalid or unsupported TLS version 2
Jun 19 10:23:05 gentoo tun-udp-p2mp-topology-subnet[1718]: 194.97.140.21:45=
789 tls_version_to_ssl_version: invalid or unsupported TLS version 1
Jun 19 10:24:11 gentoo tun-udp-p2mp-fragment[1746]: 194.97.140.21:14517 tls=
_version_to_ssl_version: invalid or unsupported TLS version 1
Jun 19 10:44:49 gentoo tun-udp-p2mp-112-mask[1741]: 194.97.140.21:42810 tls=
_version_to_ssl_version: invalid or unsupported TLS version 1

so my guess would be that on mbedTLS builds that *do* support 1.1/1.2,
incoming client connects with 1.1/1.2 cause "something to get upset"=20
in the TLS version printer.

Sorry for not testing this more thoroughly before merging.

gert



On Tue, Jun 18, 2024 at 06:30:05PM +0200, Gert Doering wrote:
> Mildly tested via GHA builds.
>=20
> Not sure we want this in release/2.6 - I tend to "not", because it might
> break someone's (non-recommended) setup...
>=20
> Your patch has been applied to the master branch.
>=20
> commit 013c119af96bc57c41e04e4a8f64b5d80e2e9ba6
> Author: Max Fillinger
> Date:   Tue Jun 18 14:02:19 2024 +0200
>=20
>      mbedtls: Remove support for old TLS versions
>=20
>      Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
>      Acked-by: Arne Schwabe <arne-openvpn@...1227...>
>      Message-Id: <20240618120219.5053-1-gert@...1296...>
>      URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg28773.html
>      Signed-off-by: Gert Doering <gert@...1296...>
>=20
>=20
> --
> kind regards,
>=20
> Gert Doering
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--4Sd5uMp4901um1oz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJmcqh1AAoJEB2Cnv7KVigSKm8MALICikAxXyd92LutoT6GQjki
Bl/WDmfHmVQ2fvB1+YMeFPAIlmLPX8QdnWX2fYl9CbD+SytWOX0s5/45afpby8ye
jr9HNDiUayUW7Nxaa+OFh6viRCuF2VQ7bt5dNYfbd7cjxb/ZNnRUUiaQca4FTG98
s0mrvihqNkNg4ioeL0oxr6TTf9Cg6Y7WZdP7HhtxMqzlGQe9SgAYVC8IE85Jp1t/
qK7SqIVtPQouR/hU9/89Imii2c6NgK6gUJybEK4x4OPwC0VCP3ZJDHTjRnFzoWGp
mc1d1Dx7cqSuwhPWbTWrLFHhr3sfOZWOZgnMUSYcXBEgyqYVsQdfiqEr5olGeRIE
6cbhF7Z0iMgEzbTKK/6vT6gJLxxwpRPjMLoc8qiia/2ME3+KcQ17wY6zZHLXuAkl
wVWXx3AVcTZVcJTW9Kxqr9x4y1vCSHtEUbZ6ZSL3L5wXUsEWK+ztEkQ7y77pgu1P
DfH9QSAa2WR96S+qmTnC6uire6Ru0lE9TBcH7PRzOA==
=HKgW
-----END PGP SIGNATURE-----

--4Sd5uMp4901um1oz--

