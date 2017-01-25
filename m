Date: Wed, 25 Jan 2017 19:57:58 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20170125195758.47ba7586@...1799...>
In-Reply-To: <5285c33f-98e5-4e06-0ed8-95728a74f755@...2080...>
References: <20161227222406.931-1-list@...1798...>
	<20170125160428.19928-1-list@...1798...>
	<5285c33f-98e5-4e06-0ed8-95728a74f755@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/._bT1hN139Px3O3E0ajoGVQ";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH v3 1/1] Clean up plugin path handling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Christian Hesse <mail@...1798...>, openvpn-devel@lists.sourceforge.net

--Sig_/._bT1hN139Px3O3E0ajoGVQ
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

David Sommerseth <openvpn@...2080...> on Wed, 2017/01/25 18:06:
> On 25/01/17 17:04, Christian Hesse wrote:
> > From: Christian Hesse <mail@...1798...>
> >=20
> > Drop --with-plugindir, instead use an environment variable PLUGINDIR
> > to specify the plugin directory.
> >=20
> > This generates a header file src/openvpn/plugindir.h which contains a
> > define file the plugindir.
> >=20
> > v2: The configure script can not evaluate the final $libdir path. So
> >     use make to create a header file on the containing the final path.
> >=20
> > v3: Fix whitespace errors and gitignore location.
> >=20
> > Signed-off-by: Christian Hesse <mail@...1798...>
> > ---
> >  .gitignore                 |  1 +
> >  configure.ac               | 14 ++++++--------
> >  src/openvpn/Makefile.am    | 11 +++++++++--
> >  src/openvpn/plugin.c       |  1 +
> >  src/openvpn/plugindir.h.in | 34 ++++++++++++++++++++++++++++++++++
> >  5 files changed, 51 insertions(+), 10 deletions(-)
> >  create mode 100644 src/openvpn/plugindir.h.in=20=20
>=20
>=20
> Okay, some more feedback to this thread :)
>=20
> As I've said, I think this makes sense.  It provides a predictable
> plug-in directory which is easily accessible within the C code ... and
> it will always be set.  So, Feature-ACK.
>=20
> But I am wondering about the rationale of adding another header file
> (plugindir.h).  Why not just add this information to
> openvpn-plugin.h.in, which results into openvpn-plugin.h ... and which
> plugin.c already includes via plugin.h ...  I actually think this path
> can be quite useful for third-party plug-ins, being built outside of the
> openvpn source tree.

I did not want to be too intrusive. ;) Happy to hear that... About to
prepare a new patch, stay tuned!
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/._bT1hN139Px3O3E0ajoGVQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAliI9TYACgkQiUUh18yA
9HYfVwf/ZF6NQosgryr8cSW/LM07JgUM3+PZwL6dXYCqE51/ZWWqT4ePsJuYNJ1i
FkRcDuuH+JPPVLON/6lM3tPH7waShG/CUKIAP+j1rT5lVkavzaOfGxXUHMf5cABa
44DJpT5Hr1HVBoI9SBTkoxGsylzfqE7YNuxVmwNd4R6OmwSzCHDnOXFrKFL0zHTw
q0AVo/2Sd8qug9B7szs2mbNpS29li5ALBaFZ0YID2BAb6Ulm1123urZSPl7qglIK
HPiVyA+I69ExATWE35mbIMUU4F1MPO9R4DKgGjmb2A7NybLvM0BigoFhsp6Go6Ie
IGcdQy/sRTFeJx4c9W9TR1C596Nrvw==
=8jrT
-----END PGP SIGNATURE-----

--Sig_/._bT1hN139Px3O3E0ajoGVQ--

