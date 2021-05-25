MIME-Version: 1.0
References: <20210522033232.20548-1-selva.nair@...277...>
 <20210522033232.20548-3-selva.nair@...277...>
 <CAGyAFMXxsv7dcubA6QLr9G4onU+87N74_8_181fwup2Sm+Wb0A@...278...>
In-Reply-To: <CAGyAFMXxsv7dcubA6QLr9G4onU+87N74_8_181fwup2Sm+Wb0A@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 25 May 2021 11:38:16 -0400
Message-ID: <CAKuzo_jgcJH_mA=Cry9oidB4k5=EqEkkPQeWhza9E4TROt+TLQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] Print format spec changes for
 tapctl and openvpnmscia
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

Thanks for the review.

On Tue, May 25, 2021 at 4:06 AM Lev Stipakov <lstipakov@...277...> wrote:
>
> Hi,
>
> I got compilation error:

Oops.. I did not test building with _DEBUG defined.

>
> 2>openvpnmsica.c
> 2>C:\Users\lev\Projects\openvpn\src\openvpnmsica\openvpnmsica.c(140,1):
> warning C4002: too many arguments for function-like macro invocation
> 'TEXT'
> 2>C:\Users\lev\Projects\openvpn\src\openvpnmsica\openvpnmsica.c(140,24):
> error C2143: syntax error: missing ')' before ';'
> 2>C:\Users\lev\Projects\openvpn\src\openvpnmsica\openvpnmsica.c(132,9):
> warning C4473: 'swprintf_s' : not enough arguments passed for format
> string
> 2>C:\Users\lev\Projects\openvpn\src\openvpnmsica\openvpnmsica.c(132,9):
> message : placeholders and their parameters expect 3 variadic
> arguments, but 0 were provided
> 2>C:\Users\lev\Projects\openvpn\src\openvpnmsica\openvpnmsica.c(132,9):
> message : the missing variadic argument 1 is required by format string
> '%ls'
>
> OTOH it is easily fixed by this change:
>
> diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
> index a4008d8f..1fb35f86 100644
> --- a/src/openvpnmsica/openvpnmsica.c
> +++ b/src/openvpnmsica/openvpnmsica.c
> @@ -129,7 +129,7 @@ _debug_popup(_In_z_ LPCTSTR szFunctionName)
>      /* Compose the pop-up message. */
>      _stprintf_s(
>          szMessage, _countof(szMessage),
> -        TEXT("The %") TEXT(PRIsLPTSTR) TEXT(" process (PID: %u) has
> started to execute the %"
> +        TEXT("The %") TEXT(PRIsLPTSTR) TEXT(" process (PID: %u) has
> started to execute the %")
>          TEXT(PRIsLPTSTR) TEXT(" custom action.\r\n")
>          TEXT("\r\n")
>          TEXT("If you would like to debug the custom action, attach a
> debugger to this process and set breakpoints before dismissing this
> dialog.\r\n")

Will submit a v2 with this one and the space below.

Selva

>
> A nit-pick:
>
> > -    _stprintf_s(szTitle, _countof(szTitle), TEXT("%s v%s"), szFunctionName, TEXT(PACKAGE_VERSION));
> > +    _stprintf_s(szTitle, _countof(szTitle), TEXT("%") TEXT(PRIsLPTSTR) TEXT("v%") TEXT(PRIsLPTSTR),
> > +               szFunctionName, TEXT(PACKAGE_VERSION));
>
> Otherwise looks good - compiled with MSVC and slightly tested. If Gert
> can fix abovementioned thigs (add a parenthesis and a whitespace)
> consider it as an ack.

