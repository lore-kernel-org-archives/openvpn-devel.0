MIME-Version: 1.0
References: <20230516024232.2680491-1-selva.nair@...277...>
In-Reply-To: <20230516024232.2680491-1-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 16 May 2023 13:53:22 +0300
Message-ID: <CAGyAFMUiWYMzof123MxOhQEnU1VUvaHLordQXc27txhZd5Mxbg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Correctly handle Unicode names for exit
 event
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
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

Hi,

My understanding is that this is related to
https://github.com/OpenVPN/openvpn-gui/issues/626#issuecomment-1546934297
since normally we use string representation of HANDLE value
as an event name.

Looks good to me. Also compiled and tested.

Acked-by: Lev Stipakov <lstipakov@...277...>

ti 16. toukok. 2023 klo 5.57 selva.nair@...277... kirjoitti:
>
> From: Selva Nair <selva.nair@...277...>
>
> Currently we use the ANSI version of CreateEvent causing name of the
> exit event to be interpreted differently depending on the code page
> in effect. Internally all strings parsed from command line and config
> file are stored as UTF8-encoded Uniode. When passed to Windows API calls,
> these should be converted to UTF16 and wide character version of the API
> should be used.
>
> CreateEvent calls for unnamed events are left unchanged as there is no
> text-encoding dependence in those cases.
>
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/win32.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
> index 1ae3723f..25da54ab 100644
> --- a/src/openvpn/win32.c
> +++ b/src/openvpn/win32.c
> @@ -509,19 +509,19 @@ win32_signal_open(struct win32_signal *ws,
>          && !HANDLE_DEFINED(ws->in.read) && exit_event_name)
>      {
>          struct security_attributes sa;
> +        struct gc_arena gc = gc_new();
> +        const wchar_t *exit_event_nameW = wide_string(exit_event_name, &gc);
>
>          if (!init_security_attributes_allow_all(&sa))
>          {
>              msg(M_ERR, "Error: win32_signal_open: init SA failed");
>          }
>
> -        ws->in.read = CreateEvent(&sa.sa,
> -                                  TRUE,
> -                                  exit_event_initial_state ? TRUE : FALSE,
> -                                  exit_event_name);
> +        ws->in.read = CreateEventW(&sa.sa, TRUE, exit_event_initial_state ? TRUE : FALSE,
> +                                   exit_event_nameW);
>          if (ws->in.read == NULL)
>          {
> -            msg(M_WARN|M_ERRNO, "NOTE: CreateEvent '%s' failed", exit_event_name);
> +            msg(M_WARN|M_ERRNO, "NOTE: CreateEventW '%s' failed", exit_event_name);
>          }
>          else
>          {
> @@ -534,6 +534,7 @@ win32_signal_open(struct win32_signal *ws,
>                  ws->mode = WSO_MODE_SERVICE;
>              }
>          }
> +        gc_free(&gc);
>      }
>      /* set the ctrl handler in both console and service modes */
>      if (!SetConsoleCtrlHandler((PHANDLER_ROUTINE) win_ctrl_handler, true))
> --
> 2.34.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



-- 
-Lev

