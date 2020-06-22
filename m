Message-ID: <1592850496.3719.16.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Mon, 22 Jun 2020 11:28:16 -0700
In-Reply-To: <20200622172815.GY1431@...1296...>
References: <20200528225920.6983-1-James.Bottomley@...2316...>
 <20200528225920.6983-4-James.Bottomley@...2316...>
 <20200621085315.GN1431@...1296...>
 <1592752234.3694.3.camel@...2316...>
 <20200622162326.GX1431@...1296...>
 <1592845604.3719.11.camel@...2316...>
 <20200622172815.GY1431@...1296...>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-k6HI6XkT+MYyMHxp2ODt"
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v6 3/3] Add unit tests for engine keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--=-k6HI6XkT+MYyMHxp2ODt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-06-22 at 19:28 +0200, Gert Doering wrote:
> Hi,
>=20
> On Mon, Jun 22, 2020 at 10:06:44AM -0700, James Bottomley wrote:
> > > [..]
> > > > Right, that's what the patch in the url does: uses .so on both
> > > > mac
> > > > and linux.
> > >=20
> > > I got all confused with your "v6" patch and your "v7" patch,
> > > which
> > > did other things, and but did not have a "v6" in the history :-)
> > >=20
> > > *This* patch definitely looks like it's doing the right thing on
> > > MacOS.
> >=20
> > Great, thanks ... I'll rewrap it and submit as a separate patch
> > email
> > with cover letter.
>=20
> I was about to just merge what I have, but it exploded on me on
> FreeBSD
> now - and I can't really figure out why (yet)...
>=20
> libtool: link: (cd ".libs" && rm -f "libtestengine.so.0" && ln -s
> "libtestengine.so.0.0.0" "libtestengine.so.0")
> libtool: link: (cd ".libs" && rm -f "libtestengine.so" && ln -s
> "libtestengine.so.0.0.0" "libtestengine.so")
> libtool: link: ar cru .libs/libtestengine.a  libtestengine_la-
> libtestengine.o
> libtool: link: ranlib .libs/libtestengine.a
> libtool: link: ( cd ".libs" && rm -f "libtestengine.la" && ln -s
> "../libtestengine.la" "libtestengine.la" )
> make  check-TESTS
> make[5]: don't know how to make openssl.cnf. Stop
>=20
> make[5]: stopped in /home/gert/src/openvpn-maint/test-build-master-
> fbsd/tests/unit_tests/engine-key
>=20
>=20
> it seems as if there is an implicit rule "somewhere" that Linux make
> has
> and FreeBSD make not how to build openssl.cnf from
> $(srcdir)/openssl.cnf.in
> - on Linux, when I remove "openssl.cnf" from the target dir and re-
> run
> "make check", I get
>=20
> make[5]: Entering directory '/rhome/gert/src/openvpn-maint/test-
> build-master-ossl111/tests/unit_tests/engine-key'
> sed "s|ABSBUILDDIR|/rhome/gert/src/openvpn-maint/test-build-master-
> ossl111/tests/unit_tests/engine-key|" <
> ../../../../openvpn/tests/unit_tests/engine-key/openssl.cnf.in >
> openssl.cnf
> PASS: check_engine_keys.sh
>=20
>=20
> Ah.  If I run "gmake check", it also passes on FreeBSD...
>=20
> gmake[5]: Entering directory '/home/gert/src/openvpn-maint/test-
> build-master-fbsd/tests/unit_tests/engine-key'
> sed "s|ABSBUILDDIR|/home/gert/src/openvpn-maint/test-build-master-
> fbsd/tests/unit_tests/engine-key|" <
> ../../../../openvpn/tests/unit_tests/engine-key/openssl.cnf.in >
> openssl.cnf
> PASS: check_engine_keys.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1 test passed
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> ... so the engine part *itself* is fine, just the "openssl.cnf from
> .in" doesn't work with BSD make...
>=20
>=20
> We need a v7 (or v8?) :-(

That will be my fault.  I assumed automake always ran with gnu make, so
the .cnf rule is in gnu make syntax at the bottom of (Makefile.am):

$(builddir)/%.cnf: $(srcdir)/%.cnf.in
	sed "s|ABSBUILDDIR|$(abs_builddir)|" < $< > $@


If I just spell everything out and don't use the percent wildcard, it
should work even on legacy make.

James


--=-k6HI6XkT+MYyMHxp2ODt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCXvD4QAAKCRDnQslM7pis
hfj8AQCRNZjnHZSf4yI80bY1Zu8pW9Vpg/6GRxOVRvW0r/BT7wEA+MfOi2bGZnMf
58ZIz3fKpjiWNoziLrq8Iwqi5o6nFas=
=S1O8
-----END PGP SIGNATURE-----

--=-k6HI6XkT+MYyMHxp2ODt--


