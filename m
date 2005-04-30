From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Radius support (Authentification, Authorization
 and Accounting)
In-Reply-To: <200504300904.51200.ralfluebben@...68...>
Message-ID: <Pine.LNX.4.58.0504300118280.24107@...41...>
References: <200504291033.00667.ralfluebben@...68...> <Pine.LNX.4.58.0504291041510.24107@...41...>
 <200504300904.51200.ralfluebben@...68...>
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
Date: Sat Apr 30 00:43:31 2005
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ralf =?iso-8859-1?q?L=FCbben?= <ralfluebben@...68...>
Cc: openvpn-devel@lists.sourceforge.net

On Sat, 30 Apr 2005, Ralf [iso-8859-1] L=FCbben wrote:

> Hello,
>=20
> thank you. That solves a lot of my problems.
>=20
> I have still one problem with accouting.
> When a client connect, I get a ticket from the RADIUS-Server, there is gi=
ven=20
> an interval, in which I must send Alive-tickets to the RADIUS-Server with=
 the=20
> actual traffic and the time of the connection.
>=20
> Can I get the data from OpenVPN during the connection?

Right now, you can only get it by reading the --status file.  For 2.1 I'm=20
considering to add another script/callback for passing current accounting=20
data.

One of the goals of the plugin interface is to allow a fully-featured
Radius plugin to be developed, as you are doing, so I would be happy to
work with you on extending the plugin interface for 2.1 if you find that
the current plugin API is insufficient.

> Another question about the IP address and OPENVPN_PLUGIN_CLIENT_CONNECT.=
=20
> Is there a possibility to give the IP address direct to the OpenVPN proce=
ss or=20
> must I create the configuration files when a client connects?

No, you have to write configuration file directives (containing the
appropriate ifconfig-push directive) to the temporary file provided by the
caller.  This is so that we can maintain an identical interface for both
script and plugin calls.

James

> Am Freitag, 29. April 2005 18:53 schrieb James Yonan:
> > On Fri, 29 Apr 2005, Ralf [iso-8859-1] L=FCbben wrote:
> > > Hello,
> > >
> > > I am interesting in build radius support for OpenVpn.
> > > At the moment I'am thinking about what is the best way.
> > >
> > > 1. Authentification and Authroization:
> > > I think this already works with the plugin pam_radius_auth.so, is that
> > > right?
> >
> > Yes.
> >
> > > But I am interested in more features,
> > > like to get the ip-address and the routes from the RADIUS-Server.
> > > Can this be done with a plugin? Maybe by creating the configurationfi=
les
> > > at the start of the connection?
> > > Or could this be integrated in the Source Code? I think this would be=
 the
> > > best solution.
> >
> > You should be able to do this as a plugin.  OpenVPN plugins can registe=
r a
> > number of callbacks (see openvpn-plugin.h).
> >
> > You could use OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY to verify user/pass,
> > OPENVPN_PLUGIN_CLIENT_CONNECT to pass IP address and routes, and
> > OPENVPN_PLUGIN_CLIENT_DISCONNECT to process client disconnects.
> >
> > > I hope the fea
> > > 2. Accounting:
> > > I need to count the traffic  of a VPN-connection, one the side every
> > > traffic which goes from a client to the server (tun0-interface) and o=
ne
> > > the other side every traffic which goes through the VPN, maybe from o=
ne
> > > client to another client.
> > > So when I use the counter of the tun-interface, I lose the traffic wh=
ich
> > > goes from one client to another. If I count the traffic of the
> > > eth-interface I get other traffic, which has nothing to do with the v=
pn.
> >
> > The OPENVPN_PLUGIN_CLIENT_DISCONNECT callback (or script) can access
> > client bandwidth info on the about-to-be-closed session by looking at t=
he
> > bytes_received and bytes_sent environmental variables.  See the man page
> > for more info.
> >
> > James
> >
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: NEC IT Guy Games.
> > Get your fingers limbered up and give it your best shot. 4 great events=
, 4
> > opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
> > win an NEC 61 plasma display. Visit http://www.necitguy.com/?r
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.
> Get your fingers limbered up and give it your best shot. 4 great events, 4
> opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
> win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

