References: <660664bc-d745-0786-6857-a08b722af6ba@...2181...>
 <20200331071437.12708-1-tom.van.leeuwen@...2499...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <b2a713d1-0c12-e64b-fd28-62e3e359fbe5@...1227...>
Date: Wed, 1 Apr 2020 13:04:26 +0200
MIME-Version: 1.0
In-Reply-To: <20200331071437.12708-1-tom.van.leeuwen@...2499...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9oamYSBWjhpPE7FQFh4TlpQdpyq63C1vc"
Subject: Re: [Openvpn-devel] [PATCH] mbedTLS: Make sure TLS session survives
 move
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tom van Leeuwen <tom.van.leeuwen@...2499...>, openvpn-devel@lists.sourceforge.net
Cc: Tom van Leeuwen <tom.van.leeuwen@...2545...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9oamYSBWjhpPE7FQFh4TlpQdpyq63C1vc
Content-Type: multipart/mixed; boundary="EMwUB6JCMzAxBhlHRj9mO7TWOJQxZGAV0"

--EMwUB6JCMzAxBhlHRj9mO7TWOJQxZGAV0
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 31.03.20 um 09:14 schrieb Tom van Leeuwen:
> From: Tom van Leeuwen <tom.van.leeuwen@...2545...>
>=20
> When a client disconnects from a server compiled with mbedTLS, the server
> cannot process the PUSH_REQUEST from a new connection with the same client
> IP and port number. This is the case when the client binds to a static po=
rt.
>=20
> This behavior is initiated by move_session(), which copies the content of=
 the
> tls_session to a new session and re-initializes the old session once the =
new
> session is authenticated.
> This tls_session contains, among other things, an mbedtls_ssl_config and=
=20
> bio_ctx structure. However, the mbedtls context has internal pointers to =
the
> mbedtls_ssl_config and bio_ctx. When the session is moved, these internal
> pointers point to the reinitialized session and as a result all received
> packets that are stored in the bio_ctx of the moved session can never be =
read
> by the mbedtls session. The PUSH_REQUEST is therefore never seen by the s=
erver.
>=20
> Since there is no public method to update these internal pointers, this
> patch dynamically allocates the mbedtls_ssl_config and bio_ctx and stores
> the pointers to those structures in the tls_session instead.

I have not verified that this fix actually fixes the bug but the
explaination is solid. I however checked the code that handling of ctx
is correct after the patch. Also the problem of moving ctx and having
pointers to the wrong object is present before this patch and the patch
fixes that bug.

Acked-By: Arne Schwabe <arne@...1227...>



--EMwUB6JCMzAxBhlHRj9mO7TWOJQxZGAV0--

--9oamYSBWjhpPE7FQFh4TlpQdpyq63C1vc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl6EdTsACgkQFRhsZwKx
RFTOqA/+JQqqZ7sSIExhqNMtt5LQ941wOObrNPQ5olizf7lV9KywVHU/NdjLzFYt
73kBuwm/bJDOQJw5d0QizE15J9bodw3nXwWf02ZIWrLUflHVkBfJSdoEbiwg3gYG
ezDhLrCqAkLGanwOF1DVmDJ5s0hJh7GqvXlIBCg+sc6rVn4qImlfxI0yESTokTgr
V3WTBGiCoRZi0cODDgjZclntzMB+9PWFkXmn6ETatiCMhqViPSAoPg44bEC6YFvT
1gk2Qv0ht0/PoApzxcXPP4mqaVdGS+n7pyzTUiQ/bJLRKRoQTTJlNHLNSV/g0JOZ
D4IHXfeFa54no2BbvaJUus2vd3ta/WbUYlN5d7Pw+xbKk5fXKEjxWu8QZrlq+wS5
kFTjwjMEcEKxtvosE8zd+gb6BSWHPRvPMTEeLWqjyFTD3n8vH2LmPHapsishIo5g
jHY4PFrZ3exA5II6liBn07d7394e04OZ39tMgqpecsCSwMM1yeq4BKbq2bMUHr3A
1QpbCHdOeeO8uhAJhl3qervh92TZVXnMp/ZfLXCrddF1v3LFclhTYR7TehDcJVtG
t/YWxvBffThGMHnOo8h6UX3ZwEwY8W32Zkb3A/GfN8WWWWN6+lgbS1wH8ycMmdkL
NFTM0CjJ9t16kSahplmfSqgWpGReh0moz6EGC4zm42i+K0P3WmI=
=HWEs
-----END PGP SIGNATURE-----

--9oamYSBWjhpPE7FQFh4TlpQdpyq63C1vc--

