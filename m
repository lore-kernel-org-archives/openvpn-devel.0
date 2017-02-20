Date: Mon, 20 Feb 2017 16:02:04 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20170220160204.5ce17c39@...1799...>
In-Reply-To: <CAKh=nwE5D4P_nuJ6fjXwt-m0asbXu2rN-Aka8RTAd6WVKOry3A@...278...>
References: <cover.1487368114.git.logout@...260...>
	<3b87d588-aad7-433d-f802-ea9f9f7a0a63@...1856...>
	<20170219174934.GK93896@...1296...>
	<CAKh=nwGOyR6reYpPvxqFVRKGDhpn7fLmw-GNBjMy=bJrqKTPmw@...278...>
	<20170220132900.050e2b1e@...1799...>
	<CAKh=nwGpVqa5yRoFxJ7ojnHveLpVmy1OvBFoZ8V=acguGixbew@...278...>
	<CAKh=nwHU5cYRVKLp1eM5QRGU5V0KX2POVBCBFVHqR+F9d9USOA@...278...>
	<CAKh=nwE5D4P_nuJ6fjXwt-m0asbXu2rN-Aka8RTAd6WVKOry3A@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/wAd1_JtjWNW0xis3UumEYSp";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [RFC PATCH v1 00/15] Add support for OpenSSL
 1.1.x
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Emmanuel Deloget <logout@...260...>
Cc: openvpn-devel@lists.sourceforge.net

--Sig_/wAd1_JtjWNW0xis3UumEYSp
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Emmanuel Deloget <logout@...260...> on Mon, 2017/02/20 15:52:
> On Mon, Feb 20, 2017 at 2:53 PM, Emmanuel Deloget <logout@...260...> wrot=
e:
> > Hi again,
> >
> > On Mon, Feb 20, 2017 at 2:33 PM, Emmanuel Deloget <logout@...260...>
> > wrote:=20=20
> >> Hi Christian,
> >>
> >> On Mon, Feb 20, 2017 at 1:29 PM, Christian Hesse <list@...1798...> wro=
te:=20=20
> >>> That matches my findings. Built against openssl 1.1.0e (Arch Linux
> >>> package openssl 1.1.0.e-1 [0]) the build itself succeeds, but 'make
> >>> check' reports lots of cipher failures.
> >>>
> >>> Are your patches available from a public git repository?=20=20
> >>
> >> I will make my patches available on github ASAP.=20=20
> >
> > I did as fast as I could, here they are:
> >
> > https://github.com/emmanuel-deloget/openvpn/commits/openvpn-1.1=20=20
>=20
> BTW, sorry for the branch name. I believe my fingers got stuck to a
> limited number of characters. This should have been openssl-1.1 but
> it's not too late to change it :)

Ah, I checked out the wrong branch. :-p

Redoing my test...
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/wAd1_JtjWNW0xis3UumEYSp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlirBOwACgkQiUUh18yA
9HahawgA7F0BeZiIrw4JWW8+zlZQZ/gQOw32qzqBOpzISYLYV3KGpwWHv7fEKoA3
8WANsVBbhObaTYNVMPgvhfKcudt/vg6ALFQVsq5Uz+oDOCoKf+L8iX0gaC0LdXFV
MnSj947SE1/G+wICnqMz8gvkMVhY1RXiATia3mMekyHEsUDJSiY0dCRcQ1Uz9sAo
m0oeoIRYSTc+lVxHKqJxtvq+wcDp4cjeZtOXYnRgesdxNLdNcRqrFdCjkPl8zDSH
NXytp9zDFykX1169Ub8FqTvfKjZiYYma2qIUWcNSIuTXyR8iAhVKASdjdRxnQ78q
f7AnVDy3OEIgmKDUXsW31pNIJ6jUOA==
=cCxc
-----END PGP SIGNATURE-----

--Sig_/wAd1_JtjWNW0xis3UumEYSp--

