References: <20210321144627.1621-1-simon@...2293...>
 <20210321144627.1621-3-simon@...2293...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <42c0333e-1199-e533-77b7-9963083a8784@...1227...>
Date: Sun, 21 Mar 2021 17:38:06 +0100
MIME-Version: 1.0
In-Reply-To: <20210321144627.1621-3-simon@...2293...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 3/5] interactive.c: Resolve MSVC C4996
 warning
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Simon Rozman <simon@...2293...>, openvpn-devel@lists.sourceforge.net

Am 21.03.21 um 15:46 schrieb Simon Rozman via Openvpn-devel:
> It's about using a standard recommended alias for the wcsdup():
> 
>> warning C4996: 'wcsdup': The POSIX name for this item is deprecated.
>> Instead, use the ISO C and C++ conformant name: _wcsdup. See online
>> help for details.
> 
> And the documentation says:
> 
>> The Microsoft-implemented POSIX function names strdup and wcsdup are
>> deprecated aliases for the _strdup and _wcsdup functions. By default,
>> they generate Compiler warning (level 3) C4996. The names are
>> deprecated because they don't follow the Standard C rules for
>> implementation-specific names. However, the functions are still
>> supported.
>>
>> We recommend you use _strdup and _wcsdup instead. Or, you can continue
>> to use these function names, and disable the warning. For more
>> information, see Turn off the warning and POSIX function names.
> 
> Reference: https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/strdup-wcsdup
> Signed-off-by: Simon Rozman <simon@...2293...>
> ---
>  src/openvpnserv/interactive.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index 5d5cbfe6..b073a0d5 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -899,7 +899,7 @@ ExecCommand(const WCHAR *argv0, const WCHAR *cmdline, DWORD timeout)
>      si.cb = sizeof(si);
>  
>      /* CreateProcess needs a modifiable cmdline: make a copy */
> -    cmdline_dup = wcsdup(cmdline);
> +    cmdline_dup = _wcsdup(cmdline);
>      if (cmdline_dup && CreateProcessW(argv0, cmdline_dup, NULL, NULL, FALSE,
>                                        proc_flags, NULL, NULL, &si, &pi) )
>      {
> @@ -1181,7 +1181,7 @@ SetDNSDomain(const wchar_t *if_name, const char *domain, undo_lists_t *lists)
>     /* Add to undo list if domain is non-empty */
>     if (err == 0 && wdomain[0] && lists)
>     {
> -        wchar_t *tmp_name = wcsdup(if_name);
> +        wchar_t *tmp_name = _wcsdup(if_name);
>          if (!tmp_name || AddListItem(&(*lists)[undo_domain], tmp_name))
>          {
>              free(tmp_name);
> @@ -1272,7 +1272,7 @@ HandleDNSConfigMessage(const dns_cfg_message_t *msg, undo_lists_t *lists)
>  
>      if (msg->addr_len > 0)
>      {
> -        wchar_t *tmp_name = wcsdup(wide_name);
> +        wchar_t *tmp_name = _wcsdup(wide_name);
>          if (!tmp_name || AddListItem(&(*lists)[undo_type], tmp_name))
>          {
>              free(tmp_name);
> 

Acked-By: Arne Schwabe <arne@...1227...>

I can accept the change in this function since it is windows specific
but overall I don't think we can reasonable move away from POSIX
function names and instead use the names with _ in front of it because
that is currently Windows specific. I am not sure what the idea for a
portable code is other than to set the _CRT_NONSTDC_NO_DEPRECATE option
on Windows.

Arne

