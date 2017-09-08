References: <20170823053054.29982-1-a@...2181...>
 <177bfb02-652a-abf6-4474-9a6575b14de4@...2080...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <5fa1f86e-7590-e936-4870-4eb65cb59de4@...1435...>
Date: Fri, 8 Sep 2017 10:00:16 +0200
MIME-Version: 1.0
In-Reply-To: <177bfb02-652a-abf6-4474-9a6575b14de4@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AnkRiHKglUwLql3Tr6iHnmklsHlSrks15"
Subject: Re: [Openvpn-devel] [PATCH] route: cleanup codestyle and make code
 more readable
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--AnkRiHKglUwLql3Tr6iHnmklsHlSrks15
Content-Type: multipart/mixed; boundary="Vl8buD9khd6JxlVUdLU9PEqUVwAO54STW";
 protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <5fa1f86e-7590-e936-4870-4eb65cb59de4@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] route: cleanup codestyle and make code
 more readable
References: <20170823053054.29982-1-a@...2181...>
 <177bfb02-652a-abf6-4474-9a6575b14de4@...2080...>
In-Reply-To: <177bfb02-652a-abf6-4474-9a6575b14de4@...2080...>

--Vl8buD9khd6JxlVUdLU9PEqUVwAO54STW
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 06-09-17 22:45, David Sommerseth wrote:
> On 23/08/17 07:30, Antonio Quartulli wrote:
>> -static void delete_route(struct route_ipv4 *r, const struct tuntap *tt,=
 unsigned int flags, const struct route_gateway_info *rgi, const struct env=
_set *es);
>> +static void delete_route(struct route_ipv4 *r, const struct tuntap *tt,
>> +			 unsigned int flags,
>> +			 const struct route_gateway_info *rgi,
>> +			 const struct env_set *es);
>=20
> vs
>=20
>>  static void
>> -delete_route(struct route_ipv4 *r,
>> -             const struct tuntap *tt,
>> -             unsigned int flags,
>> -             const struct route_gateway_info *rgi,
>> -             const struct env_set *es)
>> +delete_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned in=
t flags,
>> +             const struct route_gateway_info *rgi, const struct env_set=
 *es)
>=20
> I think the change you do in the former one is also more readable than
> squeezing everything into as few lines as possible, especially when
> there's lots of arguments.

I disagree that stretching out function prototypes/declarations over
multiple lines improves readability.  Adding newlines wastes my vertical
screen real estate, which results in more scrolling and reduced
overview.  Or: I fully agree with the proposed change by Antonio (modulo
the tabs, of course).

-Steffan


--Vl8buD9khd6JxlVUdLU9PEqUVwAO54STW--

--AnkRiHKglUwLql3Tr6iHnmklsHlSrks15
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZsk4WAAoJEEEwndWOY1w5oKYH/j0MMVRv0Ixige9lIOUIRkiM
dQMGRhAouNsUBusIwuRlb7PCGS2cfQhFnTiuBu9CmLSQ/9kl4Jen0bwmY60g0sJW
kAinEiU3Tsg6GMsWgMse/259u5936hu2ih2nNsqsCkKCryq61jLYBjbTXKM3dGOO
CebOs2caaGW97ej6gaV9Kom8YsWiP+ntSxwPS6GhrBGoMOb5uiMVNdvkHQ+MsXg6
H1wWmCYJPmHabitDZXTmbyTalS8thszXHtDOOpkexnneguFdpoOXIGrhWBcXcanW
pyf/Ohogk0OAz3dTUsP081Aj67YcE0+ctKEQMUkmqt5/RqfOEHCqC57/HSTxYjI=
=J+NU
-----END PGP SIGNATURE-----

--AnkRiHKglUwLql3Tr6iHnmklsHlSrks15--

