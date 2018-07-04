References: <20180703144755.6794-1-arne@...1227...>
 <20180703153319.GO989@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <1642332a-2977-6da9-aa77-1cc897464f10@...2181...>
Date: Wed, 4 Jul 2018 11:46:42 +0800
MIME-Version: 1.0
In-Reply-To: <20180703153319.GO989@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YQqHLbUVkyJVyLtfaXnf4NRiWzB3fCGhl"
Subject: Re: [Openvpn-devel] [PATCH] Implement parsing and sending INFO and
 INFO_PRE control messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YQqHLbUVkyJVyLtfaXnf4NRiWzB3fCGhl
Content-Type: multipart/mixed; boundary="lyEYRCRUgIsDSCxG5kwsxwb69W5ppCnvW";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <1642332a-2977-6da9-aa77-1cc897464f10@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Implement parsing and sending INFO and
 INFO_PRE control messages
References: <20180703144755.6794-1-arne@...1227...>
 <20180703153319.GO989@...1296...>
In-Reply-To: <20180703153319.GO989@...1296...>

--lyEYRCRUgIsDSCxG5kwsxwb69W5ppCnvW
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 03/07/18 23:33, Gert Doering wrote:
> Hi,
>=20
> On Tue, Jul 03, 2018 at 04:47:55PM +0200, Arne Schwabe wrote:
>> OpenVPN 3 implements these messages to send information during the
>> authentication to the UI, implement these message also in OpenVPN 2.x
>=20
> Feature-Questionmark :-)
>=20
> Is there any documentation about this?  What sort of messages are sent,
> by which product?  What do you do with it?
>=20
> Can we maybe have some documentation in management-notes.txt?

And even at a higher level: what is the actual use case for this?
Porting more features "just because they are supported in openvpn3" does
not really sound like a reason to maintain more code on the community
side, imho.

Cheers,



--=20
Antonio Quartulli


--lyEYRCRUgIsDSCxG5kwsxwb69W5ppCnvW--

--YQqHLbUVkyJVyLtfaXnf4NRiWzB3fCGhl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAls8QyMACgkQB6U8WA7y
zXQK7xAAhj8cup5ydMGCCy4PVmur1ARji+ApZ+hbVHOkcp9fHnwFBxmGLA9yAKMO
HWyTZZC16L2haiRaWiUCTzDEynHIvXsP0O8ZX35JLEaByHFXQinFnIwpF/wkszDC
7p+ie+vtymejZu8tUmDSYZ1Dg1UcqQ7Mfhz2FSREv6yvHio2KYQzWXAGDpGGM6+Z
MJRPwhZiKFdIbTA6CVWfe/1as+sob3sOf075fr7yKII+cGeyNP7iNn5X9Gw5n4sO
wWrXBmx5PDvL6FvigR01m0ic708/rZ9qiGIRxuK6RuLf2a1ysLO1GxMlAIKz+6dr
w8bESXWfguGXjYhn1OdwyHFX9CinE3PCiGowlxDflgCKLM5ndzeh0oZn/+04Yg24
2raOcmqQHxK9qcDhnd4plUFxERHCMEqyEhWt15NW1pL6/ROwKc9bLp0t39Q+nHnZ
OFcZjIJQWX93zgaotYeEbUhPuXQr+LZkvJSljMsjvPnWbjEKMJ4OXH9Fv92qxQv/
Z93XV8OkdCeZ+IwOGLLyfDPkQDc6UDEKj8fZv6E/0gVf3JVkeFo8PTFc3wjGpLQi
4RiKzWVG0JtrSZV6DU6PvKO4dSz4vORJbLJlvbzSEmC0Lw5ccopmpBS8OXEoxFCb
NAzTFmc5HhnUupPcnq4UbUrqBaXUHNx3WSdJeVexthui4EsJhgg=
=vZqn
-----END PGP SIGNATURE-----

--YQqHLbUVkyJVyLtfaXnf4NRiWzB3fCGhl--

