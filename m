Date: Sat, 21 Jan 2023 16:52:25 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y8wKOa6GK0YSCwko@...1296...>
References: <20230116194809.1980444-1-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="w6PIDHtck+z9FHp7"
Content-Disposition: inline
In-Reply-To: <20230116194809.1980444-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Fix more "existing route may get
 deleted" cases
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--w6PIDHtck+z9FHp7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 16, 2023 at 02:48:09PM -0500, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> - Set RL_DID_LOCAL only if the corresponding route addition
>   succeeds. This is needed to preserve when the direct route to
>   the vpn server preexists.

While I think this is a good thing, the existing implementation does
not look good - changing add_route() to return RTA_* sounds logical,
and makes "return something meaningful from add_route3()" very easy,
but the "check windows route installation success?" code paths relies
on code like this...

            ret =3D add_route(r, tt, flags, &rl->rgi, es, ctx) && ret;

this still *works* with an "int" return, because RTA_ERROR is 0, and
the "not flagged as error" codes are 1 and 2 - but I'm not sure if that
was intentional or luck, and it makes reading the code harder.

So maybe postpone *this* part of the patch to 2.7 to give us a bit
more time to think about how the return code/logic should look like?


> - Ensure net_route_v4/v6_add/del() functions using iproute2 return
>   error when route addition fails. Return value follows the same logic
>   as corresponding functions using netlink though all failure reasons
>   get the same error code of -1.

This one is very straightforward, easily testable in itself, and could
go in right away.

I tested this as part of "testing this whole patch" on a linux/iproute2
build, triggering errors with invalid and double routes.

Without patch (2 duplicates, 1 invalid):

2023-01-21 16:50:05 /bin/ip route del 10.194.0.0/16
2023-01-21 16:50:05 /bin/ip route del 10.195.0.0/24
RTNETLINK answers: No such process
2023-01-21 16:50:05 ERROR: Linux route delete command failed: external prog=
ram exited with error status: 2
2023-01-21 16:50:05 /bin/ip route del 10.194.0.0/16
RTNETLINK answers: No such process
2023-01-21 16:50:05 ERROR: Linux route delete command failed: external prog=
ram exited with error status: 2
2023-01-21 16:50:05 /bin/ip route del 10.194.2.1/32
2023-01-21 16:50:05 delete_route_ipv6(fd00:abcd:194::/48)
2023-01-21 16:50:05 /bin/ip -6 route del fd00:abcd:194::/48 dev tun2
2023-01-21 16:50:05 delete_route_ipv6(fd00:abcd:194::/48)
2023-01-21 16:50:05 /bin/ip -6 route del fd00:abcd:194::/48 dev tun2
RTNETLINK answers: No such process
2023-01-21 16:50:05 ERROR: Linux route -6 del command failed: external prog=
ram exited with error status: 2

With patch, same call =3D=3D same set of "input routes"

^C2023-01-21 16:51:24 event_wait : Interrupted system call (fd=3D-1,code=3D=
4)
2023-01-21 16:51:24 /bin/ip route del 10.194.0.0/16
2023-01-21 16:51:24 /bin/ip route del 10.194.2.1/32
2023-01-21 16:51:24 delete_route_ipv6(fd00:abcd:194::/48)
2023-01-21 16:51:24 /bin/ip -6 route del fd00:abcd:194::/48 dev tun2
2023-01-21 16:51:24 Closing TUN/TAP interface

-> confirmed!

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--w6PIDHtck+z9FHp7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjzAo5AAoJEB2Cnv7KVigS138MALHVoutTRTLCYGq5kNN5Ws+b
eGbrkjFAy6oeLQCu2qhWoCH75pjdhSKveAuq2qkjumPS33b+3CUpvoqKNnljXk90
H/TEXIaWNmlLKHSjbMCG4nFjXqd6DlL1nDqHif0Rhqu7Gb6mZRYBJaCT6lVom4w7
KvZjTI9ftyuOZ8nMsbmtbwiSFaRzUv64tmKqEM4INyssGpVo1kda2RlN3bEmcmRT
ZVg/95J3U8i7WWg2ud4IuwlT4oI1wfoQatHKbtHIhOyK+VpTnHUQ9moWgKZCylLX
Fa8d4/jz8fENZtXZeurF3CATGPYwIVxzGOYlqMV+7xnFAy/fI1xDfSLVqYOu4ihB
zFTPZBfHEX66Kw8lhNiQtusTBMzhC4riuRX9TqT2cX4kl3B0GelqOzcFW0NTKXMt
yJawz5DJgT2QQsGGu+XTgh+VmCgwZ6n8znMY1ng6LUwY+y8JWrePR1n+nsuHZQM2
nVS4n+efz7eSScILCFuFlIud/1uvRrHyGErz7oT8cg==
=kGcu
-----END PGP SIGNATURE-----

--w6PIDHtck+z9FHp7--

