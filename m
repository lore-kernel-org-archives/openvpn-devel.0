References: <e5ec298b-cd2e-ee95-955e-56df133e0ef8@...1227...>
 <1548164060-13144-1-git-send-email-lstipakov@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <9f02f757-fa41-49af-e455-83bb606df51e@...1227...>
Date: Tue, 22 Jan 2019 14:45:16 +0100
MIME-Version: 1.0
In-Reply-To: <1548164060-13144-1-git-send-email-lstipakov@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DXsPHiK4SXXRXJJ4DGV1ORLfyhi17A6bt"
Subject: Re: [Openvpn-devel] [PATCH v2] test_tls_crypt.c: fix
 global-buffer-overflow found by AddressSanitizer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DXsPHiK4SXXRXJJ4DGV1ORLfyhi17A6bt
Content-Type: multipart/mixed; boundary="qJoV1eL0IhIY92Ncs8xGtI9VOKyfzCpaB";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <9f02f757-fa41-49af-e455-83bb606df51e@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] test_tls_crypt.c: fix
 global-buffer-overflow found by AddressSanitizer
References: <e5ec298b-cd2e-ee95-955e-56df133e0ef8@...1227...>
 <1548164060-13144-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1548164060-13144-1-git-send-email-lstipakov@...277...>

--qJoV1eL0IhIY92Ncs8xGtI9VOKyfzCpaB
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 22.01.19 um 14:34 schrieb Lev Stipakov:
> From: Lev Stipakov <lev@...515...>
>=20
> When writing data to buffer we incorrectly specify source length
>  - sizeof for pointer returns 8, but actual buffer length is 1.
>=20
> Fix by replacing empty global string to local string literal and
> specifying the correct length.



Acked-By: Arne Schwabe

Arne



--qJoV1eL0IhIY92Ncs8xGtI9VOKyfzCpaB--

--DXsPHiK4SXXRXJJ4DGV1ORLfyhi17A6bt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlxHHmwACgkQFRhsZwKx
RFT8FBAAralOvU7684baK2rHJUPjY2dqNih8CQXtiZvdi2eDoleg3yC98LE+l2oq
8Ag/ofmGCpzEAMivaljbsx6FCCMvkvcatCzbvab5b42ZTLWD0L2UFONBVc7gHmgm
6dVEiaVdW3YToFxpao1jV2N3B7qptK8l87VwJdd53R37UrKqfo9RNgvSkcjZYNW0
iPzQXSczjxfCgN4e4bMZdqdtt5SdSlKetQ35D9K5ME+fLsRrMaLgat+Npt4elv1H
ZZ3qXkTSEIakgh5DcB+ULq7GMDbbk/HQTy855jo4nwObNH7upj7JCZQZCACQpw1c
LPx6vM+PX8CNYZdy/lYYk8zrnxNJstPudCAW4cWB7A6/2XD1fpbFlT/zP7JM2x5D
YiORRjzAhv2TsdDBIsc5ICf6qMSR6tMQejcxs58WrXr3fK28R7WWQYjzyo0HjuAE
NWL7FiFa5JZssIZIjeijGdo+tuc1PWX6pfYybJfB/6tKzPtlyxwS6c8HZRmMCN7t
Z+xg08CM6WIUXgmixDFbSIx4fkXtYwC8Gjjb0oF9StG343wo+u2fqoAbBPLqI2dm
W8VrlP44AFLVU3Za7eMDCJ/dUuLZnnPA2Ki+dFeRjlpx6yzYNPkIVT0ZEXmZeZq6
CgZ4V1rBFiRJb0NM+LWOGxV4OWih/3uRXLaG5efq2X833a06S1s=
=Zb4F
-----END PGP SIGNATURE-----

--DXsPHiK4SXXRXJJ4DGV1ORLfyhi17A6bt--

