MIME-Version: 1.0
In-Reply-To: <1323344337-13193-1-git-send-email-davids@...1347...>
References: <CAOazyz13pmU4=6XOA-2uq0rAwTMRrRYF73sszehxbcPQsa2rmQ@...278...>
	<1323344337-13193-1-git-send-email-davids@...1347...>
Date: Thu, 8 Dec 2011 14:30:33 +0200
Message-ID: <CAOazyz03dJ_UaNM=K1hm+2FuA3=UxjDc24td-Szei8vGUB9w4g@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Enable access() when building in Visual
	Studio
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

Well, this is small and beautiful! :)

On Thu, Dec 8, 2011 at 1:38 PM, David Sommerseth <davids@...1347...> wrote:
> Visual Studio does not enable certiain standard Unix functions,
> such as access(). =C2=A0By defining _CRT_NONSTDC_NO_WARNINGS and
> _CRT_SECURE_NO_WARNINGS, these functions are enabled.
>
> This patch also adds a ./configure check for access() as well,
> in case this needs to be implemented on other platforms lacking
> this feature. =C2=A0Which is why HAVE_ACCESS is defined in win/config.h.in
>
> Thanks to Alon Bar-Lev for helping solving this.
>
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
> =C2=A0configure.ac =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0options.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 -
> =C2=A0win/config.h.in | =C2=A0 28 ++++++++++++++++++++++++++++
> =C2=A0win/msvc.mak.in | =C2=A0 =C2=A02 +-
> =C2=A04 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 173d6e2..f8b3dd6 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -515,7 +515,7 @@ AC_CHECK_FUNCS(daemon chroot getpwnam setuid nice sys=
tem getpid dup dup2 dnl
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 getpass strerror syslog =
openlog mlockall getgrnam setgid dnl
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setgroups stat flock rea=
dv writev time dnl
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setsid chdir putenv getp=
eername unlink dnl
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chsize ftruncate execve=
 getpeereid umask basename dirname)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chsize ftruncate execve=
 getpeereid umask basename dirname access)
>
> =C2=A0# Windows use stdcall for winsock so we cannot auto detect these
> =C2=A0m4_define([SOCKET_FUNCS], [socket recv recvfrom send sendto listen =
dnl
> diff --git a/options.c b/options.c
> index 2280e9b..508fc82 100644
> --- a/options.c
> +++ b/options.c
> @@ -52,7 +52,6 @@
> =C2=A0#include "configure.h"
> =C2=A0#include "forward.h"
> =C2=A0#include <ctype.h>
> -#include <unistd.h>
>
> =C2=A0#include "memdbg.h"
>
> diff --git a/win/config.h.in b/win/config.h.in
> index e9df379..b5c31b8 100644
> --- a/win/config.h.in
> +++ b/win/config.h.in
> @@ -223,6 +223,34 @@ typedef unsigned long in_addr_t;
> =C2=A0/* Special Windows version of getpass() defined in io.c */
> =C2=A0#define HAVE_GETPASS 1
>
> +
> +/* The POSIX access() function is available, but requires
> + * _CRT_NONSTDC_NO_WARNINGS and _CRT_SECURE_NO_WARNINGS
> + * to be defined
> + */
> +#define HAVE_ACCESS 1
> +
> +/* Macros used by the POSIX access() function might not be available on =
Windows.
> + * Based on information found here:
> + * http://msdn.microsoft.com/en-us/library/1w06ktdy%28v=3Dvs.80%29.aspx
> + */
> +#ifndef R_OK
> +#define R_OK 4
> +#endif
> +
> +#ifndef W_OK
> +#define W_OK 2
> +#endif
> +
> +#ifndef X_OK
> +#define X_OK 1
> +#endif
> +
> +#ifndef F_OK
> +#define F_OK 0
> +#endif
> +
> +
> =C2=A0/* Define to the full name and version of this package. */
> =C2=A0#ifdef DEBUG_LABEL
> =C2=A0#define PACKAGE_STRING PACKAGE_NAME " " PACKAGE_VERSION " " DEBUG_L=
ABEL
> diff --git a/win/msvc.mak.in b/win/msvc.mak.in
> index 26d7a33..115e395 100644
> --- a/win/msvc.mak.in
> +++ b/win/msvc.mak.in
> @@ -38,7 +38,7 @@ LIB_DIRS =3D -LIBPATH:$(OPENSSL)\lib -LIBPATH:$(POLARSS=
L)\build\library -LIBPATH:$
> =C2=A0EXE =3D openvpn.exe
>
> =C2=A0CPP=3Dcl.exe
> -CPP_ARG_COMMON=3D/nologo /W3 -DWIN32 -DWIN32_LEAN_AND_MEAN -D_CONSOLE -D=
_MBCS -D_CRT_SECURE_NO_DEPRECATE $(INCLUDE_DIRS) /FD /c
> +CPP_ARG_COMMON=3D/nologo /W3 -DWIN32 -DWIN32_LEAN_AND_MEAN -D_CONSOLE -D=
_MBCS -D_CRT_SECURE_NO_DEPRECATE -D_CRT_NONSTDC_NO_WARNINGS -D_CRT_SECURE_N=
O_WARNINGS $(INCLUDE_DIRS) /FD /c
>
> =C2=A0LINK32=3Dlink.exe
>
> --
> 1.7.4.4
>

