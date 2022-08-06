Date: Sat, 6 Aug 2022 12:38:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yu5ElQzRxwGRG8Tn@...1296...>
References: <YukYNOwpaIeA7j80@...1296...>
 <20220804150301.62856-1-frank@...2641...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="DOJOlkMhc+6ZeX2M"
Content-Disposition: inline
In-Reply-To: <20220804150301.62856-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] config-version.h: remove unused
 includes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--DOJOlkMhc+6ZeX2M
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 04, 2022 at 05:03:00PM +0200, Frank Lichtenheld wrote:
> We only need to include this when we want the
> git version. This is currently only the case
> in options.c

Feature-ACK, but NAK on this hunk:

> diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
> index 51136fea..dc7fd459 100644
> --- a/src/openvpn/plugin.c
> +++ b/src/openvpn/plugin.c
> @@ -26,9 +26,6 @@
>  #elif defined(_MSC_VER)
>  #include "config-msvc.h"
>  #endif
> -#ifdef HAVE_CONFIG_VERSION_H
> -#include "config-version.h"
> -#endif

plugin.c actually uses CONFIGURE_GIT_REVISION for the openvpn version
visible to plugins

#ifndef CONFIGURE_GIT_REVISION
#define _OPENVPN_PATCH_LEVEL OPENVPN_VERSION_PATCH
#else
#define _OPENVPN_PATCH_LEVEL "git:" CONFIGURE_GIT_REVISION CONFIGURE_GIT_FL=
AGS
#endif
...
            struct openvpn_plugin_args_open_in args =3D { p->plugin_type_ma=
sk,
...
                                                        _OPENVPN_PATCH_LEVE=
L};


The other two (block_dns.c and tapctl.c) can go.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--DOJOlkMhc+6ZeX2M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi7kSVAAoJEB2Cnv7KVigSnvwMALLWvH/Xp4Uas4U5V94yOnnx
2EDAPEOra6eQ89+cU1QkFFwlMil4VhOLC/Ta8HDKWTv4QbqQ5aWxTUfOklbFiok6
XzYSwwHZgohQIiSLMFre0GR9FMMD576cn8dkhCVibiqF0N0+FsH6ZKNAlA/45/DR
i4Su1b9QFuVMjmJnGDtvsD+obGjaHUcQQhwQDg0Q+Nu1as16I59elWd3bqOpvefl
u2BTGZjrgrBwN3Lby5osiqW8MW0SHx+/hjdOdZqyVgorDH00FavlKX/nJXLdJG4G
eloNWziJHxFQmpR9AVyQwuaFPl15jAgI8feAn52DtpIQmGvOr6EvvhNl6P3aOhkL
bro8jTBGtM/I8WdVfBozEQ2ZLPLlJ3x5sR0dnTmY1pjOZZwGoOvQJLlg+OHODCpn
fu5uRf3kv5h1ZiJ9uiP2HNvXzUBYj3TX7tyDgaWtx33r59V7jvAePcV6zfYnVlza
Jbrpn6TN1IIFm/efSiUkS7V2ZeoYJzWB3GSsTyM02g==
=s7V2
-----END PGP SIGNATURE-----

--DOJOlkMhc+6ZeX2M--

