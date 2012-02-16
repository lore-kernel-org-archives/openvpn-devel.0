MIME-Version: 1.0
In-Reply-To: <1329413441-22538-3-git-send-email-heiko.hund@...1489...>
References: <1329413441-22538-1-git-send-email-heiko.hund@...1489...>
	<1329413441-22538-3-git-send-email-heiko.hund@...1489...>
Date: Thu, 16 Feb 2012 20:34:34 +0200
Message-ID: <CAOazyz0W43Hop+8d4gzB9cAsA-CH55185rgd6evDR0uJ=tf7SQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] do not use mode_t on Windows
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
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

I stopped following all OpenVPN changes.
It seems like more changes are entered than should without proper review.

Anyway, this is not the correct solution.
Correct solution is to have config-msvc.h and have:
---
#define mode_t int
---

And in autoconf (if mingw does not have this as well):
AC_CHECK_DECLS(
    [mode_t],
    ,
    [AC_DEFINE([mode_t],[int], [Emulate mode_t])],
    [[
        #include <fcntl.h>
    ]]
)

On Thu, Feb 16, 2012 at 7:30 PM, Heiko Hund <heiko.hund@...1489...> wrote:
>
> The MSVC headers do not define mode_t. open() uses an int for
> the permissions instead. Fixes building with the MSVC based
> buildsystem.
>
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
> =C2=A0misc.h =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0win32.c | =C2=A0 =C2=A02 +-
> =C2=A02 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/misc.h b/misc.h
> index 8c0bae1..e7a0b55 100644
> --- a/misc.h
> +++ b/misc.h
> @@ -158,7 +158,7 @@ openvpn_fopen (const char *path, const char *mode)
> =C2=A0#endif
>
> =C2=A0#ifdef WIN32
> -int openvpn_open (const char *path, int flags, mode_t mode);
> +int openvpn_open (const char *path, int flags, int mode);
> =C2=A0#else
> =C2=A0static inline int
> =C2=A0openvpn_open (const char *path, int flags, mode_t mode)
> diff --git a/win32.c b/win32.c
> index 5b38918..a8f4ed9 100644
> --- a/win32.c
> +++ b/win32.c
> @@ -1064,7 +1064,7 @@ openvpn_fopen (const char *path, const char *mode)
> =C2=A0}
>
> =C2=A0int
> -openvpn_open (const char *path, int flags, mode_t mode)
> +openvpn_open (const char *path, int flags, int mode)
> =C2=A0{
> =C2=A0 struct gc_arena gc =3D gc_new ();
> =C2=A0 int fd =3D _wopen (wide_string (path, &gc), flags, mode);
> --
> 1.7.5.4
>
>
> -------------------------------------------------------------------------=
-----
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

