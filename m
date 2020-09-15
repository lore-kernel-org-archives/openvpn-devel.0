Date: Tue, 15 Sep 2020 12:22:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200915102254.GC75094@...1296...>
References: <20200914115706.11066-1-davids@...515...>
 <20200914122721.14173-1-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="QU4HcMF0gOtcBmJ3"
Content-Disposition: inline
In-Reply-To: <20200914122721.14173-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH v2] sample-plugins: Partially
 autotoolize the sample-plugins build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--QU4HcMF0gOtcBmJ3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Sep 14, 2020 at 02:27:21PM +0200, David Sommerseth wrote:
> The sample-plugins have their own set of build/winbuild scripts in each
> of these plugin directories.  This does not give a good way to reuse
> various macros the autoconf/automake/configure process enables; which
> can contain important macros to make some code build without errors or
> warnings.

This looks like a step in the right direction, but is not fully working
yet - I tried both an "in-tree" and "out of tree" build, and it fails
compilation with

sample-plugins$ gmake
test -d `dirname defer/simple.o` || ../../../openvpn/./install-sh -c -d `di=
rname defer/simple.o`; \
cc -c -o defer/simple.o -Wall -Wno-unused-parameter -Wno-unused-function -g=
 -O2 -std=3Dc99 -I../../../openvpn -fPIC ../../../openvpn/sample/sample-plu=
gins/defer/simple.c
../../../openvpn/sample/sample-plugins/defer/simple.c:58:10: fatal error: '=
openvpn-plugin.h' file
      not found
#include "openvpn-plugin.h"
         ^~~~~~~~~~~~~~~~~~
1 error generated.


openvpn-plugin.h is installed if you install openvpn first, but if
you only build in tree, it seems to need an extra=20

  -I$(top_srcdir)/include

to find openvpn-plugin.h

It also needs gmake - running "make" will do "nothing at all", which
I found surprising, but did not investigate more closely.  This is likely
due to implicit rules that need to be written differently for BSD make.

I do not think this is a serious issue - just document it in the README,
and it's still better than 4 individual "build" files, half of it who
were missing the needed "-I" as well :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--QU4HcMF0gOtcBmJ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfYJX9AAoJEB2Cnv7KVigSKEIL/RcPNcHYdC3JIsTPhECdmTKu
8/2/aJbzh8PHUXFkK3BYjed6sW7yeni+6AWtqeDK+qzlT2dkaGRaQqR/GRaykLRb
5bVdWpY3BOl5gFN7wB0qPmiiZvoIdvUdBBNGLSiS6zCa/nkibmJxGGRNidiycWFA
16xh4iCXtbMBzsfiU8QJA2ZqoSXSiMHq34TkB6V4PP7380M+d/nWsyobKV4wmkRG
wY2VVXs1OlIwDMKMrs0Ah+XefyxwIjgSLecWq9V24xbpHxl7uXY6/fRKKCfc1SNB
ZD3RO+nKblS+bweIapLcxszdLpLxemVEaITY7QlxoROxnf8w95PVqnqpBCJSAgL1
Djql4Bh77p5i3JfhzgmYNOQF4tRjW2Q5sWNVyhIffo9zbozMEcrTuXAkagU8YK2q
l44OKy0vWXaJ46Bl53VJl3axy+mpwMxwhYFvIzUsR8E17dzAfBjOJEm7Shh6oG56
QM1slcpmS0N6GlSl+Y0DIW2BEUGB/XjrEbjWhTNsKA==
=KDJV
-----END PGP SIGNATURE-----

--QU4HcMF0gOtcBmJ3--

