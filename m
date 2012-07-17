Date: Tue, 17 Jul 2012 18:00:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120717160057.GX22125@...1296...>
References: <1342533472-30873-1-git-send-email-heiko.hund@...1489...>
	<CAOazyz0wc=ZGhJnLfvd=AK6_Y=vTfebccmV29Fc5z2DGpJ8EWQ@...278...>
	<21316332.O9di4uRdZn@...1526...> <20120717154628.GV22125@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rtqL2qczZrjpIe/F"
Content-Disposition: inline
In-Reply-To: <20120717154628.GV22125@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] don't treat socket related errors
	special anymore
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

--rtqL2qczZrjpIe/F
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 17, 2012 at 05:46:28PM +0200, Gert Doering wrote:
> On Tue, Jul 17, 2012 at 05:09:34PM +0200, Heiko Hund wrote:
> >   if (status =3D=3D EINPROGRESS
> >   #ifdef WIN32
> >     || status =3D=3D WSAEWOULDBLOCK
> >   #endif
> >   )
>=20
> Please let's not do that.

Uh.  Correcting myself.  In *this* scenario, with this only showing up
in a single place, it might be less complicated to figure out than
having an extra #define which is just #define'ed to EINPROGRESS for
most platforms anyway.

So while I dislike #ifdef's, I don't like magic #defines that are only
used in a single place any better...

But in the end it's just a matter of coding style, and who does the work
has to do some decisions - and we don't have a particular style guide for
such platform stuff.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--rtqL2qczZrjpIe/F
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUAWMOakuBuNlUUl1AQKZBgQAj60gP4i/5JNzPZZc+3cHf5/uudgfa0Jf
yWnRxp9YuvSj/pQUZLBwiPSheVXvlOEwvYVuIVLpfzzoamkO26RnPa+d+bwXgtBc
6ermGNMCIIlia681l2VTUOVxPOsWr+agVEW/AEQhZlJ262bT7fuJ6voVUCN2c1Sb
W5X4AVR6CQ0=
=KMN8
-----END PGP SIGNATURE-----

--rtqL2qczZrjpIe/F--

