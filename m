MIME-Version: 1.0
In-Reply-To: <1384882574-28242-1-git-send-email-heiko.hund@...1489...>
References: <528B8225.3040206@...515...>
	<1384882574-28242-1-git-send-email-heiko.hund@...1489...>
Date: Wed, 4 Dec 2013 14:19:20 +0600
Message-ID: <CAFHpkQF2RV_+1GSB69v4rGm7gauuw1=MeiXdEiApyC5urYpm2A@...278...>
From: =?KOI8-R?B?6czY0SD7ydDJw8nO?= <chipitsine@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Support non-ASCII characters in Windows
 tmp path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

I confirm such a bug. Patch resolves it.
still not commited to https://github.com/openvpn/openvpn ?

2013/11/19 Heiko Hund <heiko.hund@...1489...>:
> Get the temporary path from the system as UCS-2 and convert it to
> UTF-8 and return that for internal use.
>
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  src/openvpn/win32.c |   34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
> index 022eec5..b27e846 100644
> --- a/src/openvpn/win32.c
> +++ b/src/openvpn/win32.c
> @@ -996,19 +996,27 @@ set_win_sys_path_via_env (struct env_set *es)
>  const char *
>  win_get_tempdir()
>  {
> -  static char buf[MAX_PATH];
> -  char *tmpdir = buf;
> -
> -  CLEAR(buf);
> -
> -  if (!GetTempPath(sizeof(buf),buf)) {
> -    /* Warn if we can't find a valid temporary directory, which should
> -     * be unlikely.
> -     */
> -    msg (M_WARN, "Could not find a suitable temporary directory."
> -         " (GetTempPath() failed).  Consider to use --tmp-dir");
> -    tmpdir = NULL;
> -  }
> +  static char tmpdir[MAX_PATH];
> +  WCHAR wtmpdir[MAX_PATH];
> +
> +  if (!GetTempPathW(_countof(wtmpdir), wtmpdir))
> +    {
> +      /* Warn if we can't find a valid temporary directory, which should
> +       * be unlikely.
> +       */
> +      msg (M_WARN, "Could not find a suitable temporary directory."
> +          " (GetTempPath() failed).  Consider to use --tmp-dir");
> +      return NULL;
> +    }
> +
> +  if (WideCharToMultiByte (CP_UTF8, 0, wtmpdir, -1, NULL, 0, NULL, NULL) > sizeof (tmpdir))
> +    {
> +      msg (M_WARN, "Could not get temporary directory. Path is too long."
> +          "  Consider to use --tmp-dir");
> +      return NULL;
> +    }
> +
> +  WideCharToMultiByte (CP_UTF8, 0, wtmpdir, -1, tmpdir, sizeof (tmpdir), NULL, NULL);
>    return tmpdir;
>  }
>  #endif
> --
> 1.7.9.5
>
>
> ------------------------------------------------------------------------------
> Shape the Mobile Experience: Free Subscription
> Software experts and developers: Be at the forefront of tech innovation.
> Intel(R) Software Adrenaline delivers strategic insight and game-changing
> conversations that shape the rapidly evolving mobile landscape. Sign up now.
> http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

