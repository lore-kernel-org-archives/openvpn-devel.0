Date: Tue, 14 Feb 2023 11:21:15 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y+tgm1coNX0d7gmK@...1296...>
References: <20230208001819.244694-3-arne@...1227...>
 <20230208005925.393200-1-selva.nair@...277...>
 <Y+azhVMqdJb/6gAN@...1296...>
 <CAKuzo_imMOa+UC2FngyyyCvGpERdoyrRNpYnyqEs9+6s4q8_8Q@...278...>
 <Y+ffJEsJI1SvOupe@...1296...>
 <CAKuzo_hX3utoo8wew951AR9NZdt6hcjgq832tJDvYc6RmJvcNw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="D0n8luKZfLPMLZz8"
Content-Disposition: inline
In-Reply-To: <CAKuzo_hX3utoo8wew951AR9NZdt6hcjgq832tJDvYc6RmJvcNw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/3] Build unit tests in mingw
 Windows build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--D0n8luKZfLPMLZz8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Feb 11, 2023 at 01:44:04PM -0500, Selva Nair wrote:
> On Sat, Feb 11, 2023 at 1:32 PM Gert Doering <gert@...1296...> wrote:
>=20
> > /bin/bash ../../../libtool  --tag=3DCC   --mode=3Dlink i686-w64-mingw32=
-gcc
>=20
> This is a 32 bit build which I never tried. Maybe cmocka is not built for
> 32 bit?

Yes, that was spot-on.

Found time to debug this with Arne today, and all the "non-cmocka" stuff
was built with "configure --host=3Di686-w64-mingw32" while cmocka got
"-DCMAKE_C_COMPILER=3Dx86_64-w64-mingw32-gcc", so the resulting .a library
was full of 64 bit objects... which, of course, "file" doesn't tell on
the .a, but unpacking libcmocka.dll.a + libcrypto.dll.a and looking at=20
some of the contained .o told me...

gert@...2713...:/tmp$ file cmocka_dll_d000001.o libcrypto_3_dll_d000001.o
cmocka_dll_d000001.o:      Intel amd64 COFF object file, no line number inf=
o, not stripped, 5 sections, symbol offset=3D0x138, 8 symbols, 1st section =
name ".text"
libcrypto_3_dll_d000001.o: Intel 80386 COFF object file, no line number inf=
o, not stripped, 5 sections, symbol offset=3D0x134, 9 symbols, 1st section =
name ".text"


... so, changed the cmocka CMAKE invocation to=20

    cmake -DCMAKE_SYSTEM_NAME=3DWindows \
            -DCMAKE_C_COMPILER=3Di686-w64-mingw32-gcc \
            -DCMAKE_CXX_COMPILER=3Di686-w64-mingw32-g++ \
...

rebuilt cmocka, and "make test" now does what we expect it to do - build
something

gert@...2713...:~/mingw/openvpn.git$ ls -l ./tests/unit_tests/openvpn/.libs
total 6504
-rwxrwxr-x 1 gert gert 541621 Feb 14 10:11 argv_testdriver.exe
-rw-rw-r-- 1 gert gert   6229 Feb 14 10:11 argv_testdriver_ltshwrapper
-rwxrwxr-x 1 gert gert 816794 Feb 14 10:12 auth_token_testdriver.exe
-rw-rw-r-- 1 gert gert   6248 Feb 14 10:12 auth_token_testdriver_ltshwrapper
-rwxrwxr-x 1 gert gert 536193 Feb 14 10:11 buffer_testdriver.exe
...

and not fail :-)


So, I can confirm that the yesterday-merged patch will make "make check"
on a MinGW system do the right thing.  I didn't test 64 bit compiles, as
that wouldn't add insights on "it's make / configure specific" changes.

Thanks for your assistence and patience,

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--D0n8luKZfLPMLZz8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJj62CbAAoJEB2Cnv7KVigS+ssMAJYVxBPVFnCW5KiNns6gviGi
0NXxkw5V75otVDFk9+Q/P9Dcw27mNg1u7Cj6oSP3Rl8aZFd761lwRRtMOcs82X0B
P7B86QgEdsSNWmgPS4PXnhAmZOpAx7CtvEYrHBLT6ChbvUAnroxmI5zTVzR49MHn
HlhDWL7B3m1SmIC9OLyj3n1SEyHQpz1nQFS6LNZmIfaF/7NvX8QXOs1RSWw1lZUH
c4O/Ax2wALwjckqDj4o8yjvAGPwjPCU3VSmv85kgwJMdzsoeEq/1GZ02RK7kBVzD
tTMd5fLsf6dZiZYYyT4gXilprRI36D44LDycla5Afd7AWqOS2dFS90EArdwqOWD3
SnpUXI7ffXo7EbsiiO54Mv6Q6WqPwZqgR7oY8KMrAMyfd3oDiiVuu7613C8Yr6RC
GYk/ohquQ/mt9dQhGI7+79e90FGbnWXsaX2cFwr0+UqBqcvs062lmu8yN7/EEvSi
xD8PtPFwGb6Fv5aJzESe2a4MI/p3svHld2SSE7jxXw==
=D9FU
-----END PGP SIGNATURE-----

--D0n8luKZfLPMLZz8--

