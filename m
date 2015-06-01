MIME-Version: 1.0
In-Reply-To: <1433178914-7842-1-git-send-email-gert@...1296...>
References: <1433104918-9523-1-git-send-email-gert@...1296...>
	<1433178914-7842-1-git-send-email-gert@...1296...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 1 Jun 2015 21:30:02 +0200
Message-ID: <CAA1Abx+BZWNFkAat37=h+frMEfj3AxfAo01whHwNiLxPVDOJsA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Use EAI_AGAIN instead of EAI_SYSTEM for
	openvpn_getaddrinfo().
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Mon, Jun 1, 2015 at 7:15 PM, Gert Doering <gert@...1296...> wrote:
> Windows has no EAI_SYSTEM (introduced by 5f6c01ea6172ed), but everyone
> has EAI_AGAIN - which also fits ("a temporary failure in name resolution").
>
> Trac #276
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index e751154..4f1139d 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -417,7 +417,7 @@ openvpn_getaddrinfo (unsigned int flags,
>                            ASSERT(res);
>                            freeaddrinfo(*res);
>                            *res = NULL;
> -                          status = EAI_SYSTEM;
> +                          status = EAI_AGAIN;  /* = temporary failure */
>                            errno = EINTR;
>                        }
>                        goto done;
> --
> 2.3.6

ACK

-Steffan

