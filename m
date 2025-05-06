Message-ID: <5b795a20-df0a-400f-b921-615f01e6a22a@...2181...>
Date: Tue, 6 May 2025 10:50:36 +0200
MIME-Version: 1.0
References: <20250430123250.8627-1-a@...2181...>
 <20250505225549.19492-1-a@...2181...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20250505225549.19492-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH ovpn-net-next v2] ovpn: ensure sk is
 still valid during cleanup
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
To: Sabrina Dubroca <sd@...2891...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 06/05/2025 00:55, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
> 

[...]

> Signed-off-by: Antonio Quartulli <antonio@...515...>

This is v2 for "[PATCH ovpn-net-next 1/2] ovpn: don't access sk after 
release".

> ---
>   drivers/net/ovpn/socket.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
> index a83cbab72591..66a2ecbc483b 100644
> --- a/drivers/net/ovpn/socket.c
> +++ b/drivers/net/ovpn/socket.c
> @@ -66,6 +66,7 @@ static bool ovpn_socket_put(struct ovpn_peer *peer, struct ovpn_socket *sock)
>   void ovpn_socket_release(struct ovpn_peer *peer)
>   {
>   	struct ovpn_socket *sock;
> +	struct sock *sk;
>   	bool released;
>   
>   	might_sleep();
> @@ -75,13 +76,14 @@ void ovpn_socket_release(struct ovpn_peer *peer)
>   	if (!sock)
>   		return;
>   
> -	/* sanity check: we should not end up here if the socket
> -	 * was already closed
> +	/* sock->sk may be released concurrently, therefore we
> +	 * first attempt grabbing a reference.
> +	 * if sock->sk is NULL it means it is already being
> +	 * destroyed and we don't need any further cleanup
>   	 */
> -	if (!sock->sock->sk) {
> -		DEBUG_NET_WARN_ON_ONCE(1);
> +	sk = sock->sock->sk;
> +	if (!sk || !refcount_inc_not_zero(&sk->sk_refcnt))
>   		return;
> -	}

Rather than accessing sk without any guarantee of not having been 
nullified in the meantime, I think it is safer to check and possibly 
grab a reference.

At this point we know for sure that sk must be valid and wasn't released 
yet.

I hope it makes sense.


Cheers,


-- 
Antonio Quartulli


