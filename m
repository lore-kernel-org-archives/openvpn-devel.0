From: Arne Schwabe <arne@...1227...>
References: <20181230112901.29241-1-a@...2181...>
 <20181230112901.29241-3-a@...2181...>
 <2d900a52-6b19-1925-9d51-cfa479c1a75d@...1227...>
 <f1eb39b5-8c11-47e7-cb62-65d5d5363f82@...2181...>
Message-ID: <ce732220-cfef-ff07-0808-da78f21095c0@...1227...>
Date: Tue, 29 Jan 2019 17:45:33 +0100
MIME-Version: 1.0
In-Reply-To: <f1eb39b5-8c11-47e7-cb62-65d5d5363f82@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="txOKD6LWFpm5G3lqWgUNX6K2hs5rwYNgG"
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
--txOKD6LWFpm5G3lqWgUNX6K2hs5rwYNgG
Content-Type: multipart/mixed; boundary="mm6lVpihzeaPPMkzP96OkBWUIOIMFCC16";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Antonio Quartulli <a@...2181...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <ce732220-cfef-ff07-0808-da78f21095c0@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] socket: introduce INDIRECT transport
 protocol abstraction
References: <20181230112901.29241-1-a@...2181...>
 <20181230112901.29241-3-a@...2181...>
 <2d900a52-6b19-1925-9d51-cfa479c1a75d@...1227...>
 <f1eb39b5-8c11-47e7-cb62-65d5d5363f82@...2181...>
In-Reply-To: <f1eb39b5-8c11-47e7-cb62-65d5d5363f82@...2181...>

--mm6lVpihzeaPPMkzP96OkBWUIOIMFCC16
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


>>> +++ b/src/openvpn/forward.c
>>> @@ -2150,6 +2150,11 @@ io_wait_dowork(struct context *c, const unsigned=
 int flags)
>>>              {
>>>                  int i;
>>>                  c->c2.event_set_status =3D 0;
>>> +#ifdef ENABLE_PLUGIN
>>> +                c->c2.event_set_status |=3D
>>> +                    (socket_indirect_pump(c->c2.link_socket, esr, &sta=
tus) & 3)
>>
>> The & 3 looks like some defined should be used instead.
>=20
> I think this is simply about fetching the last two bits..not much fuzz
> here..this is mostly because of how event_set_status works. But will see
> if I find a meaningful name.
>=20

INDIRECT_FLAG_MASK or something.

>>>  bool
>>> @@ -3167,6 +3236,10 @@ proto_is_net(int proto)
>>>  bool
>>>  proto_is_dgram(int proto)
>>>  {
>>> +    if (proto_is_indirect(proto))
>>> +    {
>>> +        return true;
>>> +    }
>>>      return proto_is_udp(proto);
>>>  }
>>
>> I think here need to be a good explaination why indirect is dgram but
>> not udp and also proto_is_dgram and proto_is_udp need to get some
>> comment to explain their difference in usage as this is now different.
>=20
> I wouldn't say is_udp and is_dgram are now different, but is_dgram has
> been extended to account for the indirect case as well.
>=20

is_dgram and is_udp return different values for INDIRECT, so they are
different. I would like some comment why that is. Without having looked
deeper I suspect the one function is used to determine the wire format
and the other is used for determing the actual outer protocol. Just
adding that as comment in the is_dgram function would be nice (double
check first).

>>
>>>=20=20
>>> @@ -3301,6 +3374,18 @@ proto_remote(int proto, bool remote)
>>>          return "TCPv4_CLIENT";
>>>      }
>>>=20=20
>>> +#ifdef ENABLE_PLUGIN
>>> +    if (proto =3D=3D PROTO_INDIRECT)
>>> +    {
>>> +        /* FIXME: the string reported here should match the actual tra=
nsport
>>> +         * protocol being used, however in this function we have no kn=
owledge of
>>> +         * what protocol is exactly being used by the transport-plugin.
>>> +         * Therefore we simply return INDIRECT for now.
>>> +         */
>>> +        return "INDIRECT";
>>> +    }
>>> +#endif
>>
>> From reading the code this function is only used in creating the string
>> in options_string which needs to match between peers. As the plugin
>> emulates UDP/DGRAM behaviour I think we should instead return here the
>> same as a real UDP protocol.
>=20
> well, the problem here is that if I use transport-plugin1 and you use
> transport-plugin2 these strings will match between client and server
> even though they should not (because the protocols being used are
> actually different).

If we get to the point that the cleartext inside the openvpn tunnel is
compared the methods are compatible. And if you have a client on the one
side that has plugin in it and a proxy+openvpn server on the other side,
it should also work.

> I don't think INDIRECT is UDP only. That is just how it prefers to be
> treated, but could be non-UDP as well, I think. (need to double check)

But for this check it is only important that the wire format is the TCP
or UDP wire format. Not the actual protocol being used.

>=20
>>
>>>=20=20
>>> +#ifdef ENABLE_PLUGIN
>>> +
>>> +int link_socket_read_indirect(struct link_socket *sock,
>>> +                              struct buffer *buf,
>>> +                              struct link_socket_actual *from);
>>> +
>>> +int link_socket_write_indirect(struct link_socket *sock,
>>> +                               struct buffer *buf,
>>> +                               struct link_socket_actual *from);
>>> +
>>> +bool proto_is_indirect(int proto);
>>> +
>>
>> This prototype definition looks a bit weird here. I see not reason why
>> the real proto_is_indirect cannot be here
>=20
> you mean the proto_is_indirect() implementation should be here in the
> header? Why?

It is already in the header. Having an inline implementation AND a
prototype in the same header is what I am complaining about.


Arne




--mm6lVpihzeaPPMkzP96OkBWUIOIMFCC16--

--txOKD6LWFpm5G3lqWgUNX6K2hs5rwYNgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlxQgy4ACgkQFRhsZwKx
RFQ4WRAAs8sJVSP5lXUVzLmY+8yqZd+LnxUIQVQYEJgCHvxOHgYzIL+2HaPByyDU
JF+GfQA6PsXX9cgqs52r7KEht+eNt0A02pOeTVlNXscV3lhTRg6Npj+fNJatmgBN
h25ZIH+wULcL/G2gDmaVeV54d88GpVFeInDzTVutdAPvX9RFVPd5FXIYaOWcULe8
6iAcp38HTMb/NmkBI6rLTxa5oC8kqVzzNGku8i8LW7YQ3X/5y+TSHp4ux/9oA+Ah
OsQpxJU1iWHTOO9f64lqlIdDMIAutQvIozJokO2Pw9a4edLDWovRpaYIhvaR5xEN
p9qr8fo4JLGI/mREoG4i10idBYdzFa5HNT0s/i2N1RC828nXQf/HVErLS4jgUo6Q
CaSXHC+RhOsWcR9DZZhTaIElH2s6eMG/THIpduQnJBRP8dRZVdH2RfDxsRQZm9Is
09MyiCItc+g7E/rjQU1M2+vaS+oPfShRp5+36P434sqQo+nP0Lif50shFipda21H
Z68uulxLDcICSF100ZGovrt6wDBsBPEUmwi5WNznb8l7WQe4VPipQyjbQaNWG33u
BxX3qaSktp7hQhgJQ1HBB3UMNtsb86wHk6OiCbCmkTNtpt62ULgAwPW6natNJ4LD
LiUxTMyemd32lHYbgakaSHb3ii1kklNm9OuaCR+o2wC4m6NEYpI=
=0/Bc
-----END PGP SIGNATURE-----

--txOKD6LWFpm5G3lqWgUNX6K2hs5rwYNgG--

