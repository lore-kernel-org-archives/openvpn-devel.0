MIME-Version: 1.0
References: <CAKuzo_jwZagpBbAu3NehQ1E_N_=UiqOBYOFDrK88zg7-+vsSHA@...278...>
 <1540203571-17646-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1540203571-17646-1-git-send-email-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 22 Oct 2018 12:41:04 -0400
Message-ID: <CAKuzo_hytFZvmt3VAH2U5SN6kLR10cFN13P=z6uqtP=gZEVObA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Introduce openvpn_swprintf() with
 nul termination guarantee
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Mon, Oct 22, 2018 at 6:22 AM Lev Stipakov <lstipakov@...277...> wrote:
>
> From: Lev Stipakov <lev@...515...>
>
> Every call to swprintf is followed by line which adds nul terminator. This patch
> introduces openvpn_swprintf() which guarantees nul termination for size > 0.
>
> Same approach as for snprintf / openvpn_snprintf.
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
> v3:
>  - add missing function declaration
>  - fix indentation
>
> v2:
>  - rebase on top of master
>
>  src/openvpn/buffer.c          | 17 +++++++++++++++++
>  src/openvpn/buffer.h          | 11 +++++++++++
>  src/openvpn/tun.c             |  3 +--
>  src/openvpnserv/common.c      | 15 +++++++++++++++
>  src/openvpnserv/interactive.c | 26 ++++++++++----------------
>  src/openvpnserv/service.h     |  2 ++
>  src/openvpnserv/validate.c    |  3 +--
>  7 files changed, 57 insertions(+), 20 deletions(-)
>
> diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
> index 80fbb75..8ca189f 100644
> --- a/src/openvpn/buffer.c
> +++ b/src/openvpn/buffer.c
> @@ -37,6 +37,8 @@
>
>  #include "memdbg.h"
>
> +#include <wchar.h>
> +
>  size_t
>  array_mult_safe(const size_t m1, const size_t m2, const size_t extra)
>  {
> @@ -308,6 +310,21 @@ openvpn_snprintf(char *str, size_t size, const char *format, ...)
>      return (len >= 0 && len < size);
>  }
>
> +bool
> +openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t *const format, ...)
> +{
> +    va_list arglist;
> +    int len = -1;
> +    if (size > 0)
> +    {
> +        va_start(arglist, format);
> +        len = vswprintf(str, size, format, arglist);
> +        va_end(arglist);
> +        str[size - 1] = L'\0';
> +    }
> +    return (len >= 0 && len < size);
> +}
> +
>  /*
>   * write a string to the end of a buffer that was
>   * truncated by buf_printf
> diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
> index aab249f..c5b78a0 100644
> --- a/src/openvpn/buffer.h
> +++ b/src/openvpn/buffer.h
> @@ -448,6 +448,17 @@ __attribute__ ((format(__printf__, 3, 4)))
>  #endif
>  ;
>
> +
> +/*
> + * Like swprintf but guarantees null termination for size > 0
> + */
> +bool
> +openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t *const format, ...);
> +/*
> + * Unlike in openvpn_snprintf, we cannot use format attributes since
> + * GCC doesn't support wprintf as archetype.
> + */
> +
>  /*
>   * remove/add trailing characters
>   */
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 948fd17..c091401 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -4472,8 +4472,7 @@ get_adapter_index_method_1(const char *guid)
>      DWORD index;
>      ULONG aindex;
>      wchar_t wbuf[256];
> -    swprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%S", guid);
> -    wbuf [SIZE(wbuf) - 1] = 0;
> +    openvpn_swprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%S", guid);
>      if (GetAdapterIndex(wbuf, &aindex) != NO_ERROR)
>      {
>          index = TUN_ADAPTER_INDEX_INVALID;
> diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
> index 33a8097..fd51776 100644
> --- a/src/openvpnserv/common.c
> +++ b/src/openvpnserv/common.c
> @@ -57,6 +57,21 @@ openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...)
>      return res;
>  }
>
> +BOOL
> +openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t *const format, ...)
> +{
> +    va_list arglist;
> +    int len = -1;
> +    if (size > 0)
> +    {
> +        va_start(arglist, format);
> +        len = vswprintf(str, size, format, arglist);
> +        va_end(arglist);
> +        str[size - 1] = L'\0';
> +    }
> +    return (len >= 0 && len < size);
> +}
> +
>  static DWORD
>  GetRegString(HKEY key, LPCTSTR value, LPTSTR data, DWORD size, LPCTSTR default_value)
>  {
> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index 4a571f5..2dc152c 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -276,8 +276,7 @@ ReturnProcessId(HANDLE pipe, DWORD pid, DWORD count, LPHANDLE events)
>       * Same format as error messages (3 line string) with error = 0 in
>       * 0x%08x format, PID on line 2 and a description "Process ID" on line 3
>       */
> -    swprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%s", 0, pid, msg);
> -    buf[_countof(buf) - 1] = '\0';
> +    openvpn_swprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%s", 0, pid, msg);
>
>      WritePipeAsync(pipe, buf, (DWORD)(wcslen(buf) * 2), count, events);
>  }
> @@ -402,9 +401,8 @@ ValidateOptions(HANDLE pipe, const WCHAR *workdir, const WCHAR *options)
>
>          if (!CheckOption(workdir, 2, argv_tmp, &settings))
>          {
> -            swprintf(buf, _countof(buf), msg1, argv[0], workdir,
> -                     settings.ovpn_admin_group);
> -            buf[_countof(buf) - 1] = L'\0';
> +            openvpn_swprintf(buf, _countof(buf), msg1, argv[0], workdir,
> +                             settings.ovpn_admin_group);
>              ReturnError(pipe, ERROR_STARTUP_DATA, buf, 1, &exit_event);
>          }
>          goto out;
> @@ -421,16 +419,14 @@ ValidateOptions(HANDLE pipe, const WCHAR *workdir, const WCHAR *options)
>          {
>              if (wcscmp(L"--config", argv[i]) == 0 && argc-i > 1)
>              {
> -                swprintf(buf, _countof(buf), msg1, argv[i+1], workdir,
> -                         settings.ovpn_admin_group);
> -                buf[_countof(buf) - 1] = L'\0';
> +                openvpn_swprintf(buf, _countof(buf), msg1, argv[i+1], workdir,
> +                                 settings.ovpn_admin_group);
>                  ReturnError(pipe, ERROR_STARTUP_DATA, buf, 1, &exit_event);
>              }
>              else
>              {
> -                swprintf(buf, _countof(buf), msg2, argv[i],
> -                         settings.ovpn_admin_group);
> -                buf[_countof(buf) - 1] = L'\0';
> +                openvpn_swprintf(buf, _countof(buf), msg2, argv[i],
> +                                 settings.ovpn_admin_group);
>                  ReturnError(pipe, ERROR_STARTUP_DATA, buf, 1, &exit_event);
>              }
>              goto out;
> @@ -950,8 +946,7 @@ RegisterDNS(LPVOID unused)
>
>      HANDLE wait_handles[2] = {rdns_semaphore, exit_event};
>
> -    swprintf(ipcfg, _countof(ipcfg), L"%s\\%s", get_win_sys_path(), L"ipconfig.exe");
> -    ipcfg[_countof(ipcfg) - 1] = L'\0';
> +    openvpn_swprintf(ipcfg, MAX_PATH, L"%s\\%s", get_win_sys_path(), L"ipconfig.exe");
>
>      if (WaitForMultipleObjects(2, wait_handles, FALSE, timeout) == WAIT_OBJECT_0)
>      {
> @@ -1628,9 +1623,8 @@ RunOpenvpn(LPVOID p)
>      else if (exit_code != 0)
>      {
>          WCHAR buf[256];
> -        swprintf(buf, _countof(buf),
> -                 L"OpenVPN exited with error: exit code = %lu", exit_code);
> -        buf[_countof(buf) - 1] =  L'\0';
> +        openvpn_swprintf(buf, _countof(buf),
> +                         L"OpenVPN exited with error: exit code = %lu", exit_code);
>          ReturnError(pipe, ERROR_OPENVPN_STARTUP, buf, 1, &exit_event);
>      }
>      Undo(&undo_lists);
> diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
> index d7b7b3f..cb7020f 100644
> --- a/src/openvpnserv/service.h
> +++ b/src/openvpnserv/service.h
> @@ -86,6 +86,8 @@ BOOL openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list arglist
>
>  BOOL openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...);
>
> +BOOL openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t *const format, ...);
> +
>  DWORD GetOpenvpnSettings(settings_t *s);
>
>  BOOL ReportStatusToSCMgr(SERVICE_STATUS_HANDLE service, SERVICE_STATUS *status);
> diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
> index c576ac1..5506e90 100644
> --- a/src/openvpnserv/validate.c
> +++ b/src/openvpnserv/validate.c
> @@ -68,8 +68,7 @@ CheckConfigPath(const WCHAR *workdir, const WCHAR *fname, const settings_t *s)
>      /* convert fname to full path */
>      if (PathIsRelativeW(fname) )
>      {
> -        swprintf(tmp, _countof(tmp), L"%s\\%s", workdir, fname);
> -        tmp[_countof(tmp)-1] = L'\0';
> +        openvpn_swprintf(tmp, _countof(tmp), L"%s\\%s", workdir, fname);
>          config_file = tmp;
>      }
>      else

Acked-by: Selva Nair <selva.nair@...277...>

