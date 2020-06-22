Date: Mon, 22 Jun 2020 18:23:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200622162326.GX1431@...1296...>
References: <20200528225920.6983-1-James.Bottomley@...2316...>
 <20200528225920.6983-4-James.Bottomley@...2316...>
 <20200621085315.GN1431@...1296...>
 <1592752234.3694.3.camel@...2316...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="62dk4WrCr0YTo4T0"
Content-Disposition: inline
In-Reply-To: <1592752234.3694.3.camel@...2316...>
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

--62dk4WrCr0YTo4T0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jun 21, 2020 at 08:10:34AM -0700, James Bottomley wrote:
> > Arne, James, can we converge on something here?
>=20
> Could someone just test the proposed updated v6 patch on a Mac?
>=20
> https://sourceforge.net/p/openvpn/mailman/message/37031113/

Took Arne and me half a day ("the macos build slave did not have cmocka,
and it went downhill from there") but I can now confirm that it works
and passes the tests.

This is on a Mojave MacMini with "brew" openssl 1.1.1c and your patch
"v6":

Making check in engine-key
/Applications/Xcode.app/Contents/Developer/usr/bin/make  libtestengine.la
...
/bin/sh ../../../libtool  --tag=3DCC   --mode=3Dlink gcc -I/usr/local/Cella=
r/openssl@...2560.../1.1.1c/include   -I../../../../openvpn.git/include -I/=
usr/local/Cellar/cmocka/1.1.5/include -I -I -Wall -Wno-unused-parameter -Wn=
o-unused-function -g -O2 -std=3Dc99 -L/usr/local/Cellar/openssl@...2560.../=
1.1.1c/lib -lcrypto -lssl   -L/usr/local/Cellar/cmocka/1.1.5/lib -lcmocka -=
rpath /lib -shrext .so  -o libtestengine.la  libtestengine_la-libtestengine=
.lo  -lresolv=20
libtool: link: gcc -dynamiclib -Wl,-undefined -Wl,dynamic_lookup -o .libs/l=
ibtestengine.0.so  .libs/libtestengine_la-libtestengine.o   -L/usr/local/Ce=
llar/openssl@...2560.../1.1.1c/lib -lcrypto -lssl -L/usr/local/Cellar/cmock=
a/1.1.5/lib -lcmocka -lresolv  -g -O2   -install_name  /lib/libtestengine.0=
.so -compatibility_version 1 -current_version 1.0 -Wl,-single_module
libtool: link: (cd ".libs" && rm -f "libtestengine.so" && ln -s "libtesteng=
ine.0.so" "libtestengine.so")
libtool: link: ar cru .libs/libtestengine.a  libtestengine_la-libtestengine=
.o
libtool: link: ranlib .libs/libtestengine.a
libtool: link: ( cd ".libs" && rm -f "libtestengine.la" && ln -s "../libtes=
tengine.la" "libtestengine.la" )
/Applications/Xcode.app/Contents/Developer/usr/bin/make  check-TESTS
sed "s|ABSBUILDDIR|/Users/gert/openvpn-build-mojave/tests/unit_tests/engine=
-key|" < ../../../../openvpn.git/tests/unit_tests/engine-key/openssl.cnf.in=
 > openssl.cnf
PASS: check_engine_keys.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1 test passed
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

(I'm not sure where it is actually *calling* the "check_engine_keys.sh",
but it says "test passed!" and I see ".so" up there)

[..]
> Right, that's what the patch in the url does: uses .so on both mac and
> linux.

I got all confused with your "v6" patch and your "v7" patch, which did
other things, and but did not have a "v6" in the history :-)

*This* patch definitely looks like it's doing the right thing on MacOS.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--62dk4WrCr0YTo4T0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe8Nr9AAoJEB2Cnv7KVigSrzcL/jJYaS0ZPgEdsRDDGvHlcMUx
ilZ6SSU0rHLQs35TqtTETA4cLTiEACm2slpV3d8jal67FlrEBPqWUBtmbPogLhXO
Lmp/OgTwiFg02WkQkEY8QQ3j0FC1jyhe3ZaA6msEMs/y/vJyHhdZzDnZUBZG0MYa
N+qMupiB4T9FAQR+o/RRriVwwayc1CyEDVsWi4zrC87lYX6J+t7oJN6ZG/8W+sXV
9t3STcUJyBwD0JBdB+0/6flTVWwnU98HZl7VywdYWCp6mLMvr4/N2Ksepg7lDcQc
7qKUEML3zf3raARyrV6mtYH8YeQAoJWOvu7eTIkLcWPc+I2t/Lc1gi/3Ccvo/nCM
MU8SA5yGRhYSRnY8hHQHOAB3XPi7Z1wrykX4N5cJM77QcsJS09nUu4Y3/hNFsXz2
Y5dZbrRzzvKLGHVCn5floPtpsa8255hY9SWQe9giFzLevYP8Tn0605M0BXNwJsd9
7gwtNtJ0v1we6aoe+oc4RG3ZtdahC7z6ltXu3EOCCA==
=+CaW
-----END PGP SIGNATURE-----

--62dk4WrCr0YTo4T0--

