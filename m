References: <20180622102110.21888-1-a@...2181...>
 <CAKuzo_iAnVU=6bar7a6TLXOjWqMuNjLhiznD9oPBnpyGC4sfTg@...278...>
 <5858f87b-165f-f390-6769-938e5a43ce55@...2181...>
 <CAKuzo_i_n01fsYhxoGMSTGox5qpwkmCC+-BNHQ5RTuoz8otmrw@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <5261f403-b138-59d4-be4f-a850e56b4b62@...2181...>
Date: Fri, 22 Jun 2018 23:39:42 +0800
MIME-Version: 1.0
In-Reply-To: <CAKuzo_i_n01fsYhxoGMSTGox5qpwkmCC+-BNHQ5RTuoz8otmrw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kHgrC4t5BCkSEumcCCBvI0i8dgg45s39p"
Subject: Re: [Openvpn-devel] [PATCH] route: fix format string passed to
 argv_printf
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kHgrC4t5BCkSEumcCCBvI0i8dgg45s39p
Content-Type: multipart/mixed; boundary="gIu02CawPQ04dqsHiVyhs1fVotDgptS8M";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <5261f403-b138-59d4-be4f-a850e56b4b62@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] route: fix format string passed to
 argv_printf
References: <20180622102110.21888-1-a@...2181...>
 <CAKuzo_iAnVU=6bar7a6TLXOjWqMuNjLhiznD9oPBnpyGC4sfTg@...278...>
 <5858f87b-165f-f390-6769-938e5a43ce55@...2181...>
 <CAKuzo_i_n01fsYhxoGMSTGox5qpwkmCC+-BNHQ5RTuoz8otmrw@...278...>
In-Reply-To: <CAKuzo_i_n01fsYhxoGMSTGox5qpwkmCC+-BNHQ5RTuoz8otmrw@...278...>

--gIu02CawPQ04dqsHiVyhs1fVotDgptS8M
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi

On 22/06/18 23:37, Selva Nair wrote:
>> Last opinion? :)
>>
>=20
> I prefer "%lu" and no cast and have been replacing %u by %lu elsewhere in
> the code given a chance.

You and Gert both replied at the same time with the same preference of
supporting %lu. And I think all the arguments are valid - that is just
the right thing in this case so we can avoid shortcut/forced casts.

Will send v2 with this change included.

Thanks all!

Cheers,

--=20
Antonio Quartulli


--gIu02CawPQ04dqsHiVyhs1fVotDgptS8M--

--kHgrC4t5BCkSEumcCCBvI0i8dgg45s39p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlstGD4ACgkQB6U8WA7y
zXTOrRAAjRh5ioRtCeAt6F1RpUg6dge5aWHl/MX605cQtBta6xCDJsm+DYxMFUW5
KYJhdyOiVOv/RQqRB7myUK1xGH6ASVk/xh2V6wIPzqnCyvXUYmliGhmrgQGZD5Tw
wF4Cic13oQiGRaqmkS4SzLMoyu6h4T5Ml2WfHRSlG5wj2t6ltYLhbxGsXeMeg3eU
TWLmGFkD5ulWmFwQLpoD+Wj9BYaAvfME1HumtF0OKe3m/J5neaekOaJjYAuvexvb
O/kC5buN0TXh2bRkYJMJHvHwpUhWsVBSXWCTZXAjNUVNGzEwEt/I760/wozapcrK
83S5tPg93R2AbjnRLWLcKPwTtg847Mvs0SWWyvSYaB51kBvFH5eCQ+qCXGAEDrKZ
Ep63KcoZAw1Xl51EH75FtzYzdlzs2aJUQKF/XN/5fTdBX0nQEh+V5DD5QhaGqLVo
RrOhn7cgYKnmft+cenBfMxx3uyRARYrg9eDgtTukMnKeJWKpMN0tG4DSsQKsQ0lB
Wketzn9weP3tUtq+MFZQZHFhO0/sVzZwygX3uwDhL8dcErN+nYydlr60L6UDAaU2
StP17e+5BH/FLsdGoD/CceV29IQwKAYmnGqZY8MWr2I+BiO364tti+h/znjgyKao
YhgaZGxAY4hqPOpWT+lzc12Ub8mzMrhHRmjIuHJO8U6lB+USF8k=
=eNg+
-----END PGP SIGNATURE-----

--kHgrC4t5BCkSEumcCCBvI0i8dgg45s39p--

