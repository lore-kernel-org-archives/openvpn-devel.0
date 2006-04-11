Message-ID: <2d1888f90604110524g346237a5j@...278...>
From: "Yasen Balev" <fraxinus.excelsior@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] UDP, something like float option for local address?
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Apr 11 05:26:25 2006
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi.

Imagine an openvpn peer-to-peer link. One of the peers ("server") is
connected to 2 ISPs for failover purposes. Assume it has 2 IPs and
smart enough routing, to route "from" and "to" each address
accordingly (it's easy, if the "client" is also connected to these 2
ISPs - not-so-uncommon situation, I think).

Now, if the "client" decides to send packets to the other "server" IP,
these packets are accepted OK, but the "server" still returns it's
packets from it's original IP. This behaviour breaks statefull things
(firewalls, NATs) and complicates routing.

So, what about "localfloat" option? Is it hard to implement?

Yes, I know that using TCP solves the problem, but it also brings a
few other ones.

Sorry for my rough English, and thanks for your attention

Yasen

