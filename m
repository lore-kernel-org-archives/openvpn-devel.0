MIME-Version: 1.0
In-Reply-To: <20180201154521.7642-1-steffan@...1856...>
References: <20180201072731.GU69387@...1296...>
 <20180201154521.7642-1-steffan@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 1 Feb 2018 23:43:39 -0500
Message-ID: <CAKuzo_jyu-zuJDTXJkB2iV=MQ=Yx74uo_Eo8XN3Sgr5YLR460g@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Enable stricter compiler warnings by
 default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Thu, Feb 1, 2018 at 10:45 AM, Steffan Karger <steffan@...1856...> wrote:
> This by default enables the compiler warnings one could previously
> enable using the --enable-strict configure option.  I think it is
> okay to do so now, because we've taken care of many warnings in the
> more standard builds.  (Most of those were totally harmless, but they
> prevented us from spotting new more serious mistakes.)
>
> The --enable-strict flag now enables two extra warning flags that I
> think can be useful:
>
> -Wsign-compare warns when the compiler promotes a signed type to
> unsigned before comparing, which can lead to unexpected behaviour.
>
> -Wuninitialized adds extra warnings about usage of uninitialized variables
> or struct elements.
>
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
> v2: Just move forward with warnings, don't add --disable-strict.
> v3: Nothing is as simple as it seems:

:)

>     put user-supplied CFLAGS behind
>     default flags, check that potential esotheric compiler supports
>     flags before enabling them.
>
>  configure.ac                | 12 +++++++-
>  m4/ax_check_compile_flag.m4 | 74 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+), 1 deletion(-)
>  create mode 100644 m4/ax_check_compile_flag.m4
>
> diff --git a/configure.ac b/configure.ac
> index 2cbf3358..33b6bc8e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1292,13 +1292,23 @@ if test "${enable_pkcs11}" = "yes"; then
>         )
>  fi
>
> +AX_CHECK_COMPILE_FLAG(
> +    [-Wno-unused-function],
> +    [CFLAGS="-Wno-unused-function ${CFLAGS}"]
> +)

As Steffan himself noted, need tabs instead of spaces for consistency

> +AX_CHECK_COMPILE_FLAG(
> +    [-Wno-unused-parameter],
> +    [CFLAGS="-Wno-unused-parameter ${CFLAGS}"]
> +)

same here

> +AX_CHECK_COMPILE_FLAG([-Wall], [CFLAGS="-Wall ${CFLAGS}"])

The three options could have checked together, but this is fine too.

All said and done, the check is not as useful as I had imagined..
AX_CHECK_COMPLIE_FLAG only catches errors, not warnings.
For instance, IBM's xlc, at least on Linux, only warns about unknown options.
So nothing gained -- in fact 4 warning lines per source file caused by
these options.
Hopefully, its still useful on some other never used build envs..

Anyway, the check protects against probable build failures on some unknown
systems, and I won't waste any more time dwelling on this.

