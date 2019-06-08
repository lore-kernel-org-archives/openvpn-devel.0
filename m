References: <6dc68129-a70d-2283-9ab7-b7621e6871b2@...68...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <3b604c5e-1421-4286-0a54-2875e0ec1645@...1227...>
Date: Sat, 8 Jun 2019 14:57:27 +0200
MIME-Version: 1.0
In-Reply-To: <6dc68129-a70d-2283-9ab7-b7621e6871b2@...68...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hVUG5kZ1rJKWvdzJKDKj85y2dbFZLwZHE"
Subject: Re: [Openvpn-devel] RFC: release/2.4 (OpenVPN 2.4.7) patch for
 building with LibreSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net
Cc: Luca Pizzamiglio <pizzamig@...1249...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hVUG5kZ1rJKWvdzJKDKj85y2dbFZLwZHE
Content-Type: multipart/mixed; boundary="3qdPzCtiiX4E5ptQ3m8GKe3UvHTBh4PZq";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Matthias Andree <matthias.andree@...68...>,
 openvpn-devel@lists.sourceforge.net
Cc: Luca Pizzamiglio <pizzamig@...1249...>
Message-ID: <3b604c5e-1421-4286-0a54-2875e0ec1645@...1227...>
Subject: Re: [Openvpn-devel] RFC: release/2.4 (OpenVPN 2.4.7) patch for
 building with LibreSSL
References: <6dc68129-a70d-2283-9ab7-b7621e6871b2@...68...>
In-Reply-To: <6dc68129-a70d-2283-9ab7-b7621e6871b2@...68...>

--3qdPzCtiiX4E5ptQ3m8GKe3UvHTBh4PZq
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 07.06.19 um 20:26 schrieb Matthias Andree:
> Greetings,
>=20
> FreeBSD has received a patch contribution to enable OpenVPN 2.4.x to be
> built with LibreSSL. I'm seeking comments, and yes I am aware of
> master's a47508606be2c6359d4b27c3b65b72dfe4786222 commit description
> that claims LibreSSL isn't in the best shape for TLS 1.3.
>=20

I think got/merged already a similar patch to master. So this patch
might be just a backport of it?

Arne


--3qdPzCtiiX4E5ptQ3m8GKe3UvHTBh4PZq--

--hVUG5kZ1rJKWvdzJKDKj85y2dbFZLwZHE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlz7sNsACgkQFRhsZwKx
RFSd1xAAhw34zlfAUEMkrg8z1QccTDorbKlB7pfUFCgHMggoHOEtkZ4/Qx1wBgjo
WWxstaTHtK20AOc1c3pqg7PW37BXvznTg+lM+6vfQLUU0sF3/3d4wAFWLS/YYCmo
S0bTw3YhUtDUpqz13BIOKhS5MtNKWiXKv7udWtFpXU5XMU+4DrSjnQcuqG+Ps8VF
8toznbJQtAvBneQ7q80T06FlUsAUmhXAAKoZIp5nfF6BFDVni6DH8GGxpSkn0uhG
Y3tVr9x8AVyDnwmx1DK66UYIuBuxaApWEM8PpsSPJgnoPWT+GbtL5qA0Y1yElEtb
KZkVe+2fKOTHgilFd3ojZYn+LR3l5oy8erEtP85pTZoP9E9OPhUr7aRuzmS6uswW
WURoVeVvcqgttiraopMgky6lQeDxqGWEsCMjABGcLf32JrYyy8xyu5Md5DhHlrmM
bYx2U9CuDgJ9t6f/q2J4HMLKMEsPU9Fg8JcyYvZ8JSZ7u2Gr0+XnVAKL2JyI/Ux1
dKk4dEqanWalFIY0WjCHfdxAwhs7HAH+trp0/HQW/8SNHTdwDiA/LgWckUlvAdph
ryXaqFa2vmTaU5aBQUhZHUAIj2VLItL38SG0n29RQbZOU5NWn87Uf3DC5Z2qwcCs
+YdQwTsW4t53dw/6qeborbTyeWfwBnmRdAxmohnVgQ3G+XOJzwY=
=5nek
-----END PGP SIGNATURE-----

--hVUG5kZ1rJKWvdzJKDKj85y2dbFZLwZHE--

