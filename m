References: <1479163508-19435-1-git-send-email-davids@...515...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <c4d87247-460c-0860-5748-a62f0304653a@...1435...>
Date: Wed, 16 Nov 2016 11:44:12 +0100
MIME-Version: 1.0
In-Reply-To: <1479163508-19435-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] file checks: Merge
 warn_if_group_others_accessible() into check_file_access()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

On 14-11-16 23:45, David Sommerseth wrote:
> Commit 825e2ec1f358f2e8 cleaned up the usage of warn_if_group_others_acce=
ssible()
> and moved it into options.c.  At this point there is only one caller of t=
his
> function, check_file_access().
>=20
> This takes that clean-up one step further and merges everything into
> check_file_access().  In addition it removes some no longer needed #ifdefs
> and uses platform_stat() to allow a similar check to happen on the Windows
> platform as well.
>=20
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  src/openvpn/options.c | 38 ++++++++++++--------------------------
>  1 file changed, 12 insertions(+), 26 deletions(-)
>=20
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 4d31e4c..369f3f4 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -57,6 +57,7 @@
>  #include "manage.h"
>  #include "forward.h"
>  #include "ssl_verify.h"
> +#include "platform.h"
>  #include <ctype.h>
>=20=20
>  #include "memdbg.h"
> @@ -2683,31 +2684,6 @@ options_postprocess_mutate (struct options *o)
>   */
>  #ifndef ENABLE_SMALL  /** Expect people using the stripped down version =
to know what they do */
>=20=20
> -/*
> - * Warn if a given file is group/others accessible.
> - */
> -static void
> -warn_if_group_others_accessible (const char* filename)
> -{
> -#ifndef WIN32
> -#ifdef HAVE_STAT
> -  if (strcmp (filename, INLINE_FILE_TAG))
> -    {
> -      struct stat st;
> -      if (stat (filename, &st))
> -	{
> -	  msg (M_WARN | M_ERRNO, "WARNING: cannot stat file '%s'", filename);
> -	}
> -      else
> -	{
> -	  if (st.st_mode & (S_IRWXG|S_IRWXO))
> -	    msg (M_WARN, "WARNING: file '%s' is group or others accessible", fi=
lename);
> -	}
> -    }
> -#endif
> -#endif
> -}
> -
>  #define CHKACC_FILE (1<<0)       /** Check for a file/directory precense=
 */
>  #define CHKACC_DIRPATH (1<<1)    /** Check for directory precense where =
a file should reside */
>  #define CHKACC_FILEXSTWR (1<<2)  /** If file exists, is it writable? */
> @@ -2754,9 +2730,19 @@ check_file_access(const int type, const char *file=
, const int mode, const char *
>      if (platform_access (file, W_OK) !=3D 0)
>        errcode =3D errno;
>=20=20
> +  /* Warn if a given file is group/others accessible. */
>    if (type & CHKACC_PRIVATE)
>      {
> -      warn_if_group_others_accessible (file);
> +      platform_stat_t st;
> +      if (platform_stat (file, &st))
> +	{
> +	  msg (M_WARN | M_ERRNO, "WARNING: cannot stat file '%s'", file);
> +	}
> +      else
> +	{
> +	  if (st.st_mode & (S_IRWXG|S_IRWXO))
> +	    msg (M_WARN, "WARNING: file '%s' is group or others accessible", fi=
le);
> +	}
>      }
>=20=20
>    /* Scream if an error is found */
>=20

Hm, I like the removal of the #ifdefs, but I don't think we should merge
warn_if_group_others_accessible() into check_file_access().  Why?
Because when it was a separate function, the code was self-documenting
and nicely separated.  Now, we need an extra comment that basically
exists of the previous function name to explain what we're doing.

I was also wondering, have you tested that this work as expected on
Windows?  Since Windows has a quite different permission system.  Or
will is simply never warn, like before?  That would be fine for this patch.

-Steffan

