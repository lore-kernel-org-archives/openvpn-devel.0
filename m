References: <20170713033848.11902-1-a@...2181...>
 <CAFHpkQG_gS9cZdfTDAJGHwApPzgpbCFS6923ysqjU6_AAaG7xQ@...278...>
 <a5f62ded-89be-7115-3f31-b4ee199bdad8@...2181...>
 <2de72e2e-5ccc-992f-505a-41cd00140844@...515...>
 <20170713065907.GZ97029@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <d7604439-f453-bfb7-c9ed-1d627c9ea900@...2181...>
Date: Wed, 16 Aug 2017 21:05:08 +0800
MIME-Version: 1.0
In-Reply-To: <20170713065907.GZ97029@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gTd4thoafcNW5U78iim7Hqftq7HvfUqej"
Subject: Re: [Openvpn-devel] [PATCH] fix compilation for --disable-multi
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net, ValdikSS <valdikss@...277...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gTd4thoafcNW5U78iim7Hqftq7HvfUqej
Content-Type: multipart/mixed; boundary="JGe8bvGdMhODN803LkS76nvQLHSQvSCBT";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>
Cc: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
 openvpn-devel@lists.sourceforge.net, ValdikSS <valdikss@...277...>
Message-ID: <d7604439-f453-bfb7-c9ed-1d627c9ea900@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] fix compilation for --disable-multi
References: <20170713033848.11902-1-a@...2181...>
 <CAFHpkQG_gS9cZdfTDAJGHwApPzgpbCFS6923ysqjU6_AAaG7xQ@...278...>
 <a5f62ded-89be-7115-3f31-b4ee199bdad8@...2181...>
 <2de72e2e-5ccc-992f-505a-41cd00140844@...515...>
 <20170713065907.GZ97029@...1296...>
In-Reply-To: <20170713065907.GZ97029@...1296...>

--JGe8bvGdMhODN803LkS76nvQLHSQvSCBT
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 13/07/17 14:59, Gert Doering wrote:
> Hi,
>=20
> On Thu, Jul 13, 2017 at 09:16:13AM +0300, Samuli Sepp=E4nen wrote:
>> There were no bugs reports about --disable-multi in Trac. I say scrap
>> that option altogether and make the code slightly cleaner and less
>> entangled.
>=20
> I tend to agree with you here.  There are way too many #ifdef in our
> code, and while Antonio's patch is technically fine, it adds more #ifdef
> for a variant that nobody seems to be using - so that's not the way
> to go.

I just went over this again and unfortunately I realized that, even
though we can get rid of the --disable-multi switch (for which I will
send a patch in a minute), we can't get rid of the various "#if P2MP"
because its value depends on ENABLE_CRYPTO, which can still be enabled
or disabled.

Therefore, we have to keep the P2MP define as long we keep the
ENABLE_CRYPTO logic.

Cheers,

>=20
> P2MP_SERVER seems to have some uses, to be able to compile a client-only
> binary for really small systems.  So I'd keep that one, plus the associat=
ed
> configure options.
>=20
> gert
>=20
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
Antonio Quartulli


--JGe8bvGdMhODN803LkS76nvQLHSQvSCBT--

--gTd4thoafcNW5U78iim7Hqftq7HvfUqej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlmUQwQACgkQ0+HICM1s
oFBjrw/+L5EHeLcoKzB0e8JTZ3UR3ZbDOgYv3dAv2XSHvZVfzETNY8ODA1abEJd0
k8Qss7zJz72FV9iDazOTWPzw5z6BrcGb/SJsKxPqWkZCoZ773K5rMZepWMZBi7DG
7hU/6/O7FZCfY4VdswAMslCjmP7xq286a00q8R3OUx3n0VY+V79D9hiaXfmNNFNB
EooerZg+ztR1qdsITbgnH9Q8P9wDVaUg1vU5bsO77Be/kEIXeENAUnf4CY1XlnJ4
FkaMUfe5YEG4XoVhTP5wRfyX7qVP1PxwdqERirVECiV3cqGFZ/gl/2yYZWT2BLnP
SviuU4uddlLXjh8//6mUuzH/034t/vpU/mWsFX5Oce8TFnB7whGG2vWrdjbaARmg
i/zc7qU4vnoGfPEoNWViRAouag/LyJq6Fx0lLNADkUYGoCq0ZQzeTiSgKJ01Hd1m
qDokNNrUbTmcDj40dzBtMgTxsGX2Rxgujkfhmq6zADjKU4RcuB6QTKIBKfhE+TgE
QoclDo6Za/mVQNZqELKLTov46ruqu7ROqIRqu7/w2EUogMavaFiptQ6SmOIUyWSb
yPmnDMn4ra6pEKykd55Gs6Ck1yO+DhERlytn1DjaeR3H4vB7KvTMv5BnEGsl9PGj
HKu1Wyj2j2HE3lkJzUxNZPS1Ho44lvtVMgVylLwy39Z3/I1WuJ0=
=T8Y7
-----END PGP SIGNATURE-----

--gTd4thoafcNW5U78iim7Hqftq7HvfUqej--

