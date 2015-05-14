Date: Thu, 14 May 2015 16:10:29 +0200
From: Samuel Thibault <samuel.thibault@...1817...>
Message-ID: <20150514141029.GD2981@...1818...>
References: <20130524215902.GM5874@...1818...>
	<20130525115819.GS20843@...1296...>
	<20130526223639.GK26337@...1818...>
	<20130527072512.GY20843@...1296...>
	<20130527200519.GD5918@...1818...>
MIME-Version: 1.0
In-Reply-To: <20130527200519.GD5918@...1818...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn ipv6 pool env variables
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hello,

Any news on this issue?

Samuel

Samuel Thibault, le Mon 27 May 2013 22:05:19 +0200, a =E9crit :
> Gert Doering, le Mon 27 May 2013 09:25:12 +0200, a =E9crit :
> > On Mon, May 27, 2013 at 12:36:39AM +0200, Samuel Thibault wrote:
> > > Gert Doering, le Sat 25 May 2013 13:58:19 +0200, a =E9crit :
> > > > > To make it short: yes, the ipv6 pool environment variables are us=
eful,
> > > > > for user-defined scripts to be run at connection for instance to
> > > > > propagate routes, do accounting, etc.  The patch below adds them.
> > > >=20
> > > > You keep claiming that "yes it's useful".  The lack of feedback on =
the
> > > > list is partly due to the "To make it short" part of your mail...
> > >=20
> > > Ok. I was simply wondering whether it had perhaps got somehow dropped
> > > without reason.
> > >=20
> > > As I mentioned too briefly, the reason we need it is the same as for =
the
> > > IPv4 case: to announce the route to our bird daemon on connection, and
> > > drop it on disconnection.
> >=20
> > Mmmmh.  Trying to understand this: so you're not using a common /64 for
> > the tun addresses (=3D the ifconfig-ipv6-pool),
>=20
> We are, but,
>=20
> > which is then announced on-demand by bird?
>=20
> we need to announce it on-demand by bird, because we plan to possibly
> have several servers. Actually we also add the routes because we already
> have several openvpn daemons, because we have to let people connect
> through either udp and tcp, depending on the wild area they happen to
> have landed on. So we need to tell the kernel which tun (i.e. which
> openvpn daemon) to push paquets to.
>=20
> > Have you looked at the learn-address script?  I use something similar
> > at a customer (adding and removing proxy-arp entries on client connect)
> > and learn-address does all I need just fine...
>=20
> That could do it yes, however,
>=20
> > Well, learn-address is run on disconnect, but not "right away" - true,
> > so having it in disconnect is useful.
>=20
> yes. The rather random delay hurts by preventing from reconnecting
> immediately (either to the same daemon, or to another one or even
> another server), which is a pain when trying to set up the VPN in a wild
> area :)
>=20
> > I wonder whether we should also export iroute-ipv6 settings, as that wo=
uld
> > enable on-demand routing of more than a single IPv6 address.
>=20
> Actually in our case iroute is fed by radiusplugin, which happens to
> also already add the route for us, so we didn't have to add that one.
> But it could be better to have radiusplugin just pass iroute to openvpn,
> and let the userscript add the route if needed.

