References: <20180602034206.9459-1-a@...2181...>
 <1c15d88e-edd4-ad2d-0596-567715f41e43@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <9668e50d-7206-e0ed-b827-7f0d31756517@...2181...>
Date: Sun, 3 Jun 2018 16:30:29 +0800
MIME-Version: 1.0
In-Reply-To: <1c15d88e-edd4-ad2d-0596-567715f41e43@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9s8zvr24hpZikOAmPaP72XOLMVvtrHYDr"
Subject: Re: [Openvpn-devel] [PATCH 1/2] make tls-auth a
 per-connection-block option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9s8zvr24hpZikOAmPaP72XOLMVvtrHYDr
Content-Type: multipart/mixed; boundary="JvcG4VXKeVn0antirsEkRnvLUdA1QvPLs";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <9668e50d-7206-e0ed-b827-7f0d31756517@...2181...>
Subject: Re: [PATCH 1/2] make tls-auth a per-connection-block option
References: <20180602034206.9459-1-a@...2181...>
 <1c15d88e-edd4-ad2d-0596-567715f41e43@...1856...>
In-Reply-To: <1c15d88e-edd4-ad2d-0596-567715f41e43@...1856...>

--JvcG4VXKeVn0antirsEkRnvLUdA1QvPLs
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 03/06/18 16:27, Steffan Karger wrote:
> Hi,
>=20
> On 02-06-18 05:42, Antonio Quartulli wrote:
>> Different VPN servers may use different tls-auth keys. For this
>> reason it is convenient to make tls-auth a per-connection-block
>> option so that the user is allowed to specify one key per remote.
>=20
> Want!  This also helps with tls-auth key rollover.  Feature-ACK.
>=20
>> If no tls-auth option is specified in a given connection block,
>> the global one, if any, is used.
>>
>> Trac: #720
>> Cc: Steffan Karger <steffan@...1856...>
>> Signed-off-by: Antonio Quartulli <a@...2181...>
>> ---
>>  doc/openvpn.8         |  1 +
>>  src/openvpn/init.c    | 10 +++---
>>  src/openvpn/options.c | 82 ++++++++++++++++++++++++++++++++++---------
>>  src/openvpn/options.h |  5 +++
>>  4 files changed, 77 insertions(+), 21 deletions(-)
>>
>> diff --git a/doc/openvpn.8 b/doc/openvpn.8
>> index 4114f408..e7bc3f4f 100644
>> --- a/doc/openvpn.8
>> +++ b/doc/openvpn.8
>> @@ -372,6 +372,7 @@ block:
>>  .B remote,
>>  .B rport,
>>  .B socks\-proxy,
>> +.B tls\-auth,
>>  .B tun\-mtu and
>>  .B tun\-mtu\-extra.
>=20
> Shouldn't this also include key-direction?
>=20

good catch!
I added the manpage change at the end and I forgot about key-direction.

Will wait a bit more before sending v2.

> (Didn't really review or test yet, but otherwise looks good at first
> glance.)
>=20

Thanks so far

Cheers,


--=20
Antonio Quartulli


--JvcG4VXKeVn0antirsEkRnvLUdA1QvPLs--

--9s8zvr24hpZikOAmPaP72XOLMVvtrHYDr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsTpykACgkQB6U8WA7y
zXTCTw/+IcWqzEOzf/GQgsbkjZtElGZEVLPAZHKaoMP1djT/x7+YjLC8YCYwNyWf
O1WZ7cJoLkpFSujaGk02UNJQbK2dfiqg7h5HQcE/fKQ5pBIp4CgdhX52xiAkMmsu
rP1LmiZv6qZHpPhu4y/C7aDEIT6hF55r0GkaosUvFNUYiiS6WsASCpeZVqUgtauD
cVxxSr87P3ZVDZFpEOI+K9Cz/xjrhWUg+EUuJvfj2TTmLFMxYWBRXvVOYDO9Rz3O
LMN5oIHbXSTUpZKcPauh19XQbBzXeHW4uu6/4KDMgY5l1aZRScNpzHzNjiPYtxSI
gkicDZmtPZm5yLrLwTQ9hoLn17Gvycbx2l7DLAV9LT4DReoDVbRol2EwbGK5fWj5
K79EZJLkl6XwCzFKwioCCg4LIfPhAv9EzZawk7IvZAY95sEZ4qWIZmdTTe4qYP+Z
a+luBOl/vQOjgxHULetCOyNrJVjYbx2D1vwdpnf5mC0mlFe9OcSlMp5ROQadSjEL
ORXpoatQ5jt0Imj+/0P5g6rs5OFXv9ncYvXaomMYG2dsHfJPvyqeLBVrPizsKpc1
S6L7J8Di+lFbXd5QNYxnVPzjRPqC+sx939jBrWYYM5zU1z/MrjFy3yXsSQQ5aly8
CCIHi+CaWb9tzKJpHaDCKbleGBQjGgi4G/JfHs6giD/rSZFkbTg=
=zdQc
-----END PGP SIGNATURE-----

--9s8zvr24hpZikOAmPaP72XOLMVvtrHYDr--

