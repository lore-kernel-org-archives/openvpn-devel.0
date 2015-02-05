Message-ID: <54D34AA7.4030902@...1114...>
Date: Thu, 05 Feb 2015 11:49:11 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAB7qsSN2BzxzuY2hfqE59U+5dw4+wdGGOfUrXRQ4YmoMwAt4Mw@...278...>
In-Reply-To: <CAB7qsSN2BzxzuY2hfqE59U+5dw4+wdGGOfUrXRQ4YmoMwAt4Mw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix CN maximum length
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Jorge Luiz Silva Peixoto <jorge.peixoto@...277...>, openvpn-devel@lists.sourceforge.net

On 04/02/15 18:01, Jorge Luiz Silva Peixoto wrote:
> The following patch fixes CN maximum length as discussed with Steffan
> Kargen at openvpn users mailing list.
> 
> 
> Signed-off-by: Jorge Peixoto <jorgepeixoto@...277...>
> ---
>  src/openvpn/ssl_verify.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index ad50458..73488fc 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -47,7 +47,7 @@
>  #endif
> 
>  /** Maximum length of common name */
> -#define TLS_USERNAME_LEN 64
> +#define TLS_USERNAME_LEN 65

I've not really followed the discussion you've had with Steffan, but I
suspect this is related to NULL-termination.  That the username can be
64 characters according to some specs, but needs to be 65 to allow NULL
termination?  I'm speculating here ... so if I'm right I'd appreciate an
update to the comment above if it includes NULL termination or not.
Also since you do this TLS_USERNAME_LEN-1 a few other places in the
code, being explicit would help to avoid any doubts.


-- 
kind regards,

David Sommerseth