> +
>  if test "${enable_pedantic}" = "yes"; then
>         enable_strict="yes"
>         CFLAGS="${CFLAGS} -pedantic"
>         AC_DEFINE([PEDANTIC], [1], [Enable pedantic mode])
>  fi
>  if test "${enable_strict}" = "yes"; then
> -       CFLAGS="${CFLAGS} -Wall -Wno-unused-parameter -Wno-unused-function"
> +       CFLAGS="${CFLAGS} -Wsign-compare -Wuninitialized"
>  fi
>  if test "${enable_werror}" = "yes"; then
>         CFLAGS="${CFLAGS} -Werror"
> diff --git a/m4/ax_check_compile_flag.m4 b/m4/ax_check_compile_flag.m4
> new file mode 100644
> index 00000000..dcabb92a
> --- /dev/null
> +++ b/m4/ax_check_compile_flag.m4
> @@ -0,0 +1,74 @@
> +# ===========================================================================
> +#  https://www.gnu.org/software/autoconf-archive/ax_check_compile_flag.html
> +# ===========================================================================
> +#
> +# SYNOPSIS
> +#
> +#   AX_CHECK_COMPILE_FLAG(FLAG, [ACTION-SUCCESS], [ACTION-FAILURE], [EXTRA-FLAGS], [INPUT])
> +#
> +# DESCRIPTION
> +#
> +#   Check whether the given FLAG works with the current language's compiler
> +#   or gives an error.  (Warnings, however, are ignored)
> +#
> +#   ACTION-SUCCESS/ACTION-FAILURE are shell commands to execute on
> +#   success/failure.
> +#
> +#   If EXTRA-FLAGS is defined, it is added to the current language's default
> +#   flags (e.g. CFLAGS) when the check is done.  The check is thus made with
> +#   the flags: "CFLAGS EXTRA-FLAGS FLAG".  This can for example be used to
> +#   force the compiler to issue an error when a bad flag is given.
> +#
> +#   INPUT gives an alternative input source to AC_COMPILE_IFELSE.
> +#
> +#   NOTE: Implementation based on AX_CFLAGS_GCC_OPTION. Please keep this
> +#   macro in sync with AX_CHECK_{PREPROC,LINK}_FLAG.
> +#
> +# LICENSE
> +#
> +#   Copyright (c) 2008 Guido U. Draheim <guidod@...68...>
> +#   Copyright (c) 2011 Maarten Bosmans <mkbosmans@...277...>
> +#
> +#   This program is free software: you can redistribute it and/or modify it
> +#   under the terms of the GNU General Public License as published by the
> +#   Free Software Foundation, either version 3 of the License, or (at your
> +#   option) any later version.
> +#
> +#   This program is distributed in the hope that it will be useful, but
> +#   WITHOUT ANY WARRANTY; without even the implied warranty of
> +#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
> +#   Public License for more details.
> +#
> +#   You should have received a copy of the GNU General Public License along
> +#   with this program. If not, see <https://www.gnu.org/licenses/>.
> +#
> +#   As a special exception, the respective Autoconf Macro's copyright owner
> +#   gives unlimited permission to copy, distribute and modify the configure
> +#   scripts that are the output of Autoconf when processing the Macro. You
> +#   need not follow the terms of the GNU General Public License when using
> +#   or distributing such scripts, even though portions of the text of the
> +#   Macro appear in them. The GNU General Public License (GPL) does govern
> +#   all other use of the material that constitutes the Autoconf Macro.
> +#
> +#   This special exception to the GPL applies to versions of the Autoconf
> +#   Macro released by the Autoconf Archive. When you make and distribute a
> +#   modified version of the Autoconf Macro, you may extend this special
> +#   exception to the GPL to apply to your modified version as well.
> +
> +#serial 5
> +
> +AC_DEFUN([AX_CHECK_COMPILE_FLAG],
> +[AC_PREREQ(2.64)dnl for _AC_LANG_PREFIX and AS_VAR_IF
> +AS_VAR_PUSHDEF([CACHEVAR],[ax_cv_check_[]_AC_LANG_ABBREV[]flags_$4_$1])dnl
> +AC_CACHE_CHECK([whether _AC_LANG compiler accepts $1], CACHEVAR, [
> +  ax_check_save_flags=$[]_AC_LANG_PREFIX[]FLAGS
> +  _AC_LANG_PREFIX[]FLAGS="$[]_AC_LANG_PREFIX[]FLAGS $4 $1"
> +  AC_COMPILE_IFELSE([m4_default([$5],[AC_LANG_PROGRAM()])],
> +    [AS_VAR_SET(CACHEVAR,[yes])],
> +    [AS_VAR_SET(CACHEVAR,[no])])
> +  _AC_LANG_PREFIX[]FLAGS=$ax_check_save_flags])
> +AS_VAR_IF(CACHEVAR,yes,
> +  [m4_default([$2], :)],
> +  [m4_default([$3], :)])
> +AS_VAR_POPDEF([CACHEVAR])dnl
> +])dnl AX_CHECK_COMPILE_FLAGS
> --
> 2.14.1

This macro is a part of autoconf archive which, I thought, is
prerequisite for building from the repo. One anyway needs autotools
installed. Can't we not insist on having these common macros be present
as well? After all this is for building from git sources, not from a
dist tarball
which needs no autotools.

Also the notes in the macro file says "Please keep this macro in sync with
AX_CHECK_{PREPROC,LINK}_FLAG." which is easier to do if we use the
system's installed copy.

Anyway, if including such m4 macros in the repo is the policy,  this
is fine.

Having done the self-satisfying nitpicking:

Acked-by: Selva Nair <selva.nair@...277...>

(compile tested: --Wall is surprisingly quiet on linux, but exposes
lots of warnings on Windows (mingw) some of which are not benign)

Selva

