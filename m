Date: Mon, 22 Jun 2020 19:28:15 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200622172815.GY1431@...1296...>
References: <20200528225920.6983-1-James.Bottomley@...2316...>
 <20200528225920.6983-4-James.Bottomley@...2316...>
 <20200621085315.GN1431@...1296...>
 <1592752234.3694.3.camel@...2316...>
 <20200622162326.GX1431@...1296...>
 <1592845604.3719.11.camel@...2316...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="zsMpAHEomHNSj3k9"
Content-Disposition: inline
In-Reply-To: <1592845604.3719.11.camel@...2316...>
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

--zsMpAHEomHNSj3k9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 22, 2020 at 10:06:44AM -0700, James Bottomley wrote:
> > [..]
> > > Right, that's what the patch in the url does: uses .so on both mac
> > > and linux.
> >=20
> > I got all confused with your "v6" patch and your "v7" patch, which
> > did other things, and but did not have a "v6" in the history :-)
> >=20
> > *This* patch definitely looks like it's doing the right thing on
> > MacOS.
>=20
> Great, thanks ... I'll rewrap it and submit as a separate patch email
> with cover letter.

I was about to just merge what I have, but it exploded on me on FreeBSD
now - and I can't really figure out why (yet)...

libtool: link: (cd ".libs" && rm -f "libtestengine.so.0" && ln -s "libteste=
ngine.so.0.0.0" "libtestengine.so.0")
libtool: link: (cd ".libs" && rm -f "libtestengine.so" && ln -s "libtesteng=
ine.so.0.0.0" "libtestengine.so")
libtool: link: ar cru .libs/libtestengine.a  libtestengine_la-libtestengine=
.o
libtool: link: ranlib .libs/libtestengine.a
libtool: link: ( cd ".libs" && rm -f "libtestengine.la" && ln -s "../libtes=
tengine.la" "libtestengine.la" )
make  check-TESTS
make[5]: don't know how to make openssl.cnf. Stop

make[5]: stopped in /home/gert/src/openvpn-maint/test-build-master-fbsd/tes=
ts/unit_tests/engine-key


it seems as if there is an implicit rule "somewhere" that Linux make has
and FreeBSD make not how to build openssl.cnf from $(srcdir)/openssl.cnf.in
- on Linux, when I remove "openssl.cnf" from the target dir and re-run
"make check", I get

make[5]: Entering directory '/rhome/gert/src/openvpn-maint/test-build-maste=
r-ossl111/tests/unit_tests/engine-key'
sed "s|ABSBUILDDIR|/rhome/gert/src/openvpn-maint/test-build-master-ossl111/=
tests/unit_tests/engine-key|" < ../../../../openvpn/tests/unit_tests/engine=
-key/openssl.cnf.in > openssl.cnf
PASS: check_engine_keys.sh


Ah.  If I run "gmake check", it also passes on FreeBSD...

gmake[5]: Entering directory '/home/gert/src/openvpn-maint/test-build-maste=
r-fbsd/tests/unit_tests/engine-key'
sed "s|ABSBUILDDIR|/home/gert/src/openvpn-maint/test-build-master-fbsd/test=
s/unit_tests/engine-key|" < ../../../../openvpn/tests/unit_tests/engine-key=
/openssl.cnf.in > openssl.cnf
PASS: check_engine_keys.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1 test passed
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

... so the engine part *itself* is fine, just the "openssl.cnf from .in"
doesn't work with BSD make...


We need a v7 (or v8?) :-(

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--zsMpAHEomHNSj3k9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe8OovAAoJEB2Cnv7KVigSt9UL/3Pzm9IadkCkGp8Dao/bk+N9
b88xn63s/lRPSAxmZO0DxMY36aV3yxvIVP9hnb1lDKRHdwwmt3O5/rWJzE6ggGiv
MH11NNRDC+F2NQgBrEMaiLkkQnuOMjPfqp/RdvOFGsOlaGOlpuxwau0W2QpI3cqK
Xl13+9bx52u+vqWCSV+gfMWGDF+FU4hGKJBo8M0UMVYvCcRqwjc/lFoYYis+CkLH
mVGOetuE2mwKKRD3ObCdvd/Uq1zpJud0L1RQAHmGy/ChYXaWNhpXslgr576EZD7c
rFoFFnCxeDezs9qJoeoESmpHKJwelFhvR5JTHEfr91kABUJksHnPKwRpY+i/Jl1T
pNLLIFWjj3aRcmkz/V5VEO6urbmpCux5o4WIt0fPdBN9rr0fa4N3mIhP9lfBKdFP
FAGhRRsP8qE/t45T2qkAc2+ZiLi6oqjS7xl9wcv21LMudLbEiSdKjFPvdoSC93oF
poZJFDi+pn71SvOxciSCLkVyprfSKhmBfvsFVpGFRA==
=9EN3
-----END PGP SIGNATURE-----

--zsMpAHEomHNSj3k9--

