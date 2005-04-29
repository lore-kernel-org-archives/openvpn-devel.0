From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Radius support (Authentification, Authorization
 and Accounting)
In-Reply-To: <200504291033.00667.ralfluebben@...68...>
Message-ID: <Pine.LNX.4.58.0504291041510.24107@...41...>
References: <200504291033.00667.ralfluebben@...68...>
MIME-Version: 1.0
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
Date: Fri Apr 29 09:56:31 2005
Content-Type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Ralf =?iso-8859-1?q?L=FCbben?= <ralfluebben@...68...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, 29 Apr 2005, Ralf [iso-8859-1] L=EF=BF=BDbben wrote:

> Hello,
>=20
> I am interesting in build radius support for OpenVpn.
> At the moment I'am thinking about what is the best way.
>=20
> 1. Authentification and Authroization:
> I think this already works with the plugin pam_radius_auth.so, is that ri=
ght?

Yes.

> But I am interested in more features,
> like to get the ip-address and the routes from the RADIUS-Server.
> Can this be done with a plugin? Maybe by creating the configurationfiles =
at=20
> the start of the connection?=20
> Or could this be integrated in the Source Code? I think this would be the=
 best=20
> solution.

You should be able to do this as a plugin.  OpenVPN plugins can register a=
=20
number of callbacks (see openvpn-plugin.h).

You could use OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY to verify user/pass,=20
OPENVPN_PLUGIN_CLIENT_CONNECT to pass IP address and routes, and=20
OPENVPN_PLUGIN_CLIENT_DISCONNECT to process client disconnects.

> I hope the fea
> 2. Accounting:
> I need to count the traffic  of a VPN-connection, one the side every traf=
fic=20
> which goes from a client to the server (tun0-interface) and one the other=
=20
> side every traffic which goes through the VPN, maybe from one client to=20
> another client.
> So when I use the counter of the tun-interface, I lose the traffic which =
goes=20
> from one client to another. If I count the traffic of the eth-interface I=
 get=20
> other traffic, which has nothing to do with the vpn.=20

The OPENVPN_PLUGIN_CLIENT_DISCONNECT callback (or script) can access=20
client bandwidth info on the about-to-be-closed session by looking at the
bytes_received and bytes_sent environmental variables.  See the man page=20
for more info.

James


