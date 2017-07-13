References: <20170713033848.11902-1-a@...2181...>
	<CAFHpkQG_gS9cZdfTDAJGHwApPzgpbCFS6923ysqjU6_AAaG7xQ@...278...>
	<a5f62ded-89be-7115-3f31-b4ee199bdad8@...2181...>
	<2de72e2e-5ccc-992f-505a-41cd00140844@...515...>
	<CAFHpkQHMUtx3ztQ5y6zAnPbPH4Gnf6kfwSJ6aatdOcxFdB219w@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <17692092-d40d-72cb-381e-98177668250d@...2181...>
Date: Thu, 13 Jul 2017 14:45:17 +0800
MIME-Version: 1.0
In-Reply-To: <CAFHpkQHMUtx3ztQ5y6zAnPbPH4Gnf6kfwSJ6aatdOcxFdB219w@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CuxSdXokksQIBWk3x1cvWBgsNxADHslmb"
Subject: Re: [Openvpn-devel] [PATCH] fix compilation for --disable-multi
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Cc: ValdikSS <valdikss@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CuxSdXokksQIBWk3x1cvWBgsNxADHslmb
Content-Type: multipart/mixed; boundary="Pt4PUVXp4eCFrBSP4KRP4eFM2aKUkkkRB";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
 =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Cc: ValdikSS <valdikss@...277...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <17692092-d40d-72cb-381e-98177668250d@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] fix compilation for --disable-multi
References: <20170713033848.11902-1-a@...2181...>
 <CAFHpkQG_gS9cZdfTDAJGHwApPzgpbCFS6923ysqjU6_AAaG7xQ@...278...>
 <a5f62ded-89be-7115-3f31-b4ee199bdad8@...2181...>
 <2de72e2e-5ccc-992f-505a-41cd00140844@...515...>
 <CAFHpkQHMUtx3ztQ5y6zAnPbPH4Gnf6kfwSJ6aatdOcxFdB219w@...278...>
In-Reply-To: <CAFHpkQHMUtx3ztQ5y6zAnPbPH4Gnf6kfwSJ6aatdOcxFdB219w@...278...>

--Pt4PUVXp4eCFrBSP4KRP4eFM2aKUkkkRB
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 13/07/17 14:34, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
> 2017-07-13 11:16 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:
>=20
>> On 13/07/2017 09:05, Antonio Quartulli wrote:
>>> On 13/07/17 14:02, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
>>>> Should we add --disable-multi to some travis-ci build ?
>>>
>>> Might be a good idea. It was actually broken since 2013, therefore it
>>> seems like not many people are using it....either we drop it or yes, we
>>> should have some automated test.
>>
>> There were no bugs reports about --disable-multi in Trac. I say scrap
>> that option altogether and make the code slightly cleaner and less
>> entangled.
>>
>=20
>=20
> was it broken in 2.3 as well ?
> I'm afraid, not many people are using 2.4 since 2013

As reported in my patch, this is the commit that introduced the first
problem:

commit 598e03f0e7bce434e501a9895819f2af0714d5f6
Author: James Yonan <james@...515...>
Date:   Mon May 20 12:13:21 2013 +0200

    Always push basic set of peer info values to server.

Checking what tag contains this id, we get:

$ git tag --contains 598e03f0e7bce434e501a9895819f2af0714d5f6
892e64b6b9
v2.4.0
v2.4.1
v2.4.2
v2.4.3
v2.4_alpha1
v2.4_alpha2
v2.4_beta1
v2.4_beta2
v2.4_rc1
v2.4_rc2

However, if you check the release/2.3 branch, you will see that this
commit was cherry-picked manually and therefore it has a new id in the
2.3 history: eed9b8eec911a26a952f07ad18d4397c334ac089

Checking this commit ID shows that:

$ git tag --contains eed9b8eec911a26a952f07ad18d4397c334ac089
v2.3.10
v2.3.11
v2.3.12
v2.3.13
v2.3.14
v2.3.15
v2.3.16
v2.3.17
v2.3.2
v2.3.3
v2.3.4
v2.3.5
v2.3.6
v2.3.7
v2.3.8
v2.3.9


Hence, 2.3 is broken starting at v2.3.9. This is confirmed by the fact
that release/2.3 does not compile with --disable-multi.



Cheers,


p.s. this is an example of how cherry-picking instead of forward merging
can be troublesome for the git history.


Cheers=C2=B2,



--=20
Antonio Quartulli


--Pt4PUVXp4eCFrBSP4KRP4eFM2aKUkkkRB--

--CuxSdXokksQIBWk3x1cvWBgsNxADHslmb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAllnFv0ACgkQ0+HICM1s
oFAsHQ/9FsREyzOeNBXCyQhG56vmmV4Rr+s/1WQZNA/NNcC425f17WScyxjglykt
X2EUwt2lB7gss/ukSdLI+t1203AdogkhV21x/jh41qX67C7q9oN3VGfjAON2G3Gi
NXEiO77n3hK4ZDpIHDm/Ym0ZfxzM6/QoYoA9A0YZL7V5CCfHP584OUir1LGW/mbg
f2gI1Fxd+GdXJu1Po6/PjQBYzmxFJg3BD+pNo9Ydb5J8HJmoJxVGewnrJJszo5ev
AiHXU7HUtPtqruV9kJugsaavQ67eYRvIE/3uXXe4/jN5UHPvu/PlxXPNYo3vHEih
+VTahIpoE7ObNZ7bkJNRC8BBqOfKcdgQADHRM1tiP/gu73TFwbGJHk8veNyABGXe
vygTsLc98j+78Pkm58GLYOpewx3aISYbP7CbJ4ni/8FEX1ty4f8Dgp+gT2I/R/Ci
NtdGUoqMkdbhdU9E0rIhr9iiJWu/x/8X0JAHfwz/kXZmPQbd5pG2IuD7OJZju6yZ
paOUOVR61NCFOlSbgfyTlwQpItRnS6JFyBVNN1fiwwFdwRX55DJNZbJqLTD7hJce
qHVbi6a/9Pr2V+RS9uwE27zm2lqH1cGtySSo6Qh8Mo16IYm9pCdeE+OcQ94MiqU8
vByU4EsuQDXVNDLP/qBtexyqjon1bJEEAHkcMdfTB6aGS/FlfN8=
=+G7C
-----END PGP SIGNATURE-----

--CuxSdXokksQIBWk3x1cvWBgsNxADHslmb--

