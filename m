References: <1478555042-31299-1-git-send-email-gert@...1296...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <e0eec14b-e44f-a8b1-26e3-d0fecdbf7fac@...1435...>
Date: Tue, 8 Nov 2016 09:47:24 +0100
MIME-Version: 1.0
In-Reply-To: <1478555042-31299-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] clean up *sig_info handling in
 link_socket_init_phase2()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 07-11-16 22:44, Gert Doering wrote:
> The code was a mix of "assume that it is not NULL" and "check that
> it is not NULL before using" - it cannot be NULL (due to the single
> call graph, referencing c->sig with the global context), but for
> good measure, add an ASSERT() upon function entry and get rid of
> all the individual checks.
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/socket.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index 184c7ad..18e6409 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -1857,8 +1857,9 @@ link_socket_init_phase2 (struct link_socket *sock,
>    int sig_save = 0;
>  
>    ASSERT (sock);
> +  ASSERT (sig_info);
>  
> -  if (sig_info && sig_info->signal_received)
> +  if (sig_info->signal_received)
>      {
>        sig_save = sig_info->signal_received;
>        sig_info->signal_received = 0;
> @@ -1879,7 +1880,7 @@ link_socket_init_phase2 (struct link_socket *sock,
>    if (sock->inetd)
>      {
>        phase2_inetd (sock, frame, remote_dynamic,  &sig_info->signal_received);
> -      if (sig_info && sig_info->signal_received)
> +      if (sig_info->signal_received)
>  	goto done;
>  
>      }
> @@ -1921,7 +1922,7 @@ link_socket_init_phase2 (struct link_socket *sock,
>  	  goto done;
>  	}
>  
> -      if (sig_info && sig_info->signal_received)
> +      if (sig_info->signal_received)
>  	goto done;
>  
>        if (sock->info.proto == PROTO_TCP_SERVER)
> @@ -1942,7 +1943,7 @@ link_socket_init_phase2 (struct link_socket *sock,
>        if (sock->sd != -1)
>  	protect_fd_nonlocal (sock->sd, &sock->info.lsa->actual.dest.addr.sa);
>  #endif
> -      if (sig_info && sig_info->signal_received)
> +      if (sig_info->signal_received)
>  	goto done;
>      }
>  
> @@ -1950,7 +1951,7 @@ link_socket_init_phase2 (struct link_socket *sock,
>    linksock_print_addr(sock);
>  
>   done:
> -  if (sig_save && sig_info)
> +  if (sig_save)
>      {
>        if (!sig_info->signal_received)
>  	sig_info->signal_received = sig_save;
> 

ACK

-Steffan

