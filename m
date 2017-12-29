Reply-To: openvpn-devel@lists.sourceforge.net
References: <1514540857-19290-1-git-send-email-steffan.karger@...1435...>
 <CAFHpkQG56wpZzN2KD3BYmcSDFFLi8Jpq0e-ZN-=9yJH4VWybiQ@...278...>
 <f6271a6e-0a17-a678-05c8-9b3b7912766d@...1435...>
 <5d048ecc-a9db-b448-71e7-ec874b5fb15f@...2181...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ffa065ae-0078-3271-1300-00594cbe3b52@...2080...>
Date: Fri, 29 Dec 2017 22:14:26 +0100
MIME-Version: 1.0
In-Reply-To: <5d048ecc-a9db-b448-71e7-ec874b5fb15f@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="GW38ymH105SBIl2FckJsBDH90rNyg5zyB"
Subject: Re: [Openvpn-devel] --with-mem-check, what to do with it?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, Steffan Karger <steffan.karger@...1435...>, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GW38ymH105SBIl2FckJsBDH90rNyg5zyB
Content-Type: multipart/mixed; boundary="uwvnD75ht43ITPX5phFkQ6DYpPfhj7BJB";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Antonio Quartulli <a@...2181...>,
 Steffan Karger <steffan.karger@...1435...>,
 =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <ffa065ae-0078-3271-1300-00594cbe3b52@...2080...>
Subject: Re: [Openvpn-devel] --with-mem-check, what to do with it?
References: <1514540857-19290-1-git-send-email-steffan.karger@...1435...>
 <CAFHpkQG56wpZzN2KD3BYmcSDFFLi8Jpq0e-ZN-=9yJH4VWybiQ@...278...>
 <f6271a6e-0a17-a678-05c8-9b3b7912766d@...1435...>
 <5d048ecc-a9db-b448-71e7-ec874b5fb15f@...2181...>
In-Reply-To: <5d048ecc-a9db-b448-71e7-ec874b5fb15f@...2181...>

--uwvnD75ht43ITPX5phFkQ6DYpPfhj7BJB
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 29/12/17 12:02, Antonio Quartulli wrote:
> Hi,
>=20
> On 29/12/17 18:23, Steffan Karger wrote:
>> Hi,
>>
>> On 29-12-17 11:11, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
>>> thank for the patch.
>>>
>>> not directly related to the patch itself, but openvpn is shipped with
>>> several memory debugging options
>>>
>>> --with-mem-check=3DTYPE=C2=A0=C2=A0 build with debug memory checking
>>>
>>>
>>> should we get rid of them (in favour of sanitizers) ? or, maybe add to
>>> tests instead ?
>>
>> I've tried to use those in the past, but found them hard to use.  I
>> think they're a remnant of the past.  I would personally prefer to get
>> rid of them and use the (nowadays much better) fully external memory
>> checking tools instead (sanitizers, valgrind, etc).
>=20
> As Selva pointed out, we don't use --with-mem-check in any test,
> therefore I am not even sure it still works as expected.
>=20
> I am also in favour in of getting rid of our custom made check and use
> compilers provided sanitizers instead (also gcc provides interesting
> sanitizers, thus everybody should be bale to enable them).
>=20
When compiling with --with-mem-check=3Dvalgrind ... a lot of the noise from
OpenSSL (and other external issues) vanishes when running OpenVPN via
valgrind.  So I find that feature very useful.  It's really handy to use th=
is
approach when checking for memory leaks in plug-ins.

There might be better checks, granted.  But not sure how well they will play
with plug-ins.  The valgrind type works fine.  Not sure how well the other
--with-mem-check alternatives (dmalloc, ssl) works, so can't speak for them.
If they don't build or work, then we should consider to remove what doesn't=
 work.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--uwvnD75ht43ITPX5phFkQ6DYpPfhj7BJB--

--GW38ymH105SBIl2FckJsBDH90rNyg5zyB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJaRrA3AAoJEIbPlEyWcf3yeykQAKf3jEeAaASjVTipRMJnsHWd
rSjggeokT/KCvI6ShGYXUn+csglcjA2pQeZAFF8/LeHVrlMGgzFv8CYheJBBukvs
4rbw14IR/PbkO2lFbf78BJFJgKcrAjqKZCIxT0UonP8cEQBbu3MB7S9ecF7NptkL
2VSOxziO/6dNJ/h3vlt/WvM9HIqhCoXnuUPTGY7fHBi3/alpwjjrDC1cMosLL5JZ
NgOC6Dgb4bFoivhHs5vFaxi31NTwxokYxTclLkAneY4x4gI05J9LNE56yn5duly5
JX3PsqRKPLDXAnZMt2qUhUnyeipoNdkyELEbF2zRBkBPuTkE2GGFS2rOL4vRKeXq
baILCNOTNF15svfbH+QZNB+1Rz9xf5xs5WkbvilsXDwFb6NcFCfE6kNEI2NIWdmg
JqnqUgpykCPhFWOStQg7c0GNQfs5wrjkIjzHC5zO1PrRb59MU2hNXQJjueaditwB
2FSo4Ekx+B7eTBtwb52Vny5xCU5RtMwrYNppZ4FMDcYZK8FwY7lmqpqAtUpC0WYa
5x5Ufh3x1fj5I6BxMJKe37FKfZYzWmEG/M3QJGK4Zh9ttPLRbfATvuxxLv4S5fcs
QzGdxaQx5k2AgMff+QNMM0MfHFjQy9hRY0WWY/QYwTrvy/Mh8l0rIuRfSrVrt6eS
o7Z+NW9+WDWQ8d/myoJE
=+tRc
-----END PGP SIGNATURE-----

--GW38ymH105SBIl2FckJsBDH90rNyg5zyB--

