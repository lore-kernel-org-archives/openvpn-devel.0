Date: Wed, 16 Sep 2020 15:48:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200916134803.GD976@...1296...>
References: <20200914115706.11066-1-davids@...515...>
 <20200915205254.32605-1-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <20200915205254.32605-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH v3] sample-plugins: Partially
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

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Sep 15, 2020 at 10:52:54PM +0200, David Sommerseth wrote:
> ---
> v2 - Process README files with correct instructions and details
> v3 - Add missing -I$(top_srcdir)/include and explicitly state GNU Make
>      requirement

Unfortunately, we need a v4... stupid me...

For in-tree builds, it is working:

cc -c -o simple/simple.o -Wall -Wno-unused-parameter -Wno-unused-function -=
g -O2 -std=3Dc99 -I../.. -I../../include -fPIC simple/simple.c
cc  -shared -fPIC -o simple/simple.so simple/simple.o
rm simple/simple.o

For out of tree builds, it is still failing:

cc -c -o simple/simple.o -Wall -Wno-unused-parameter -Wno-unused-function -=
g -O2 -std=3Dc99 -I../../../openvpn -I../../../openvpn/include -fPIC ../../=
../openvpn/sample/sample-plugins/simple/simple.c
../../../openvpn/sample/sample-plugins/simple/simple.c:37:10: fatal error:=
=20
      'openvpn-plugin.h' file not found
#include "openvpn-plugin.h"
         ^~~~~~~~~~~~~~~~~~

because "openvpn-plugin.h" is not actually to be found in the source
tree, but it's generated at compile time - so "-I../../include" will
find it.

The other -I should maybe also be "-I../.."?  What is it looking for
in the $(top_builddir)?  The only .h file in $(top_builddir) is
"config-msvc.h" - config.h is in "../.."


But anyway, if I do "-I../../include", it compiles out of tree as
well...

cc -c -o simple/simple.o -Wall -Wno-unused-parameter -Wno-unused-function -=
g -O2 -std=3Dc99 -I../../../openvpn -I../../include -fPIC ../../../openvpn/=
sample/sample-plugins/simple/simple.c


gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfYheTAAoJEB2Cnv7KVigSJSwL/2iUEnjvq8fAlpy+8wK11DW+
hsS1BIEODv6ketj4y8sJRcm/xjBEToU+Q20oK14yO6Z828PFNaFdePFQIG7ixE39
d6C8izDckxyfhpAI+mj4GWBQ2NJ/jSj0PmlMZMwu2oYq3fXuNz8iiIkm9a7ADux4
R/vhTS/xD5v519zbLGJ0JJrkC4UEw16W2+Tw/cRduhasNAcYOu9ge2yP7Tbar33a
LRxg6MHC9sU89+ROe8I8gJASZjNQEkObaCXuLtg9D+gf3ZF0EfrA5wG1FRANvNHg
I4knqMxZXg5CXW8O3bx+IX+x0SqWE4XQKeNrVYIlm3KFPJIozuFrZ6EI5LG+YQ9n
XEeQQMLrngx/mT25A33KJKkqaSdCMluR8Jh5WuZV2rwU+c5XpScrJmMioBtzDQw7
qpCKhJauK2RojYRPTHaHnPALuCTCNxHl18K1hzySEYC5MCwnHeqqzfDJDqiKqaQ8
Alo0hxrfS5QksB7puVJsLkJiF8UMqOEzGqvMYVPCNQ==
=Fi81
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--

