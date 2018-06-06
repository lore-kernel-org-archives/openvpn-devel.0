References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...> <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
 <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
 <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
 <20180605195935.GU57262@...1296...>
 <CAKuzo_jP1F13rw2pdRx9zF0n-7+N29u3d4FE53tL9SrwxMwk9w@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <9a878b99-12ef-47b4-fc85-a16ecc196363@...2181...>
Date: Wed, 6 Jun 2018 19:33:58 +0800
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jP1F13rw2pdRx9zF0n-7+N29u3d4FE53tL9SrwxMwk9w@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SMwmAdAi6LQZ4FswacoQbhGdo5RPlHaIO"
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SMwmAdAi6LQZ4FswacoQbhGdo5RPlHaIO
Content-Type: multipart/mixed; boundary="MNLCM4at89xtON4rkzrZ2TxqMRwGuoL3E";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <9a878b99-12ef-47b4-fc85-a16ecc196363@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...> <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
 <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
 <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
 <20180605195935.GU57262@...1296...>
 <CAKuzo_jP1F13rw2pdRx9zF0n-7+N29u3d4FE53tL9SrwxMwk9w@...278...>
In-Reply-To: <CAKuzo_jP1F13rw2pdRx9zF0n-7+N29u3d4FE53tL9SrwxMwk9w@...278...>

--MNLCM4at89xtON4rkzrZ2TxqMRwGuoL3E
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/06/18 04:30, Selva Nair wrote:
>>> However, even with !ipv4, redirect-gateway ipv6 appears to error out
>>> -- it fails with
>>>
>>> "TEST ROUTES: 0/2 succeeded len=3D1 ret=3D0 a=3D0 u/d=3Dup
>>> Route: Waiting for TUN/TAP interface to come up..."
>>
>> Interesting.  This is route.c, test_routes(), using test_route_helper()
>> -> test_route(), which basically tries to find the adapter index where
>> a given (route)->gateway is configured on.  Since it cannot find anythin=
g,
>> it assumes "tun interface is stuck in DHCP" and is unhappy.
>>
>> This shouldn't actually try to do anything in the first place - it
>> looks at "struct route_list *rl", which should not be populated if
>> we have no v4 address to point the routes to.  (Or maybe it should,
>> but only for "non-tun/tap routes").
>=20
> Yeah, we cant ignore v4 routes completely. So the logic for checking the
> tun is ready has to change?
>=20

I am not sure why you get those 2 routes. Do you have a more extensive
log to show? It may help clearing up some doubts.

On Linux the route_list is empty when there is no v4 and
"gateway-redirect !ipv4" is set.


Cheers,

--=20
Antonio Quartulli


--MNLCM4at89xtON4rkzrZ2TxqMRwGuoL3E--

--SMwmAdAi6LQZ4FswacoQbhGdo5RPlHaIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsXxqYACgkQB6U8WA7y
zXQ3PRAAiwhE656BFrQqEWCu/x2tHtJzsG0GsTOZO4FIcg6hk3UEAT0pVoVEtdr8
TVe1WL3y6iRBcy6XNSH71vnaihP0LABOKqg7bNjlcfb5sWwPqYpv8BzI6p3J3OUm
QqWTTV6cuX+HzoNssrfb7J0ts35N/76y+wRw70oxP+uI3DHd3OvD5FMV7cb3mgCF
wzGxzFCQLyBPf0SB9P3ITab3RuAxCEjPBVUVkVEjanZFz0rXtSNAIGlwAlQjmQR1
Fb3j1y2vdC654RLS99VbcbIgbEiNn6Kz/4zZeCLdS47OxQFnxZMdLJv4Tu0oSkHE
AGMdQU8zI7VN3ZIBfN1KNhOfjq2Xw+2A9qxqCOQPilF5w85q/tpT0F3IvL0zQ6AG
1xhWmpqCH9qGmBy0W7jZDMahwv4/qxeBtgAAcZNwCb9eODmkLEL5+ndEOblq6915
liizoeq3KjoVgyPas89hYrgQ8YtLWy9l54rn1TAkHzkAovZi00vJgnaWvgQD5sf3
N2+4j0AnYGkkCQp0HXv+l7fBx9LZZhVPn/XxcbtEoJmroAE5y5983dNZ2bVw5RaD
U8oOLH9QyZWlVIhNUCAtMm7oBOwyzivIq47zkwy7tZrakkyd8JASfCxNzngTDPt4
zkYT6ilqgfubotPm0s7o5Rd9+SXGNTlZH8hT3b77rOleZo5df2Y=
=PjLd
-----END PGP SIGNATURE-----

--SMwmAdAi6LQZ4FswacoQbhGdo5RPlHaIO--

