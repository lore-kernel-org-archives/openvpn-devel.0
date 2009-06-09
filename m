Message-ID: <29370.65.118.50.246.1244561532.squirrel@...1166...>
In-Reply-To: <4A2B5F8B.4040208@...41...>
References: <16130.65.118.50.246.1232730850.squirrel@...1166...>
	<24624.65.118.50.246.1244149998.squirrel@...1166...>
	<1244174393l.6685l.3l@...1207...>
	<31530.65.118.50.246.1244212489.squirrel@...1166...>
	<4A2B5F8B.4040208@...41...>
Date: Tue, 9 Jun 2009 10:32:12 -0500 (CDT)
From: "Daniel Johnson" <Progman2000@...1085...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Loss of routes causes routing loop
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

James Yonan wrote:
> Earlier you mentioned that "In wireless use, we find that Windows will
> dump SOME of the routes created by OpenVPN when the radio changes APs".
>
> When this occurs, does it trigger a reconnection by the OpenVPN clients
> to the server?  If so, you can ensure that client-side routes are reset
> as part of the reconnection by NOT using the "persist-tun" directive in
> the client config file.

By itself, no, the event does not trigger a reconnection.  After the
ping timeout (30 seconds) it tries to reconnect, and fails.  I suppose
to make things near-seamless the client would need to know which route(s)
is/are critical, and check them regularly or when any ping fails?  Man
this is frustrating.

I'll test running without persist-tun.  Other than it re-running the 'up'
script, are there any gotchas?

If anyone wants to demonstrate the disappearing-route issue, here's the
easiest way:  On a Windows NT 5.1/'XP' computer, connect to a network
with a cable.  Create a route (by hand or via OpenVPN) whose gateway is
on the LAN.  Unplug the network cable for about ten seconds, then plug
it back in.  The route will be gone.  A wireless hiccup need not last
ten seconds to cause the same issue.  I can understand why the current
Windows behavior is generally desireable but it really fouls things up
if you are depending on one of those routes.

Daniel Johnson
Progman2000@...1085...
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFKLoAi6vGcUBY+ge8RAuuPAKCHhYqDylEhVOzZheOfJQukxD+/YACcD4TO
kT45+dETGw6ZVdVLtljWouM=
=SFDI
-----END PGP SIGNATURE-----


