Message-ID: <556C1EEA.6070009@...1227...>
Date: Mon, 01 Jun 2015 10:59:22 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1433104918-9523-1-git-send-email-gert@...1296...>
In-Reply-To: <1433104918-9523-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] On signal reception,
 return EAI_SYSTEM from openvpn_getaddrinfo().
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net



Am 31.05.15 um 22:41 schrieb Gert Doering:
> A signal (except SIGUSR1) received while waiting for getaddrinfo() is
> considered fatal, so openvpn_getaddrinfo() is destroying the returned
> information with freeaddrinfo(), but still signalled "success" (0)
> to the caller - so if the caller accessed *res before checking
> *signal_received, it would access just-free()ed memory, which on some
> platforms still worked and on others caused a crash.
>
> Also, ensure that *ai is also NULLed in the caller now.
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/socket.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index cf2dec3..034ccc1 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -219,10 +219,13 @@ msg(M_INFO, "if(*signal_received)");
>                      }
>                    else
>                      {
> +		      /* turn success into failure (interrupted syscall) */
>                        if (0 == status) {
>                            ASSERT(res);
>                            freeaddrinfo(*res);
> -                          res = NULL;
> +                          *res = NULL;
> +                          status = EAI_SYSTEM;
> +                          errno = EINTR;
>                        }
>                        goto done;
>                      }
ACK. The patch is doing the right thing.

Arne

