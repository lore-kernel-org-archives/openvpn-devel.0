References: <de9db75e-98de-6a56-6f3c-6ba66f475cca@...1227...>
 <20200826165128.23117-1-themiron@...2010...>
 <e170069f-a0da-0f86-fb05-ec900e799f52@...1227...>
 <027b01d6869f$2ce27910$86a76b30$@yandex-team.ru>
From: Arne Schwabe <arne@...1227...>
Message-ID: <60d933c1-5238-1d0f-91e5-b94570180531@...1227...>
Date: Wed, 9 Sep 2020 14:15:16 +0200
MIME-Version: 1.0
In-Reply-To: <027b01d6869f$2ce27910$86a76b30$@yandex-team.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wDot3jCR2BGppEkGpC2IZDkqsTLXhpUQj"
Subject: Re: [Openvpn-devel] [PATCH v2] Add DNS SRV host discovery support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladislav Grishenko <themiron@...2010...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wDot3jCR2BGppEkGpC2IZDkqsTLXhpUQj
Content-Type: multipart/mixed; boundary="x461a4IU20zzfL28ejvrToJEHEVXXewEk"

--x461a4IU20zzfL28ejvrToJEHEVXXewEk
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> I see your point, thank you.
> Fallback is done just to conform RFC 2782 suggestion, personally I feel i=
t's hardly be used with controllable client profiles when it's known that d=
omain.tld does dns srv.

Yes. And see the point in that RFC. I would rather document that for out
fallback the user has to manually specify that because I don't see a
good "works for all" fallback.

> Additional --remote-srv indeed has benefits:
> * opens a non-conflicting syntax way to have multiple udp/tcp dns srv req=
uests, as you wrote in earlier mails. This will allow to sort them all by p=
rio/weight.
> * cleaner syntax for specifying custom dns srv service name, with default=
 "openvpn" and protocol (if need to limit discovery to only udp or tcp)
> So, in my mind syntax looks like:
> 	--remote-srv [service] [protocol], where both args are optional, by defa=
ult service=3D=3Dopenvpn, protocol=3D=3Dany

Sounds good to me!

> And, important thing, multiple --remote-srv still needs to be supported f=
or:
> * custom order of protocol
> * different service names
> * allow to reuse --remote-random with --random-srv as well to achieve dns=
-srv-based lb
>=20
> Is it good enough in this form?

I don't really see the need for that but it doesn't break the normal
case of just one remote-srv, so fine with me.

Arne



--x461a4IU20zzfL28ejvrToJEHEVXXewEk--

--wDot3jCR2BGppEkGpC2IZDkqsTLXhpUQj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9Yx1QACgkQFRhsZwKx
RFQ5qg/+OyOAa0J4oUYbt5tBvkYNeMYtloO0yDT8TqcwYFL+PuLsTCQ6JwTO+LTG
4yS8ubf7Pk1O+IVUay0rAoETk308hg1DYMI418WDMWEYXwC92MhO74YGM/zeWNJZ
1CZMdpvt7wFaPheURGVHcZ7x7dJPaOE0x0lVMJK+1z01L5dfG3WYKWuMmIkGCCtJ
lpk4U7Aq84W+l3HrywTGmIu7awAXNRBtFTDcVpxoLiDFdni+Bgcw0sF6SsbOAhHU
rKjU0XIXUbDDr7HHCKwlMd1W4BYAPTMEEirkpMdoYngBtMRkv5h7DhVAB7YJtMWn
EN7ziaa8qxN5fTgDvzmgiTOJGrBvbZU84exCusY4nKekblk7pwS5ziZe8SMLXAxl
tFbK1SpdILxTHNV7qlQ7/HVepa3ktSSiDW9wQBop1ZICgTuyQDDslIIucUwwKsuN
CZiM+E9AvfJRBvnoVrZDQU74gYX00X/2lM9yxvCBxGnZU75SjBHbrpzotyC/33ys
uT7YqyJFpvpKZ0CLgRik6YSBdE+l0wbuCUVL3ATUkVNkVj028eDOFiG2sgGlLGVb
wfI2e/PqZeT8uzAxUwXtHZ8o8x3cu22hOhtAQYm+EeP7kMeySM6to4SQmcs927/m
WDouBMeKvbbcM/RGQvSriSZLlDxERPyEc+x0kqNWWgShBS3ZB60=
=SKdm
-----END PGP SIGNATURE-----

--wDot3jCR2BGppEkGpC2IZDkqsTLXhpUQj--

