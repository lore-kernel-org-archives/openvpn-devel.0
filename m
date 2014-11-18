Message-ID: <546B0E65.1050003@...1227...>
Date: Tue, 18 Nov 2014 10:16:21 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1416068708-6871-1-git-send-email-heiko.hund@...1489...>
	<1416257903-24629-1-git-send-email-gert@...1296...>
In-Reply-To: <1416257903-24629-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix windows build on older mingw
	versions.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 17.11.14 21:58, schrieb Gert Doering:
> Add missing #define for IPV6_V6ONLY sockopt.
>
> Fix last remaining fallout of dual-stack patch set in connect() call
> for "not CONNECT_NONBLOCK" case.
I like your optimism.

> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/socket.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index 2499ab0..f3f6422 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -1081,6 +1081,14 @@ socket_listen_accept (socket_descriptor_t sd,
>    return new_sd;
>  }
>  
> +/* older mingw versions and WinXP do not have this define, 
> + * but Vista and up support the functionality - just define it here
> + */
> +#ifdef WIN32
> +# ifndef IPV6_V6ONLY
> +#  define IPV6_V6ONLY 27
> +# endif
> +#endif
>  void
>  socket_bind (socket_descriptor_t sd,
>               struct addrinfo *local,
> @@ -1211,7 +1219,7 @@ openvpn_connect (socket_descriptor_t sd,
>  	}
>      }
>  #else
> -  status = connect (sd, &remote->addr.sa, af_addr_size(remote->addr.sa.sa_family));
> +  status = connect (sd, remote, af_addr_size(remote->sa_family));
>    if (status)
>      status = openvpn_errno ();
>  #endif

ACK

Arne

