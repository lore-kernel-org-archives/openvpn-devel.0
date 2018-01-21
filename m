MIME-Version: 1.0
In-Reply-To: <20180120164114.12478-1-steffan@...1856...>
References: <20180120164114.12478-1-steffan@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 21 Jan 2018 00:37:00 -0500
Message-ID: <CAKuzo_hZh0+P2-CjdQ9Y4xVMxB5WsJEEOt8nR7rG72fGCdie7Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Enable extra compiler warnings by
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

On Sat, Jan 20, 2018 at 11:41 AM, Steffan Karger <steffan@...1856...> wrote:
>
> This by default enables the compiler warnings any could previously
> enable using the --enable-strict configure option.  I think it is
> okay to do so now, because we've taken care of many warnings in the
> more standard builds.  (Most of those were totally harmless, but they
> prevented us from spotting new more serious mistakes.)
>
> Those who prefer a more silent build can use --disable-strict to revert
> to the old default behaviour.

I think --enable-strict by default is good to have. In fact its needed to
keep on bugging us about many of those printf format spec issues we
still have with mingw.

>
>
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  configure.ac | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 2c1937e5..2b5fa533 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -209,9 +209,9 @@ AC_ARG_ENABLE(
>
>  AC_ARG_ENABLE(
>         [strict],
> -       [AS_HELP_STRING([--enable-strict], [enable strict compiler warnings (debugging option) @<:@default=no@:>@])],
> +       [AS_HELP_STRING([--disable-strict], [enable strict compiler warnings (debugging option) @<:@default=yes@:>@])],

The description should now read "disable strict compiler warnings...",
isn't it? Could be fixed while merging..

>
>         ,
> -       [enable_strict="no"]
> +       [enable_strict="yes"]
>  )
>
>  AC_ARG_ENABLE(

Selva

