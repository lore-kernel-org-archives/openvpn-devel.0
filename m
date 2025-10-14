Message-ID: <187920a6e1e3630c27310f402bc13a3d63e9811a.camel@...2726...>
From: ralf@...2726...
Date: Tue, 14 Oct 2025 18:29:17 +0200
In-Reply-To: <aO5luBPhHTSEMCzu@...2915...>
References: <20251014101948.250823-1-ralf@...2726...>
 <aO5luBPhHTSEMCzu@...2915...>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Sabrina Dubroca <sd@...2891...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, 2025-10-14 at 17:01 +0200, Sabrina Dubroca wrote:
> This would clear EPOLLIN and EPOLLRDNORM if they were set (alongside
> EPOLLRDHUP) because the socket was shutdown():
>=20
> //
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/net/c=
ore/datagram.c?h=3Dv6.17#n952
> 	shutdown =3D READ_ONCE(sk->sk_shutdown);
> 	if (shutdown & RCV_SHUTDOWN)
> 		mask |=3D EPOLLRDHUP | EPOLLIN | EPOLLRDNORM;
>=20
> which may not be desireable?
>=20
>=20
> Maybe another way to deal with it would be to add a variant of
> datagram_poll that takes the "real" RX queue as extra argument, and
> make datagram_poll a wrapper (using sk_receive_queue) around it. Then
> ovpn could use this new __datagram_poll helper with tcp.user_queue

I totally agree.

> (but I'm not sure we can call datagram_poll under rcu_read_lock).

I see the problem may arise from the call to sock_poll_wait, which isn't
safe inside an rcu_read_lock() section. Perhaps the __datagram_poll
helper could delegate the responsibility of calling sock_poll_wait to
the caller, allowing it to perform the rest of the polling logic safely
within the RCU read-side critical section.

>=20
--=20
Ralf Lici
Mandelbit Srl

