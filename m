References: <20200821062443.69245-1-eric@...1918...>
 <bd154015-3f5f-6035-c4ff-fae5abc7857c@...1227...>
 <3df6fedd-f30a-4e08-0e82-b31a7728f21d@...1918...>
 <446bb2a7-7597-1c89-b4eb-543abf4e6e3f@...1227...>
 <2f192d4f-fa69-20d3-f9a2-90329d308b53@...1918...>
 <f2ddadee-f969-2bcb-5b19-ad2273a17b18@...1227...>
 <050fed64-f566-35be-f3fa-d9d79cf2a7c6@...1918...>
 <c6d1361f-f7d5-9a28-ff93-580b9dd75ad3@...1227...>
 <84776d54-ca63-e21a-6c6d-311760f9e280@...1918...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <e4040184-0209-da97-e98c-f55c29b9a463@...1227...>
Date: Thu, 27 Aug 2020 10:39:22 +0200
MIME-Version: 1.0
In-Reply-To: <84776d54-ca63-e21a-6c6d-311760f9e280@...1918...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="c6k576IMkHNJkMNq7OhQEpqw3KiRttPD6"
Subject: Re: [Openvpn-devel] [PATCH] Adds client-auth-pending-extra
 management functionality.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eric Thorpe <eric@...1918...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c6k576IMkHNJkMNq7OhQEpqw3KiRttPD6
Content-Type: multipart/mixed; boundary="1VElx7EzCsXbVwSasinbDPTWOZ9Y2cUEo"

--1VElx7EzCsXbVwSasinbDPTWOZ9Y2cUEo
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 27.08.20 um 01:34 schrieb Eric Thorpe:
> Hi Arne,
>=20
> The first we are trying to migrate across is U2F -
> https://www.sparklabs.com/support/kb/article/yubikey-u2f-two-factor-authe=
ntication-with-openvpn-and-viscosity/
> <https://www.sparklabs.com/support/kb/article/yubikey-u2f-two-factor-auth=
entication-with-openvpn-and-viscosity/>


Okay makes more sense now and I see that U2F needs larger messages. But
especially U2F is important/common enough to properly document how this
should be done in detail. The last thing we want is to end up with two
different U2F implementation in OpenVPN one from your side and one from
us (OpenVPN inc) that are incompatible with each other.

So we probably want a IV_SSO=3Du2f, so the client can signal U2F support
and then a documentation what messages are sent back and forth and then
I see no problem in merging your patches.

> Even though the patches in the above article work for the vast majority,
> they are a bit of a hack and we want to get away from them as they're
> still prone to failing on connections with low MTU or fragmentation
> issues as previously mentioned.
>=20
> All our 2FA supported methods that we want to migrate across to
> AUTH_PENDING instead of AUTH_FAILED are available here as well if you'd
> like some further examples of what this would be used for -
> https://github.com/thesparklabs/openvpn-two-factor-extensions
> <https://github.com/thesparklabs/openvpn-two-factor-extensions>
>=20
> Anything using this new method would also end up in the above repo.

If you interested in the SAML/webauth/other web based authentication
protocols, here is a document that I am preparing to document that
properly (should also be soon on the official openvpn3 repo):

https://github.com/schwabe/openvpn3/blob/schwabe/web_auth_spec/doc/webauth.=
md

Arne


--1VElx7EzCsXbVwSasinbDPTWOZ9Y2cUEo--

--c6k576IMkHNJkMNq7OhQEpqw3KiRttPD6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9HcToACgkQFRhsZwKx
RFRb+w/+NYLZO4XLUI7VN/wnXXcJgIYMLbs3Nsy6PlA58JkMxpmQVoY+ZgN4Dop9
BG+Vvz51GgJ8vR+iiaKeeSaIfSEkOYw1Oa4dONco3TS7QwFceC34Y4BVB9v06qg5
y/7LfmH/XuC3lS0QYzkkJimwaM/PkkU5sWVIrab+luyJoPyybtb5mBYUeTzIfP6D
SJyOlTxNJ5uZ7KjrKARqOkKe/SF6pbg/yYWLT/TPX3dqyJBrdcwxp3qrB6rbSIuQ
kw97HDR8nCm0faUd0v44lkJHulWH6BdSHD1Y+mJ2xB8E/CeIHk/JufxIgf+rQU8h
UrBXkzC24T/qTnDuW8rDpkgInuEgybZpEgWRnU76jJ6trLo5MxM5PAiGqAx6rDiG
3kVw4XTEjdaIRiBk6VCTF9cXklY8wuE7kFT/sFH0YhuDQDQMUIAd6ZRqKECAAihR
VjQrvmBDAjCkmOSW5FjnLEwpodZxdp9XqahdfAfDUrmZGRM6V51mtxR9I8sGyeqc
clsDm8WYvADXe+tHiu8NMkf+ELXl005dW5gOYpt8s6L8tfALb76tJt3aDlpmewzY
soqncEABQX7Vk6ZWE86PKtfmjJaLDoUuEWtGEZ6QWckxYLrRDArLPwMV5DGF6gVF
3MQF2Fz5fy/q08fZ24CjtWC+rfzr3z3W685PtPZNSbWq09tWICc=
=merK
-----END PGP SIGNATURE-----

--c6k576IMkHNJkMNq7OhQEpqw3KiRttPD6--

