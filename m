References: <20200813072923.24385-1-eric@...1918...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <1fb10dd1-8ddf-c467-21a5-a93e21e6a8ac@...1227...>
Date: Thu, 13 Aug 2020 10:30:25 +0200
MIME-Version: 1.0
In-Reply-To: <20200813072923.24385-1-eric@...1918...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="o85iaZ5DsGfABnpL30fxgrATiFA00t1PK"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Send auth-fail messages to clients
 on renegotiation failures via auth-token or user-pass expiry
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eric Thorpe <eric@...1918...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o85iaZ5DsGfABnpL30fxgrATiFA00t1PK
Content-Type: multipart/mixed; boundary="vkujcdV2GU4wdPfD1QkRsd38weqNhYDYE"

--vkujcdV2GU4wdPfD1QkRsd38weqNhYDYE
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

>  /*
>   * Send restart message from server to client.
>   */
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index 96897e48..b5cc9dc9 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -576,6 +576,7 @@ struct tls_multi
>=20=20
>      char *remote_ciphername;    /**< cipher specified in peer's config f=
ile */
>=20=20
> +    bool connection_established; /** Notifies future auth calls this is =
a reneg */
>      /*
>       * Our session objects.
>       */
>

NAK from my side. Adding another variable to state machine for just this
feature that duplicates already existing states is something I really
want to avoid. This might look and work fine for this patch but at the
end you end up with a plenthora of mini states and unclear
interdependency. I worked hard in the connect-client patches to remove
duplication of these states and are not eager to reduce them, especially
not "connection_established" which duplicates the name of
link_socket->connection_established that has a completely different meaning.

Arne


--vkujcdV2GU4wdPfD1QkRsd38weqNhYDYE--

--o85iaZ5DsGfABnpL30fxgrATiFA00t1PK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl80+iEACgkQFRhsZwKx
RFRCbhAAlYdTFSYMe4QKVUd7VazCgZ7TTIS1DZAvzPgxYJ7p6rS+aAB6hBUy2FDM
tCJZoqlaBZbN7ex8sKo3v/yweblo3Cc9hCBzy/CFMOcsBw2/5u0zUAD0G6rK5UbX
vOJQtiXoi7OcjKzE6v5qPwW5+a0rrWwDHoJFIri7yqgqXVlAv4HDG/2jHUQ+Ria3
dgMJoxIy3IQLfHklpe3MQZ7gs64y6ugYEKrAXKSeV3v9N5IytAsUYokFZtWMaQVe
xvDIoDKl6iZmNMSNu5CQ0ECa3JsmSr2u7DOMg8sQH0Wt+ezxpkgn1RjAsvolZNU4
EyjNvLf9lZlWdaYyQhlheoLHdnrwKaGEzWe+UgXQGuJrIQ9lJrxmTROcMjZ4CDuM
0PbcIMX2qJ3hLT+g6oJTuL7tltoDlNsNeAhjTCJjtZL4iMp2SQ8JLCxX1RdSHog6
kBx38LeKV4fMH4H+doZux3FbaHbLvy/zg60kH8E3JDvTU91X7LwpJFx4A5KHkFGA
doGi3qSmhFVk1lYWwPQFo9UsXfCteOhkoByhsnCG3bTsAjhACZoEBRLdayniWuv+
gMd3EjrEAuMu4kDINaHm+flN21HWNYT1eP3R4HQaaUk4Wuai2z8NknBMQc/Oh94Q
txQ63y6ozVW7s/aVDI6+7qLP0jXiAoTijTDpAxD/6UyIOZO0DY8=
=c7WO
-----END PGP SIGNATURE-----

--o85iaZ5DsGfABnpL30fxgrATiFA00t1PK--

