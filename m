Date: Thu, 11 Aug 2016 19:30:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160811173021.GX78279@...1296...>
References: <1470368394-2722-1-git-send-email-selva.nair@...277...>
	<20160805061418.GO78279@...1296...>
	<CAA1AbxJ8G5ztG1mgdkbvg7S9yqYuTwtq76SCkksUkrpVi8SjxA@...278...>
	<CAKuzo_gsjEjhCZ7eczDtGb2XOrjXwKh4LroL4ULZrc96Jy8Lhg@...278...>
	<CAA1Abx+CTuRmnZJEJB9zCVjAv6bMNicsPiRg6wNdtac+fKF4gQ@...278...>
	<CAKuzo_hbfMrz3_bJBVjiPOu0fmRs=fvMr-Cm6sXZBGQp=fd-uQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cEOOY/qhMBY6Rcxu"
Content-Disposition: inline
In-Reply-To: <CAKuzo_hbfMrz3_bJBVjiPOu0fmRs=fvMr-Cm6sXZBGQp=fd-uQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Avoid format specifier %zu for Windows
 compatibility
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cEOOY/qhMBY6Rcxu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

sorry for being a bit lazy in answering.  This is the sort of threads
that lead to endless wars ... :-)

On Sun, Aug 07, 2016 at 10:47:16AM -0400, Selva Nair wrote:
> > I looked into this a bit, and it should indeed fix the printing of %zu
> > on Windows.  I would prefer to teach autotools to include this flag on
> > Windows builds, instead of the suggested casts in the code.  (But if
> > you both prefer the casts, just ignore my rambling.)
>=20
> I don't like casts and agree with Steffan. That is, assuming MSVC support
> is only for developers, we need not worry about the runtime and could
> require MSVC 2015. I suppose we only distribute mingw cross-compiled
> binaries.
>=20
> I think, with __USE_MINGW_ANSI_STDIO=3D1 mingw will use a custom
> implementation I/O routines, so the binary size may increase a bit (by ~50
> kB or ~5% in my tests).
>=20
> Also we currently use MS-specific format specs like %I64u %I64x for
> counter_format and ptr_format. Those will have to be changed once the abo=
ve
> define is in place. Its only a couple of instances, though.

Mmmh.  Trading off 3 ("easy") casts vs. 50 kB extra code for stdio instead=
=20
of using the platform-provided stdio library *plus* having to change
(and possibly review) quite a few other parts of the code sounds like
a fairly easy trade-off to me - and my conclusion would be "drop %zu,
just cast to (unsigned int)".


Just to make this clear: I do not like sprinkling casts across the code
"to silence the compiler" at all.  It quite often hides bugs (especially
when dealing with pointers).=20=20

Now *these* are all very simple - talking about numbers in the numerical=20
range "0..2000", so "%u" plus (unsigned int) would be totally safe here,
no matter what platform used.

> I am looking at this as an opportunity to stop coding for VS2011 and 2013
> and feel liberated :) If Gert is fine with this I'll make a new patch.

This is somewhat tangential from not using %zu :) - I think regarding
"which VS versions do we support", we should at least check with James
and Lev, as these two seem to be the last ones to (regularily) build=20
with MSVC...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--cEOOY/qhMBY6Rcxu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV6y2LKkuBuNlUUl1AQIinQQAssgAO84AYV7FrVu51HF60QXI53Z6gyE0
isSbbLbSWUlJ83oQFhB45P604S3ECkF5eXOafpPjVAk+OpSbGPe/90nWiC9ncdQe
yRRL4OmIKRyR4PBuzon+nZO2RsAinwJaCYbY7UN+xzP2xDVyFQQxiwPyHqpIDXBu
A2/P04LXiqU=
=jnMU
-----END PGP SIGNATURE-----

--cEOOY/qhMBY6Rcxu--

