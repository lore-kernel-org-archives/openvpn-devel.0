From: Ralf =?iso-8859-1?q?L=FCbben?= <ralfluebben@...68...>
Subject: Re: [Openvpn-devel] Radius support (Authentification, Authorization and Accounting)
References: <200504291033.00667.ralfluebben@...68...> <Pine.LNX.4.58.0504291041510.24107@...41...>
In-Reply-To: <Pine.LNX.4.58.0504291041510.24107@...41...>
MIME-Version: 1.0
Message-Id: <200504300904.51200.ralfluebben@...68...>
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
Date: Sat Apr 30 00:07:08 2005
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hello,

thank you. That solves a lot of my problems.

I have still one problem with accouting.
When a client connect, I get a ticket from the RADIUS-Server, there is give=
n=20
an interval, in which I must send Alive-tickets to the RADIUS-Server with t=
he=20
actual traffic and the time of the connection.

Can I get the data from OpenVPN during the connection?

Another question about the IP address and OPENVPN_PLUGIN_CLIENT_CONNECT.=20
Is there a possibility to give the IP address direct to the OpenVPN process=
 or=20
must I create the configuration files when a client connects?

Ralf L=FCbben







Am Freitag, 29. April 2005 18:53 schrieb James Yonan:
> On Fri, 29 Apr 2005, Ralf [iso-8859-1] L=FCbben wrote:
> > Hello,
> >
> > I am interesting in build radius support for OpenVpn.
> > At the moment I'am thinking about what is the best way.
> >
> > 1. Authentification and Authroization:
> > I think this already works with the plugin pam_radius_auth.so, is that
> > right?
>
> Yes.
>
> > But I am interested in more features,
> > like to get the ip-address and the routes from the RADIUS-Server.
> > Can this be done with a plugin? Maybe by creating the configurationfiles
> > at the start of the connection?
> > Or could this be integrated in the Source Code? I think this would be t=
he
> > best solution.
>
> You should be able to do this as a plugin.  OpenVPN plugins can register a
> number of callbacks (see openvpn-plugin.h).
>
> You could use OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY to verify user/pass,
> OPENVPN_PLUGIN_CLIENT_CONNECT to pass IP address and routes, and
> OPENVPN_PLUGIN_CLIENT_DISCONNECT to process client disconnects.
>
> > I hope the fea
> > 2. Accounting:
> > I need to count the traffic  of a VPN-connection, one the side every
> > traffic which goes from a client to the server (tun0-interface) and one
> > the other side every traffic which goes through the VPN, maybe from one
> > client to another client.
> > So when I use the counter of the tun-interface, I lose the traffic which
> > goes from one client to another. If I count the traffic of the
> > eth-interface I get other traffic, which has nothing to do with the vpn.
>
> The OPENVPN_PLUGIN_CLIENT_DISCONNECT callback (or script) can access
> client bandwidth info on the about-to-be-closed session by looking at the
> bytes_received and bytes_sent environmental variables.  See the man page
> for more info.
>
> James
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.
> Get your fingers limbered up and give it your best shot. 4 great events, 4
> opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
> win an NEC 61 plasma display. Visit http://www.necitguy.com/?r
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

