References: <20171202162453.29838-1-a@...2181...>
 <20171202162453.29838-2-a@...2181...>
 <df3fcdd1-7d42-0de5-c8c1-568f297381f4@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <2e39cd09-fbf6-18b3-c559-c7200e99043c@...2181...>
Date: Sun, 3 Dec 2017 00:49:23 +0800
MIME-Version: 1.0
In-Reply-To: <df3fcdd1-7d42-0de5-c8c1-568f297381f4@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GBl6DW2Xm7at6QSS2UR8Ouji38wbEcI2p"
Subject: Re: [Openvpn-devel] [PATCH 2/2] PF: never drop essential ICMPv6
 packets
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
--GBl6DW2Xm7at6QSS2UR8Ouji38wbEcI2p
Content-Type: multipart/mixed; boundary="d3jK5KcMFDvRGiq5bkOGAod8lCurpfO4M";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Arne Schwabe <arne@...1227...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <2e39cd09-fbf6-18b3-c559-c7200e99043c@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] PF: never drop essential ICMPv6
 packets
References: <20171202162453.29838-1-a@...2181...>
 <20171202162453.29838-2-a@...2181...>
 <df3fcdd1-7d42-0de5-c8c1-568f297381f4@...1227...>
In-Reply-To: <df3fcdd1-7d42-0de5-c8c1-568f297381f4@...1227...>

--d3jK5KcMFDvRGiq5bkOGAod8lCurpfO4M
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 03/12/17 00:47, Arne Schwabe wrote:
> Am 02.12.17 um 17:24 schrieb Antonio Quartulli:
>> Some ICMPv6 packets can't be dropped otherwise the entire
>> overlaying network layer (IPv6) would just stop working.
>>
>> Such packets are described in RFC4890, sec. 4.4.1.
>>
>> Improve the mroute packet parsing routine in order to detect
>> these specific packets types and thus avoid PF to drop them.
>>
>> This way, when PF is enabled, the user won't need to whitelist
>> any specific multicats IPv6 address. PF will just work as
>> expected.
>=20
>  (&b);
>> +
>> +    switch (type)
>> +    {
>> +        /*
>> +         * By following the guideline of RFC4890, sec. 4.4.1, the
>> +         * following are the ICMPv6 packet types that are strictly
>> +         * required to let a host join a IPv6 network.
>> +         * Therefore, such packets can't be dropped by PF.
>> +         */
>> +        case OPENVPN_ND_ROUTER_SOLICIT:
>> +        case OPENVPN_ND_ROUTER_ADVERT:
>> +        case OPENVPN_ND_NEIGHBOR_SOLICIT:
>> +        case OPENVPN_ND_NEIGHBOR_ADVERT:
>> +        case OPENVPN_ND_INVERSE_SOLICIT:
>> +        case OPENVPN_ND_INVERSE_ADVERT:
>> +            return true;
>> +    }
>> +    return false;
>> +}
>=20
>=20
> I think we should still drop tehse if they do not target the local
> network. Otherwise you can just send all information hidden in these
> packet types.

You mean dropping packets not a having link-local address as destination
(for unicasts)?

Cheers,

--=20
Antonio Quartulli


--d3jK5KcMFDvRGiq5bkOGAod8lCurpfO4M--

--GBl6DW2Xm7at6QSS2UR8Ouji38wbEcI2p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAloi2ZMACgkQB6U8WA7y
zXSmwA/9FJs9zDBA5fD9xpNT5MY6Xvhkw5S9oH9y5Dixwq30nMY8Nh5QeezHiH3V
pDtB41ZtIAb1bxjwa8naOWCYuqBouhCFXy1ZmM6JS0euH97ZSD0Fg9yQa5fGLTDb
UNdC9GcVmqp/DDzZqFUl3Y5d9yyAOGsZqgFM/zOQF1/HgknA7TULqm4iy0mOwuRK
q4uZPcfKhGYLewLvKvc5sJTAquzV+qTSHPMeJJNdaIg3eKAK6Iq5Ck7ItrdinoFr
9SLt3IDDXnTz8uvA2bS6kbAXlSv1409U7+MWhqKx1+2ccvMDpuGMEM8atwOzqWMp
MrVSJlSISWDTBIanKN5MLZQGHKz22ZwwXCZf+dG3lEPqoWVFrBeMuLvhcVGxIRw9
izairS6bkYSWmqtjsAXwInbP1Q4bJuEcig689Od9/P3N4alQEDaNjrmyVv6eGioJ
/y0mT2hEvd3CzWrWb2RqkmqVtVTZ96sKmYdtv0euguniDx97tqgUf5I5qlFXGIih
GOfbfGXION+vqQxaao5astBXZZGy8jg7oa3BdsX9qWmi9S6y/Whw2hF3Kr1Xon+t
gnyKMTZmNxUw88kCyQASLuEwpQfdNLisYkM1u9AdPfhFaUIPJRiDEw/Cxwoxfm2Q
KjcInW681CLr76JOse6xO843XCIuJQG9vqyZi31nk6sEjMuglak=
=L2VX
-----END PGP SIGNATURE-----

--GBl6DW2Xm7at6QSS2UR8Ouji38wbEcI2p--

