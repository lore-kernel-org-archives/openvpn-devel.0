Date: Fri, 17 Apr 2020 23:41:09 +0200
From: Christian Hesse <list@...1798...>
Message-ID: <20200417234109.313f09d8@...1799...>
In-Reply-To: <CAEsd45Q+GvZf3du9FYCaLiPeupN88UTv3BjE1dzPKsJO2hzFjQ@...278...>
References: <0a607581-4179-a97b-1e8b-e19dd6bd85bd@...515...>
 <CAEsd45Q+GvZf3du9FYCaLiPeupN88UTv3BjE1dzPKsJO2hzFjQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/u6uGVR7A=NEUUabmJk.X5dZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Subject: Re: [Openvpn-devel] OpenVPN 2.4.9 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: Samuli =?UTF-8?B?U2VwcMOkbmVu?= <samuli@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Sig_/u6uGVR7A=NEUUabmJk.X5dZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"Jonathan K. Bullard" <jkbullard@...277...> on Fri, 2020/04/17 17:16:
>  IHi,
>=20
> On Fri, Apr 17, 2020 at 8:47 AM Samuli Sepp=C3=A4nen <samuli@...515...> w=
rote:
> >
> > The OpenVPN community project team is proud to release OpenVPN 2.4.9. It
> > can be downloaded from here:
> >
> > <https://openvpn.net/community-downloads/>=20=20
>=20
> I'm having trouble verifying 2.4.9.tar.gz with GPG. I'm pretty
> clueless about gpg, but I think it may not have been signed with the
> correct key.

The key is still correct, but it has new subkeys. Try to refresh the key fr=
om
a keyserver:

$ gpg --refresh-keys F554A3687412CFFEBDEFE0A312F5F7B42F2B01E7
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/u6uGVR7A=NEUUabmJk.X5dZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAl6aInUACgkQiUUh18yA
9Haq4wgAgcBz9ktRGDsq1LD1Wj2XWPMbvfmtP4npRKm2PN/s9FLsHRjB2d1tL8z6
+Lm1Kxo7vOaC0hG6G1WA3hVasWyycQr/Vz63ado8tkUW/bRg+GbdlSyBzhPJGAO1
sXIcG4uyk9j3TaWrodwdiVnRkN41sUAm85N/LinX9J6DHZcx2EDawT/SEv0s+PWD
KAuqPOYaXP5WcTNNYpTT5UtRj9uosQ78c/AjETujIYcg3Ky0/AgT7PrExzlIgDcp
sXRBC6xp3oY/SVu1PHyG72r8CJTezZQp09jmfb2QlW3JjqLTzEORiCYzDQ3jprxb
1yVS75hC2xOmW/wnOSuXoT5LSSUvxg==
=o0RS
-----END PGP SIGNATURE-----

--Sig_/u6uGVR7A=NEUUabmJk.X5dZ--

