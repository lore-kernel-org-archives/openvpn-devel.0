References: <20181011184200.22175-1-a@...2181...>
 <20181011184200.22175-4-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <efb55a38-71f8-4044-d05d-dbac50de8a6c@...1227...>
Date: Mon, 26 Nov 2018 14:14:08 +0100
MIME-Version: 1.0
In-Reply-To: <20181011184200.22175-4-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="P2R2TeGEHxjsvHmF9NvOvjlbT6vbsiVoj"
Subject: Re: [Openvpn-devel] [PATCH v2 3/7] introduce sitnl: Simplified
 Interface To NetLink
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P2R2TeGEHxjsvHmF9NvOvjlbT6vbsiVoj
Content-Type: multipart/mixed; boundary="VNnxbYupKW9PkTWpfojlqtPU3Zssfm44l";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Antonio Quartulli <a@...2181...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <efb55a38-71f8-4044-d05d-dbac50de8a6c@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/7] introduce sitnl: Simplified
 Interface To NetLink
References: <20181011184200.22175-1-a@...2181...>
 <20181011184200.22175-4-a@...2181...>
In-Reply-To: <20181011184200.22175-4-a@...2181...>

--VNnxbYupKW9PkTWpfojlqtPU3Zssfm44l
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 11.10.18 um 20:41 schrieb Antonio Quartulli:
> This patch introduces a tiny netlink interface, optimized
> for the openvpn use case.
>=20
> It basically exposes all those operations that are currently
> handled by directly calling the /sbin/ip command (or even
> ifconfig/route, if configured).
>=20
> By using netlink, openvpn won't need to spawn new processes
> when configuring the tun interface or routes.
> This new approach will also allow openvpn to be granted
> CAP_NET_ADMIN and be able to properly work even though it
> dropped the root privileges (currently handled via workarounds).
>=20
> By moving this logic into the sitnl module, tun.c and route.c
> also benefit from some code simplification

Just FYI for the rest. The current code still has a bug handling ipv6
and I am waiting for V3 that does not have this bug.

So this is not a full review

> +typedef union {
> +    in_addr_t ipv4;
> +    struct in6_addr ipv6;
> +} inet_address_t;
> +



> +/**
> + * Link state request message
> + */
> +struct sitnl_link_req {
> +    struct nlmsghdr n;

I think one two sentences that netlink requires messages in a certain
format but has no standard header that defines them so we need to define
the message ourselves would be good here.

> +
> +/*            if (((int)nladdr.nl_pid !=3D peer) || (h->nlmsg_pid !=3D n=
laddr.nl_pid)
> +                || (h->nlmsg_seq !=3D seq))
> +            {
> +                rcv_len -=3D NLMSG_ALIGN(len);
> +                h =3D (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
> +                msg(M_DEBUG, "%s: skipping unrelated message. nl_pid:%d =
(peer:%d) nl_msg_pid:%d nl_seq:%d seq:%d",
> +                    __func__, (int)nladdr.nl_pid, peer, h->nlmsg_pid,
> +                    h->nlmsg_seq, seq);
> +                continue;
> +            }
> +*/

The "normal" style for these debug commented out parts is using #ifdef
instead of comments.


> +typedef struct {
> +    int addr_size;
> +    inet_address_t gw;
> +    char iface[IFNAMSIZ];
> +} route_res_t;
> +

This struct is in the middle of the file and I think it should either go
along with the other struct definition in the top of the file or all
structs should be defined before the function that they are used in first.


> +/* used by iproute2 implementation too */

I would not add that comment. Where a function is used can be inferred
pretty easily and we don't have such comments elsewhere. And I fear this
comment might be overlooked when iproute2 is remove in 2.6/2.7 and then
more confusing than helpful.

Arne


--VNnxbYupKW9PkTWpfojlqtPU3Zssfm44l--

--P2R2TeGEHxjsvHmF9NvOvjlbT6vbsiVoj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlv78aEACgkQFRhsZwKx
RFTxMxAAhU7CGty8/9Fz6Z6ECN514p5ca08NFhfhwyyZ8tFOe6dNZWRHQnKXkBLU
RzPhSHwzyWrqg4+QklaTDtGY56g99SSzcmjM4y0psu7LAWRPrrg4+dkk/AVNtdKd
Bu1SjosJL+LdchR5bsD0C/iyvgKtJVmLekkqYexNW2tTdUJ6BlFPX/ZKwHTmxDPq
JF/Ni5H+7N4FFrYwbozN9tfVfoBqmyTkqzMLuMi96b9XFO+LVkv5KfZ90K0ebDpo
dnOYq0bRLcf7QQWMtsL7PJkIQofbv3igC7Kmv/J3JNBsvDV19/ibOpasuSZrvLu5
n63smW2ocVpJ1SIkmK/A1bR49TFmWsEaOYjT4bt+XKRUhp2shevKQ2MjP0jzWXO0
8X9t2SsoNqyZi7xCW24pIyzCwuGSizTIjPgPCELnUZDGGQTFYWri5RyVfST2vWGa
AZqJUHVqG9kpOn64m9QAreflUnucA13DyOEYO1E/frfQpST4xwWZlC5X45UYMPvt
a61eMez6TqopUp9cmvulyK0pQ6Fsf2HpsG60ZeHaEa2B27hIQhYxoufdm4cdsSdK
D0iaa9GPJl2rD6EBpSYe1pS1ETxnQXALtHS6s2U8v71V23NkRbE9IQeA/L0wPAf5
AtIz7i48tZQu1oooT4ZjNOppFDNkf/aqz0G/xd8DtOJgUGq8/hg=
=WA5U
-----END PGP SIGNATURE-----

--P2R2TeGEHxjsvHmF9NvOvjlbT6vbsiVoj--

