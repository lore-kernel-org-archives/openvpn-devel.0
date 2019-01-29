References: <20181230112901.29241-1-a@...2181...>
 <20181230112901.29241-3-a@...2181...>
 <2d900a52-6b19-1925-9d51-cfa479c1a75d@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <f1eb39b5-8c11-47e7-cb62-65d5d5363f82@...2181...>
Date: Tue, 29 Jan 2019 14:47:54 +1000
MIME-Version: 1.0
In-Reply-To: <2d900a52-6b19-1925-9d51-cfa479c1a75d@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kiazqchlywQfPduN8jFejA12q27vjafar"
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
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kiazqchlywQfPduN8jFejA12q27vjafar
Content-Type: multipart/mixed; boundary="4wB3tCwlAxEDfIj3ZlcR9oUKaiqwjiEAg";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Arne Schwabe <arne@...1227...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <f1eb39b5-8c11-47e7-cb62-65d5d5363f82@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] socket: introduce INDIRECT transport
 protocol abstraction
References: <20181230112901.29241-1-a@...2181...>
 <20181230112901.29241-3-a@...2181...>
 <2d900a52-6b19-1925-9d51-cfa479c1a75d@...1227...>
In-Reply-To: <2d900a52-6b19-1925-9d51-cfa479c1a75d@...1227...>

