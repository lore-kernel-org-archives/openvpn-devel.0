Date: Fri, 23 Mar 2012 16:32:41 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120323153206.GD1181@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="brEuL7wsLY8+TuWz"
Content-Disposition: inline
Subject: [Openvpn-devel] discussion: get rid of useless HAVE_* tests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--brEuL7wsLY8+TuWz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

reviewing some of the build patches, I found tests like

#ifdef HAVE_CHDIR

or=20

#ifdef HAVE_GETPID

... which is craziness.  All platforms OpenVPN runs on (except for WIN32)
are fully POSIX compliant, and those are all required to have these
functions - so testing for them, and having special #ifdef in the code
for them, and then doing things like this:

int
platform_chdir (const char* dir)
{
#ifdef HAVE_CHDIR
#ifdef WIN32
  int res;
  struct gc_arena gc =3D gc_new ();
  res =3D _wchdir (wide_string (dir, &gc));
  gc_free (&gc);
  return res;
#else
  return chdir (dir);
#endif
#else
  return -1;              <<<< yeah, how much good will that do?
#endif

is just extra code in various places that serves no purpose than to
make "look, we can test for it!" autotools maniacs happy.


So I propose that after Alon's build patches have been merged, I go
through the HAVE_* defines and rip out everything that is part of
POSIX and is not use on #ifdef WIN32 anyway (like "getpid()").

We're not going to port this to a non-posix OS any time soon.


Comments?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--brEuL7wsLY8+TuWz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT2yXmKkuBuNlUUl1AQLWxAP+Oqjmo8ofg3TOn6xkjgsi7BqCAIHb/BP9
TD7oh+QD6zwfUJ8oHJ8Q6e2NzUFd+5rjs/qoXgv1nSP5k2kxkZ0ZM6blqOdzb5az
nbkPN4tJr+9XLeIjP7GkCjI5gApdJUDQDYZaWqzvd3clPiRhZa2mkyGJ3kdvT9+1
nZF/EcnUtrE=
=y9Ej
-----END PGP SIGNATURE-----

--brEuL7wsLY8+TuWz--

