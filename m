Message-ID: <d213eecb-9c09-4daa-941d-562b95a58367@...2181...>
Date: Tue, 10 Feb 2026 14:50:47 +0100
MIME-Version: 1.0
From: Antonio Quartulli <a@...2181...>
References: <20260202132309.567382-1-ralf@...2726...>
 <6d85c24b-3bd1-4e1e-83cd-26f378663ade@...2181...> <aYY2WMtG6K9GEWoi@...2915...>
 <823dd41a-639c-4b81-a1dc-892bf9d2b567@...2181...>
 <9b5a8486-dfcc-426f-85e8-7e9a278baf13@...2181...>
 <d8c4f1a9-add1-45a9-84b8-b0463c4a88f7@...2181...> <aYoMraOqbVSIS6uC@...2915...>
 <70dda2d6-bd91-4fef-a4b3-c9755d11ef7e@...2181...>
Content-Language: en-US
In-Reply-To: <70dda2d6-bd91-4fef-a4b3-c9755d11ef7e@...2181...>
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
To: Sabrina Dubroca <sd@...2891...>
Cc: openvpn-devel@lists.sourceforge.net, Ralf Lici <ralf@...2726...>

On 10/02/2026 01:07, Antonio Quartulli wrote:
> On 09/02/2026 17:34, Sabrina Dubroca wrote:
>> 2026-02-09, 16:36:55 +0100, Antonio Quartulli wrote:
>>> On 09/02/2026 16:32, Antonio Quartulli wrote:
>>>> What if we go the other way around: we have ovpn_tcp_close() check if
>>>> the peer was already gone from the ovpn hash or not.
>>>>
>>>> If it did, we know the peer is going through its own lifecycle and we
>>>> skip the ovpn_peer_del() call.
>>
>> To make sure I understand: the bug we're trying to fix here is that we
>> end up calling ovpn_tcp_close() too early, so by the time
>> ovpn_tcp_socket_detach() is called, sk->sk_socket is already NULL so
>> "sk->sk_socket->ops = ..." crashes the kernel. Ralf's patch makes sure
>> ovpn_socket_release() -> ... -> ovpn_tcp_socket_detach() has been
>> called by the time we're done with close(). Is that correct?
>>
>> Then I'm confused by how this would solve the issue. We could still be
>> done with ovpn_tcp_close() before ovpn_peer_keepalive_work() ->
>> unlock_ovpn -> ovpn_socket_release has completed?
> 


As we have already stated, the crux of the issue is the moment 
tcp_close() sets sk->sk_socket to NULL.

This happens in:
1. tcp_close(sk, timeout);
   2. __tcp_close(sk, timeout);
     3. sock_orphan(sk);
       4. sk_set_socket(sk, NULL);

When we later/concurrently invoke ovpn_tcp_socket_release() we 
dereference sk->sk_socket, which is now NULL.

sock_orphan()is actually pretty small:

2123 static inline void sock_orphan(struct sock *sk)
2124 {
2125         write_lock_bh(&sk->sk_callback_lock);
2126         sock_set_flag(sk, SOCK_DEAD);
2127         sk_set_socket(sk, NULL);
2128         sk->sk_wq  = NULL;
2129         write_unlock_bh(&sk->sk_callback_lock);
2130 }

and as we can see it holds and then releases sk_callback_lock.

I remember that we were originally using this lock when setting the 
callbacks, but we eventually dropped it (around v3 or v4 of the original 
patchset, but I couldn't find the reason).
Maybe we thought there was no need to hold that lock?

Now, if we actually acquire this lock in ovpn_tcp_socket_detach(), check 
that sk_socket is non-NULL, restores the CB and release it, wouldn't we 
solve our problem?

Cheers,

-- 
Antonio Quartulli


