Message-ID: <9b8571ef18c4f2dc1e1b5d166e0206c48dcb914d.camel@...2726...>
From: Ralf Lici <ralf@...2726...>
Date: Thu, 22 Jan 2026 13:39:21 +0100
In-Reply-To: <aXEDWpwGYp1V2Tro@...2915...>
References: <20260119131400.424161-1-ralf@...2726...>
 <aXEDWpwGYp1V2Tro@...2915...>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Sabrina Dubroca <sd@...2891...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 2026-01-21 at 17:48 +0100, Sabrina Dubroca wrote:
> 2026-01-19, 14:13:58 +0100, Ralf Lici wrote:
> > During initialization, we override some socket callbacks and set
> > sk_user_data to ovpn_sock. Currently these two operations are
> > decoupled:
> > the callbacks are overridden before sk_user_data is set, leaving a
> > potentially ill-formed state while socket ownership is not yet
> > complete.
> > For example, if a packet arrives after ovpn_udp_socket_attach has
> > been
> > called but before ovpn_socket_new finishes, ovpn_udp_encap_recv may
> > be
> > invoked without a configured sk_user_data pointer.
>=20
> Since all the callbacks check whether sk_user_data is set before doing
> anything, can you describe the problem?

True, but if we receive UDP traffic before the socket setup is
completed, we get some net_err_ratelimited messages in the logs. While
this is not necessarily a real bug, setting user_data before the
callbacks ensures we do not hit this situation and avoids polluting the
logs. This should also be safe, since no other user is "owning" the
socket at that point.

I will update the commit message with this info.

> > Set sk_user_data before overriding the callbacks so that it can be
> > accessed safely from them. Since we already check that the socket
> > has no
> > sk_user_data before setting it, this remains safe even if an
> > interrupt
> > accesses the socket after sk_user_data is set but before the
> > callbacks
> > are overridden.
>=20
> A Fixes: tag would be good to add here. (probably f6226ae7a0cd ("ovpn:
> introduce the ovpn_socket object"), don't worry too much about which
> exact patch within the initial series is best)

Sure, I'll add it.

> > Signed-off-by: Ralf Lici <ralf@...2726...>
> > ---
> > =C2=A0drivers/net/ovpn/socket.c | 38 +++++++++++++++++++++-------------=
--
> > --
> > =C2=A0drivers/net/ovpn/tcp.c=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > =C2=A0drivers/net/ovpn/udp.c=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > =C2=A03 files changed, 23 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
> > index 9750871ab65c..053b8abe5619 100644
> > --- a/drivers/net/ovpn/socket.c
> > +++ b/drivers/net/ovpn/socket.c
> > @@ -200,6 +200,22 @@ struct ovpn_socket *ovpn_socket_new(struct
> > socket *sock, struct ovpn_peer *peer)
> > =C2=A0	ovpn_sock->sk =3D sk;
> > =C2=A0	kref_init(&ovpn_sock->refcount);
> > =C2=A0
> > +	/* TCP sockets are per-peer, therefore they are linked to
> > their unique
> > +	 * peer
> > +	 */
> > +	if (sk->sk_protocol =3D=3D IPPROTO_TCP) {
> > +		INIT_WORK(&ovpn_sock->tcp_tx_work,
> > ovpn_tcp_tx_work);
> > +		ovpn_sock->peer =3D peer;
> > +		ovpn_peer_hold(peer);
> > +	} else if (sk->sk_protocol =3D=3D IPPROTO_UDP) {
> > +		/* in UDP we only link the ovpn instance since the
> > socket is
> > +		 * shared among multiple peers
> > +		 */
> > +		ovpn_sock->ovpn =3D peer->ovpn;
> > +		netdev_hold(peer->ovpn->dev, &ovpn_sock-
> > >dev_tracker,
> > +			=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> > +	}
> > +
>=20
> Can you add a few words in the commit message to describe why this
> needs to be moved?

Of course, I'll specify why this was moved.

> > =C2=A0	/* the newly created ovpn_socket is holding reference to
> > sk,
> > =C2=A0	 * therefore we increase its refcounter.
> > =C2=A0	 *
> > @@ -212,29 +228,17 @@ struct ovpn_socket *ovpn_socket_new(struct
> > socket *sock, struct ovpn_peer *peer)
> > =C2=A0
> > =C2=A0	ret =3D ovpn_socket_attach(ovpn_sock, sock, peer);
> > =C2=A0	if (ret < 0) {
> > +		if (sk->sk_protocol =3D=3D IPPROTO_TCP)
> > +			ovpn_peer_put(peer);
> > +		else if (sk->sk_protocol =3D=3D IPPROTO_UDP)
> > +			netdev_put(peer->ovpn->dev, &ovpn_sock-
> > >dev_tracker);
> > +
> > =C2=A0		sock_put(sk);
> > =C2=A0		kfree(ovpn_sock);
> > =C2=A0		ovpn_sock =3D ERR_PTR(ret);
> > =C2=A0		goto sock_release;
> > =C2=A0	}
> > =C2=A0
> > -	/* TCP sockets are per-peer, therefore they are linked to
> > their unique
> > -	 * peer
> > -	 */
> > -	if (sk->sk_protocol =3D=3D IPPROTO_TCP) {
> > -		INIT_WORK(&ovpn_sock->tcp_tx_work,
> > ovpn_tcp_tx_work);
> > -		ovpn_sock->peer =3D peer;
> > -		ovpn_peer_hold(peer);
> > -	} else if (sk->sk_protocol =3D=3D IPPROTO_UDP) {
> > -		/* in UDP we only link the ovpn instance since the
> > socket is
> > -		 * shared among multiple peers
> > -		 */
> > -		ovpn_sock->ovpn =3D peer->ovpn;
> > -		netdev_hold(peer->ovpn->dev, &ovpn_sock-
> > >dev_tracker,
> > -			=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> > -	}
> > -
> > -	rcu_assign_sk_user_data(sk, ovpn_sock);
> > =C2=A0sock_release:
> > =C2=A0	release_sock(sk);
> > =C2=A0	return ovpn_sock;
> > diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
> > index 0d7f30360d87..e078f9b39122 100644
> > --- a/drivers/net/ovpn/tcp.c
> > +++ b/drivers/net/ovpn/tcp.c
> > @@ -487,6 +487,7 @@ int ovpn_tcp_socket_attach(struct ovpn_socket
> > *ovpn_sock,
> > =C2=A0	/* make sure no pre-existing encapsulation handler exists
> > */
> > =C2=A0	if (ovpn_sock->sk->sk_user_data)
> > =C2=A0		return -EBUSY;
> > +	rcu_assign_sk_user_data(ovpn_sock->sk, ovpn_sock);
>=20
> And reset sk_user_data to NULL in the error cases that can happen
> later in ovpn_tcp_socket_attach?

Right, will fix.
>=20

--=20
Ralf Lici
Mandelbit Srl

