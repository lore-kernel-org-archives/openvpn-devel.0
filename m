References: <7f72b2de-f411-c4a0-bd1e-f343543cb8e2@...2030...>
 <CAAjorqWaFY+XdD5XZ95rPyXJHd9MfPv3Xmv3M1gKfWHbnJXL9w@...278...>
 <6ad04520-6e42-51aa-bd38-b2285e7adaab@...2030...>
 <a1174daaa1e8e1c6af98add253dfc1ac.squirrel@...2257...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <b84a05c0-30cc-3e21-4470-4ec19de36cde@...2181...>
Date: Fri, 5 Jan 2018 15:42:22 +0800
MIME-Version: 1.0
In-Reply-To: <a1174daaa1e8e1c6af98add253dfc1ac.squirrel@...2257...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uH2X9NOey9yrJ4hyQne0kHhBA4XN5UzNS"
Subject: Re: [Openvpn-devel] OVPN vs IPSec performance as a transport
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>, Tom Kunz <tkunz@...2030...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uH2X9NOey9yrJ4hyQne0kHhBA4XN5UzNS
Content-Type: multipart/mixed; boundary="eKs1fdiy063Zc2UiWj4sEwNGZrqHKtyHm";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Simon Matter <simon.matter@...2249...>,
 Tom Kunz <tkunz@...2030...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <b84a05c0-30cc-3e21-4470-4ec19de36cde@...2181...>
Subject: Re: [Openvpn-devel] OVPN vs IPSec performance as a transport
References: <7f72b2de-f411-c4a0-bd1e-f343543cb8e2@...2030...>
 <CAAjorqWaFY+XdD5XZ95rPyXJHd9MfPv3Xmv3M1gKfWHbnJXL9w@...278...>
 <6ad04520-6e42-51aa-bd38-b2285e7adaab@...2030...>
 <a1174daaa1e8e1c6af98add253dfc1ac.squirrel@...2257...>
In-Reply-To: <a1174daaa1e8e1c6af98add253dfc1ac.squirrel@...2257...>

--eKs1fdiy063Zc2UiWj4sEwNGZrqHKtyHm
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 05/01/18 15:06, Simon Matter wrote:
> Hi,
>=20
>> That would explain it if it always worked that way.
>> But I can get 400%+ wire speed from A to B with compressible data, and
>> 102% with incompressible data.=C2=A0 If I do the same test from B to A o=
r A
>> to B, I get those results.=C2=A0 If I hop off of that to C, speed goes f=
rom
>>> 1Gbps to sub-200Mbps.=C2=A0 In either case, the data has left the kernel
>> space to arrive at "nc", so just simply saying "it's kernel vs user"
>> doesn't answer it.
>=20
> So if I understand correctly you are able to get wire speed over the
> OpenVPN link as long as you don't route traffic further via an other
> simple router?
>=20
> Maybe you could try those two things:
> 1) Disable all LZO compression just to make sure it has nothing to do with
> it.
>=20
> 2) Run tcpdump/wireshark on B and look in detail how data is moved over
> the different tun and ethernet devices. I'm sure you should see something
> there at least if you compare it with a run made without OpenVPN.

I agree on this point. If the slowdown comes from here, you should
definitely see something.

>=20
> BTW, you don't have any iptables rules on any of the boxes, do you?
>=20

Good point: iptables/ebtables can kill performances quite fast.
Are doing pure routing between the VPN tunnel and the Ethernet
interface? Or there is some NAT involved?

Cheers,


--=20
Antonio Quartulli


--eKs1fdiy063Zc2UiWj4sEwNGZrqHKtyHm--

--uH2X9NOey9yrJ4hyQne0kHhBA4XN5UzNS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlpPLF4ACgkQB6U8WA7y
zXT0HxAAjLOokKtdJ+Z//MpBKbkKUHBurfauo1L37OeEOSWEeqM1YsYBVjwSe51P
YDIZgszr0W7cwll9ThibYG7sUWiEo5d4esn7crGmDA3j/XzbCKNANaaq9txkYPnV
SeA3NNAHNkPOVUYcds+o+2/6ex823d0VKJ+zwg2gLCNu5cIucbnZqX8sY/B7lmUH
zb1Eiswfm0IozN01Qb8haWDjr1ApBBaPHdRBg52UcgnQB0jeaHfL5qrR2T3l4kgX
JAtY9BmAvfzQb+tryrQk8iy4eFKkIEKCUKoaWfOp5hX0xF+EyA+Epgh2HfVJupSY
YpjRjZrPxxc9RkAkfxKku/4mbl2BctGGTPrOHYA3QN1Yz1cnujPux3JUAf/8OqoU
FC7U4Rt2IZT15f0HeswHesk+A3CwYZ3Ut5zy0WBb3h5dU8NEdtQJTxCLnLBwdgyJ
95JPrEYLAJ3lER1cfu4H+SxwbLSE5L6ZIxfdUxp9KrLqea1EnenpdM8uF3uuWpAl
JybAKKZRXrfNNLgZmvZ7fr7RGCLeE7fI+qr7/gXkjNwgneFbAyy3YEJJNEWW79FZ
WjHFY9kPGzypgNCLnd4DWFjiMkLfHU0dOCJZXOkuJjQezyAP2Qu4fF16Zwz202RL
eM8KIJcuJ7bT/lT5mHc7Q7FLPHdUmDNRGeCmYtKKmwQDWVrvhlQ=
=Z76C
-----END PGP SIGNATURE-----

--uH2X9NOey9yrJ4hyQne0kHhBA4XN5UzNS--

