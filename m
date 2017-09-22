Date: Fri, 22 Sep 2017 22:59:44 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170922205944.GA70062@...1296...>
References: <20170907022827.10658-1-davids@...515...>
 <20170907172004.22534-1-davids@...515...>
 <c122b7ac9f1d63ac0ba060f7f7d3ceff.squirrel@...2257...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fzxPtQiUsqZaJiu9"
Content-Disposition: inline
In-Reply-To: <c122b7ac9f1d63ac0ba060f7f7d3ceff.squirrel@...2257...>
Subject: Re: [Openvpn-devel] [PATCH v2] lz4: Move towards a newer LZ4 API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>
Cc: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

--fzxPtQiUsqZaJiu9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 07, 2017 at 10:40:21PM +0200, Simon Matter wrote:
> While we are at it, I found it useful to see the used LZ4 version at
> runtime as it is done with LZO and other libraries.
>=20
> I've patched my rpms with the patch attached.
[..]

> diff -Naur openvpn-2.4.0.orig/src/openvpn/comp-lz4.h openvpn-2.4.0/src/op=
envpn/comp-lz4.h
> --- openvpn-2.4.0.orig/src/openvpn/comp-lz4.h	2016-12-26 12:51:00.0000000=
00 +0100
> +++ openvpn-2.4.0/src/openvpn/comp-lz4.h	2017-01-17 09:11:12.000000000 +0=
100
> @@ -28,6 +28,10 @@
>=20=20
>  #if defined(ENABLE_LZ4)
>=20=20
> +#if defined(HAVE_LZ4_H)
> +#include "lz4.h"
> +#endif
> +
>  #include "buffer.h"

Feature-ACK (I think this is a useful idea, for the same reasons we have
LZO and OpenSSL versions :-) ), but that will not work if we use=20
compat-lz4.h, so "code NAK".

comp-lz4.c currently has

#if defined(NEED_COMPAT_LZ4)
#include "compat-lz4.h"
#else
#include "lz4.h"
#endif

which might just be moved to comp-lz4.h, and then things should work.


>  extern const struct compress_alg lz4_alg;
> diff -Naur openvpn-2.4.0.orig/src/openvpn/options.c openvpn-2.4.0/src/ope=
nvpn/options.c
> --- openvpn-2.4.0.orig/src/openvpn/options.c	2016-12-26 12:51:00.00000000=
0 +0100
> +++ openvpn-2.4.0/src/openvpn/options.c	2017-01-17 09:11:12.000000000 +01=
00
> @@ -4121,11 +4121,17 @@
>  #else
>  #define LZO_LIB_VER_STR "", ""
>  #endif
> +#ifdef ENABLE_LZ4
> +#define LZ4_LIB_VER_STR ", LZ4 ", LZ4_versionString()
> +#else
> +#define LZ4_LIB_VER_STR "", ""
> +#endif
>=20=20
> -    msg(flags, "library versions: %s%s%s", SSL_LIB_VER_STR, LZO_LIB_VER_=
STR);
> +    msg(flags, "library versions: %s%s%s%s%s", SSL_LIB_VER_STR, LZO_LIB_=
VER_STR, LZ4_LIB_VER_STR);
>=20=20
>  #undef SSL_LIB_VER_STR
>  #undef LZO_LIB_VER_STR
> +#undef LZ4_LIB_VER_STR
>  }

That part looks good.

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--fzxPtQiUsqZaJiu9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZxXm/AAoJEB2Cnv7KVigSpEcMALQsJkgi0eZYZuxIK3VPk4rB
zNxpkVypQd8aTD8SgytqS5biNX2iyq+IAS6m/bTCyQIsqz2i5tDzUIX5gij3UJpg
0MjM6tkz+QNOsTxmO16qClDtL32CIESFPOGp6WbILghU4ANbs/ETSPJtS3qESo6S
36okTtLDLlx0P9KzksabWj+BQsoUUaeGCIk/T4SF1dCInPeAwyUAXVtL35EjwQ5k
5JpiptA7n9k0viRlfm1vDavv6CMahTVReLNEOcauSXUV9fLF3gTfn7y0dFijAnG7
ebWOQcdnqdwoR1q01pAw7Y6utJWLMjx0Xf4pHfJbe96lPqJdYT874+Fe2BEM9U0u
aagsNmqgVqWSOrSxioDev3+FFy5PZ1EHBJRhCTNWOOX9sr6Gwe+C1yXMf2x+w3/d
SvnP4KQvv+2hdS9/G237SHVmVU74Vt1R1WH6CHDHW8VJmv7wHBUkNV1NsXUm78hh
6R8p0brg97eD2M0Td21YvOcxw8OmVklF1R2iNKfWMg==
=GVxm
-----END PGP SIGNATURE-----

--fzxPtQiUsqZaJiu9--

