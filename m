From: Arne Schwabe <arne@...1227...>
References: <CACqLfMnrWmytCz9Oz9ES1qsQienJXbxOjGAHydx2RS=5sL=waQ@...278...>
	<CACqLfMkwi_Y+jQg4zyivzwyTkPApNVQx6XWYBXiSxBANYC5nOg@...278...>
	<CACqLfMnBXwSY=MXyc7B1oMKwYE2Z_49G3mpkEPxbSAuG61tgZA@...278...>
Message-ID: <56B8A008.2000702@...1227...>
Date: Mon, 8 Feb 2016 15:02:48 +0100
MIME-Version: 1.0
In-Reply-To: <CACqLfMnBXwSY=MXyc7B1oMKwYE2Z_49G3mpkEPxbSAuG61tgZA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix misleading socket error code on
 Windows
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
To: Leonardo <leobasilio@...277...>, openvpn-devel@lists.sourceforge.net



Am 07.02.16 um 21:21 schrieb Leonardo:
> Hi. I've made some mistakes on my previous message. I should have been
> more patient. After further investigation, I realized that ETIMEDOUT
> is defined in several header files:
>
> #define ETIMEDOUT WSAETIMEDOUT - WinSock2.h
> #define ETIMEDOUT 138 - winsock.h
> #define ETIMEDOUT WSAETIMEDOUT - winerror.h
>
> WSAETIMEDOUT has the right value:
>
> #define WSAETIMEDOUT (WSABASEERR+60) - WinSock2.h
> #define WSAETIMEDOUT (WSABASEERR+60) - winsock.h
> #define WSAETIMEDOUT 10060L - winerror.h
>
> So it seems like socket.c is getting its value from winsock.h. Here's
> a better patch:
>
> Signed-off-by: Leonardo Basilio <leobasilio@...277...>
> ---
>  src/openvpn/socket.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index 396fa54..37fa129 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -1177,7 +1177,11 @@ openvpn_connect (socket_descriptor_t sd,
>          {
>            if (--connect_timeout < 0)
>          {
> +#ifdef WIN32
> +          status = WSAETIMEDOUT;
> +#else
>            status = ETIMEDOUT;
> +#endif
>            break;
>          }
>            openvpn_sleep (1);
I give a cautionary ACK to this. I have not tested this but the code
looks good and the explaination sounds valid.

Arne


