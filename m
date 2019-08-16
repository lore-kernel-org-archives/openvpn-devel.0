References: <bd464d61-d16e-4a9b-de38-f96891e65368@...2525...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <43f87c71-6da5-b777-0def-e3a0893398b0@...2181...>
Date: Fri, 16 Aug 2019 17:22:27 +0200
MIME-Version: 1.0
In-Reply-To: <bd464d61-d16e-4a9b-de38-f96891e65368@...2525...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2d0p3wEgvfS2w3AQ06QBkerAeg7yUPtEQ"
Subject: Re: [Openvpn-devel] [PATCH] Adding support for wolfSSL backend
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Juliusz Sosinowicz <juliusz@...2525...>, openvpn-devel@lists.sourceforge.net
Cc: Todd Ouska <todd@...2525...>, Sean Parkinson <sean@...2525...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2d0p3wEgvfS2w3AQ06QBkerAeg7yUPtEQ
Content-Type: multipart/mixed; boundary="oPsQ23MdhPBtrXBEYX8ay3lLxaxikzONP";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Juliusz Sosinowicz <juliusz@...2525...>,
 openvpn-devel@lists.sourceforge.net
Cc: Todd Ouska <todd@...2525...>, Sean Parkinson <sean@...2525...>
Message-ID: <43f87c71-6da5-b777-0def-e3a0893398b0@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Adding support for wolfSSL backend
References: <bd464d61-d16e-4a9b-de38-f96891e65368@...2525...>
In-Reply-To: <bd464d61-d16e-4a9b-de38-f96891e65368@...2525...>

--oPsQ23MdhPBtrXBEYX8ay3lLxaxikzONP
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Juliusz,
On 16/08/2019 16:14, Juliusz Sosinowicz wrote:
> This patch adds the option to use wolfSSL as the ssl backend. To build
> this patch:
>=20
> 1. wolfSSL needs to be built with the `--enable-all` configure option.
> 2. OpenVPN must be built with the `--with-crypto-library=3Dwolfssl`
> =C2=A0=C2=A0 configure option.
>=20

first of all thanks a lot for your contribution!

I have looked at wolfSSL more than a year ago and back then it was
implementing an OpenSSL compatibility layer, so that it could be used as
drop-in replacement in all those programs using OpenSSL as main TLS library.

Is this layer still in place?
If so, why not using it to link OpenVPN against wolfSSL rather than
adding yet another backend?

The reason why I ask is that adding a new crypto backend drastically
increases the maintenance cost for us. Therefore, reducing the change
required in OpenVPN would be extremely beneficial.


Thanks a lot.

Best Regards,


--=20
Antonio Quartulli


--oPsQ23MdhPBtrXBEYX8ay3lLxaxikzONP--

--2d0p3wEgvfS2w3AQ06QBkerAeg7yUPtEQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAl1WyjMACgkQ9FVsWUWD
Dm0ezw/+KFGB+bxw2nLfBHHbVxhjfW8XWu59G97h+6TVWbtu97ot8BMHwrqn3FOO
zjlqHdgwmm4LFvnyY50loiDGxU2hDBVmpNjdOjaVPabzH7tMw0DH2r2xnqL1tbBa
Oc963CJQg0PuORuJIzhxmKFcB6Doo7od+cvn6e01PUnVlrDLp2OQ1UBbobuNTVug
8eggS6Gd2gZfYzHzA1IDw1Ndxa2usHfBCUnxXQJu1RW/DOegOK30IteyEP7mMrqU
dzFnqkVrg1UHC9qsb8+yOl3UJWYViPo75UyR4zMjIT/O04/uZkgbpmwmJRrkYHXf
ZITEVBDhICAAj6tj5RTif8cdW/9zhkOrKfrqH+nbMdGjacuwGNzgIq7mHv67EsgT
2Y9xGM/tuoq+3P+JM1ilkyS8QAMOgo27rFGiJ7QJsSB2IM6mLS4TFOUvp8877LSj
aoItbAf05v0z6PK6N8Kb5Ipv6hHDUWWlJzvNFakPREwrjrj4k5FmXWubaosQuxgV
j6Jz6EkTgYm8HDe8ngQsOP/yGerXmes9BJYOAtKW1x9z9cjT62kpor4/jHVP+EX7
4ifx7iPGXsUR1TNOl9vH54yC7Q+A/f+lbCe97AJLvTi2oIszo2kY/bUowJIbAe1v
EIkBX6QHtl97orcAptE58tlXDVkvoGtUVxS7uSmJ8fn8+BLumcY=
=2Dq3
-----END PGP SIGNATURE-----

--2d0p3wEgvfS2w3AQ06QBkerAeg7yUPtEQ--

