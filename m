From: Simon Rozman <simon@...2293...>
Date: Thu, 12 Oct 2017 08:09:39 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10857E4741@...2294...>
References: <20171012072440.8704-1-simon@...2293...>
In-Reply-To: <20171012072440.8704-1-simon@...2293...>
Content-Language: en-US
Content-Type: multipart/signed; micalg=2.16.840.1.101.3.4.2.1;
 protocol="application/x-pkcs7-signature";
 boundary="----=_NextPart_000_0024_01D34342.370A97E0"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Uniform snwprintf() across MinGW and
 MSVC compilers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

------=_NextPart_000_0024_01D34342.370A97E0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This is a follow-up (or better worded: a replacement) patch for "[PATCH
01/13] snwprintf() => _snwprintf()".

I have taken into consideration all Selva's recommendations.

Best regards,
Simon

> -----Original Message-----
> From: Simon Rozman [mailto:simon@...2293...]
> Sent: Thursday, October 12, 2017 9:25 AM
> To: openvpn-devel@lists.sourceforge.net
> Cc: Simon Rozman
> Subject: [PATCH] Uniform snwprintf() across MinGW and MSVC compilers
> 
> MinGW's snwprintf() is a replacement for ISO C's swprintf() used by MSVC.
> MSVC also provides _snwprintf(), however using it leads to unportable
code.
> 
> After a discussion with Selva Nair on devel mailing list, an agreement was
> reached to use swprintf() for MSVC builds.
> 
> This patch uniforms snwprintf() usage while making it compile using MinGW
> and MSVC.
> 
> Assigning _snwprintf() return value to unused variable was also removed at
> one occasion.
> ---
>  config-msvc.h                 | 3 ++-
>  src/openvpn/tun.c             | 2 +-
>  src/openvpnserv/interactive.c | 8 ++++----
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/config-msvc.h b/config-msvc.h index 0bb153d..c940d15 100644
> --- a/config-msvc.h
> +++ b/config-msvc.h
> @@ -93,9 +93,10 @@
>  #define strncasecmp strnicmp
>  #define strcasecmp _stricmp
> 
> -#if _MSC_VER<1900
> +#if _MSC_VER < 1900
>  #define snprintf _snprintf
>  #endif
> +#define snwprintf swprintf
> 
>  #if _MSC_VER < 1800
>  #define strtoull strtoul
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c index 3639718..9e3ca41
> 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -4622,7 +4622,7 @@ get_adapter_index_method_1(const char *guid)
>      DWORD index;
>      ULONG aindex;
>      wchar_t wbuf[256];
> -    _snwprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%S", guid);
> +    snwprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%S", guid);
>      wbuf [SIZE(wbuf) - 1] = 0;
>      if (GetAdapterIndex(wbuf, &aindex) != NO_ERROR)
>      {
> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index 823b25b..a060a06 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -276,7 +276,7 @@ ReturnProcessId(HANDLE pipe, DWORD pid, DWORD
> count, LPHANDLE events)
>       * Same format as error messages (3 line string) with error = 0 in
>       * 0x%08x format, PID on line 2 and a description "Process ID" on
line 3
>       */
> -    _snwprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%s", 0, pid, msg);
> +    snwprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%s", 0, pid, msg);
>      buf[_countof(buf) - 1] = '\0';
> 
>      WritePipeAsync(pipe, buf, wcslen(buf) * 2, count, events); @@ -1066,7
> +1066,7 @@ RegisterDNS(LPVOID unused)
> 
>      if (GetSystemDirectory(sys_path, MAX_PATH))
>      {
> -        _snwprintf(ipcfg, MAX_PATH, L"%s\\%s", sys_path,
L"ipconfig.exe");
> +        snwprintf(ipcfg, MAX_PATH, L"%s\\%s", sys_path,
> + L"ipconfig.exe");
>          ipcfg[MAX_PATH-1] = L'\0';
>      }
> 
> @@ -1706,8 +1706,8 @@ RunOpenvpn(LPVOID p)
>      else if (exit_code != 0)
>      {
>          WCHAR buf[256];
> -        int len = _snwprintf(buf, _countof(buf),
> -                             L"OpenVPN exited with error: exit code =
%lu", exit_code);
> +        snwprintf(buf, _countof(buf),
> +                  L"OpenVPN exited with error: exit code = %lu",
> + exit_code);
>          buf[_countof(buf) - 1] =  L'\0';
>          ReturnError(pipe, ERROR_OPENVPN_STARTUP, buf, 1, &exit_event);
>      }
> --
> 2.9.0.windows.1


------=_NextPart_000_0024_01D34342.370A97E0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
/tIZTpwAAAAAAAA=

------=_NextPart_000_0024_01D34342.370A97E0--

