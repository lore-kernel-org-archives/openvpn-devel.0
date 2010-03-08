Date: Mon, 08 Mar 2010 13:19:01 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <20100308165048.19002.qmail@...1287...> (from peter@...1287... on
	Mon Mar  8 10:50:48 2010)
Message-Id: <1268075941.2962.0@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Supporting "route-gateway dhcp" on non-Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Peter Stuge <peter@...1287...>
Cc: openvpn-devel@lists.sourceforge.net

On 03/08/2010 10:50:48 AM, Peter Stuge wrote:
> Karl O. Pinc wrote:
> > > I'm hoping that we can make "route-gateway dhcp" work on Unix
> > > platforms as well.  I'm thinking there are two possible ways we
> > > could do this:
>=20
> Network interface configuration is highly distribution specific.
>=20
>=20
> > A) dhclient
> >=20
> > B) dhclient.conf
> >=20
> > C) dhclient
> >=20
> > D) dhcptl or omapi or .. omshell
> ..
> > This would be tied to the ISC implementation, but probably nobody
> > cares.
>=20
> I know of at least four DHCP clients and I avoid dhclient as much as
> possible. It would be a tremendous mistake to tie OpenVPN to any one
> DHCP client IMO.

Only D is tied to dhclient.  A, B, and C, work fine with any dhcp
client daemon.  (Or A does anyway, B and C require configuration file
support for the interface.  I assume this is a common property of dhcp
clients.)

Yes.  It would be nice not to force use of a particular client.
Especially if, as you write, many clients are in use.

>=20
>=20
> What most if not all distributions have in common, or could have in
> common, is that a script configures the network interface. Sometimes
> it's called ifup, other times it's /etc/init.d/net.tap0, yet other
> times it's something else.
>=20
> I suggest instead relying on a generic configuration script to do
> interface configuration when the VPN comes up.

The trouble with that is that these scripts can do other things.
If all you're interested in is configuring via dhcp, then that's all
you want to start/stop.  At least that's what runs through my head.
It's because network configuration is distro specific, but=20
starting/stopping/running/configuring a dhcp daemon isn't nearly so=20
that makes this approach appealing.   On the other hand, if
the ifup/ifdown/(etc.) scripts do what's needed and don't cause
any problems then maybe it makes sense to use what the
administrator is familiar with -- but this assumes that the
person setting up OpenVPN is familiar with how network
interface activation is scripted.

In either case we'd be looking at an openvpn configuration
directive (or 2) that takes a command to run once
the link comes up (and down).  If that was in place then
any of A, B, C, or D, or your choice of using an ifup/ifdown
script would all work.

Given that.  Why not just use -up and --down to do what's
needed?  Avoid changing the code and write documentation.


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


