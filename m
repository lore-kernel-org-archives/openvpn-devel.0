From: Antonio Quartulli <a@...2181...>
References: <20170707044704.7239-1-a@...2181...>
Message-ID: <3cb90709-9fdb-e9f1-dabe-ad3f8663bcd6@...2181...>
Date: Fri, 07 Jul 2017 09:53:00 +0000
MIME-Version: 1.0
In-Reply-To: <20170707044704.7239-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="nNKq4IUlCfo613xfXCTLCpsq82fpl0DuB"
Subject: Re: [Openvpn-devel] [PATCH] crypto: create function to initialize
 encrypt and decrypt key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nNKq4IUlCfo613xfXCTLCpsq82fpl0DuB
Content-Type: multipart/mixed; boundary="qQr8KfMcDpFKUvccOVvc7gvwBlLxfHdQq";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <3cb90709-9fdb-e9f1-dabe-ad3f8663bcd6@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] crypto: create function to initialize
 encrypt and decrypt key
References: <20170707044704.7239-1-a@...2181...>
In-Reply-To: <20170707044704.7239-1-a@...2181...>

--qQr8KfMcDpFKUvccOVvc7gvwBlLxfHdQq
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



Antonio Quartulli:
> From: Steffan Karger <steffan@...1856...>
>=20
> Instead of always initialize the encrypt and decrypt keys separately,
> implement an helper function init_key_ctx_bi() that takes care of
> both of them for us.
>=20
> Reduces code duplication and improves readability.
>=20
> Acked-by: Antonio Quartulli <antonio@...515...>
> Signed-off-by: Steffan Karger <steffan@...1856...>

I have to retreat my ACK. This patch is generating some new warnings
that have to be fixed before being considered for merging.

Cheers,

--=20
Antonio Quartulli


--qQr8KfMcDpFKUvccOVvc7gvwBlLxfHdQq--

--nNKq4IUlCfo613xfXCTLCpsq82fpl0DuB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAllfWg4ACgkQ0+HICM1s
oFA7Qw//UXEtoxvbYXHxT8JzMJ7f8p1dy1WlcgnJ5jqbURyWOAQ15qJIDCNdhNIW
ghTVojdzOGq/nAvmGjxdbFq8t67f26IXIugm4q2Ccj766zB7vptrNE6R/QhU7ocZ
ruH3YlRdlkmKnNcm23Kb+312FH03PCUeVP/zHGFaPy6sQQWXEEqLCOs9vZDMREN8
3reotTzUrlhRlqKXq1iJBTP1+pzxDdahPPInYWOn8CvIOLtzZJLGcII12o1z8mVh
p63GHnggCoTkVV0P3i1HstDrelg5rfIJcdj9vr8DshsG31+aII11VJEng50OoNRe
nH91XUIOzSqvZ1XbKCTXkhwACgT4lxe3dDtGxwYCwuch4n+BUzEiOLLO3/ATCJgK
tapHz54O3YHJ+TAF1RnD7QDrKe0fFJUVvsTwUUYSu62OYXdmB1srNCiPecdA4p0w
NZ7UUUin6Qxg7e4s/YxCG/5mjOLCyaylJbpADwTzIrAqhaGMOfqyLzSV+WYqzrFM
H/F05tVc6AKVNfPXmSlIWVoJnAUo+CmwyDRvLhXgn7xd6V+79fhTGpGuGSdHgfFt
X5O2nkw9kC5EIM5ouQhXzs21Q7YCN3Sl8c7Rzb4YQUdid76gD7P6+GEnbsMGAc4A
OzGfydyRc12EN8AheelEapVTX7jxDjn8QwBCakac03zqe/CvL+c=
=BYZh
-----END PGP SIGNATURE-----

--nNKq4IUlCfo613xfXCTLCpsq82fpl0DuB--

