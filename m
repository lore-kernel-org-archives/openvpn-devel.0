Message-ID: <4F633524.1060602@...515...>
Date: Fri, 16 Mar 2012 14:42:12 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1330547702-18756-1-git-send-email-alon.barlev@...277...>
	<1330547854-18889-3-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330547854-18889-3-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [tap-windows 05/11] build: set default to newer
 ddk
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

I think we can drop WinDDK <=3D 5600 support entirely. If I'm not
mistaken, this means supporting Visual Studio 2008 and later only, which
is fine. Afaik the only "reason" to support Visual Studio 2005 and older
is Win2k support, which we don't need. OpenVPN 2.1.3 was the last
version with Win2k support anyways.

Besides that, it's an ACK.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  src/prototypes.h |    2 +-
>  src/tapdrvr.c    |    5 +----
>  2 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/src/prototypes.h b/src/prototypes.h
> index 55454d5..18c566f 100755
> --- a/src/prototypes.h
> +++ b/src/prototypes.h
> @@ -202,7 +202,7 @@ VOID HookDispatchFunctions();
>=20=20
>  #if ENABLE_NONADMIN
>=20=20
> -#if DDKVER_MAJOR < 5600
> +#if defined(DDKVER_MAJOR) && DDKVER_MAJOR < 5600
>  /*
>   * Better solution for use on Vista DDK, but possibly not compatible with
>   * earlier DDKs:
> diff --git a/src/tapdrvr.c b/src/tapdrvr.c
> index 0df076a..0f75b77 100755
> --- a/src/tapdrvr.c
> +++ b/src/tapdrvr.c
> @@ -36,9 +36,6 @@
>  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>=20=20
>  #include "common.h"
> -#ifndef DDKVER_MAJOR
> -#error DDKVER_MAJOR must be defined as the major number of the DDK Versi=
on
> -#endif
>=20=20
>  #define NDIS_MINIPORT_DRIVER
>  #define BINARY_COMPATIBLE 0
> @@ -66,7 +63,7 @@
>  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>  #define ENABLE_NONADMIN 1
>=20=20
> -#if DDKVER_MAJOR < 5600
> +#if defined(DDKVER_MAJOR) && DDKVER_MAJOR < 5600
>  #include <ndis.h>
>  #include <ntstrsafe.h>
>  #include <ntddk.h>


