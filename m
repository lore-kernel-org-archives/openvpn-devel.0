Message-ID: <4F55E72D.2010306@...515...>
Date: Tue, 06 Mar 2012 12:30:05 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-10-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-10-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 09/52] cleanup: memcmp.c: remove unused
 source
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>


> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  configure.ac |    3 ---
>  memcmp.c     |   43 -------------------------------------------
>  2 files changed, 0 insertions(+), 46 deletions(-)
>  delete mode 100644 memcmp.c
>
> diff --git a/configure.ac b/configure.ac
> index 25dcc37..1c4d66c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -564,9 +564,6 @@ else
>=20=20
>  fi
>=20=20
> -dnl Required library functions
> -AC_FUNC_MEMCMP
> -
>  dnl
>  dnl Check for res_init
>  dnl
> diff --git a/memcmp.c b/memcmp.c
> deleted file mode 100644
> index d921aac..0000000
> --- a/memcmp.c
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -/*
> - *  OpenVPN -- An application to securely tunnel IP networks
> - *             over a single TCP/UDP port, with support for SSL/TLS-based
> - *             session authentication and key exchange,
> - *             packet encryption, packet authentication, and
> - *             packet compression.
> - *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License version 2
> - *  as published by the Free Software Foundation.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program (see the file COPYING included with this
> - *  distribution); if not, write to the Free Software Foundation, Inc.,
> - *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> - */
> -
> -#include "syshead.h"
> -
> -#include "memdbg.h"
> -
> -int
> -memcmp (const void *s1, const void *s2, size_t n)
> -{
> -  unsigned const char *p1 =3D s1, *p2 =3D s2;
> -  int d;
> -
> -  if (n)
> -    while (n-- > 0)
> -      {
> -	d =3D *p1++ - *p2++;
> -	if (d !=3D 0)
> -	  return d;
> -      }
> -  return 0;
> -}

My C-fu is fairly low, but this still seems to make sense as there's no
memcmp.h. The memcmp function calls in other source files seem to use
memcmp function stored elsewhere (gcc[1], libc[2], etc.).

ACK.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


[1] <http://justin.harmonize.fm/index.php/2009/05/exploring-memcmp>
[2]
<http://www.slac.stanford.edu/comp/unix/package/rtems/doc/html/libc/libc.in=
fo.memcmp.html>

