References: <e79eb6bd-87bb-a8f7-eda6-e65b33addd24@...277...>
	<0440d93b-6ded-9efc-8fba-838b4e954261@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <a4da2c12-b6ba-08c8-9de3-4ef127aafe3e@...2080...>
Date: Wed, 22 Mar 2017 14:11:56 +0100
MIME-Version: 1.0
In-Reply-To: <0440d93b-6ded-9efc-8fba-838b4e954261@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s3IoFRQ9kTlT3M3qKxq1IHwDkEi5WA18s"
Subject: Re: [Openvpn-devel] Consider git tags for I60x
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, debbie10t <debbie10t@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s3IoFRQ9kTlT3M3qKxq1IHwDkEi5WA18s
Content-Type: multipart/mixed; boundary="C2gm02OH8N4P7xH4QcnXjpKp64tv95Gjw";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
	debbie10t <debbie10t@...277...>, "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Message-ID: <a4da2c12-b6ba-08c8-9de3-4ef127aafe3e@...2080...>
Subject: Re: [Openvpn-devel] Consider git tags for I60x
References: <e79eb6bd-87bb-a8f7-eda6-e65b33addd24@...277...>
	<0440d93b-6ded-9efc-8fba-838b4e954261@...515...>
In-Reply-To: <0440d93b-6ded-9efc-8fba-838b4e954261@...515...>

--C2gm02OH8N4P7xH4QcnXjpKp64tv95Gjw
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 22/03/17 10:07, Samuli Sepp=E4nen wrote:
> On 20/03/2017 17:13, debbie10t wrote:
>> Hi
>>
>> just so this does not get forgotten about:
>>
>>   @dazo | slypknot: https://github.com/OpenVPN/openvpn-build
>>   @dazo | I see that there are no tags with the I60x indicator ...
>>           that could probably be something mattock should consider to add
>> @cron2 | true
>>
>> Regards
>>
>=20
> For openvpn-build I have not added release tags, as the commit message
> usually contains the necessary information. For example:
>=20
> ---
>=20
> commit 23d42200f282d2fcdc57bd4262d1fffc0832c7ff
> Author: Samuli Sepp=E4nen <samuli@...515...>
> Date:   Tue Dec 27 12:31:39 2016 +0000
>=20
>     Update build parameters to match openvpn-install-2.4.0
>=20
>     Signed-off-by: Samuli Sepp=E4nen <samuli@...515...>
>=20
> ---
>=20
> Adding a tag per installer release is not a big deal, though, if we have
> a use-case for it.

Currently we do not have anything providing a guaranteed match between
openvpn-install-2.x.y-I60z and a particular git commit.  This helps
understanding what a release really contains, especially if you have
more commits in a release.  Then you just do:

   $ git shortlog v2.4.0-I601..v2.4.0-I602

Another aspect is when you do signed commits (git tag -s), then the tag
is "cryptographically bound" to a particular git commit.  That is
incredibly hard to manipulate.  If the branch itself is modified the
committish will change, thus there will be a mismatch between the branch
committis and the commit the tag points at.  In fact, if you do a git
checkout using the tag name, you will most likely get the correct commit
checked out and not the manipulated one.

Of course, the git commits can also be hardened a bit further by using
signed commits (git commit -S).


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--C2gm02OH8N4P7xH4QcnXjpKp64tv95Gjw--

--s3IoFRQ9kTlT3M3qKxq1IHwDkEi5WA18s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY0ngcAAoJEIbPlEyWcf3y7y0QAMg/1aaDlSygGbwY3Zna1kL+
LLNcCqm9ARkX23InXnevk89zIJ3ok0HgfesNvowI2sf9nUsm/KR0nMh5GIzcPx2T
u6tlIFWh9vrXWrKt0TxQeJeLiqnyRKZ2jy3UFryGSI7d8UUZXe8Up5nut58WQBsq
JJzIXTWyP7BIVV4cWpNs2FN0F+NG5m3Amciy6pkB7rpw9WBG7XSHq4wdOF2gXMGb
GjlCf/9zBYeV8uGchYKThCp70EVcZB+zHGo/q0KPZP6M7EorPminx4MLZEBVdcR6
kSb65rd862lNN9by+8FqihsE/Sjb0biYFA2C7+zZ4qDvDQnYTuekfNyW4pA1yEuK
x2QGwYdrhCafSshSubspsy1xyQHy2aCuGS+XTCPHQBSAsRGE5dboaIMR8P2itzgt
XoSKpaoV3phTgd1uAVwXPQb9kcw/+PuvamugM3aZ+vWQQ3F/ff7iMPlxGzqmhBT4
ySEWXYyt97mN4XJuaSY9cvykX4wz0J/MxDnF9H0ug8nV2AwgY8qg2z62yJymeaJE
2KP3tX8UM6DQOnWyrEgPKbNOshEVDpqYP0vTylwzUw29mnf5eihU80cksnwkJ/2u
MrU+rXm635MJ8jsV4CFLuIzgzAvg5kdQZLD8tubFGh2vD80dsZ5IdY0wIsDE78sl
GtGkQvdaIgQjzT3lf4s1
=pbC6
-----END PGP SIGNATURE-----

--s3IoFRQ9kTlT3M3qKxq1IHwDkEi5WA18s--

