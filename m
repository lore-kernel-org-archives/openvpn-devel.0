Message-ID: <16130.65.118.50.246.1232730850.squirrel@...1166...>
Date: Fri, 23 Jan 2009 11:14:10 -0600 (CST)
From: "Daniel Johnson" <Progman2000@...1085...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Loss of routes causes routing loop
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Short version:
  After temporary loss of the physical connection, OpenVPN does
not reestablish the tunnel due to a routing loop.  I think this is
a Windows issue that OpenVPN should try to work around.  We are
running v2.1_rc15 on the clients, rc15 on one server and rc13 on
the other two.

Long version:
  I have configured the routing computer on our wireless network
to intercept OpenVPN traffic destined to our normal OpenVPN server
and serve it locally.  It adds the "redirect-gateway def1" option
so that all traffic on the wireless link will be protected by the
VPN.  To ensure that a reconnection attempt to a different server
address will not be looped into the tunnel, I added two /32 routes
for the server addresses to the wireless gateway.  This worked
great in hard-wired testing on that subnet.

  In wireless use, we find that Windows will dump SOME of the
routes created by OpenVPN when the radio changes APs (or for
whatever reason drops momentarily).  It seems to be deleting
routes which use the gateway of that interface (or maybe just
anything on that subnet?).

So specifically:
  Wireless subnet: 172.21.166.0/24
  Gateway (and OpenVPN server): 172.21.166.254
  Public server addresses: 65.120.131.235 & .238
  The gateway uses iptables to internally redirect requests to the
public addresses to itself.  The client computers think they are
still talking to the public address.

  push "route 65.120.131.235 255.255.255.255 172.21.166.254"
  push "route 65.120.131.238 255.255.255.255 172.21.166.254"
  push "redirect-gateway def1"

  After anything that makes Windows reset the physical interface,
the route table no longer contains the 65.120.131.* routes.  My
guess is that it deleted any routes that used 172.21.166.* as a
gateway, and then re-added 172.21.166.254 as the default after
DHCP finished negotiating.

  I can see two possible OpenVPN fixes for this, but I have not
even dared to look at the code yet.  When trying to reconnect
after a ping-timeout:
1) Remove all OpenVPN-added routes first, or
2) Re-add/fix all OpenVPN-added routes first.

  Either would work in my situation, but some people may want to
choose between the two.

Daniel Johnson
Progman2000@...1085...
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFJefql6vGcUBY+ge8RAjoAAJ9NzJE/p3qxJlwnv5cWIwpfBS6b0gCghNHr
bObdcQYAH1Ob7Z93t9ATzHg=
=xN7F
-----END PGP SIGNATURE-----


