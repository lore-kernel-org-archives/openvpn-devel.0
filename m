References: <11098166-9909-4011-83F9-C5BC3FEA769D@...260...>
 <20181122092047.GS962@...1296...>
 <DFA3F418-5C5E-46F6-A39B-9CF5D76F2EE9@...260...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <fe1c465a-b9d7-df65-b19c-19384c40b84b@...1227...>
Date: Thu, 22 Nov 2018 15:43:05 +0100
MIME-Version: 1.0
In-Reply-To: <DFA3F418-5C5E-46F6-A39B-9CF5D76F2EE9@...260...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bsaFkg3KsEufPdZLBhsC7zQzWUOysi463"
Subject: Re: [Openvpn-devel] foreign_option_2 not set in 2.4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Cyril Scetbon <cyril.scetbon@...260...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bsaFkg3KsEufPdZLBhsC7zQzWUOysi463
Content-Type: multipart/mixed; boundary="rP0S8au6pNcNelsjyZ8RRfGYpJKbDUC23";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Cyril Scetbon <cyril.scetbon@...260...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <fe1c465a-b9d7-df65-b19c-19384c40b84b@...1227...>
Subject: Re: [Openvpn-devel] foreign_option_2 not set in 2.4
References: <11098166-9909-4011-83F9-C5BC3FEA769D@...260...>
 <20181122092047.GS962@...1296...>
 <DFA3F418-5C5E-46F6-A39B-9CF5D76F2EE9@...260...>
In-Reply-To: <DFA3F418-5C5E-46F6-A39B-9CF5D76F2EE9@...260...>

--rP0S8au6pNcNelsjyZ8RRfGYpJKbDUC23
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 22.11.18 um 14:46 schrieb Cyril Scetbon:
> OpenVPN 2.4.6 x86_64-alpine-linux-musl [SSL (OpenSSL)] [LZO] [LZ4]
> [EPOLL] [MH/PKTINFO] [AEAD] built on Jul =C2=A08 2018
>=20
> Output with =E2=80=94verb 4=C2=A0https://pastebin.com/huQmnGaU=C2=A0
>

Read your log closer. This is not a bug in OpenVPN but rather a broken
config what we accepted in 2.3:

Thu Nov 22 13:34:56 2018 us=3D235164 PUSH: Received control message:
'PUSH_REPLY,route 10.0.0.0 255.0.0.0,route 192.168.174.0
255.255.255.0,route 193.252.149.32 255.255.255.224,route 193.252.121.96
255.255.255.224,dhcp-option DNS 10.201.67.120,dhcp-option DOMAIN
cyril.net cyril2.net,route 10.252.12.150,topology net30,ping
5,ping-restart 30,ifconfig 10.252.12.158 10.252.12.157'

Thu Nov 22 13:34:56 2018 us=3D235314 Options error: Unrecognized option or
missing or extra parameter(s) in [PUSH-OPTIONS]:6: dhcp-option (2.4.6)

OpenVPN gets 'dhcp-option DOMAIN cyril.net cyril2.net' via push and
using two arguments after DOMAIN is wrong but OpenVPN 2.3 ignored the
second argument while 2.4 gives you an error and ignores the whole option.

Arne


--rP0S8au6pNcNelsjyZ8RRfGYpJKbDUC23--

--bsaFkg3KsEufPdZLBhsC7zQzWUOysi463
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlv2wK0ACgkQFRhsZwKx
RFTGeRAAp9hdawTGyAw0+dWCBuy/4Jeq8sxNP7RQcpTYKIV5SOR9rw5tNVD/Zs1+
UoDWURlWokwu/FUGFn7hix1nrbJD8B1do9rG681oWRwfMaaUiuDaQDdUk98KUqzP
voNocbS7RnNzVsS83AYYHkdX/EpL3nUtXa7f72e4PuRK1iIG7vc98LrVnf2mb7gx
9hCs5QV5M4w+NdLmSveoeFU4XwId4cdQPYxaUb5Zu36aEsakfQV+UBDzMsRbhh0q
H6GBh95HXmeXqMO5d1MDUAPJV70akFEYboBQiNancjTJg+MHp1wxf0Mg1BhGzglk
llMYLQE01vnr9ucNaz/+/Z2qWlv3WQm2M4646HNenf06AvYo5I0pN2iEyN0WWqnD
eLYYyM9YLurrlmW42XO0x8p+nkmk1lWEMjuJqzgJSnPPnrzxOjIKt6J20NpUstSj
MSUfiybEsBeLBAspMqz44vhUjhwN+r4DBdjJracDGquvreJY2TGkUYpwEp+xoSl2
Cm8Jv62OitizzRX15Ppf+MG08oYaoRULv3zyvjCshIGXqlgi6PU9WMs7BHBqFBdm
fkRzXMyOh3QL/JUgOkkTcK+uBiPAtqUXeRD4i3NiHmwqvveJ+TBxR5O6XG/ApeU4
CX56AKnv/GGuQjELHvGXnKgJUW5aRnaMLkPaxexML9NhJE9tdIg=
=XgxD
-----END PGP SIGNATURE-----

--bsaFkg3KsEufPdZLBhsC7zQzWUOysi463--

