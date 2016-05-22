Date: Sun, 22 May 2016 18:56:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160522165620.GC53051@...1296...>
References: <CAKuzo_g1jx2JkxP2BSVYPW4axnMUQgVe=WvBSzC+x8n6LR_A9g@...278...>
	<1463892387-4793-1-git-send-email-selva.nair@...277...>
	<20160522073101.GV53051@...1296...>
	<CAKuzo_gcP+YiNE9tHqkW1aVtsm=wy=wg9yPf0PpUwL1_vDXuYA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bjP1ynumGsNfxNCR"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gcP+YiNE9tHqkW1aVtsm=wy=wg9yPf0PpUwL1_vDXuYA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix handling of out of memory error in
 interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--bjP1ynumGsNfxNCR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, May 22, 2016 at 11:00:22AM -0400, Selva Nair wrote:
> > On Sun, May 22, 2016 at 12:46:27AM -0400, Selva Nair wrote:
> > >          {
> > >            size +=3D 10;
> > > -          handles =3D realloc (handles, size * sizeof (HANDLE));
> > > -          if (handles =3D=3D NULL)
> > > -            return ERROR_OUTOFMEMORY;
> > > +          LPHANDLE tmp =3D realloc (handles, size * sizeof (HANDLE));
> > > +          if (tmp =3D=3D NULL)
> >
> > ... oh, and this might actually fail MSVC compilation, due to
> > "variable declared after other code parts" (size +=3D 10)...
>=20
> Isn't it time to deprecate support for visual studio older than 2013? MSVC
> in VS-2015 supports C99 constructs and VS2013 may also do.
>=20
> If not, I'll submit a version 2.

Dunno... the only time I compiled on windows, I was using mingw+msys... but
since I get yelled at if we break MSVC compatibility, I started to look
out for such constructs.

Lev, what are you compiling with?

[..]
> > So we do not exit anymore when this fails, except if WAIT_FAILED?
>=20
> That is correct.  I tested it and works nicely -- i.e., on realloc error,
> all previous connections continue while new connections get an error
> message.

This is very nice indeed!

(Not that a realloc() failure for +40 bytes would ever happen on its
own - if memory is that tight, other stuff will explode as well :-) - but
I really really like such defensive code that just works with what it
has, instead of "oh, panic, just crash")


Mmmh, anyway, I have two options now :-) - ask you for a v2 that is
MSVC 2010 compatible, and has the initial value reverted to "10", or
just apply...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--bjP1ynumGsNfxNCR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV0HkqKkuBuNlUUl1AQLYLwP6A3o0eGDsk3RRzD9zEfts/QQUtZwuRAmT
hqMC3Zz6Vg6dtCcK7AAQF0HkPZib8s6jcERf8bFHg/KtUWssP/04U2SliQTob8/v
GyC/jooD0cV9/TL/nBtaRLqJXqBSTg/RY89wCN244ur3t67Pp7znt23jxL8Yo9a/
PO63QA94Juc=
=4Mod
-----END PGP SIGNATURE-----

--bjP1ynumGsNfxNCR--

