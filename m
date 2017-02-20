Date: Mon, 20 Feb 2017 16:08:16 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20170220160816.114598d9@...1799...>
In-Reply-To: <20170220160204.5ce17c39@...1799...>
References: <cover.1487368114.git.logout@...260...>
	<3b87d588-aad7-433d-f802-ea9f9f7a0a63@...1856...>
	<20170219174934.GK93896@...1296...>
	<CAKh=nwGOyR6reYpPvxqFVRKGDhpn7fLmw-GNBjMy=bJrqKTPmw@...278...>
	<20170220132900.050e2b1e@...1799...>
	<CAKh=nwGpVqa5yRoFxJ7ojnHveLpVmy1OvBFoZ8V=acguGixbew@...278...>
	<CAKh=nwHU5cYRVKLp1eM5QRGU5V0KX2POVBCBFVHqR+F9d9USOA@...278...>
	<CAKh=nwE5D4P_nuJ6fjXwt-m0asbXu2rN-Aka8RTAd6WVKOry3A@...278...>
	<20170220160204.5ce17c39@...1799...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/Uu8K0BYrGa/bCFvXB/mFyk_";
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

--Sig_/Uu8K0BYrGa/bCFvXB/mFyk_
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Christian Hesse <list@...1798...> on Mon, 2017/02/20 16:02:
> Emmanuel Deloget <logout@...260...> on Mon, 2017/02/20 15:52:
> > On Mon, Feb 20, 2017 at 2:53 PM, Emmanuel Deloget <logout@...260...>
> > wrote:=20=20
> > > Hi again,
> > >
> > > On Mon, Feb 20, 2017 at 2:33 PM, Emmanuel Deloget <logout@...260...>
> > > wrote:=20=20=20=20
> > >> Hi Christian,
> > >>
> > >> On Mon, Feb 20, 2017 at 1:29 PM, Christian Hesse <list@...1798...>
> > >> wrote:=20=20=20=20
> > >>> That matches my findings. Built against openssl 1.1.0e (Arch Linux
> > >>> package openssl 1.1.0.e-1 [0]) the build itself succeeds, but 'make
> > >>> check' reports lots of cipher failures.
> > >>>
> > >>> Are your patches available from a public git repository?=20=20=20=20
> > >>
> > >> I will make my patches available on github ASAP.=20=20=20=20
> > >
> > > I did as fast as I could, here they are:
> > >
> > > https://github.com/emmanuel-deloget/openvpn/commits/openvpn-1.1=20=20=
=20=20
> >=20
> > BTW, sorry for the branch name. I believe my fingers got stuck to a
> > limited number of characters. This should have been openssl-1.1 but
> > it's not too late to change it :)=20=20
>=20
> Ah, I checked out the wrong branch. :-p
>=20
> Redoing my test...

That one looks good! Build and tested against ArchLinux package
openssl 1.1.0e.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/Uu8K0BYrGa/bCFvXB/mFyk_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlirBmAACgkQiUUh18yA
9HarBggA4tQbFBD5xiqojDmUIHdcEDdmDa0igSqfUW20wCwGs3nXMZ9gqw/dkVaS
PwyG6SS6Xofd47iSaRveNP9tHXQtuHYLXRmUxvc7x2PCD9DIoZbOJAN1j03yNX+F
hMkPQQfxDWw3YzkEO6Hog3VpmgXfXwbcgeSawjec0kZgQ/3KdaH0VMgXHl7/23Xu
TC5v9fOmSFyISN8ex4VJNqLf3YDzcH+kt8sFE+gveGuAHHSAQ4mFfedfOMjiBSYp
d1MgpF5vFr7qbkgmK98B/UDnZnryeclMT6W/SeaUZjwwEUc7GFirlxKt/cf1OqPN
9bF6QYGRr7OXMUpbgFJL7NYXvPArmQ==
=Z5j7
-----END PGP SIGNATURE-----

--Sig_/Uu8K0BYrGa/bCFvXB/mFyk_--

