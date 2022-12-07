Date: Wed, 7 Dec 2022 08:56:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y5BHFHtyZCCDYPtx@...1296...>
References: <20221201110128.271064-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="btHxlgV+u0eI5k1k"
Content-Disposition: inline
In-Reply-To: <20221201110128.271064-1-arne@...1227...>
Subject: [Openvpn-devel] OpenVPN crash with latest "fix p2p reconnect" patch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--btHxlgV+u0eI5k1k
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

bad news...

On Thu, Dec 01, 2022 at 12:01:28PM +0100, Arne Schwabe wrote:
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 1b418b1bc..958bf0b56 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -1174,9 +1174,22 @@ process_incoming_dco(struct context *c)
>=20=20
>      dco_do_read(dco);
>=20=20
> +    /* FreeBSD currently sends us removal notifcation with the old peer-=
id in
> +     * p2p mode with the ping timeout reason, so ignore that one to not =
shout
> +     * ourselves in the foot and removing the just established session */
> +    if (dco->dco_message_peer_id !=3D c->c2.tls_multi->dco_peer_id)
> +    {
> +        msg(D_DCO_DEBUG, "%s: received message for mismatching peer-id %=
d, "
> +            "expected %d", __func__, dco->dco_message_peer_id,
> +            c->c2.tls_multi->dco_peer_id);
> +        return;
> +    }

This code works perfectly well for p2p TLS environments, but makes OpenVPN
explode in a scenario that my tests did not trigger properly

 - you have a p2p tun instance with --secret & DCO
 - you have a second p2p DCO instance on the same machine, with TLS
    - peers connect and disconnect to the p2p TLS instance

 - the *first* instance receives a DCO message, and explodes...

2022-12-07 08:34:50 us=3D63605 setsockopt(IPV6_V6ONLY=3D0)
2022-12-07 08:34:50 us=3D63826 UDPv6 link local (bound): [AF_INET6][undef]:=
51204
2022-12-07 08:34:50 us=3D64015 UDPv6 link remote: [AF_UNSPEC]
2022-12-07 08:35:00 us=3D977186 Attempting to send data packet while data c=
hannel offload is in use. Dropping packet

Program received signal SIGSEGV, Segmentation fault.
0x00005555555772b9 in process_incoming_dco (c=3D0x7fffffffd460) at forward.=
c:1180
1180        if (dco->dco_message_peer_id !=3D c->c2.tls_multi->dco_peer_id)
(gdb) where
#0  0x00005555555772b9 in process_incoming_dco (c=3D0x7fffffffd460)
    at forward.c:1180
#1  process_io (c=3D0x7fffffffd460) at forward.c:2283
#2  0x000055555559db4c in tunnel_point_to_point (c=3D0x7fffffffd460)
    at openvpn.c:94
#3  openvpn_main (argc=3D2, argv=3D0x7fffffffe608) at openvpn.c:311
#4  0x00007ffff7cbf083 in __libc_start_main (main=3D0x55555555e500 <main>,=
=20
    argc=3D2, argv=3D0x7fffffffe608, init=3D<optimized out>, fini=3D<optimi=
zed out>,=20
    rtld_fini=3D<optimized out>, stack_end=3D0x7fffffffe5f8)
    at ../csu/libc-start.c:308
#5  0x000055555555e53e in _start () at socket.h:1206
(gdb) print *dco
$2 =3D {nl_sock =3D 0x555555642bd0, nl_cb =3D 0x55555563b310, status =3D 0,=
=20
  ifmode =3D __OVPN_MODE_FIRST, ovpn_dco_id =3D 37, ovpn_dco_mcast_id =3D 5=
,=20
  ifindex =3D 27659, dco_packet_in =3D {capacity =3D 65536, offset =3D 0, l=
en =3D 0,=20
    data =3D 0x555555643370 ""}, dco_message_type =3D 0, dco_message_peer_i=
d =3D -1,=20
  dco_del_peer_reason =3D 0}

(gdb) print c->c2.tls_multi
$3 =3D (struct tls_multi *) 0x0

^^^^ dat.

B=E4m.


My tests did not alert me of this, as the sequence of things is

 - build new openvpn binary
 - stop all instances
 - start all instances with new binary
 - run client side tests against all these instances
 - be happy if client side tests succeed

the client side tests tested p2p udp (8) before p2p udp TLS (11), so
never noticed that after running (11), (8) would not work any longer...


One item of obvious confusion - yes, this is --secret and not TLS, and
yes, we use DCO...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--btHxlgV+u0eI5k1k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjkEcUAAoJEB2Cnv7KVigSQjIL/1C0aS/0BDOjGOeGSV7ruVZR
l278wkymJF2v6ZPUmwDBEZ3uDPZOs2i3S2inW/nd/uJDGaGmL2uN66l3ABDptTKx
fOQYEdABsAh3VwQyUz0Rhl3ZblbrHJ2/h4yzo6oLvXpEkgiObZCDDL9ZmB3H0QG6
mFEAFey0K9qn8toniijaU1ZoGaNBFkukgff9Ux0BxuK2ZZAzRfsAsJsiCDQxPrU9
wxxloX5287Agtr/tgDkasEorS65Prt+pQ84Cxzb9UkIVJS68DExzop8XM7MIzbpM
0stfxLmtJhbKw09ZzH6OBapr9rq0IUR6tfhbv6oprf70os9DfFiV0mqWmhBX3zPu
AWrMYR8rvpxxpAjEX8D1SWoUq2Pme6uabPqT5/j2zP+vwyAitP6aTAQyaFm0RtGy
q28RKtW2IBKtFXQiCj/JikHad5hMsxggJ0Rn8rQi1LmXH0BEKePR0z6Tac5DZWmG
XIEjvRn+FJ+bUFOc0XwF3ZjhO+bgMTDG+inl3jI34g==
=6Q23
-----END PGP SIGNATURE-----

--btHxlgV+u0eI5k1k--