--4wB3tCwlAxEDfIj3ZlcR9oUKaiqwjiEAg
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 23/01/2019 03:22, Arne Schwabe wrote:
> Am 30.12.18 um 12:28 schrieb Antonio Quartulli:
>> From: Robin Tarsiger <rtt@...2484...>
>>
>> This new transport protocol is used to tell the core code that traffic
>> should not be directly processed, but should rather be rerouted to a
>> transport plugin. It is basically an abstraction as it does not say tell
>> the code how to process the data, but simply forces its redirection to
>> the external code.
>>
>> Signed-off-by: Robin Tarsiger <rtt@...2484...>
>> [antonio@...515...: refactored commits, restyled code]
>> ---
>>  src/openvpn/forward.c   |   5 ++
>>  src/openvpn/socket.c    | 146 ++++++++++++++++++++++++++++++++++++++--
>>  src/openvpn/socket.h    |  70 +++++++++++++++++++
>>  src/openvpn/transport.h |   5 ++
>>  4 files changed, 222 insertions(+), 4 deletions(-)
>>
>> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
>> index 0a90fff0..a7092c7e 100644
>> --- a/src/openvpn/forward.c
>> +++ b/src/openvpn/forward.c
>> @@ -2150,6 +2150,11 @@ io_wait_dowork(struct context *c, const unsigned =
int flags)
>>              {
>>                  int i;
>>                  c->c2.event_set_status =3D 0;
>> +#ifdef ENABLE_PLUGIN
>> +                c->c2.event_set_status |=3D
>> +                    (socket_indirect_pump(c->c2.link_socket, esr, &stat=
us) & 3)
>=20
> The & 3 looks like some defined should be used instead.

I think this is simply about fetching the last two bits..not much fuzz
here..this is mostly because of how event_set_status works. But will see
if I find a meaningful name.

>=20
>=20
>=20
>>      if (addr->ai_protocol =3D=3D IPPROTO_UDP || addr->ai_socktype =3D=
=3D SOCK_DGRAM)
>>      {
>>          sock->sd =3D create_socket_udp(addr, sock->sockflags);
>> @@ -2279,7 +2320,11 @@ link_socket_init_phase2(struct link_socket *sock,
>>          }
>>=20=20
>>          /* If socket has not already been created create it now */
>> -        if (sock->sd =3D=3D SOCKET_UNDEFINED)
>> +        if (sock->sd =3D=3D SOCKET_UNDEFINED
>> +#ifdef ENABLE_PLUGIN
>> +            && !sock->indirect
>> +#endif
>> +            )
>>          {
>>              /* If we have no --remote and have still not figured out the
>>               * protocol family to use we will use the first of the bind=
 */
>> @@ -2300,7 +2345,11 @@ link_socket_init_phase2(struct link_socket *sock,
>>          }
>>=20=20
>>          /* Socket still undefined, give a warning and abort connection =
*/
>> -        if (sock->sd =3D=3D SOCKET_UNDEFINED)
>> +        if (sock->sd =3D=3D SOCKET_UNDEFINED
>> +#ifdef ENABLE_PLUGIN
>> +            && !sock->indirect
>> +#endif
>> +            )
>=20
> Better use the inline funtcion proto_is_indirect (or similar
> sock_is_indirect) that always returns false here and ifdef in header
> than to add the ifdefs inline in the code.

agreed! I am all for that! will change

>=20
>=20
>>  bool
>> @@ -3167,6 +3236,10 @@ proto_is_net(int proto)
>>  bool
>>  proto_is_dgram(int proto)
>>  {
>> +    if (proto_is_indirect(proto))
>> +    {
>> +        return true;
>> +    }
>>      return proto_is_udp(proto);
>>  }
>=20
> I think here need to be a good explaination why indirect is dgram but
> not udp and also proto_is_dgram and proto_is_udp need to get some
> comment to explain their difference in usage as this is now different.

I wouldn't say is_udp and is_dgram are now different, but is_dgram has
been extended to account for the indirect case as well.

>=20
>>=20=20
>> @@ -3301,6 +3374,18 @@ proto_remote(int proto, bool remote)
>>          return "TCPv4_CLIENT";
>>      }
>>=20=20
>> +#ifdef ENABLE_PLUGIN
>> +    if (proto =3D=3D PROTO_INDIRECT)
>> +    {
>> +        /* FIXME: the string reported here should match the actual tran=
sport
>> +         * protocol being used, however in this function we have no kno=
wledge of
>> +         * what protocol is exactly being used by the transport-plugin.
>> +         * Therefore we simply return INDIRECT for now.
>> +         */
>> +        return "INDIRECT";
>> +    }
>> +#endif
>=20
> From reading the code this function is only used in creating the string
> in options_string which needs to match between peers. As the plugin
> emulates UDP/DGRAM behaviour I think we should instead return here the
> same as a real UDP protocol.

well, the problem here is that if I use transport-plugin1 and you use
transport-plugin2 these strings will match between client and server
even though they should not (because the protocols being used are
actually different).

I don't think INDIRECT is UDP only. That is just how it prefers to be
treated, but could be non-UDP as well, I think. (need to double check)

>=20
>>=20=20
>> +#ifdef ENABLE_PLUGIN
>> +
>> +int link_socket_read_indirect(struct link_socket *sock,
>> +                              struct buffer *buf,
>> +                              struct link_socket_actual *from);
>> +
>> +int link_socket_write_indirect(struct link_socket *sock,
>> +                               struct buffer *buf,
>> +                               struct link_socket_actual *from);
>> +
>> +bool proto_is_indirect(int proto);
>> +
>=20
> This prototype definition looks a bit weird here. I see not reason why
> the real proto_is_indirect cannot be here

you mean the proto_is_indirect() implementation should be here in the
header? Why?

>=20
>> +#else  /* ifdef ENABLE_PLUGIN */
>> +
>> +static int
>> +link_socket_read_indirect(struct link_socket *sock,
>> +
>> +static int
>> +link_socket_write_indirect(struct link_socket *sock,
>=20
>> +static bool
>> +proto_is_indirect(int proto)
>=20
> I think functions implemented in the header should have the inline
> keyword. At least the rest of the header files do it that way.

yeah they should. will fix that.

>=20
>=20
> Arne
>=20

--=20
Antonio Quartulli


--4wB3tCwlAxEDfIj3ZlcR9oUKaiqwjiEAg--

--kiazqchlywQfPduN8jFejA12q27vjafar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlxP2voACgkQ9FVsWUWD
Dm201Q/9HfeP17RpFOgY7wONFCOxbKB99NAp2VierHysdwhruCo6FpH3wDEoxX/d
k5192+6JAkXRmB3Au9/p//45hOl+PjvvKVWlW8Ts2iQC9zUCY5AKe0yWfSo2HBTS
8F0XJQENXaENrzZ7S7rt4kvrx3346sgurQP3Pc+i48JFY3xJGc4ZD7x9XWIsMY0b
u3jIwjeXuauWa4CC+QoGdIrTDpYtYt3S563xB+YSTHj7dabgdWJ5uEWcvRNMSHsV
kJUJnztkZ1K/b3pNgbhR70SOsUexel9eo2kJGAgN66AAt3VOWtUEb+EfCjubcGEJ
fjdPTzYmogILfTRb29JerNv5+xxJMIwAjKJluGVLJWawoZA8WYyYYlTB+vo7fNLV
xhVg8xywZIOuJfx71joPGri8+U9mDw13nMOzKnQaUWhvEckTsmN0tZFAPviZxxMG
rbrZ2zr5xbJZ473AFxQ+bFcRtnMEC1/P2XdZFs9MCs4+jBkmAyICd1lW9Udu/VU+
iwMduOKlLSD1qdc9F5nDkY/DBq3OoQ6w2P/+xqLkGtDW0uiPe2sP2xoH7/D9tvyy
bI5KYVZwdaTWy05c0wr7BTXmFPlX9pPf1MuW4AdleDi4nd2k2F9K5p3prOhi3F/q
Jgbd6bdxHmsj9LxRE8zHYx7fL83ufyiuBQne9x4bpvt5pV929+o=
=G1Rw
-----END PGP SIGNATURE-----

--kiazqchlywQfPduN8jFejA12q27vjafar--

