Date: Mon, 22 Jun 2020 20:40:15 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200622184015.GZ1431@...1296...>
References: <20200528225920.6983-1-James.Bottomley@...2316...>
 <20200528225920.6983-4-James.Bottomley@...2316...>
 <20200621085315.GN1431@...1296...>
 <1592752234.3694.3.camel@...2316...>
 <20200622162326.GX1431@...1296...>
 <1592845604.3719.11.camel@...2316...>
 <20200622172815.GY1431@...1296...>
 <1592850496.3719.16.camel@...2316...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GQns980g72gHFMRT"
Content-Disposition: inline
In-Reply-To: <1592850496.3719.16.camel@...2316...>
Subject: Re: [Openvpn-devel] [PATCH v6 3/3] Add unit tests for engine keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2317...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--GQns980g72gHFMRT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 22, 2020 at 11:28:16AM -0700, James Bottomley wrote:
> That will be my fault.  I assumed automake always ran with gnu make,=20

No :-)   (and let's not start a gnu make vs bsd make vs. cmake vs. ant
discussion now :-) ).

Specifically, we run automake on linux systems before doing release
tarballs, so the target host doesn't even *need* automake installed -
but if you want, automake runs just fine on BSD, producing "standard
makefiles" that work fine with BSD make.

> so the .cnf rule is in gnu make syntax at the bottom of (Makefile.am):
>=20
> $(builddir)/%.cnf: $(srcdir)/%.cnf.in
> 	sed "s|ABSBUILDDIR|$(abs_builddir)|" < $< > $@
>=20
>=20
> If I just spell everything out and don't use the percent wildcard, it
> should work even on legacy make.

Ah, there it is :) - I think "non-GNU" make doesn't handle these in
combination with paths.

"man make" on FreeBSD says:

     The $@ and $< variables are more or less universally portable, as is t=
he
     $(MAKE) variable.  Basic use of suffix rules (for files only in the
     current directory, not trying to chain transformations together, etc.)=
 is
     also reasonably portable.

so

$(builddir)/openvpn.cnf: $(srcdir)/openvpn.cnf.in
	sed "s|ABSBUILDDIR|$(abs_builddir)|" < $< > $@

should work.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--GQns980g72gHFMRT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe8PsPAAoJEB2Cnv7KVigSzrwL/iVSv1grbP30K6PI18aKdrZK
lJR9ab4g+hJGjvgTcoUP2/JQ9R/j+bQ0U9Ljb8tRPtxHg02PgjQ9prpFMie9EJ3J
Ju9TghUfx27qvyoRRTE32f7EH6NZDlV5nrEBOjIWihexiehg4bcnusCpFKn7cYkM
xbU1Se04nTEnf3R7PUb51klqIIv6w83uvKudv6d8pD8rpRuDEB7tM4u1E9dkbm1z
m2ZGHDmKO2VoNp3vjB/p6dHE9t0p4rwwCjjblsk4XWkDFaS86ctV1Mv0Fv0a/nNj
C4VJAh/Bbb2QBlNGaJtpI9vf7lBX2tdk+Q+5y+7DMD4LWdEh7KIHtZEop56+HMZI
Zh0no83HoHYHmvNEQUdvwt1WiahWvyBRoIr3aP/q/kuwhit2l5veuDqOwT1SjlmG
FEbX7E4VckEcRTCWKjFtpuImOWZW8Rwy4NNXZ6+XL16UsYPajRy+Xvj8ZTKKieSo
03azfPwA7/GppyQ76QHc+W3fPAqZr1tnFmsfE1Q70Q==
=1Ru4
-----END PGP SIGNATURE-----

--GQns980g72gHFMRT--

