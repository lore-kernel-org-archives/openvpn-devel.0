References: <20180608052017.6696-1-a@...2181...>
 <20180613141213.5962-1-a@...2181...> <20180620155301.GY57262@...1296...>
 <c416ea67-e4ce-148b-eb19-6d18b35da559@...2181...>
 <20180622094635.GI57262@...1296...>
 <d496bbf5-3c55-f2d9-2ab2-bc89ded80131@...2181...>
 <CAKuzo_jDrcGjQeMaVm3X6yzgKBZecbYHfAAxxCFAuycagTe22Q@...278...>
 <20180622182709.GO57262@...1296...>
 <8117ab50-c3d1-2210-6665-9ea86b7110ac@...2181...>
 <CAKuzo_je1ZsOoTeaUdFxnP1JDMM1Op5TP-p=xA85SLn0pPCSGQ@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <5fe13344-8e3c-3283-3217-c64f4ef234c5@...2181...>
Date: Sat, 23 Jun 2018 11:13:07 +0800
MIME-Version: 1.0
In-Reply-To: <CAKuzo_je1ZsOoTeaUdFxnP1JDMM1Op5TP-p=xA85SLn0pPCSGQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="C8IB94osrYfG8pASOqqAKwsWng52lNvcJ"
Subject: Re: [Openvpn-devel] [PATCH v3 2/8] windows: properly configure TAP
 driver when no IPv4 is configured
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C8IB94osrYfG8pASOqqAKwsWng52lNvcJ
Content-Type: multipart/mixed; boundary="e50yaoCxQnihsMuGxM4ZxMYe0G9i8Kjli";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <5fe13344-8e3c-3283-3217-c64f4ef234c5@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/8] windows: properly configure TAP
 driver when no IPv4 is configured
References: <20180608052017.6696-1-a@...2181...>
 <20180613141213.5962-1-a@...2181...> <20180620155301.GY57262@...1296...>
 <c416ea67-e4ce-148b-eb19-6d18b35da559@...2181...>
 <20180622094635.GI57262@...1296...>
 <d496bbf5-3c55-f2d9-2ab2-bc89ded80131@...2181...>
 <CAKuzo_jDrcGjQeMaVm3X6yzgKBZecbYHfAAxxCFAuycagTe22Q@...278...>
 <20180622182709.GO57262@...1296...>
 <8117ab50-c3d1-2210-6665-9ea86b7110ac@...2181...>
 <CAKuzo_je1ZsOoTeaUdFxnP1JDMM1Op5TP-p=xA85SLn0pPCSGQ@...278...>
In-Reply-To: <CAKuzo_je1ZsOoTeaUdFxnP1JDMM1Op5TP-p=xA85SLn0pPCSGQ@...278...>

--e50yaoCxQnihsMuGxM4ZxMYe0G9i8Kjli
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 23/06/18 11:09, Selva Nair wrote:
>> My guts say that the issue might be related to "gateway-redirect",
>> because only 8/8 makes sure that no logic is activated for IPv4 and
>> without that patch there might be some IPv4 route being installed
>> nonetheless.
>=20
> Very likely. It would be nice to find the on-link route that triggers tha=
t code
> path to ensure it doesn't cause any other issues.

My server was on the same LAN (connecting via v4) as the client - should
that be considered on-link? maybe this is what triggers that code path.

>=20
> But not very critical as the assert is fixed and route errors are not FAT=
AL.
>=20

If you like the argv patch v2, would you mind giving your blessing? :-)

Thanks!
Cheers,

>=20

--=20
Antonio Quartulli


--e50yaoCxQnihsMuGxM4ZxMYe0G9i8Kjli--

--C8IB94osrYfG8pASOqqAKwsWng52lNvcJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlstusMACgkQB6U8WA7y
zXTc8Q//TwKhWQwrjpn0aJCPBqJ/3lJZkCxWxRBu0ex7ODtOuJJk//XXKP+yavQe
s5+xkqYh5MGLNZbWTtrW0ic6kcYc/JDyJjOS81Og6dpXIU7K8iCGN2PF5AIj5xe/
nFA5/7pwlSSmdLbTc48FjA9m2MgXQBhhiGNMbVvprVCA46p3k+BKFjhpTDe2pu6G
lo4Nwb65gDYEAVs+BEvJIDOPo5g2GQf4pigEweP03jl4nCnxeEyRBmXPfYJJwKzo
SiSZFnOF1dFGqeZLramjDeYlsGl4wdDrsNpnklqJkoJqsb8hFKCQk37kbsZu2T2k
4MgZOXxcTwdHTzBZ0VvyTMLrbnRMHi8OwReg+RlpWebffhiQl7lDF3HLFyYC7YTb
JVBTI2hGCkFtTykEM+fgCDnK3fZRB++QcVhXvCMfi4N/dDA+eFLe9sTYw8OgEOdd
WdQ10ExTqbqaGyDe4maNzWPuXcS7LIaTJaWXn/JGK45plxZKgogg2gCohBkCTEyt
qmtL4GmV8blFcHlLvLdTLIzPqD+RA0eYgz/okACkpnDEuAdRtqevcpKBQLuntxpv
0vlazwvt2sMkEmGey+2AaIyDeG8GBIiWokATmTHqpaLg3Ez8qZGxxknSnt/Kd7bc
MtS7UmaK88wRMsJTS++9j90gQhVZG5uwfIyAkBxwSp0JtM8U3is=
=tKv1
-----END PGP SIGNATURE-----

--C8IB94osrYfG8pASOqqAKwsWng52lNvcJ--

