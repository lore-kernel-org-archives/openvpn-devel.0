MIME-Version: 1.0
References: <20200229123515.9745-1-lstipakov@...277...>
In-Reply-To: <20200229123515.9745-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 29 Feb 2020 20:11:06 -0500
Message-ID: <CAKuzo_g4OKFEfRGaUAWa__BnsiYLR8kw58Dy5=UqvJEYaMpG1Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH] interactive.c: remove unused function
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

Hi,

On Sat, Feb 29, 2020 at 7:36 AM Lev Stipakov <lstipakov@...277...> wrote:
>
> From: Lev Stipakov <lev@...515...>
>
> Function ReturnOpenvpnOutput was used to read
> openvpn process output and write it to openvpn-gui.
>
> Commit 852f1e4 has directed stdout/stderr streams of openvpn
> process to NUL, after which ReturnOpenvpnOutput() has become unused.
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpnserv/interactive.c | 25 -------------------------
>  1 file changed, 25 deletions(-)
>
> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index 8da49be6..1f13163e 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -361,31 +361,6 @@ ReturnLastError(HANDLE pipe, LPCWSTR func)
>      ReturnError(pipe, GetLastError(), func, 1, &exit_event);
>  }
>
> -
> -static VOID
> -ReturnOpenvpnOutput(HANDLE pipe, HANDLE ovpn_output, DWORD count, LPHANDLE events)
> -{
> -    WCHAR *wide_output = NULL;
> -    CHAR output[512];
> -    DWORD size;
> -
> -    ReadFile(ovpn_output, output, sizeof(output), &size, NULL);
> -    if (size == 0)
> -    {
> -        return;
> -    }
> -
> -    wide_output = malloc((size) * sizeof(WCHAR));
> -    if (wide_output)
> -    {
> -        MultiByteToWideChar(CP_UTF8, 0, output, size, wide_output, size);
> -        wide_output[size - 1] = 0;
> -    }
> -
> -    ReturnError(pipe, ERROR_OPENVPN_STARTUP, wide_output, count, events);
> -    free(wide_output);
> -}
> -
>  /*
>   * Validate options against a white list. Also check the config_file is
>   * inside the config_dir. The white list is defined in validate.c

Makes sense to get rid of this unused static function.
Compile tested.

Acked-by: <selva.nair@...277...>

