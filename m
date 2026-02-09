Date: Mon, 9 Feb 2026 17:34:53 +0100
From: Sabrina Dubroca <sd@...2891...>
Message-ID: <aYoMraOqbVSIS6uC@...2915...>
References: <20260202132309.567382-1-ralf@...2726...>
 <6d85c24b-3bd1-4e1e-83cd-26f378663ade@...2181...>
 <aYY2WMtG6K9GEWoi@...2915...>
 <823dd41a-639c-4b81-a1dc-892bf9d2b567@...2181...>
 <9b5a8486-dfcc-426f-85e8-7e9a278baf13@...2181...>
 <d8c4f1a9-add1-45a9-84b8-b0463c4a88f7@...2181...>
MIME-Version: 1.0
In-Reply-To: <d8c4f1a9-add1-45a9-84b8-b0463c4a88f7@...2181...>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Ralf Lici <ralf@...2726...>

2026-02-09, 16:36:55 +0100, Antonio Quartulli wrote:
> On 09/02/2026 16:32, Antonio Quartulli wrote:
> > What if we go the other way around: we have ovpn_tcp_close() check if
> > the peer was already gone from the ovpn hash or not.
> > 
> > If it did, we know the peer is going through its own lifecycle and we
> > skip the ovpn_peer_del() call.

To make sure I understand: the bug we're trying to fix here is that we
end up calling ovpn_tcp_close() too early, so by the time
ovpn_tcp_socket_detach() is called, sk->sk_socket is already NULL so
"sk->sk_socket->ops = ..." crashes the kernel. Ralf's patch makes sure
ovpn_socket_release() -> ... -> ovpn_tcp_socket_detach() has been
called by the time we're done with close(). Is that correct?

Then I'm confused by how this would solve the issue. We could still be
done with ovpn_tcp_close() before ovpn_peer_keepalive_work() ->
unlock_ovpn -> ovpn_socket_release has completed?

> > This is what I have mind (not tested yet! only compiled):
> > 
> > diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
> > index 1c02cc06f21b..83e7a5354266 100644
> > --- a/drivers/net/ovpn/tcp.c
> > +++ b/drivers/net/ovpn/tcp.c
> > @@ -543,8 +543,8 @@ int ovpn_tcp_socket_attach(struct ovpn_socket
> > *ovpn_sock,
> > 
> >   static void ovpn_tcp_close(struct sock *sk, long timeout)
> >   {
> > +       struct ovpn_peer *peer, *tmp;
> >          struct ovpn_socket *sock;
> > -       struct ovpn_peer *peer;
> > 
> >          rcu_read_lock();
> >          sock = rcu_dereference_sk_user_data(sk);
> > @@ -555,7 +555,26 @@ static void ovpn_tcp_close(struct sock *sk, long
> > timeout)
> >          peer = sock->peer;
> >          rcu_read_unlock();
> > 
> > -       ovpn_peer_del(sock->peer,
> > OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
> > +       spin_lock_bh(&peer->ovpn->lock);
> > +       /* if the peer is already unhashed, it means it already
> > +        * went through ovpn_peer_remove() due to the actual removal event.
> > +        * This tcp_close call is just the socket being cleaned up by
> > +        * userspace and we don't need to double process the deletion
> > +        *
> > +        * NOTE: we need to lock (instead of just rcu-read-lock) because
> > +        * we have to synchronize with other calls to ovpn_peer_remove()
> > +        * happening with ovpn->lock held.
> > +        * This way we are guaranteed to call ovpn_peer_del() without
> > +        * racing with another ovpn_peer_remove().
> > +        */
> > +       tmp = ovpn_peer_get_by_id(peer->ovpn, peer->id);
> > +       if (tmp) {
> 
> or even better, we could check for !hlist_unhashed(&peer->hash_entry_id), to

But hash_entry_id isn't used in P2P mode?

> avoid hitting another peer that just got the same ID re-assigned (nearly
> impossible, but you know ..)
> 
> 
> Cheers,
> 
> > +               ovpn_peer_del(sock->peer,

ovpn_peer_del wants to acquire peer->ovpn->lock which we just took,
you'd have to rework that function.

> > +                             OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
> > +               ovpn_peer_put(tmp);
> > +       }
> > +       spin_unlock_bh(&peer->ovpn->lock);
> > +
> >          peer->tcp.sk_cb.prot->close(sk, timeout);
> >          ovpn_peer_put(peer);
> >   }

-- 
Sabrina

