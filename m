Date: Fri, 24 Mar 2023 12:44:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZB2NE5KqeMoA6K+J@...1296...>
References: <20230323170601.1256132-1-arne@...1227...>
 <20230323170601.1256132-4-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="BEjhguqOG38mxMGr"
Content-Disposition: inline
In-Reply-To: <20230323170601.1256132-4-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 4/4] Parse compression options and
 bail out when compression is disabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--BEjhguqOG38mxMGr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 23, 2023 at 06:06:01PM +0100, Arne Schwabe wrote:
> This change keeps the option parsing of compression options even when
> compression is disabled. This allows OpenVPN to also refuse/reject connec=
tions
> that try to use compression when compression is completely disabled.

Amazing as that might be, if you actually disable compression, master + 4/4
does not compile anymore...

depbase=3D`echo init.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`; cc -DHAVE_CONFI=
G_H -I. -I../.. -I../../include  -I../../include  -I../../src/compat       =
     -DPLUGIN_LIBDIR=3D\"/usr/local/lib/openvpn/plugins\"  -Wall -g -O2 -st=
d=3Dc99 -MT init.o -MD -MP -MF $depbase.Tpo -c -o init.o init.c && mv -f $d=
epbase.Tpo $depbase.Po
init.c:2648:9: warning: implicit declaration of function 'comp_uninit' is
      invalid in C99 [-Wimplicit-function-declaration]
        comp_uninit(c->c2.comp_context);
        ^
init.c:2648:27: error: no member named 'comp_context' in 'struct context_2'=
; did
      you mean 'mda_context'?
        comp_uninit(c->c2.comp_context);
                          ^~~~~~~~~~~~
                          mda_context
./openvpn.h:459:33: note: 'mda_context' declared here
    struct man_def_auth_context mda_context;
                                ^
init.c:2649:30: warning: implicit declaration of function 'comp_init' is in=
valid
      in C99 [-Wimplicit-function-declaration]
        c->c2.comp_context =3D comp_init(&c->options.comp);
init.c:2649:15: error: no member named 'comp_context' in 'struct context_2'=
; did
      you mean 'mda_context'?
        c->c2.comp_context =3D comp_init(&c->options.comp);
              ^~~~~~~~~~~~
              mda_context
./openvpn.h:459:33: note: 'mda_context' declared here
    struct man_def_auth_context mda_context;
                                ^
init.c:2649:28: error: assigning to 'struct man_def_auth_context' from
      incompatible type 'int'
        c->c2.comp_context =3D comp_init(&c->options.comp);
                           ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
2 warnings and 3 errors generated.
*** Error code 1


so, NAK.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--BEjhguqOG38mxMGr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkHY0TAAoJEB2Cnv7KVigSyZEMAITpJl1FV2obQm8wuCxoVfTq
SDWVcWdv7oP8u6J6kI493/dswMYjtpnz/AyxZEEXG9uIgx08xOdh4w2/hRVLspnn
c7ru2KlmmoVSpBHn1SjjSLIm/zZcGbIPUiWr/HsxqC12Q7DRIDIj/R7LV+Xeps7x
HchZ0V/XTKgI1RpuY8p2ZwZvicsgjmCWMaiQ0TLcxE5+lUNx3pOG5/68x4FYHc9B
cG7D8K0lcJNkHB+xWiQtXWyKyiEN39D3P0pHs+bG6r4IjAUv89q9nApgFYCZhw6d
Ry2U6KbNq2fhB6yJfrvgNrNWqCkUMMz7T4WkEkYZIgQHkvlvmtbimeLcpc3S4oC6
qsP93n+mKrrI14ieUG0hWo3qIwKobxeTzFgAO3cDi57dSVEFW84jw/OLpPNYviiW
ScrJWfN4RVT8sGSAQTfeKnb5aLnh3sUYlTQHb6FiwxlVqHDGDD7cNwZZSkMsAc2R
73+NDldWwpKkkrVGiWojqHvKk6z1poYefpvOTrkAKA==
=RMKe
-----END PGP SIGNATURE-----

--BEjhguqOG38mxMGr--

