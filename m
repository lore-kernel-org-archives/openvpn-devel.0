Message-ID: <53579122.1090200@...1227...>
Date: Wed, 23 Apr 2014 12:08:34 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1393370880-28553-1-git-send-email-steffan@...1856...>
	<1393370880-28553-3-git-send-email-steffan@...1856...>
In-Reply-To: <1393370880-28553-3-git-send-email-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="JUu0COoWpVK1POEwAkDmRkA6xvKEJTV3W"
Subject: Re: [Openvpn-devel] [PATCH 2/2] Add an elliptic curve testing cert
 chain to the sample keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JUu0COoWpVK1POEwAkDmRkA6xvKEJTV3W
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 26.02.14 00:28, schrieb Steffan Karger:
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  sample/sample-keys/README        |  6 ++--
>  sample/sample-keys/ec-ca.crt     | 13 +++++++++
>  sample/sample-keys/ec-ca.key     |  6 ++++
>  sample/sample-keys/ec-client.crt | 61 ++++++++++++++++++++++++++++++++++=
++++++
>  sample/sample-keys/ec-client.key |  6 ++++
>  sample/sample-keys/ec-server.crt | 61 ++++++++++++++++++++++++++++++++++=
++++++
>  sample/sample-keys/ec-server.key |  6 ++++
>  7 files changed, 156 insertions(+), 3 deletions(-)
>=20=20
ACK.

I don't think that adding sample keys is a good idea. Having a script
which generates sample dummy key is probably a much better idea. I am
acking this on the basis that we do the same stuff for RSA.




--JUu0COoWpVK1POEwAkDmRkA6xvKEJTV3W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNXkSIACgkQe8+cMNS4zReQSwCffPm/7s4UuzySRBRFUB1mSnWE
n6IAoMDhFEpVVeD4ee5VA+odAkyKKIgd
=CjyM
-----END PGP SIGNATURE-----

--JUu0COoWpVK1POEwAkDmRkA6xvKEJTV3W--

