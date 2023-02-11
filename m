Date: Sat, 11 Feb 2023 19:32:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y+ffJEsJI1SvOupe@...1296...>
References: <20230208001819.244694-3-arne@...1227...>
 <20230208005925.393200-1-selva.nair@...277...>
 <Y+azhVMqdJb/6gAN@...1296...>
 <CAKuzo_imMOa+UC2FngyyyCvGpERdoyrRNpYnyqEs9+6s4q8_8Q@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="z9p0LP+nrurzVE27"
Content-Disposition: inline
In-Reply-To: <CAKuzo_imMOa+UC2FngyyyCvGpERdoyrRNpYnyqEs9+6s4q8_8Q@...278...>
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

--z9p0LP+nrurzVE27
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 10, 2023 at 06:10:41PM -0500, Selva Nair wrote:
> Ignore the previous email  -- (I behaved as if I can't read more than a
> pageful).

:-)

> Looks like unit-tests are not enabled during configure. For that, cmocka
> should be available in the search path or set using CMOCKA_LIBS and
> CMOCKA_INCLUDES.

Yes, that's the conclusion I arrived at, after I sent yesterday's
mail and went to bed - "oh no, it can't do anything, there is no cmocka
in that cross-compile environment".  But I didn't want to get up again
just to send that followup mail ;-)

> It took a while for me to figure out how to cross-compile cmocka using
> cmake and mingw on Linux. Finally what worked was pretty simple:
>=20
> git clone https://github.com/clibs/cmocka.git
> cd cmocka
> checkout cmocka-1.1.5
> mkdir build
> cd build
> cmake -DCMAKE_SYSTEM_NAME=3DWindows -DCMAKE_C_COMPILER=3Dx86_64-w64-mingw=
32-gcc
> \
>             -DCMAKE_SHARED_LINKER_FLAGS=3D-static-libgcc \
>             -DCMAKE_INSTALL_PREFIX=3D$HOME/mingw-cmocka/ -S .. -B .
> make install

This would have been my next question "how do I build this?" :-)

... adapted to my build environment...

-- Installing: /home/gert/mingw/opt/include/cmocka.h
-- Installing: /home/gert/mingw/opt/bin/cmocka.dll

... then returning to openvpn & re-running configure, it will
still not find it :-(

checking for CMOCKA... no
configure: WARNING: cmocka.pc not found on the system.  Unit tests disabled

... so, configure CMOCKA_CFLAGS/CMOCKA_LIBS it is...

checking for CMOCKA... yes

... but then trying to build the test drivers fails, and from the looks
of it, it's finding but not utilizing the cmocka lib...

/bin/bash ../../../libtool  --tag=3DCC   --mode=3Dlink i686-w64-mingw32-gcc=
 -I/home/gert/mingw/opt/include  -I/home/gert/mingw/opt/include -I../../../=
include -I/home/gert/mingw/opt/include -Wall -Wno-stringop-truncation -I/ho=
me/gert/mingw/opt/include -std=3Dc99 -L/home/gert/mingw/lib -L/home/gert/mi=
ngw/opt/lib64 -lssl -lcrypto  -L/home/gert/mingw/opt/lib -llzo2 -L/home/ger=
t/mingw/opt/lib -lcmocka -L/home/gert/mingw/opt/lib -o example_testdriver.e=
xe example_testdriver-test.o=20=20
libtool: link: i686-w64-mingw32-gcc -I/home/gert/mingw/opt/include -I/home/=
gert/mingw/opt/include -I../../../include -I/home/gert/mingw/opt/include -W=
all -Wno-stringop-truncation -I/home/gert/mingw/opt/include -std=3Dc99 -o .=
libs/example_testdriver.exe example_testdriver-test.o  -L/home/gert/mingw/l=
ib -L/home/gert/mingw/opt/lib64 -lssl -lcrypto -L/home/gert/mingw/opt/lib /=
home/gert/mingw/opt/lib/liblzo2.a -lwinmm -lcmocka
/usr/bin/i686-w64-mingw32-ld: example_testdriver-test.o:test.c:(.text+0x89)=
: undefined reference to `_assert_int_equal'
/usr/bin/i686-w64-mingw32-ld: example_testdriver-test.o:test.c:(.text+0xc6)=
: undefined reference to `_assert_int_equal'
/usr/bin/i686-w64-mingw32-ld: example_testdriver-test.o:test.c:(.text+0x153=
): undefined reference to `_cmocka_run_group_tests'
collect2: error: ld returned 1 exit status
make[5]: *** [Makefile:461: example_testdriver.exe] Error 1

... tried various permutations of "-L$path -lcmocka", putting the
actual path to "libcmocka.dll.a" on the link/libtool command line, but
the error never changes...

*scratch head*

Need to debug this more tonight...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--z9p0LP+nrurzVE27
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJj598jAAoJEB2Cnv7KVigS72oMAJNXUaUcBYvJ1YWZDHuXH0Td
3LTP6RbdYt0HluveNWkiKlNagSOAZ0N1tfMB4HtRXsnsn04vJJ0uBBY7rOa9z1Kl
Ge8VpWgNHB3B5ylxAfQTJy3ilCInAB6onl5NSW8RKvbuh0qRZM5lAJirMDwEjxa8
Kj629dYGxRT6lmj3V1R9BmOLdrJWrfajCRviZN+/tFWwN+ydAtr6gc0EuIIHbtBz
7A9nGlZeLqIAW3O3ys9eikxO+LVaBCUpy+SZiE5UCbNd4bzMm3DVs4Jl23H+qE81
unD/SnWxkISmLuuSKoO0UX8JTX4/0DLXbwM93JpcTtv/PXS0X/WgLrbSx9iyyeiq
AlbZkRJtneRHe35OYvvMGnXu41RoKBkX1ouZfx3yGwXOE0bv9dsnPzA+K+Rhy4Vj
ehzFQ/LV8yh/tgWbWGiDzkm0j3xOKZhyUAvZn/kiapgJ+ENUqMx9pTepLpY4nvTQ
Oztoo7ROWlcqtdm3d3B24GWeTslKz23f2jSwZNLMew==
=KWNY
-----END PGP SIGNATURE-----

--z9p0LP+nrurzVE27--

