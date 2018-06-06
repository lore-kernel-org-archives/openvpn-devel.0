References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...> <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
 <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
 <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
 <20180605195935.GU57262@...1296...>
 <CAKuzo_jP1F13rw2pdRx9zF0n-7+N29u3d4FE53tL9SrwxMwk9w@...278...>
 <9a878b99-12ef-47b4-fc85-a16ecc196363@...2181...>
 <CAKuzo_hU64ML71iL7Xdt5_k08QLXwDytXd1W2TVze=7SUhLLSQ@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <46042b3b-ff87-903a-315e-dd6d577a8a39@...2181...>
Date: Thu, 7 Jun 2018 00:02:44 +0800
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hU64ML71iL7Xdt5_k08QLXwDytXd1W2TVze=7SUhLLSQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Tg4UzAZ8AZxRXnqdSrVEFzZvhWoD8ANNv"
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
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Tg4UzAZ8AZxRXnqdSrVEFzZvhWoD8ANNv
Content-Type: multipart/mixed; boundary="edRshwO7h0usWnBNh2a28e6AEmf4IOHJy";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <46042b3b-ff87-903a-315e-dd6d577a8a39@...2181...>
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
 <9a878b99-12ef-47b4-fc85-a16ecc196363@...2181...>
 <CAKuzo_hU64ML71iL7Xdt5_k08QLXwDytXd1W2TVze=7SUhLLSQ@...278...>
In-Reply-To: <CAKuzo_hU64ML71iL7Xdt5_k08QLXwDytXd1W2TVze=7SUhLLSQ@...278...>

--edRshwO7h0usWnBNh2a28e6AEmf4IOHJy
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/06/18 23:40, Selva Nair wrote:
>> I am not sure why you get those 2 routes. Do you have a more extensive
>> log to show? It may help clearing up some doubts.
>=20
> Don't have access to those logs right now -- will post later.
>=20
> I had looked into it further and noticed that there was one other v4
> route being pushed from the server. On taking that out the error still
> persisted but with "TEST ROUTES: 0/1...".
>=20
> That one remaining route was from redirect-gateway: even with
> "redirect-gateway !ipv4", the direct v4 route to the server is being
> set (redundant but shouldn't hurt). That route did succeed but our
> logic for testing routes involves waiting for the interface to come up
> with a v4 address which needs some tweaking.
>=20
> On Windows, v4-only works as long as a ifconfig address is in the
> config (or pushed) as the address/mask is required for the tap driver.
> Adding some v6 routes doesn't break it (I think) although those routes
> may fail with warnings if there is no v6 address. I would like to see
> v6-only work with minimal caveats as well. So, some
> suggestions/comments for Windows:
>=20
> - Require either a v4 or a v6 address must be specified (this is not
> essential for v6-only tunnels but makes the logic easier)
>=20

The check you already suggested to modify in open_tun() should do the
trick, no?
Apparently that should be enough to ensure that at least of address
family was configured (but I haven't tested on windows yet).

> - The tap ioctl appears to work with 0/0 as address/mask, so no
> special treatment needed there --- (improve the logging in this case).
> This may need more testing
>=20

ok

> - Wait for the interface to come up only if a v4 address is specified
> (this wait is needed as the address may be set asynchronously by dhcp,
> unlike other platforms)
>=20

ok

> - Skip the above wait if there is no v4 address. As v6 address is set
> synchronously no wait needed -- or change the logic used for deciding
> whether the interface is up or not
>=20

ok

> - Make sure v4 routes do not break a v6-only connection -- either
> filter out and warn about v4 routes via the tun interface or just let
> them fail with a warning but proceed with the rest of the tasks.
> Setting v4 routes via other adapters should work
>=20

Do you think it makes sense to install other v4 routes (i.e. routes
using the LAN gateway as next-hop) even though we have no IPv4 on tun?
It feels like they would be totally unrelated.
Gert? what do you think?

> - Redirect-gateway with no v4 address: mutate to !ipv4 and also omit
> the bypass route to the server. Or leaving that route in could be an
> easier option and should work once the logic for checking the adpater
> mentioned above is fixed
>=20

Yeah, this is actually happening also on linux, but it's applied
externally to the route list. This is why I hadn't seen it before.
I have a fix that prevents setting that route in the pipe.

> - Test block-outside-dns (just to be sure as failure there is FATAL).
>=20

oh, thanks for this.

>>
>> On Linux the route_list is empty when there is no v4 and
>> "gateway-redirect !ipv4" is set.
>=20
> Some how on Windows the bypass route gets set even with !ipv4. But
> as said above that and any other non-tap routes should just work.
>=20

this relates to the comments above.


Thanks!


Cheers,


--=20
Antonio Quartulli


--edRshwO7h0usWnBNh2a28e6AEmf4IOHJy--

--Tg4UzAZ8AZxRXnqdSrVEFzZvhWoD8ANNv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsYBaQACgkQB6U8WA7y
zXQRmA//cJPP1Ve2EZFGDeneCvikb/Acyx0MA8d046zrIs8foeNR9SvgkRafTCZJ
rrGP1Ayr0gxDN5wL7/VgQ+pXzOSPKjfssNf5iooKNoUqb41zdLXMJzr0J+hy0O2h
zeXW/K8N/ZpIOWkBecrBJmbPb3cQ3gv8Kw5vvnBXpEbaRHbYjqoB1wjTBZjRgGGA
dfSzE1bqWzrPC4gdVGMY7USCXEuvW0hX4NGDzpzxN/7X/8MI/SKbASnAUlbJuz6z
c5ImqLrxoRXrlux+grFzSzvO4Zpb5j9jxnuhLGIkJqkf4m8cJLSPxa2RVfa75nia
7zHtvDjAxdt7cE0rebmHJU8THAUqfYfc4Dt4b6C5citEQtj8aUFyBWTYy8dNn8Mi
zPglJccnxLNb2A/oMXzDRxlgV2r+srHKR2ztle1bGGqkpmIGseDuq8X/VZ4n9hmy
B2PtyzScAbGb3PPyydtJuu7nEl4w49EZk++iSgRc0tN9ImTTsTnSreO6OdNImAPT
rEmnqyfCq8IE+fMecqU6NH9mztTxQvvDPPrA0jklNySYiZrl2LvUkljFF5R7AK+l
5WxcY6cgL43ac6O21Wpap6ZOW2KYE5K3bBS/R51aVb/nTh+UkbW5oAhz4Fe90VdH
hRP2LMN2WpIFy4CFreQnGqouJY9kRkCnAPsDmKUxo2E3SDoy4l8=
=07VU
-----END PGP SIGNATURE-----

--Tg4UzAZ8AZxRXnqdSrVEFzZvhWoD8ANNv--

