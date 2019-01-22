References: <20181230112901.29241-1-a@...2181...>
 <20181230112901.29241-3-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <2d900a52-6b19-1925-9d51-cfa479c1a75d@...1227...>
Date: Tue, 22 Jan 2019 18:22:48 +0100
MIME-Version: 1.0
In-Reply-To: <20181230112901.29241-3-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DX8CyMoFXRo5QGJYLEs1gNBmnRQkkvTF2"
Subject: Re: [Openvpn-devel] [PATCH 2/4] socket: introduce INDIRECT
 transport protocol abstraction
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
--DX8CyMoFXRo5QGJYLEs1gNBmnRQkkvTF2
Content-Type: multipart/mixed; boundary="nLl2GG0Nsi7XvmAmxFATiutpsTilZEd3x";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Antonio Quartulli <a@...2181...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <2d900a52-6b19-1925-9d51-cfa479c1a75d@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] socket: introduce INDIRECT transport
 protocol abstraction
References: <20181230112901.29241-1-a@...2181...>
 <20181230112901.29241-3-a@...2181...>
In-Reply-To: <20181230112901.29241-3-a@...2181...>

--nLl2GG0Nsi7XvmAmxFATiutpsTilZEd3x
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 30.12.18 um 12:28 schrieb Antonio Quartulli:
> From: Robin Tarsiger <rtt@...2484...>
>=20
> This new transport protocol is used to tell the core code that traffic
> should not be directly processed, but should rather be rerouted to a
> transport plugin. It is basically an abstraction as it does not say tell
> the code how to process the data, but simply forces its redirection to
> the external code.
>=20
> Signed-off-by: Robin Tarsiger <rtt@...2484...>
> [antonio@...515...: refactored commits, restyled code]
> ---
>  src/openvpn/forward.c   |   5 ++
>  src/openvpn/socket.c    | 146 ++++++++++++++++++++++++++++++++++++++--
>  src/openvpn/socket.h    |  70 +++++++++++++++++++
>  src/openvpn/transport.h |   5 ++
>  4 files changed, 222 insertions(+), 4 deletions(-)
>=20
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 0a90fff0..a7092c7e 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -2150,6 +2150,11 @@ io_wait_dowork(struct context *c, const unsigned i=
nt flags)
>              {
>                  int i;
>                  c->c2.event_set_status =3D 0;
> +#ifdef ENABLE_PLUGIN
> +                c->c2.event_set_status |=3D
> +                    (socket_indirect_pump(c->c2.link_socket, esr, &statu=
s) & 3)

The & 3 looks like some defined should be used instead.



>      if (addr->ai_protocol =3D=3D IPPROTO_UDP || addr->ai_socktype =3D=3D=
 SOCK_DGRAM)
>      {
>          sock->sd =3D create_socket_udp(addr, sock->sockflags);
> @@ -2279,7 +2320,11 @@ link_socket_init_phase2(struct link_socket *sock,
>          }
>=20=20
>          /* If socket has not already been created create it now */
> -        if (sock->sd =3D=3D SOCKET_UNDEFINED)
> +        if (sock->sd =3D=3D SOCKET_UNDEFINED
> +#ifdef ENABLE_PLUGIN
> +            && !sock->indirect
> +#endif
> +            )
>          {
>              /* If we have no --remote and have still not figured out the
>               * protocol family to use we will use the first of the bind =
*/
> @@ -2300,7 +2345,11 @@ link_socket_init_phase2(struct link_socket *sock,
>          }
>=20=20
>          /* Socket still undefined, give a warning and abort connection */
> -        if (sock->sd =3D=3D SOCKET_UNDEFINED)
> +        if (sock->sd =3D=3D SOCKET_UNDEFINED
> +#ifdef ENABLE_PLUGIN
> +            && !sock->indirect
> +#endif
> +            )

Better use the inline funtcion proto_is_indirect (or similar
sock_is_indirect) that always returns false here and ifdef in header
than to add the ifdefs inline in the code.


>  bool
> @@ -3167,6 +3236,10 @@ proto_is_net(int proto)
>  bool
>  proto_is_dgram(int proto)
>  {
> +    if (proto_is_indirect(proto))
> +    {
> +        return true;
> +    }
>      return proto_is_udp(proto);
>  }

I think here need to be a good explaination why indirect is dgram but
not udp and also proto_is_dgram and proto_is_udp need to get some
comment to explain their difference in usage as this is now different.

>=20=20
> @@ -3301,6 +3374,18 @@ proto_remote(int proto, bool remote)
>          return "TCPv4_CLIENT";
>      }
>=20=20
> +#ifdef ENABLE_PLUGIN
> +    if (proto =3D=3D PROTO_INDIRECT)
> +    {
> +        /* FIXME: the string reported here should match the actual trans=
port
> +         * protocol being used, however in this function we have no know=
ledge of
> +         * what protocol is exactly being used by the transport-plugin.
> +         * Therefore we simply return INDIRECT for now.
> +         */
> +        return "INDIRECT";
> +    }
> +#endif
--nLl2GG0Nsi7XvmAmxFATiutpsTilZEd3x--

--DX8CyMoFXRo5QGJYLEs1gNBmnRQkkvTF2--
