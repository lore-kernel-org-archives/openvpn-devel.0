References: <201806231209.w5NC9AhF028415@...2054...>
 <20180623121503.4080-1-gert@...1296...>
 <20180623173104.GT57262@...1296...>
 <CAKuzo_iE0zU_6+19+V0QSSbU0sBpSYtJU48uLaS_ireoj81n8Q@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <0afcdadf-9270-a709-35bc-66318e58f8f5@...2181...>
Date: Sun, 24 Jun 2018 02:12:29 +0800
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iE0zU_6+19+V0QSSbU0sBpSYtJU48uLaS_ireoj81n8Q@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Vrbhk0tji7gKARDG7HCAzRl3IfakR1X6A"
Subject: Re: [Openvpn-devel] [PATCH] Add %d,
 %u and %lu tests to test_argv unit tests.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Vrbhk0tji7gKARDG7HCAzRl3IfakR1X6A
Content-Type: multipart/mixed; boundary="7L3kg4mCZQ6j0MbHgMSd0FpmpbyyTz4bv";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Selva Nair <selva.nair@...277...>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <0afcdadf-9270-a709-35bc-66318e58f8f5@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Add %d, %u and %lu tests to test_argv
 unit tests.
References: <201806231209.w5NC9AhF028415@...2054...>
 <20180623121503.4080-1-gert@...1296...>
 <20180623173104.GT57262@...1296...>
 <CAKuzo_iE0zU_6+19+V0QSSbU0sBpSYtJU48uLaS_ireoj81n8Q@...278...>
In-Reply-To: <CAKuzo_iE0zU_6+19+V0QSSbU0sBpSYtJU48uLaS_ireoj81n8Q@...278...>

--7L3kg4mCZQ6j0MbHgMSd0FpmpbyyTz4bv
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 24/06/18 02:08, Selva Nair wrote:
>> Or shall I just have it print "1", so we know "%lu works and prints its
>> argument nicely"?
>>
>=20
> That should be enough, but we could get fancy and use -1L and compare
> the result against sprintf(str, "%lu", -1L)
>=20

I just recommended something similar on IRC.
I think it would make sense to "validate" argv_printf* against sprintf.
Not just for %lu but also for the other formats. This way we know our
code is doing what sprintf would also do.



Cheers,



--=20
Antonio Quartulli


--7L3kg4mCZQ6j0MbHgMSd0FpmpbyyTz4bv--

--Vrbhk0tji7gKARDG7HCAzRl3IfakR1X6A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsujY0ACgkQB6U8WA7y
zXTQig//WtO1ayHq9gOJhpk+exYAfnUpXsquWv5PCY3CF/1mc3nJhNvfjPG8XV+b
JxtZbpVgHNHis1QwsZsF2oiE/1paWa6DcQxFluE3Yzh2eHVtfxzM36eMPeFSPTKI
pxM69l4AsAdx4EYh8FKcgmzbxsF3cHWpfeuq84v6B8zfL2oHkqRZR0WgCr//W//m
1Z4fmaYhoyN94PBQgMrW64fPqYm9zlvDhqXv0Nez4QCljsLGTvuC07w8eAhLDcfy
WBA/Hhy+WPU6m8yNzihXMy5mnRrKpowdCJSCsj1Isdz4uPbiLYAT7g/3919P4tdz
o22CVv/fs29ifbNfd9iRqppvCnnLRVO7BJVLCaGCmOSjq5kbPV5DZH9gjdRQ6gKw
kid9rGLGcsmCnvWQXc250LC/KQej+kHkX5ssRbKf6tS2G3FNPlYF6r5qPNy5/k+q
RX8RMpxDoXRMRiMM0bFH/EuEdzZwIE2GyFDA7/brFhb2guy61lRdHN4js6sErAEN
4+KFBHsMYpK/b8t8T0r1nbGyMmBSOTcHtOPBDXZ6oIx9tdUs6fG9BOhgSbTr8Abq
PJRQxiO6jjgFKRDh7dzLUBciTURB1GhV78UOukxjsMuGB6RU9xQiqwA8E1hyYq2U
30SW2mPdVMf6wx+y5kH/8iIm+1qX5KyHkC3zu+gxjW1cgPYzm/I=
=8S2C
-----END PGP SIGNATURE-----

--Vrbhk0tji7gKARDG7HCAzRl3IfakR1X6A--

