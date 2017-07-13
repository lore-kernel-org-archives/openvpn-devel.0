References: <20170713033848.11902-1-a@...2181...>
	<CAFHpkQG_gS9cZdfTDAJGHwApPzgpbCFS6923ysqjU6_AAaG7xQ@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <a5f62ded-89be-7115-3f31-b4ee199bdad8@...2181...>
Date: Thu, 13 Jul 2017 14:05:50 +0800
MIME-Version: 1.0
In-Reply-To: <CAFHpkQG_gS9cZdfTDAJGHwApPzgpbCFS6923ysqjU6_AAaG7xQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="stO4Rvq8ocisnpC1d04HETx42TGmbQVGK"
Subject: Re: [Openvpn-devel] [PATCH] fix compilation for --disable-multi
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net, ValdikSS <valdikss@...277...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--stO4Rvq8ocisnpC1d04HETx42TGmbQVGK
Content-Type: multipart/mixed; boundary="MNP2kEGhrl8H9fhJCkwQHisT0WENQJVA3";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net, ValdikSS <valdikss@...277...>
Message-ID: <a5f62ded-89be-7115-3f31-b4ee199bdad8@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] fix compilation for --disable-multi
References: <20170713033848.11902-1-a@...2181...>
 <CAFHpkQG_gS9cZdfTDAJGHwApPzgpbCFS6923ysqjU6_AAaG7xQ@...278...>
In-Reply-To: <CAFHpkQG_gS9cZdfTDAJGHwApPzgpbCFS6923ysqjU6_AAaG7xQ@...278...>

--MNP2kEGhrl8H9fhJCkwQHisT0WENQJVA3
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 13/07/17 14:02, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
> Should we add --disable-multi to some travis-ci build ?

Might be a good idea. It was actually broken since 2013, therefore it
seems like not many people are using it....either we drop it or yes, we
should have some automated test.

Cheers,


--=20
Antonio Quartulli


--MNP2kEGhrl8H9fhJCkwQHisT0WENQJVA3--

--stO4Rvq8ocisnpC1d04HETx42TGmbQVGK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAllnDcEACgkQ0+HICM1s
oFCVrBAAiZr/ICf8ZwOHvgaSqvmULjpeb7IAHy5czcwMcpSXIx5mIYAI3Qx+eJd2
NjfzChA6UEHyGI9ms2j7YTwCL9m6QuDl/2TIRCDdOFWWWUouV6cBHRiV1Npz0smz
alHUlFWOmC2jjDZ3rc7Iw+7GOin53DoEfUW4F2/ZDKx/majKPwtFZKQGJ5QNRH54
/Bi/BzPd+5Z6ADNpt7XZVXszg93+PY2FSjXDq4HyDlBcPokylW2QHBKNePWo4trv
vCi4Tt7/Ir9YwAGmqTEIXLcWwzgzIyn2AQ9cJaK+aq7MNMOii10whQrrgGL7eMd5
t7kzyA0lQa/aTCzzmz9NKCmzoNcux6cgNawK0p6QineJgH516Z1P5yFfZPDkdZBJ
XX4LsgPYSVQIWDf8W/bqxDCHRjFUsreEATdTGrD4ytyzWb8HLFGLGAlXH64hWM4V
vWudS4kgrn0DtUVhPO0MRpN9UV4H1/9qFKmYAWbKvIVBBZLa5Z728tExfycuO5Nt
PE9wkWVSv0ihoI734Wqp82slyG/o1SSIiVaNT9TEFAAtTh7zhWTVHS58cjs1Jopa
GPOs+e7SurZ1Eh6jRTY+B1ZSshdF8RPCcfvYMLOGkM1xyqTpYkxr8xWESA1GKcKb
qwfCIU7MDOSRXM/I9rmcQCvkDuvyHDbYWHi9zxRUcZsn7fpkvJE=
=E4te
-----END PGP SIGNATURE-----

--stO4Rvq8ocisnpC1d04HETx42TGmbQVGK--

