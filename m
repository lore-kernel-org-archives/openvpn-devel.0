Date: Tue, 09 Mar 2010 13:58:47 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <4B9684F1.5020202@...1114...> (from
	openvpn.list@...1114... on Tue Mar  9 11:27:13 2010)
Message-Id: <1268164727.6842.7@...1207...>
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, James Yonan <jim@...41...>

On 03/09/2010 11:27:13 AM, David Sommerseth wrote:
> On 09/03/10 17:41, Karl O. Pinc wrote:
> > On 03/09/2010 10:16:37 AM, David Sommerseth wrote:
> >
> >>> Over-automating things will cause people headaches.
> >>> You don't want to willy-nilly startup a dhcp client
> >>> and have all your interfaces configured with dhcp without
> >>> your consent.
> >>
> >> Exactly!  Which again moves it more in the direction of some
> built-in
> >> DHCP client in OpenVPN, but as stated earlier - that mostly solves
> >> the
> >> core DHCP issues - but not the resolv.conf issue.
> >
> > I'm not at all sure it solves the core issues, which is that
> > an already running dhcp client won't have auto-detected
> > the tap interface that OpenVPN creates -- iff OpenVPN is
> > started after the dhcp client.
>=20
> Can you actually start an DHCP client on a non-existing TAP device?=20=20
> I
> don't think so.

No.  That's my point.  The tap device won't exist if you start
openvpn after starting dhcp.

>  And I haven't seen any clients which do have such
> auto-detect features

man dhclient says: "If no interface names are specified
       on the command line dhclient will normally  identify
       all  network  interfaces,  eliminating non-broadcast
       interfaces if possible,  and  attempt  to  configure
       each interface."


 ... I begin to feel we're talking about=20
> different
> things now.

You may be closer to reality than me.  I'm not a dhcp expert,
at least not when it comes to experience with various client
implementations and especially not when it comes to tap
interfaces.  So I hope I'm not making things more confusing
when I point out potential problems I see.=20=20

>=20
> > This is the
> > core issue, right? Otherwise it would just work so long
> > as dhcp is turned on.  I think we need to decide where
> > the problem really is before we decide how to fix it.
>=20
> I don't think we're on the same page now.  The issue how I see it:
> There is a real DHCP server which provides DHCP clients network
> configurations automatically, including IP addresses, routes and
> default
> gateway, DNS/WINS servers, and a lot of the other options the DHCP
> server supports.
>=20
> The challenge for OpenVPN in this is that now a separate DHCP client
> needs to be started via a --up script, and to be torn down via a
> --down
> script.  But this needs to be run as root (at least on most platforms
> I
> know about).
>=20
> The problem, how I see it, is how to do this in an easier and more
> robust way, configuration wise - to make OpenVPN on *nix behave more
> like it does on Windows, where no extra configuration is needed at=20
> all
> (if you ignore the DNS cache issues in Windows for now), it just
> works.
>=20
> Please correct me, if you think I have made it too vague and simple,
> or
> simply wrong.

This is right.  Perhaps too simple in the case of dhcp clients
that support multiple interfaces.  This is especially true
if the dhcp server is started after the openvpn process
because then the dhcp server can see the tap interface
and configure it (and fiddle with resolv.conf) without=20
anything having to be done on the openvpn side.
See also this bottom of this message for an alternate statement of
the problem.

>=20
> > If you build a dhcp client into openvpn you push the problem in
> > the other direction.  Now you've, potentially, got
> > multiple dhcp clients running and you need to do
> > something to keep them from interfering with each other.
>=20
> Why is this an issue?  Unless they operate on each separate network
> segment, this shouldn't cause any unexpected behaviour.  And it's not
> uncommon to see boxes with multiple interfaces running separate DHCP
> clients per interface, and that don't seem to cause any problems in
> those setups I've done that with.

The issue is when two clients want to assign an address to=20
one interface.  I don't know if dhclient will autodetect tap
interfaces but if so, or if anything else does, then you get
2 clients doing dhcp for one interface.


> > You can't rely on processes being started and stopped
> > in boot-time order because the sysadmin might start
> > and stop services as needed to maintain the system
> > and you don't want surprising things to happen.
> > (The principle of least surprise is a good one.)
>=20
> Exactly, and if a user stops OpenVPN, the DHCP client for that TAP
> interface should also be taken down, right?  And if the OpenVPN is
> started at boot time, OpenVPN will take care of getting the DHCP
> config
> when the link is established, right?  I don't see any obstacles here,
> nor any potential surprises.

You're assuming one client dhcp process per interface.  I'm not.
(And have been habitually assuming the opposite until
corrected by Peter's post.)
So an already running (or yet to be started) dhcp client
can fuss with the openvpn tap interface.

>=20
> You start OpenVPN, and expect it to do the setup properly.  If the
> DHCP
> client is built into OpenVPN, that should really not cause any
> surprises.  It should simply, just work(tm).
>=20
> I don't see how this relies on boot-time order, etc, etc.  As long as
> OpenVPN has not established a connection it would not start a DHCP
> request anywhere.
>=20
> > You may as well just statically configure your existing
> > dhcp client so that it knows to go looking for the
> > tap device.
>=20
> How would you do that?  The different DHCP client applications might
> have different arguments, where and how would you configure this
> statically?

Yes, it would vary based on client.  That is the crux of the problem.
If the system is already setup to automatically configure all
interfaces with dhcp in a simplistic if-it-exists-then-configure-it
fashion then introducing a dhcp client into openvpn breaks the
system and manual intervention is required to turn off this
simplistic behavior.

> > I think the only way to go is to integrate with
> > anything that the local admin may decide to use
> > for dhcp/resolv.conf/etc.
>=20
> For resolv.conf issues, at present, using a third-party DHCP
> application
> is probably a safer bet right now.  I agree to that one.  But I'm far
> from convinced that it is the best solution, just because of the wide
> range of DHCP clients and distribution specific adjustments.

This is the reason I'm inclined to try to do something that pushes
the responsibility for integrating openvpn with dhcp onto the
distribution maintainers.  They know how their distro works,
what dhcp client is installed by default, what order
things are started at boot, how resolv.conf gets frobbed, etc.=20=20
The trick is to do it in a way that also allows the end user control
as well (i.e. not do it in ./configure).  Provide a few example
configs for the major distros and once they get that in place
all the downstream distros should pick up from there.

If you've got security concerns starting and stopping dhcp
daemons from openvpn then don't.  Reformulate the problem
so that it's openvpn that's started and stopped, along with
dhcp and whatever else, from whatever the distro uses to
bring interfaces up and down.  In other words treat the
vpn interface as just another interface rather than
some special thing -- make the vpn-ness transparent by
integrating it into interface management.  This is the
sort of ease of use that end-users are looking for anyway.

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


