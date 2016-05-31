Date: Tue, 31 May 2016 09:19:09 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160531071909.GO53051@...1296...>
References: <20160525175756.56186-1-openvpn-devel@...2127...>
	<20160525175756.56186-2-openvpn-devel@...2127...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s14R9olktCOAsFYN"
Content-Disposition: inline
In-Reply-To: <20160525175756.56186-2-openvpn-devel@...2127...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Add unit testing support via cmocka
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@...2127...
Cc: openvpn-devel@lists.sourceforge.net

--s14R9olktCOAsFYN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, May 25, 2016 at 07:57:55PM +0200, openvpn-devel@...2127... wrote:
> From: Jens Neuhalfen <jens@...2127...>
>=20
> cmocka [1,2] is a testing framework for C. Adding unit test capabilities =
to the
> openvpn repository will greatly ease the task of writing correct code.
>=20
> cmocka source code is added as git submodule in ./vendor. A submodule app=
roach
> has been chosen over a classical library dependency because libcmocka is =
not
> available, or only available in very old versions (e.g. on Ubuntu).
>=20
> cmocka is build during 'make check' and installed in vendor/dist/.
>=20
> [1] https://cmocka.org/
> [2] https://lwn.net/Articles/558106/

This patch needs more work - David merged it tonight, and it blew up half
our buildslaves.

Two main issues I could identify:

 - if cmake is not installed, it should result in "SKIPPED" tests, not in
   build/make failures - since we do not list it in our build requirements
   (and we shouldn't, for normal builds), building and testing needs to be
   possible if cmake is not existing - of course, without the cmocka tests

 - if the build is done in a directory with blanks in, which our buildbots
   like to do, things blow up due to lack of quoting

   rm -rf /var/lib/buildbot/slaves/openvpn/build-ubuntu-1204-i386-stable-ma=
ster--disable-server --enable-small /build/vendor/.build/cmocka
   rm: unrecognized option '--enable-small'

   the "--enable-small" bit is part of the current directory name, and
   has a blank before it...  (which might not be considered good practice,
   but better it blows up for us than for users)


It also blows up in configure already when building for windows, but I'm
not sure I understand why - Samuli is looking into that.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--s14R9olktCOAsFYN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV0067KkuBuNlUUl1AQJV7wQAhWv0CZT/uZBRGi62fVQP5piIV8dSpWr2
eBbqKaBgniPE3dObvKaXVW45QCqEegIILDiffZgQlF5RpQG0nRWUmU8gMuQTUY0N
OMUUbcF7aFPJQuf0wuzpem1rwxb1dhEKnlZR8EqrvyYEcEXq5RdDa2qNdZp7qUf7
aImSAY+Q1YY=
=1+Ax
-----END PGP SIGNATURE-----

--s14R9olktCOAsFYN--

