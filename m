References: <20191109151306.18597-1-arne@...1227...>
 <20191109151306.18597-3-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <56eb987f-9dc8-1579-fee9-9273e39cb0ce@...2080...>
Date: Fri, 27 Mar 2020 22:06:16 +0100
MIME-Version: 1.0
In-Reply-To: <20191109151306.18597-3-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="rziWdlbwTesa8eR8ce3KAMFfGJioDvbtS"
Subject: Re: [Openvpn-devel] [PATCH v2 3/5] Implement sending response to
 challenge via CR_RESPONSE
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rziWdlbwTesa8eR8ce3KAMFfGJioDvbtS
Content-Type: multipart/mixed; boundary="aivhzIOwbp7wdYT70fMYirdvOh8Gal2jm";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <56eb987f-9dc8-1579-fee9-9273e39cb0ce@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/5] Implement sending response to
 challenge via CR_RESPONSE
References: <20191109151306.18597-1-arne@...1227...>
 <20191109151306.18597-3-arne@...1227...>
In-Reply-To: <20191109151306.18597-3-arne@...1227...>

--aivhzIOwbp7wdYT70fMYirdvOh8Gal2jm
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 09/11/2019 16:13, Arne Schwabe wrote:
> When a client announces its support to support text based
> challenge/response via IV_SOO=3Dcr_text,the client needs to also

Typo.  IV_SOO -> IV_SSO

> be able to reply to that response.
>=20
> This adds the "cr-response" management function to be able to
> do this. The answer should be base64 encoded.

Could we have some kind of test/sample script demonstrating this feature?  =
It
would also help test that this feature works and also useful for regression
testing later on.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--aivhzIOwbp7wdYT70fMYirdvOh8Gal2jm--

--rziWdlbwTesa8eR8ce3KAMFfGJioDvbtS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJefmrIAAoJEIbPlEyWcf3yOtAQALzxebPN3fOs4F/oggElRrRw
/Nsl8KxrYkQ9QSbr5AAfip+zA5j+yX4teed8OI+7KCZi290HPWdtL0/2nxZlEDuw
3J/H3ArkNrgK6cptSHooyANJenqhm346QuFP3uICQzBLxjuNVhPeq2rpBMMZTWkX
cU/KaKScadafyFzEIErt4p6DsKcj0m9af2KdStoU+oSlyIHB2adWSnv0QfXVcrJb
rmC1Iam6FJJmlMpfcpFO9oQag+5PzIpY81U4MT0eJo1w1PYlbCLMMoCJZ/mNyGqf
V5g4KaZ9G7xFk79pYd+u5sgxfbuHv1/G5m0lwkh5SUxjfdw4avvVdGDbE/X0K2N+
CoVQm166GXJbqXlMSUWPbdu4/wO2e2sLkWI2QDAImfeBQpUJ5+DV3aRMd4zF7evh
A6O5NEK7FLL8KCqnTGI8rj/KatSAZ3fkbDYfey1H9ePckdiSNXXPEWq1XoWQwczS
GSeZ/QveP2nSnzf71beHzo8wcG82A1Zb7ixT6r1NpLV8+vVBH3XsIUhrx+NI2AbF
zSraRK91ADC5ILWNLo4OQG40cB7b3pvjMWm1FntgKatOTvDLsbgKUt4z114xpFkR
Tfco1xMs5t1UQZOTchQYUiGchfPXHQ+v/R5cEnKIhxB+RGQHrez4HRzhu/ROhGg6
v4aJjMUi6gfVO7P0nRX7
=+6Ry
-----END PGP SIGNATURE-----

--rziWdlbwTesa8eR8ce3KAMFfGJioDvbtS--

