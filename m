Message-ID: <9b5a8486-dfcc-426f-85e8-7e9a278baf13@...2181...>
Date: Mon, 9 Feb 2026 16:32:47 +0100
MIME-Version: 1.0
From: Antonio Quartulli <a@...2181...>
References: <20260202132309.567382-1-ralf@...2726...>
 <6d85c24b-3bd1-4e1e-83cd-26f378663ade@...2181...> <aYY2WMtG6K9GEWoi@...2915...>
 <823dd41a-639c-4b81-a1dc-892bf9d2b567@...2181...>
Content-Language: en-US
In-Reply-To: <823dd41a-639c-4b81-a1dc-892bf9d2b567@...2181...>
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
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Sabrina Dubroca <sd@...2891...>
Cc: openvpn-devel@lists.sourceforge.net, Ralf Lici <ralf@...2726...>

On 09/02/2026 11:21, Antonio Quartulli wrote:
>>> On 02/02/2026 14:23, Ralf Lici wrote:
>>>> Currently, when a connected peer expires (no packets received within 
>>>> the
>>>> keepalive interval), we remove the peer and notify userspace of the
>>>> deletion. We then insert the peer in the release list and proceed to
>>>> detach and release the socket and the peer. This can be problematic 
>>>> with
>>>> TCP because, as soon as we send the notification, openvpn will close 
>>>> the
>>>> peer's socket and if ovpn_tcp_close is invoked before
>>>> ovpn_tcp_socket_detach we incurr in a NULL pointer dereference when
>>>> trying to access sk->sk_socket.
>>>>
>>>> Enforce correct ordering by calling ovpn_sock_release before invoking
>>>> the original socket close callback. This avoids potential race
>>>> conditions and guarantees that we completely detach from the socket 
>>>> once
>>>> userspace issues the close command.
>>
>> The comment for ovpn_sock_release says:
>>
>>   * This function is expected to be invoked exactly once per peer
>>
>> But it seems in this case we won't be obeying this assumption? Once
>> from ovpn_tcp_close, and again from unlock_ovpn in the timeout
>> handler?
>>
>> IIRC this "invoked exactly once" was the condition that made
>>
>>      rcu_replace_pointer(peer->sock, NULL, true);
>>
>> valid, but what will prevent both sides from seeing peer->sock != NULL
>> now?
> 
> Mh indeed you are right.
> 
> The rcu_replace_pointer call must be protected now.
> We have to double check which lock we can safely hold without incurring 
> in any conflict with the rest of the socket lifecycle.
> 
> Thanks for pointing this out.

What if we go the other way around: we have ovpn_tcp_close() check if 
the peer was already gone from the ovpn hash or not.

If it did, we know the peer is going through its own lifecycle and we 
skip the ovpn_peer_del() call.

This is what I have mind (not tested yet! only compiled):

diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 1c02cc06f21b..83e7a5354266 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -543,8 +543,8 @@ int ovpn_tcp_socket_attach(struct ovpn_socket 
*ovpn_sock,

  static void ovpn_tcp_close(struct sock *sk, long timeout)
  {
+       struct ovpn_peer *peer, *tmp;
         struct ovpn_socket *sock;
-       struct ovpn_peer *peer;

         rcu_read_lock();
         sock = rcu_dereference_sk_user_data(sk);
@@ -555,7 +555,26 @@ static void ovpn_tcp_close(struct sock *sk, long 
timeout)
         peer = sock->peer;
         rcu_read_unlock();

-       ovpn_peer_del(sock->peer, 
OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
+       spin_lock_bh(&peer->ovpn->lock);
+       /* if the peer is already unhashed, it means it already
+        * went through ovpn_peer_remove() due to the actual removal event.
+        * This tcp_close call is just the socket being cleaned up by
+        * userspace and we don't need to double process the deletion
+        *
+        * NOTE: we need to lock (instead of just rcu-read-lock) because
+        * we have to synchronize with other calls to ovpn_peer_remove()
+        * happening with ovpn->lock held.
+        * This way we are guaranteed to call ovpn_peer_del() without
+        * racing with another ovpn_peer_remove().
+        */
+       tmp = ovpn_peer_get_by_id(peer->ovpn, peer->id);
+       if (tmp) {
+               ovpn_peer_del(sock->peer,
+                             OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
+               ovpn_peer_put(tmp);
+       }
+       spin_unlock_bh(&peer->ovpn->lock);
+
         peer->tcp.sk_cb.prot->close(sk, timeout);
         ovpn_peer_put(peer);
  }


What do you think?


-- 
Antonio Quartulli


