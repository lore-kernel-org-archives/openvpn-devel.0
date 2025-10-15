Message-ID: <b95868878e77e5c1ed3cb9fa15165ad6bf52dced.camel@...2726...>
From: Ralf Lici <ralf@...2726...>
Date: Wed, 15 Oct 2025 10:16:37 +0200
In-Reply-To: <187920a6e1e3630c27310f402bc13a3d63e9811a.camel@...2726...>
References: <20251014101948.250823-1-ralf@...2726...>
 <aO5luBPhHTSEMCzu@...2915...>
 <187920a6e1e3630c27310f402bc13a3d63e9811a.camel@...2726...>
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

On Tue, 2025-10-14 at 18:29 +0200, ralf@...2726... wrote:
> On Tue, 2025-10-14 at 17:01 +0200, Sabrina Dubroca wrote:
> > (but I'm not sure we can call datagram_poll under rcu_read_lock).
>=20
> I see the problem may arise from the call to sock_poll_wait, which
> isn't
> safe inside an rcu_read_lock() section. Perhaps the __datagram_poll
> helper could delegate the responsibility of calling sock_poll_wait to
> the caller, allowing it to perform the rest of the polling logic
> safely
> within the RCU read-side critical section.
>=20

After discussing this with Antonio, we realized that we can safely take
a reference to the queue and increment the peer's refcounter, allowing
us to call __datagram_poll outside the RCU section. This approach lets
us avoid modifying the original kernel function.

I'll send a patch shortly.

Thanks for your help!

--=20
Ralf Lici
Mandelbit Srl

