References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
 <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
 <CAKuzo_gQaniVbD2QuEBb1x+xe8wULUjJkhXMWocyxi=oDknz0w@...278...>
 <66f25180-945c-1dc9-a5ca-62d3cacdff2c@...2080...>
 <87b2c993-9711-a7f5-fb3f-d3e2a26da610@...2181...>
 <3bb917b3-3ed2-8097-49ff-1aebca097561@...2080...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <a926945a-3fcc-ef92-f98b-e7e0c87666ab@...2181...>
Date: Thu, 8 Feb 2018 20:26:09 +0800
MIME-Version: 1.0
In-Reply-To: <3bb917b3-3ed2-8097-49ff-1aebca097561@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rbddjCDkj3SZjl1aN3doyd8DVgkCVnETk"
Subject: Re: [Openvpn-devel] [Openvpn-users] "Reconnect" button in
 openvpn-gui
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, Selva Nair <selva.nair@...277...>
Cc: "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rbddjCDkj3SZjl1aN3doyd8DVgkCVnETk
Content-Type: multipart/mixed; boundary="t8FLWr2Fd4Y89HOiAWxrh3jgNOyH7K785";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: openvpn-devel@lists.sourceforge.net, Selva Nair <selva.nair@...277...>
Cc: "openvpn users list (openvpn-users@lists.sourceforge.net)"
 <openvpn-users@lists.sourceforge.net>
Message-ID: <a926945a-3fcc-ef92-f98b-e7e0c87666ab@...2181...>
Subject: Re: [Openvpn-devel] [Openvpn-users] "Reconnect" button in openvpn-gui
References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
 <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
 <CAKuzo_gQaniVbD2QuEBb1x+xe8wULUjJkhXMWocyxi=oDknz0w@...278...>
 <66f25180-945c-1dc9-a5ca-62d3cacdff2c@...2080...>
 <87b2c993-9711-a7f5-fb3f-d3e2a26da610@...2181...>
 <3bb917b3-3ed2-8097-49ff-1aebca097561@...2080...>
In-Reply-To: <3bb917b3-3ed2-8097-49ff-1aebca097561@...2080...>

--t8FLWr2Fd4Y89HOiAWxrh3jgNOyH7K785
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 08/02/18 20:20, David Sommerseth wrote:
>> This way we still save all those setups where the token survives fast
>> reconenctions on the server side
>=20
> This sounds reasonable to me.  But it is crucial that it is a proper
> re-connect - meaning, if UDP the "--explicit-exit-notify" message must be=
 sent
> to the server to close the session on the server side.  Otherwise you'll =
get
> into some odd back-and-forth until the session is fully closed on the ser=
ver.

I thought that the new CLIENT_HARD_RESET packet would still clear the
client session on the server.

No matter if we did send an exit-notify or not.


Cheers,


--=20
Antonio Quartulli


--t8FLWr2Fd4Y89HOiAWxrh3jgNOyH7K785--

--rbddjCDkj3SZjl1aN3doyd8DVgkCVnETk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlp8QeEACgkQB6U8WA7y
zXQiwhAAh3Ula1O56hLduMuPLH+k2WSN0idJEBIcHElGmRIgwuYe1iUfFVtAbuEs
DFb63ekOdu5JCUsd0xeTq9bJhRdKE7rcnaEfdId9I4oZIuSrtrSzLyORxb8kaMLV
FoiSG+IIA+WjuTRHCLNhjdnjl3+gq37FlUdU/9qxbWt/5DnlTPBMHhmfYss+CE1l
9nTbNTAUwLiuOh8NmDMZvKuDGtGn6IZNjfDslahCHOQokgYnKxWOZq1i/wKJaaOt
uV6830IbrojkVtBXw8pJAUK/oLdaB+XC2cjmcHtJa/abttsKwTT324MZBuCMbim9
iWZEv3Nft+OuaM/3tCz4+dFoMz4Chd1XDlBuVZwUuyzVnX+uCJ/d7rlIFleKJ8ZZ
S5rZivzEFt8aaHcSfRpUs18XD287CVs0zrhH+7z0aKmtGQYKZ8d4BFE9JqcRuvHi
+JMvSHDli0G2IEHhrbe0Q1dqlXq5s7VAokYjzTeyMt8Bqrxrq+2Zb4falBhLOmJs
UzIUycieMaZYb3JOKuGEvCaBZPpeOfh9t+zunhE4Vp5abU2XTBsOLBVrXWLJxX1K
+1jm1vpdrMJEDX9ejpftxHmH+8bmzKWHvHp7ktKdF0K0fuEOqRHbsC8ugCM/bddp
iBPaXQePtbXVr29S2f9uj2sGGoIsj5iiEel4WxwhStdWvf+Sev8=
=XS64
-----END PGP SIGNATURE-----

--rbddjCDkj3SZjl1aN3doyd8DVgkCVnETk--

