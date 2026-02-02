Message-ID: <692c5914a99531db88c15f1c19e6d46ede12e84f.camel@...2726...>
From: Ralf Lici <ralf@...2726...>
Date: Mon, 02 Feb 2026 16:54:01 +0100
In-Reply-To: <20260202132309.567382-1-ralf@...2726...>
References: <20260202132309.567382-1-ralf@...2726...>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: Sabrina Dubroca <sd@...2891...>

On Mon, 2026-02-02 at 14:23 +0100, Ralf Lici wrote:
> Currently, when a connected peer expires (no packets received within
> the
> keepalive interval), we remove the peer and notify userspace of the
> deletion. We then insert the peer in the release list and proceed to
> detach and release the socket and the peer. This can be problematic
> with
> TCP because, as soon as we send the notification, openvpn will close
> the
> peer's socket and if ovpn_tcp_close is invoked before
> ovpn_tcp_socket_detach we incurr in a NULL pointer dereference when
> trying to access sk->sk_socket.
>=20
> Enforce correct ordering by calling ovpn_sock_release before invoking
> the original socket close callback. This avoids potential race
> conditions and guarantees that we completely detach from the socket
> once
> userspace issues the close command.
>=20
Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
> Signed-off-by: Ralf Lici <ralf@...2726...>
> ---
> =C2=A0drivers/net/ovpn/tcp.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
> index 0d7f30360d87..13d2a8069695 100644
> --- a/drivers/net/ovpn/tcp.c
> +++ b/drivers/net/ovpn/tcp.c
> @@ -553,6 +553,7 @@ static void ovpn_tcp_close(struct sock *sk, long
> timeout)
> =C2=A0	rcu_read_unlock();
> =C2=A0
> =C2=A0	ovpn_peer_del(sock->peer,
> OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
> +	ovpn_socket_release(peer);
> =C2=A0	peer->tcp.sk_cb.prot->close(sk, timeout);
> =C2=A0	ovpn_peer_put(peer);
> =C2=A0}

--=20
Ralf Lici
Mandelbit Srl

