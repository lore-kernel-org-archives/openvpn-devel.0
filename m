MIME-Version: 1.0
In-Reply-To: <1322823734-17993-1-git-send-email-davids@...1347...>
References: <1322823734-17993-1-git-send-email-davids@...1347...>
Date: Fri, 2 Dec 2011 14:28:35 +0200
Message-ID: <CAOazyz0=n=7w6d-k3rcwBOsEJ+35aDLwZ8uPugPb8_b2QbgM6g@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Windows does not have dirname() -
 reimplement a portable version
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

I think the whole code should be more autoconf depended.
Autoconf can detect if POSIX version is available and if not, code can
provide alternative.
No need for the openvpn_ functions and wrappers.

On Fri, Dec 2, 2011 at 1:02 PM, David Sommerseth <davids@...1347...> wrote:
>
> Commit 0f2bc0dd92f43c91e33bba8a66b06b98f281efc1 adds some extra
> checks on configured files and directories. =C2=A0This required use of
> the dirname() function. =C2=A0Unfortunately, this function is not availab=
le
> on Windows.
>
> This function reimplements the POSIX variant of dirname(), using the
> framework already available in openvpn_basename(). =C2=A0The POSIX variant
> of dirname() will modify the input data.
>
> Signed-off-by: David Sommerseth <davids@...1347...>
> Cc: Heiko Hund <heiko.hund@...1489...>
> ---
> =C2=A0misc.c =C2=A0 =C2=A0| =C2=A0 36 ++++++++++++++++++++++++++++++++----
> =C2=A0misc.h =C2=A0 =C2=A0| =C2=A0 =C2=A03 +++
> =C2=A0options.c | =C2=A0 =C2=A03 +--
> =C2=A03 files changed, 36 insertions(+), 6 deletions(-)
>
> diff --git a/misc.c b/misc.c
> index 99e5bc5..eb04918 100644
> --- a/misc.c
> +++ b/misc.c
> @@ -2370,10 +2370,13 @@ argv_test (void)
> =C2=A0}
> =C2=A0#endif
>
> -const char *
> -openvpn_basename (const char *path)
> +
> +enum ovpn_dirbasename_t { DIRNAME, BASENAME };
> +
> +static inline char *
> +openvpn_dirbasename(char *path, enum ovpn_dirbasename_t type)
> =C2=A0{
> - =C2=A0const char *ret;
> + =C2=A0char *ret;
> =C2=A0 const int dirsep =3D OS_SPECIFIC_DIRSEP;
>
> =C2=A0 if (path)
> @@ -2384,11 +2387,36 @@ openvpn_basename (const char *path)
> =C2=A0 =C2=A0 =C2=A0 else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D path;
> =C2=A0 =C2=A0 =C2=A0 if (*ret)
> - =C2=A0 =C2=A0 =C2=A0 return ret;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0switch( type ) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0case BASENAME:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0case DIRNAME:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* This implements the POSIX variant =
of dirname(),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * which do modify the input
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*(ret-1) =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return path;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 }
> =C2=A0 return NULL;
> =C2=A0}
>
> +const char *
> +openvpn_basename (const char *path)
> +{
> + =C2=A0/* the path is recasted as non-const, as we are sure it will not =
be modified
> + =C2=A0 * in the basename type
> + =C2=A0 */
> + =C2=A0return (const char *) openvpn_dirbasename((char *) path, BASENAME=
);
> +}
> +
> +const char *
> +openvpn_dirname (char *path)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return openvpn_dirbasename(path, DIRNAME);
> +}
> +
> =C2=A0/*
> =C2=A0* Remove security-sensitive strings from control message
> =C2=A0* so that they will not be output to log file.
> diff --git a/misc.h b/misc.h
> index b2e6f91..9b35f18 100644
> --- a/misc.h
> +++ b/misc.h
> @@ -384,6 +384,9 @@ size_t adjust_power_of_2 (size_t u);
> =C2=A0/* return the basename of path */
> =C2=A0const char *openvpn_basename (const char *path);
>
> +/* return the dirname of path - POSIX variant, which modifies the input =
*/
> +const char *openvpn_dirname (char *path);
> +
> =C2=A0/*
> =C2=A0* A printf-like function (that only recognizes a subset of standard=
 printf
> =C2=A0* format operators) that prints arguments to an argv list instead
> diff --git a/options.c b/options.c
> index 28296a5..a29c115 100644
> --- a/options.c
> +++ b/options.c
> @@ -53,7 +53,6 @@
> =C2=A0#include "forward.h"
> =C2=A0#include <ctype.h>
> =C2=A0#include <unistd.h>
> -#include <libgen.h>
>
> =C2=A0#include "memdbg.h"
>
> @@ -2616,7 +2615,7 @@ check_file_access(const int type, const char *file,=
 const int mode, const char *
> =C2=A0 if (type & CHKACC_DIRPATH)
> =C2=A0 =C2=A0 {
> =C2=A0 =C2=A0 =C2=A0 char *fullpath =3D strdup(file); =C2=A0/* POSIX dirn=
ame() implementaion may modify its arguments */
> - =C2=A0 =C2=A0 =C2=A0char *dirpath =3D dirname(fullpath);
> + =C2=A0 =C2=A0 =C2=A0const char *dirpath =3D openvpn_dirname(fullpath);
>
> =C2=A0 =C2=A0 =C2=A0 if (access (dirpath, mode|X_OK) !=3D 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errcode =3D errno;
> --
> 1.7.4.4
>
>
> -------------------------------------------------------------------------=
-----
> All the data continuously generated in your IT infrastructure
> contains a definitive record of customers, application performance,
> security threats, fraudulent activity, and more. Splunk takes this
> data and makes sense of it. IT sense. And common sense.
> http://p.sf.net/sfu/splunk-novd2d
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

