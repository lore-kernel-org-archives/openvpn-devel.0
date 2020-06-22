Message-ID: <1592845604.3719.11.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Mon, 22 Jun 2020 10:06:44 -0700
In-Reply-To: <20200622162326.GX1431@...1296...>
References: <20200528225920.6983-1-James.Bottomley@...2316...>
 <20200528225920.6983-4-James.Bottomley@...2316...>
 <20200621085315.GN1431@...1296...>
 <1592752234.3694.3.camel@...2316...>
 <20200622162326.GX1431@...1296...>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-2wQ3LPZVo81oAu3VL663"
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

--=-2wQ3LPZVo81oAu3VL663
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-06-22 at 18:23 +0200, Gert Doering wrote:
> Hi,
>=20
> On Sun, Jun 21, 2020 at 08:10:34AM -0700, James Bottomley wrote:
> > > Arne, James, can we converge on something here?
> >=20
> > Could someone just test the proposed updated v6 patch on a Mac?
> >=20
> > https://sourceforge.net/p/openvpn/mailman/message/37031113/
>=20
> Took Arne and me half a day ("the macos build slave did not have
> cmocka, and it went downhill from there") but I can now confirm that
> it works and passes the tests.
>=20
> This is on a Mojave MacMini with "brew" openssl 1.1.1c and your patch
> "v6":
>=20
> Making check in engine-key
> /Applications/Xcode.app/Contents/Developer/usr/bin/make  libtestengin
> e.la
> ...
> /bin/sh ../../../libtool  --tag=3DCC   --mode=3Dlink gcc -I/usr/local/Cel
> lar/openssl@...2560.../1.1.1c/include   -I../../../../openvpn.git/include
> -I/usr/local/Cellar/cmocka/1.1.5/include -I -I -Wall -Wno-unused-
> parameter -Wno-unused-function -g -O2 -std=3Dc99 -L/usr/local/Cellar/op
> enssl@...2560.../1.1.1c/lib -lcrypto -lssl   -
> L/usr/local/Cellar/cmocka/1.1.5/lib -lcmocka -rpath /lib -shrext
> .so  -o libtestengine.la  libtestengine_la-libtestengine.lo  -
> lresolv=20
> libtool: link: gcc -dynamiclib -Wl,-undefined -Wl,dynamic_lookup -o
> .libs/libtestengine.0.so  .libs/libtestengine_la-libtestengine.o   -L
> /usr/local/Cellar/openssl@...2560.../1.1.1c/lib -lcrypto -lssl
> -L/usr/local/Cellar/cmocka/1.1.5/lib -lcmocka -lresolv  -g -O2   -
> install_name  /lib/libtestengine.0.so -compatibility_version 1
> -current_version 1.0 -Wl,-single_module
> libtool: link: (cd ".libs" && rm -f "libtestengine.so" && ln -s
> "libtestengine.0.so" "libtestengine.so")
> libtool: link: ar cru .libs/libtestengine.a  libtestengine_la-
> libtestengine.o
> libtool: link: ranlib .libs/libtestengine.a
> libtool: link: ( cd ".libs" && rm -f "libtestengine.la" && ln -s
> "../libtestengine.la" "libtestengine.la" )
> /Applications/Xcode.app/Contents/Developer/usr/bin/make  check-TESTS
> sed "s|ABSBUILDDIR|/Users/gert/openvpn-build-
> mojave/tests/unit_tests/engine-key|" <
> ../../../../openvpn.git/tests/unit_tests/engine-key/openssl.cnf.in >
> openssl.cnf
> PASS: check_engine_keys.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1 test passed
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> (I'm not sure where it is actually *calling* the
> "check_engine_keys.sh",
> but it says "test passed!" and I see ".so" up there)

Yes, it's using the standard test runner, so if it says PASS/FAIL:
<script> it definitely called <script>

> [..]
> > Right, that's what the patch in the url does: uses .so on both mac
> > and linux.
>=20
> I got all confused with your "v6" patch and your "v7" patch, which
> did other things, and but did not have a "v6" in the history :-)
>=20
> *This* patch definitely looks like it's doing the right thing on
> MacOS.

Great, thanks ... I'll rewrap it and submit as a separate patch email
with cover letter.

James

--=-2wQ3LPZVo81oAu3VL663
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCXvDlJAAKCRDnQslM7pis
hTv6APsFFfYxXXqCMl0hGoVJq9fMHP5LxrmlyVAiDhPtwkzzpQEAmp1M6fJSOmMo
a+nXBlizCoL8enevm6urauPVODZxHkk=
=80+A
-----END PGP SIGNATURE-----

--=-2wQ3LPZVo81oAu3VL663--


