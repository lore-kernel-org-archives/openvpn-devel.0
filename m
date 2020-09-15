References: <20200914115706.11066-1-davids@...515...>
 <20200914122721.14173-1-davids@...515...>
 <20200915102254.GC75094@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <a04b390d-c9e7-f22f-f85e-2773c7db5d63@...2080...>
Date: Tue, 15 Sep 2020 22:52:05 +0200
MIME-Version: 1.0
In-Reply-To: <20200915102254.GC75094@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="CTvZUWfLnvAr5e4O4bEI6rCGT0y3vDRtM"
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
To: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CTvZUWfLnvAr5e4O4bEI6rCGT0y3vDRtM
Content-Type: multipart/mixed; boundary="69cyejD3kcEVPQZmw0ino1fitYnXxWAND";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <a04b390d-c9e7-f22f-f85e-2773c7db5d63@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] sample-plugins: Partially autotoolize
 the sample-plugins build
References: <20200914115706.11066-1-davids@...515...>
 <20200914122721.14173-1-davids@...515...>
 <20200915102254.GC75094@...1296...>
In-Reply-To: <20200915102254.GC75094@...1296...>

--69cyejD3kcEVPQZmw0ino1fitYnXxWAND
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 15/09/2020 12:22, Gert Doering wrote:
> Hi,
>=20
> On Mon, Sep 14, 2020 at 02:27:21PM +0200, David Sommerseth wrote:
>> The sample-plugins have their own set of build/winbuild scripts in each
>> of these plugin directories.  This does not give a good way to reuse
>> various macros the autoconf/automake/configure process enables; which
>> can contain important macros to make some code build without errors or
>> warnings.
>=20
> This looks like a step in the right direction, but is not fully working
> yet - I tried both an "in-tree" and "out of tree" build, and it fails
> compilation with
>=20
> sample-plugins$ gmake
> test -d `dirname defer/simple.o` || ../../../openvpn/./install-sh -c -d `=
dirname defer/simple.o`; \
> cc -c -o defer/simple.o -Wall -Wno-unused-parameter -Wno-unused-function =
-g -O2 -std=3Dc99 -I../../../openvpn -fPIC ../../../openvpn/sample/sample-p=
lugins/defer/simple.c
> ../../../openvpn/sample/sample-plugins/defer/simple.c:58:10: fatal error:=
 'openvpn-plugin.h' file
>       not found
> #include "openvpn-plugin.h"
>          ^~~~~~~~~~~~~~~~~~
> 1 error generated.
>=20
>=20
> openvpn-plugin.h is installed if you install openvpn first, but if
> you only build in tree, it seems to need an extra=20
>=20
>   -I$(top_srcdir)/include
>=20
> to find openvpn-plugin.h

Hmmm ... I would have expected that to be picked up automatically, but clea=
rly
didn't watch the compile arguments carefully enough.

> It also needs gmake - running "make" will do "nothing at all", which
> I found surprising, but did not investigate more closely.  This is likely
> due to implicit rules that need to be written differently for BSD make.

Yikes ... I see potentially two issues here.  BSD Make seems to lack support
for $(foreach ...) and it does not grok '%.so : %.o' (which is Make "macro
magic" to simplify rule writing).  To avoid this and make it BSD Make
compatible, we would probably need to go full-fledged automake - pulling in
libtools (and the awkward .libs directories, .la/.lo files, etc, etc).

So if we're fine with reducing this to GNU Make only, the change is trivial.

> I do not think this is a serious issue - just document it in the README,
> and it's still better than 4 individual "build" files, half of it who
> were missing the needed "-I" as well :-)

New updated patch coming very soon.

--=20
kind regards,

David Sommerseth
OpenVPN Inc



--69cyejD3kcEVPQZmw0ino1fitYnXxWAND--

--CTvZUWfLnvAr5e4O4bEI6rCGT0y3vDRtM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfYSl2AAoJEIbPlEyWcf3y17QQAJFLO2FzNbO5jVuwk/KwtAhl
bjO4bIGT8q7DOFKGv+YheVjZUC1q0d03YhVfjyNYdw/s6ysIyPr4z9tD9ILaZFkx
DV/Fa0P5uiGPJLNeztHYUAMxEYmaJAnEbgP+TlSMYVf/4x/ShpFVfMdwHfWgfg8+
GppziCAbuWyY9FNITkDYDNAjoo6h3BrgLun8ikr4fLMqH4g2A2RZdCfOzGKtMZZA
JCNoRV70f8kMjGIq8e7JaFo6qFeisqEIpSx8SmhELppq+ZCx0dYekzMt0Fjtt/11
RNYp8DjqjkqfGpfGwvv9RIltrtc8TcEIq0ii6Kid4VMQjn4DJIJDgK2ihOFEnFVx
EQnVVz6TawbAEGXUZgZklKxLgFBIRmzQHMq4V5bb7fk0kafi1OteP5OvSmehnY/m
HikBGSNOeBVOjxumiH6uJfsyDa76H4kqu0mErnSs5FzhePvXSIFH6yirXTnYFq9M
KPa81Mu3FKSgrmTHypcwqX0RGzHAkfjNtM1RGipeGyeVyBrdX2UvUpWfFuA8z9UX
zUMPqbzm8ZuHECOeMlQbkDjG5jLAoNFzFb29mb5ddbAbNoIK1wTMRYrL+BnLVqNF
I2cM/w/n/PB+RDZWcCug1gbc0Evx+010TlWOWRGdhDcUNr9btLyhdlc/E/Y++E5X
c+HNuTOFIl4lyd8dSPhR
=YHVT
-----END PGP SIGNATURE-----

--CTvZUWfLnvAr5e4O4bEI6rCGT0y3vDRtM--

