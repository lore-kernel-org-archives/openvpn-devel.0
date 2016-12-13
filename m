References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<CAKuzo_gH06N2yip+h-=Q_w1xpyP62d6v4-7=Bb2NK-=+ji6iKw@...278...>
	<943c0ce1-501c-df5a-fb47-53ab7a689d36@...2080...>
	<bfcaa197-893f-afba-7554-07edcde483a2@...2080...>
	<CAA1AbxLXh_AOuHFBt0Om=eDOLH-WHM_C6OnGgHLnO+iAYP7dEw@...278...>
	<CAKuzo_gH8UNruspCDOTeAa-wU9YsDB8nGGponvkCrVWnPR7SKw@...278...>
	<CAA1AbxJORM6ONqNNH7cA+Wy88_f1us=jvtTSXKzc4r5YbwtQcQ@...278...>
	<efc994a6-49bc-121b-3c47-503e6228d1ca@...2080...>
	<CAKuzo_hQyg2vQidGdkhOkn8jCSQKN3+uh-SL-uc8sfft_fFFeA@...278...>
	<a13638c6-23cf-520f-6b5b-d18da4a87d62@...1856...>
	<f4e2b0db-98e8-ea01-36cb-30f3cb86eab5@...2080...>
	<CAKuzo_jyGPFWyx+qZqwvtxpFqd-+V9=gmDV_z+-uoBbqCjOKvA@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <1a440998-18b1-5595-7393-fdae2a78e2ae@...2080...>
Date: Tue, 13 Dec 2016 22:15:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jyGPFWyx+qZqwvtxpFqd-+V9=gmDV_z+-uoBbqCjOKvA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="wvtwBTra6naTnG7I9ppFj5qIrDrJCm3v1"
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wvtwBTra6naTnG7I9ppFj5qIrDrJCm3v1
Content-Type: multipart/mixed; boundary="I6nU9K52TTFBRcmnaSolADaCqXJX8WBqU";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Message-ID: <1a440998-18b1-5595-7393-fdae2a78e2ae@...2080...>
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<CAKuzo_gH06N2yip+h-=Q_w1xpyP62d6v4-7=Bb2NK-=+ji6iKw@...278...>
	<943c0ce1-501c-df5a-fb47-53ab7a689d36@...2080...>
	<bfcaa197-893f-afba-7554-07edcde483a2@...2080...>
	<CAA1AbxLXh_AOuHFBt0Om=eDOLH-WHM_C6OnGgHLnO+iAYP7dEw@...278...>
	<CAKuzo_gH8UNruspCDOTeAa-wU9YsDB8nGGponvkCrVWnPR7SKw@...278...>
	<CAA1AbxJORM6ONqNNH7cA+Wy88_f1us=jvtTSXKzc4r5YbwtQcQ@...278...>
	<efc994a6-49bc-121b-3c47-503e6228d1ca@...2080...>
	<CAKuzo_hQyg2vQidGdkhOkn8jCSQKN3+uh-SL-uc8sfft_fFFeA@...278...>
	<a13638c6-23cf-520f-6b5b-d18da4a87d62@...1856...>
	<f4e2b0db-98e8-ea01-36cb-30f3cb86eab5@...2080...>
	<CAKuzo_jyGPFWyx+qZqwvtxpFqd-+V9=gmDV_z+-uoBbqCjOKvA@...278...>
In-Reply-To: <CAKuzo_jyGPFWyx+qZqwvtxpFqd-+V9=gmDV_z+-uoBbqCjOKvA@...278...>

--I6nU9K52TTFBRcmnaSolADaCqXJX8WBqU
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 13/12/16 22:05, Selva Nair wrote:
>=20
> On Tue, Dec 13, 2016 at 3:56 PM, David Sommerseth
> <openvpn@...2080...
> <mailto:openvpn@...2080...>> wrote:
>=20
>     Already at it.  Written a script to do everything in a consistent way,
>     added the cmt_cpp_to_c=3Dtrue (and sp_arith=3Dadd) ....=20
>=20
>=20
> As Steffan mentioned we do had decided against sp_arith =3D add, but
> please do use pos_bool =3D Lead.

Yes will do.

But to be honest, I think we will end up manually editing quite some
places where sp_arith would do it for us.  But decided is decided.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--I6nU9K52TTFBRcmnaSolADaCqXJX8WBqU--

--wvtwBTra6naTnG7I9ppFj5qIrDrJCm3v1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYUGTaAAoJEIbPlEyWcf3ysawQAJ6sSQjmb98WQw3RYptYI+I5
3gr1rFx90V4jLQ4C4FsIPaHZDf7MAC4EFbTAsAxo8TBS9iHEtk764Yi80hYGW+4B
ixMS7CU+SiP6Rhgmh0NFr5YsQNQ/sFo7GjP3q49K7VUtRSjtJ9Zde2Qaz/TgVnDt
dEgIXpckiGTd/BZPy1rkZyeIShN/SJXAK/gYtWBfX8usrLqQ5ozdMccTtOT9k1Sn
iVdSJJ46TgBtwkSgJhCklB15lJi/h2F55ZwJIMqbsUkGJ3mppnpYYCXzSZmzkuyJ
Df0N3xe3YLHI3x/j3/mEjplOOs1gT65P+2/OSKvQRiXsEA0r1ulkGy3bFNg33edL
IB37BX6RZNCi99CFtwwn6cy09bbzKYDov73nJwmx7xXDmSqJEzB3PXUNbmogXfXp
OStES/C8Br023ah6R5qWDSs3l0uxJHDiLQfKJQIe/17lp75hmxJZEHp8ranlbRkf
LjZHMQc9WnNSfgN6gaJo/Zy2n5sqa7dtSvsItH/RKKfnSAiIIIbksjXUoteZRo1w
BqJZvqp5jqkUE2KN5V2aEAAYrMVF2ImJXz/6wot4wrVPWsDs2f8Gp//AUCLDTca3
AXUEDDJurLlsjIhmQVjO4PpUap4a5ZDI83d2uoGVzv0G7r8ycZLt1IvkBv7SPVgr
NS3ctZA85F39WL+EckxE
=T+28
-----END PGP SIGNATURE-----

--wvtwBTra6naTnG7I9ppFj5qIrDrJCm3v1--

