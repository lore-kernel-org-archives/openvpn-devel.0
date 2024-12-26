Date: Thu, 26 Dec 2024 14:13:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Z21WewOcAbuPu71M@...1296...>
References: <7e42399c-3a94-40a2-bcaa-15545c3b761c@...68...>
 <6a00da72-dc11-409e-9d47-4694e1d6f02f@...68...>
 <a986633d-69d7-4bd1-b288-2f0de53b106e@...2181...>
 <86c60a4f-685e-4157-ad10-6de03bb2eef0@...68...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="VoFtRuoHDufuHeNo"
Content-Disposition: inline
In-Reply-To: <86c60a4f-685e-4157-ad10-6de03bb2eef0@...68...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] port-share: Add proxy protocol
 v2 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: corubba <corubba@...68...>
Cc: openvpn-devel@lists.sourceforge.net

--VoFtRuoHDufuHeNo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 16, 2024 at 01:22:51PM +0100, corubba via Openvpn-devel wrote:
> In addition to the custom journal solution, also support the widely
> used binary PROXY protocol version 2 to convey the original client
> connection parameters to the proxy receiver. This makes the port-share
> journal feature more accessable and easier to use, because one doesn't
> need a custom integration.
>=20
> While this is a spec-compliant sender implementation of the PROXY
> protocol, it does not implement it in full. Version 1 was left out
> entirely, in favour of the superior and easier-to-implement version 2.
> The implementation was also kept minimal with regards to what OpenVPN
> supports/requires: Local commands, unix sockets, UDP and TLVs are not
> implemented.

Are there any reference URLs for the PROXY protocol?  If yes, I think it
would be good to include a reference into one of the comments - the next
person to read that code would then know which document this is based on.

Besides this, I'm not sure what to do with these

> +            ASSERT(4 >=3D sizeof(src.addr.in4.sin_addr));
> +            ASSERT(4 >=3D sizeof(dst.addr.in4.sin_addr));
> +            memcpy(&header[16], &src.addr.in4.sin_addr, sizeof(src.addr.=
in4.sin_addr));
> +            memcpy(&header[20], &dst.addr.in4.sin_addr, sizeof(dst.addr.=
in4.sin_addr));

... this is all obviously correct, but it feels heavy handed, and many
lines of code...  (especially 2x sizeof on the same structure element)

I think we can fairly safely assume that an in4.sin_addr will always be
4 bytes, an in4.sin_port will always be 2 bytes, and an IPv6 address will
always be 16 bytes...  so I wonder if it wouln't be easier to just copy
a well-known number of bytes (openvpn_sockaddr is also "always bigger
than that", so no read overrun) here.

I know that "magic numbers" in code are considered a bad pattern, but
these things are really constant length, and the buffer layout *requires*
"exactly 4" and "exactly 2" bytes...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--VoFtRuoHDufuHeNo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJnbVZ7AAoJEB2Cnv7KVigSdVUL/ROgnWFIvKeu+YfSSKhWCaVf
P1OYKLVSHqaLgo2KsSv3Vx9wWHEYUFVuPDqf6jv9wOh0LtByxTd+odwDvlqvPv8k
3WKdT1CJYxdZHOHgEzcgnANx9OBsPvCHhyuJBgQYWXQlCUahId/gL0sQljhWoyfT
5T0bMlGrlPzm+HaGc0QxDZdcxnjN2gsVWGgtOpQ+cbEjlw+WUneYbLiq2j2Crmf9
uPLxX8aBwOtK6EA++SRDSCGhGGTKmY5iymcKagxNgYIdDtxmrb7xQeaL4C/cylKf
1WeHATq5qFngTKBtzMNt6cJzD+4D7mswOGrBFIaWcVx4/43SrPgEDOGAMMblBCcY
v3xRdLxlUVre+YSMZUtpDbwqhj1nfxDc1WaY0YXhi3tyd5zLsFSstZRgbq2U7r3/
hSYF2MT0nMQK+lahqIt9TDcqKqaipV2/hWUH34LBSszxoQHhnWmBEYzYHlO1gr7U
Q7qFRmTxEg8issXVnXzQL2tXX6Wbqozhwi+gq4X3aw==
=mFzZ
-----END PGP SIGNATURE-----

--VoFtRuoHDufuHeNo--

