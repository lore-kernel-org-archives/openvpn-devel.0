From: Antonio Quartulli <a@...2181...>
References: <20170713033848.11902-1-a@...2181...>
	<CAFHpkQG_gS9cZdfTDAJGHwApPzgpbCFS6923ysqjU6_AAaG7xQ@...278...>
	<a5f62ded-89be-7115-3f31-b4ee199bdad8@...2181...>
	<2de72e2e-5ccc-992f-505a-41cd00140844@...515...>
	<CAFHpkQHMUtx3ztQ5y6zAnPbPH4Gnf6kfwSJ6aatdOcxFdB219w@...278...>
	<17692092-d40d-72cb-381e-98177668250d@...2181...>
Message-ID: <50bec2e7-9f29-d36f-72fe-3b1d45fb0150@...2181...>
Date: Thu, 13 Jul 2017 14:46:30 +0800
MIME-Version: 1.0
In-Reply-To: <17692092-d40d-72cb-381e-98177668250d@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rR9BCl2mfbVfrr0ROgVkegkkvS6b91VUg"
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
--rR9BCl2mfbVfrr0ROgVkegkkvS6b91VUg
Content-Type: multipart/mixed; boundary="R5XUPMbcDmVfaWDBgbffEJwckuVwkpR4D";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
 =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Cc: ValdikSS <valdikss@...277...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <50bec2e7-9f29-d36f-72fe-3b1d45fb0150@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] fix compilation for --disable-multi
References: <20170713033848.11902-1-a@...2181...>
 <CAFHpkQG_gS9cZdfTDAJGHwApPzgpbCFS6923ysqjU6_AAaG7xQ@...278...>
 <a5f62ded-89be-7115-3f31-b4ee199bdad8@...2181...>
 <2de72e2e-5ccc-992f-505a-41cd00140844@...515...>
 <CAFHpkQHMUtx3ztQ5y6zAnPbPH4Gnf6kfwSJ6aatdOcxFdB219w@...278...>
 <17692092-d40d-72cb-381e-98177668250d@...2181...>
In-Reply-To: <17692092-d40d-72cb-381e-98177668250d@...2181...>

--R5XUPMbcDmVfaWDBgbffEJwckuVwkpR4D
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 13/07/17 14:45, Antonio Quartulli wrote:
> $ git tag --contains eed9b8eec911a26a952f07ad18d4397c334ac089
> v2.3.10
> v2.3.11
> v2.3.12
> v2.3.13
> v2.3.14
> v2.3.15
> v2.3.16
> v2.3.17
> v2.3.2
> v2.3.3
> v2.3.4
> v2.3.5
> v2.3.6
> v2.3.7
> v2.3.8
> v2.3.9
>=20
>=20
> Hence, 2.3 is broken starting at v2.3.9. This is confirmed by the fact
> that release/2.3 does not compile with --disable-multi.
>=20

typ0: I meant starting at 2.3.2.

Cheers,

--=20
Antonio Quartulli


--R5XUPMbcDmVfaWDBgbffEJwckuVwkpR4D--

--rR9BCl2mfbVfrr0ROgVkegkkvS6b91VUg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAllnF0YACgkQ0+HICM1s
oFASZg//fmdl5KbTDtEQYgRLSMxQtWh0cpMFq3xiN9xytbvlKIa4g6qj3lC10h0G
mJB5CyVkekReREJPG+72tjXx2iX8b3xmtprdKOo1yph1BzmOj/jNTm7KS7ToLTEh
RIAw+Nd4W/KzKk/b4RzT4QhiWTNZ0sYSTsicHoq+MTmDfTFnwX6dykmuOIYZ5RRT
on/A1IMXx9yYWaq0eljpx7ZwKKKYZ2wRiMwQU2V31uIY5Xxj0QLPnHxuqyrAGxb3
fbxvFGDPlrOTEjB5qYl5wa6KawyK43uOZdMqE8ye+tbOdhfs6HLEAZ9sOPCsnKAw
Vp0cc3mLZ6VNNF1ca7Tt3wH613Dm6tng5qLjvnBkwNx/3TwmsFoy0J+yOd6o7qgn
hfEtV8EwLd0Xf6C0rvIqeOnXdqYUtuLl3zDZakEqi58spbE6COG1ktso9409qMBK
n94ESMV4eTmc3hG1EHfespLXLGRsQgGlTSK9RuL2anhcVde5mkLikCTUpzRzRCiS
h7vRwxtb6SCnmFjinTXPi4vqsR+lVSu/fijw5GpYYawHe29zV9vaa57XEdQLoXYs
3sfN4pFk19Sd+b24a/GmuvZ3otMDuqh+xKwUccNNQnE2BM4aS30hmfU1XOL6bQNl
ZyHK1/LENPeiFgbmYdJ6lk+k3rtE6SR+q9698aLulQdxHbaFKKA=
=rsZ/
-----END PGP SIGNATURE-----

--rR9BCl2mfbVfrr0ROgVkegkkvS6b91VUg--

