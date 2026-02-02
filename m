Message-ID: <6d85c24b-3bd1-4e1e-83cd-26f378663ade@...2181...>
Date: Mon, 2 Feb 2026 14:33:47 +0100
MIME-Version: 1.0
References: <20260202132309.567382-1-ralf@...2726...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20260202132309.567382-1-ralf@...2726...>
Subject: Re: [Openvpn-devel] [PATCH ovpn net] ovpn: detach TCP socket before
 invoking close
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
To: Sabrina Dubroca <sd@...2891...>, Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

This patch is actually fixing the same issue reported here:

https://lore.kernel.org/netdev/176996279620.3109699.15382994681575380467@...2990.../

Cheers,

On 02/02/2026 14:23, Ralf Lici wrote:
> Currently, when a connected peer expires (no packets received within the
> keepalive interval), we remove the peer and notify userspace of the
> deletion. We then insert the peer in the release list and proceed to
> detach and release the socket and the peer. This can be problematic with
> TCP because, as soon as we send the notification, openvpn will close the
> peer's socket and if ovpn_tcp_close is invoked before
> ovpn_tcp_socket_detach we incurr in a NULL pointer dereference when
> trying to access sk->sk_socket.
> 
> Enforce correct ordering by calling ovpn_sock_release before invoking
> the original socket close callback. This avoids potential race
> conditions and guarantees that we completely detach from the socket once
> userspace issues the close command.
> 
> Signed-off-by: Ralf Lici <ralf@...2726...>
> ---
>   drivers/net/ovpn/tcp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
> index 0d7f30360d87..13d2a8069695 100644
> --- a/drivers/net/ovpn/tcp.c
> +++ b/drivers/net/ovpn/tcp.c
> @@ -553,6 +553,7 @@ static void ovpn_tcp_close(struct sock *sk, long timeout)
>   	rcu_read_unlock();
>   
>   	ovpn_peer_del(sock->peer, OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
> +	ovpn_socket_release(peer);
>   	peer->tcp.sk_cb.prot->close(sk, timeout);
>   	ovpn_peer_put(peer);
>   }

-- 
Antonio Quartulli


