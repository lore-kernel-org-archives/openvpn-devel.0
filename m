Message-ID: <008d96b3-3062-85a0-b35b-52a45462faa9@...2669...>
Date: Tue, 31 Jan 2023 13:39:36 +0100
MIME-Version: 1.0
Content-Language: en-US, de-DE
References: <20230131122542.1887-1-lstipakov@...277...>
From: Timo Rothenpieler <timo@...2669...>
In-Reply-To: <20230131122542.1887-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] dco-win: use proper calling convention
 on x86
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

On 31/01/2023 13:25, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
> 
> WinAPI uses __stdcall calling convention on x86. Wrong
> calling convention causes UB, which in this case breaks
> dco-win functionality.
> 
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>   src/openvpn/dco_win.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
> index 7594024c..da1e1fbc 100644
> --- a/src/openvpn/dco_win.c
> +++ b/src/openvpn/dco_win.c
> @@ -110,7 +110,7 @@ dco_connect_wait(HANDLE handle, OVERLAPPED *ov, int timeout, struct signal_info
>   {
>       volatile int *signal_received = &sig_info->signal_received;
>       /* GetOverlappedResultEx is available starting from Windows 8 */
> -    typedef BOOL (*get_overlapped_result_ex_t) (HANDLE, LPOVERLAPPED, LPDWORD, DWORD, BOOL);
> +    typedef BOOL (__stdcall *get_overlapped_result_ex_t) (HANDLE, LPOVERLAPPED, LPDWORD, DWORD, BOOL);

Wouldn't it be better to use the WINAPI Macro here, so it's the right 
calling convention no matter the arch?

Not sure what header it's defined in, but a quick search suggests it 
comes from minwindef.h.

>       get_overlapped_result_ex_t get_overlapped_result_ex =
>           (get_overlapped_result_ex_t)GetProcAddress(GetModuleHandle("Kernel32.dll"),
>                                                      "GetOverlappedResultEx");

