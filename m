Date: Fri, 6 Feb 2026 19:43:36 +0100
From: Sabrina Dubroca <sd@...2891...>
Message-ID: <aYY2WMtG6K9GEWoi@...2915...>
References: <20260202132309.567382-1-ralf@...2726...>
 <6d85c24b-3bd1-4e1e-83cd-26f378663ade@...2181...>
MIME-Version: 1.0
In-Reply-To: <6d85c24b-3bd1-4e1e-83cd-26f378663ade@...2181...>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Antonio Quartulli <a@...2181...>
Cc: Ralf Lici <ralf@...2726...>, openvpn-devel@lists.sourceforge.net

2026-02-02, 14:33:47 +0100, Antonio Quartulli wrote:
> This patch is actually fixing the same issue reported here:
> 
> https://lore.kernel.org/netdev/176996279620.3109699.15382994681575380467@...2990.../

So it would be nice to add a

Link: <url>

tag just above the sign-off/fixes tag (to the netdev post or to the
debian bugtracker), and there could also be a Reported-by tag (you may
want to check with the reporter if they agree, but the debian
bugtracker publicly lists the name and email so I don't see why not).

> Cheers,
> 
> On 02/02/2026 14:23, Ralf Lici wrote:
> > Currently, when a connected peer expires (no packets received within the
> > keepalive interval), we remove the peer and notify userspace of the
> > deletion. We then insert the peer in the release list and proceed to
> > detach and release the socket and the peer. This can be problematic with
> > TCP because, as soon as we send the notification, openvpn will close the
> > peer's socket and if ovpn_tcp_close is invoked before
> > ovpn_tcp_socket_detach we incurr in a NULL pointer dereference when
> > trying to access sk->sk_socket.
> > 
> > Enforce correct ordering by calling ovpn_sock_release before invoking
> > the original socket close callback. This avoids potential race
> > conditions and guarantees that we completely detach from the socket once
> > userspace issues the close command.

The comment for ovpn_sock_release says:

 * This function is expected to be invoked exactly once per peer

But it seems in this case we won't be obeying this assumption? Once
from ovpn_tcp_close, and again from unlock_ovpn in the timeout
handler?

IIRC this "invoked exactly once" was the condition that made

    rcu_replace_pointer(peer->sock, NULL, true);

valid, but what will prevent both sides from seeing peer->sock != NULL
now?


(not really related, but maybe unlock_ovpn should be using
llist_for_each_entry_safe since the current peer might go away before
we grab the next list item?)

-- 
Sabrina

