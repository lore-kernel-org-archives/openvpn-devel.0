Date: Tue, 14 Oct 2025 17:01:12 +0200
From: Sabrina Dubroca <sd@...2891...>
Message-ID: <aO5luBPhHTSEMCzu@...2915...>
References: <20251014101948.250823-1-ralf@...2726...>
MIME-Version: 1.0
In-Reply-To: <20251014101948.250823-1-ralf@...2726...>
Subject: Re: [Openvpn-devel] [PATCH ovpn-net-next] ovpn: only signal sk
 readable if user_queue has packets
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

2025-10-14, 12:19:48 +0200, Ralf Lici wrote:
> datagram_poll marks a socket as readable whenever there are packets in
> the standard sk_receive_queue. However, with TCP encapsulation, another
> queue is used to hold packets destined for userspace.
> 
> To ensure correct EPOLLIN signaling, reset EPOLLIN and EPOLLRDNORM after
> calling datagram_poll, and set them only if user_queue is not empty.
> 
> Signed-off-by: Ralf Lici <ralf@...2726...>
> ---
>  drivers/net/ovpn/tcp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
> index 289f62c5d2c7..4dbdd59a0b1c 100644
> --- a/drivers/net/ovpn/tcp.c
> +++ b/drivers/net/ovpn/tcp.c
> @@ -563,6 +563,11 @@ static __poll_t ovpn_tcp_poll(struct file *file, struct socket *sock,
>  	__poll_t mask = datagram_poll(file, sock, wait);
>  	struct ovpn_socket *ovpn_sock;
>  
> +	/* Mark socket as readable for userspace only if there are packets in
> +	 * the user_queue, not in sk_receive_queue.
> +	 */
> +	mask &= ~(EPOLLIN | EPOLLRDNORM);

This would clear EPOLLIN and EPOLLRDNORM if they were set (alongside
EPOLLRDHUP) because the socket was shutdown():

// https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/net/core/datagram.c?h=v6.17#n952
	shutdown = READ_ONCE(sk->sk_shutdown);
	if (shutdown & RCV_SHUTDOWN)
		mask |= EPOLLRDHUP | EPOLLIN | EPOLLRDNORM;

which may not be desireable?


Maybe another way to deal with it would be to add a variant of
datagram_poll that takes the "real" RX queue as extra argument, and
make datagram_poll a wrapper (using sk_receive_queue) around it. Then
ovpn could use this new __datagram_poll helper with tcp.user_queue
(but I'm not sure we can call datagram_poll under rcu_read_lock).

>  	rcu_read_lock();
>  	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
>  	if (ovpn_sock && ovpn_sock->peer &&
> -- 
> 2.51.0
> 

-- 
Sabrina

