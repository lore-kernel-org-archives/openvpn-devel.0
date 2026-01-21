Date: Wed, 21 Jan 2026 17:48:26 +0100
From: Sabrina Dubroca <sd@...2891...>
Message-ID: <aXEDWpwGYp1V2Tro@...2915...>
References: <20260119131400.424161-1-ralf@...2726...>
MIME-Version: 1.0
In-Reply-To: <20260119131400.424161-1-ralf@...2726...>
Subject: Re: [Openvpn-devel] [PATCH ovpn net 1/3] ovpn: set sk_user_data
 before overriding callbacks
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
Content-Disposition: inline
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

2026-01-19, 14:13:58 +0100, Ralf Lici wrote:
> During initialization, we override some socket callbacks and set
> sk_user_data to ovpn_sock. Currently these two operations are decoupled:
> the callbacks are overridden before sk_user_data is set, leaving a
> potentially ill-formed state while socket ownership is not yet complete.
> For example, if a packet arrives after ovpn_udp_socket_attach has been
> called but before ovpn_socket_new finishes, ovpn_udp_encap_recv may be
> invoked without a configured sk_user_data pointer.

Since all the callbacks check whether sk_user_data is set before doing
anything, can you describe the problem?

> Set sk_user_data before overriding the callbacks so that it can be
> accessed safely from them. Since we already check that the socket has no
> sk_user_data before setting it, this remains safe even if an interrupt
> accesses the socket after sk_user_data is set but before the callbacks
> are overridden.

A Fixes: tag would be good to add here. (probably f6226ae7a0cd ("ovpn:
introduce the ovpn_socket object"), don't worry too much about which
exact patch within the initial series is best)

> Signed-off-by: Ralf Lici <ralf@...2726...>
> ---
>  drivers/net/ovpn/socket.c | 38 +++++++++++++++++++++-----------------
>  drivers/net/ovpn/tcp.c    |  1 +
>  drivers/net/ovpn/udp.c    |  1 +
>  3 files changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
> index 9750871ab65c..053b8abe5619 100644
> --- a/drivers/net/ovpn/socket.c
> +++ b/drivers/net/ovpn/socket.c
> @@ -200,6 +200,22 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
>  	ovpn_sock->sk = sk;
>  	kref_init(&ovpn_sock->refcount);
>  
> +	/* TCP sockets are per-peer, therefore they are linked to their unique
> +	 * peer
> +	 */
> +	if (sk->sk_protocol == IPPROTO_TCP) {
> +		INIT_WORK(&ovpn_sock->tcp_tx_work, ovpn_tcp_tx_work);
> +		ovpn_sock->peer = peer;
> +		ovpn_peer_hold(peer);
> +	} else if (sk->sk_protocol == IPPROTO_UDP) {
> +		/* in UDP we only link the ovpn instance since the socket is
> +		 * shared among multiple peers
> +		 */
> +		ovpn_sock->ovpn = peer->ovpn;
> +		netdev_hold(peer->ovpn->dev, &ovpn_sock->dev_tracker,
> +			    GFP_KERNEL);
> +	}
> +

Can you add a few words in the commit message to describe why this
needs to be moved?

>  	/* the newly created ovpn_socket is holding reference to sk,
>  	 * therefore we increase its refcounter.
>  	 *
> @@ -212,29 +228,17 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
>  
>  	ret = ovpn_socket_attach(ovpn_sock, sock, peer);
>  	if (ret < 0) {
> +		if (sk->sk_protocol == IPPROTO_TCP)
> +			ovpn_peer_put(peer);
> +		else if (sk->sk_protocol == IPPROTO_UDP)
> +			netdev_put(peer->ovpn->dev, &ovpn_sock->dev_tracker);
> +
>  		sock_put(sk);
>  		kfree(ovpn_sock);
>  		ovpn_sock = ERR_PTR(ret);
>  		goto sock_release;
>  	}
>  
> -	/* TCP sockets are per-peer, therefore they are linked to their unique
> -	 * peer
> -	 */
> -	if (sk->sk_protocol == IPPROTO_TCP) {
> -		INIT_WORK(&ovpn_sock->tcp_tx_work, ovpn_tcp_tx_work);
> -		ovpn_sock->peer = peer;
> -		ovpn_peer_hold(peer);
> -	} else if (sk->sk_protocol == IPPROTO_UDP) {
> -		/* in UDP we only link the ovpn instance since the socket is
> -		 * shared among multiple peers
> -		 */
> -		ovpn_sock->ovpn = peer->ovpn;
> -		netdev_hold(peer->ovpn->dev, &ovpn_sock->dev_tracker,
> -			    GFP_KERNEL);
> -	}
> -
> -	rcu_assign_sk_user_data(sk, ovpn_sock);
>  sock_release:
>  	release_sock(sk);
>  	return ovpn_sock;
> diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
> index 0d7f30360d87..e078f9b39122 100644
> --- a/drivers/net/ovpn/tcp.c
> +++ b/drivers/net/ovpn/tcp.c
> @@ -487,6 +487,7 @@ int ovpn_tcp_socket_attach(struct ovpn_socket *ovpn_sock,
>  	/* make sure no pre-existing encapsulation handler exists */
>  	if (ovpn_sock->sk->sk_user_data)
>  		return -EBUSY;
> +	rcu_assign_sk_user_data(ovpn_sock->sk, ovpn_sock);

And reset sk_user_data to NULL in the error cases that can happen
later in ovpn_tcp_socket_attach?

>  	/* only a fully connected socket is expected. Connection should be
>  	 * handled in userspace
> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
> index d6a0f7a0b75d..272b535ecaad 100644
> --- a/drivers/net/ovpn/udp.c
> +++ b/drivers/net/ovpn/udp.c
> @@ -386,6 +386,7 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock, struct socket *sock,
>  			   struct ovpn_priv *ovpn)
>  {
>  	struct udp_tunnel_sock_cfg cfg = {
> +		.sk_user_data = ovpn_sock,
>  		.encap_type = UDP_ENCAP_OVPNINUDP,
>  		.encap_rcv = ovpn_udp_encap_recv,
>  		.encap_destroy = ovpn_udp_encap_destroy,
> -- 
> 2.52.0
> 

-- 
Sabrina

