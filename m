References: <20170701112951.19119-1-steffan@...1856...>
 <b67daad4-362b-3605-5716-3e17c5f0c362@...2080...>
 <CAFHpkQFADMG50xb4UD_bAvT4a94EbLVstAuPEmhkxhUEnZoXQg@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <480c51a7-a17d-c29f-1b8e-33c874ca9670@...2181...>
Date: Tue, 15 Aug 2017 16:32:58 +0800
MIME-Version: 1.0
In-Reply-To: <CAFHpkQFADMG50xb4UD_bAvT4a94EbLVstAuPEmhkxhUEnZoXQg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="F2LPCrIxsCuTdClcbtKESDwnnlIJe2mpx"
Subject: Re: [Openvpn-devel] [PATCH] Deprecate --keysize
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F2LPCrIxsCuTdClcbtKESDwnnlIJe2mpx
Content-Type: multipart/mixed; boundary="wbfabAU8t8ObKNXuEs07nm75g4RXI4ghe";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <480c51a7-a17d-c29f-1b8e-33c874ca9670@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Deprecate --keysize
References: <20170701112951.19119-1-steffan@...1856...>
 <b67daad4-362b-3605-5716-3e17c5f0c362@...2080...>
 <CAFHpkQFADMG50xb4UD_bAvT4a94EbLVstAuPEmhkxhUEnZoXQg@...278...>
In-Reply-To: <CAFHpkQFADMG50xb4UD_bAvT4a94EbLVstAuPEmhkxhUEnZoXQg@...278...>

--wbfabAU8t8ObKNXuEs07nm75g4RXI4ghe
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 15/08/17 16:26, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
> 2017-08-14 15:36 GMT+05:00 David Sommerseth <
> openvpn@...2080...>:
>=20
>> On 01/07/17 13:29, Steffan Karger wrote:
>>
>> So I propose:
>>
>> - We add the warning about removing --keysize for both v2.4 and v2.5.
>>
>> - Add a warning in v2.4 and v2.5 that ciphers with block sizes < 128
>>   bits will be *removed* in v2.6
>>
>> - When removing those ciphers in v2.6, we can remove --keysize together
>>   with the ciphers, as it will no longer be valid.  But --keysize needs
>>   to be a NOP for some time (with a warning it has no effect), to avoid
>>   OpenVPN stopping to run on upgrades.
>>
>> - Ensure these changes are synchronised within OpenVPN 3 as well
>>
>> - Start a new wiki page: "How-To: Migrate to secure and modern
>>   OpenVPN configurations" where we list all deprecated features/options
>>   and their replacement (including examples).  We also need to have a
>>   description on the reasoning for deprecating and removing these
>>   options.
>>
>=20
> there are special cases like Mikrotik openvpn (pretty popular), where
> user simply use what hardware vendor installed (without possibility to
> recompile).
>=20
> should we contact such hardware vendors as well ?

there might be an non-predictable number of vendors shipping their own
openvpn version. We can't contact them all. It's their responsibility to
stay behind the changes in what they ship.

If they don't, their users will complain aloud with them ;)

On top of that, this does not prevent users from using their own config,
right? So they can still configure the client to avoid deprecated options.


Cheers,

--=20
Antonio Quartulli


--wbfabAU8t8ObKNXuEs07nm75g4RXI4ghe--

--F2LPCrIxsCuTdClcbtKESDwnnlIJe2mpx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlmSsboACgkQ0+HICM1s
oFCgXg//Q4yS41CYCWwMw1OibTtwRCcEZAcRLQv4BHrizv6E/wFzboBfUOUUOhES
FuhUhepA0v/ZmuzhdKQi/mTX04b/+Le0FwE28rpOKFi+nJE7fmjYspJqm9PXRavc
zhNkk7zP8hvB8m7gPac8NuVvPupjcFkK4hxWwOoVClBqoorYWrhRhcLI4kMt9raU
LOCfMA7sJahbgy833i2qAf1lQsNJD9zr3/PiGj5JYKe1TI9zIwAoMEeEWShAvn53
bZcz41wrrFC7GVVp51Lp78aFqR7brv6JGxu0GXajRbO4sNmX6PxjfvxJKp968NPn
qVvPgOFQLCjodjJHQQopF6qHmr9yV8uCDqrG0qSVESWXZrQp0+8F0yIMQlQ5UEGS
P7JmWSD9NfCgD860b4JvIgxgMr+g6Zf8aS+J/t47PBpTIEhaXMfQVp2oM01TfeY8
eKz3sYeOQe4wIzGXLK1vG1CKdejOBZ65J20oZUNI5dafr4fy74/AHiPp54cWHqFc
0yjCPKwuwsPXhcD8DDIxwuFFA7w3pnAhGqoS4VZrwS/mqQryOVVekqO6vNeqVcLg
JR7UmSRx82hpDsE/lYBlHKq3lBSGpDktC/5D4gTHB4TWKjAl6ce76WhC+HIr59EQ
0kYVyPfPA3I7wdU+jdC2dbtEceivLZ0ZrSZFo/wyXESzjObtuxo=
=lEmE
-----END PGP SIGNATURE-----

--F2LPCrIxsCuTdClcbtKESDwnnlIJe2mpx--

