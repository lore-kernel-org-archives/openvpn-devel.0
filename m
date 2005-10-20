Message-ID: <1e6368e80510201225r42c4181cl670f1e9ae227b709@...278...>
From: Leonard Isham <leonard.isham@...277...>
Subject: Re: [Openvpn-devel] Re: Bug report (long) - OpenVPN dropping small frames
In-Reply-To: <dj8pnu$1ea$1@...165...>
MIME-Version: 1.0
References: <dj6pnr$gs4$1@...165...>
	 <Pine.LNX.4.58.0510192103130.32723@...41...>
	 <dj8pnu$1ea$1@...165...>
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
Date: Thu Oct 20 12:27:23 2005
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Mike Ireton <mike-openvpn@...479...>
Cc: openvpn-devel@lists.sourceforge.net

On 10/20/05, Mike Ireton <mike-openvpn@...479...> wrote:
> James Yonan wrote:
>
> >
> > When you do your 1393 byte ping from A to B, the packet is going to tra=
vel
> > 1 -> 2 -> 3 -> 4 -> ICMP echo reply on B -> 4 -> 3 -> 2 -> 1.
> >
> > I need to know exactly where the packet is being dropped in this chain.
>
>
> The problem with this test is that there are many hundreds of OpenVPN
> packets per second flying between machine a and machine b - coupla
> megabits per second in fact. There is no way to capture just the crypted
> udp packets carrying the tunneled data involved in the test seperate
> from normal data traffic.

Actually it is quite trivial using tcpdump/windump, ethereal. snoop,
sniffer, etc.

If you traffic volume is too high then I'd say you may want to check
the performance of the equipment for bottlenecks.


> >
> > If the packet disappears between 1 and 2 or between 3 and 4 then either
> > OpenVPN or a firewall/packet-filter operating on the tap interface is
> > dropping it.
> >
> > If the packet disappears between 2 and 3, it's a network connectivity
> > issue, or a firewall/router/NAT issue on OpenVPN's communication port
> > (usually 1194).
>
>
> The evidence is that the link 2 -- 3 is good. These are passing a _lot_
> of traffic, both openvpn tunneled pppoe and regularly routed subnets and
> I have excellent low latency no packet loss connectivity to hosts
> reached over this link. My test case with the 1393 byte packets not
> working 'well' is actually directly connected to the same switch that
> 'Machine B' connects to.
>
>
> >
> > BTW, I tried a 1393 byte ping through an OpenVPN tap tunnel with default
> > settings and it worked fine.
> >
> > If you think that 1393 is an important number with respect to reproduci=
ng
> > the problem, try to isolate and differentiate the cases where 1393 byte
> > pings fail and where they succeed.
> >
> > James
>
>         I do think 1393 is an important number, at least on this newtwork=
, and
> I think it's the point at which the resulting crypted frames exceed the
> link mtu (1500) and generate fragments.
>
>         I should have stated that my test case actually has two ip addres=
ses.
> One IP is routed only thru the openvpn tunnel, and the other is a normal
> statically assigned routed public ip address. Both IP's are on the same
> interface, and this interface is connected to a switch that also
> interconnects the OpenVPN client and the router that serves this subnet.
>
>         The 1393 byte pings to the OpenVPN address (and larger), are the =
ones
> that do not work reliably. I can see up to %95 loss with pinging that
> address, while at the exact same time I can see %0 loss pinging the
> other (routed) address, which travels over the same exact path. When
> running tcpdump, if the ping is currently working for the openvpn
> tunneled address, I will see the icmp messages as I should. When the
> pings aren't working, I don't see anything. But this doesn't tell me if
> they're being dropped on the Openvpn client or server. However, running
> this ping to the statically routed address does continue to work
> thruout, so I think I can rule out a transport problem between the
> client and server.
>
>         For what it's worth, at the time when the pings to the tunneled a=
ddress
> are not working, this is when I see a high instance of icmp errors from
> the client directed at the server:
>
> x.x.x.x ICMP ip reassembly time exceeded, length 556
>
>
>         For the others who suggested reducing mss values and such - I'm a=
lready
> doing it. In fact I have mss clamped down to 1312 right now for testing.
> But, mss clamping doesn't have anything to do with the loss of the
> lcp-echo frames I was complaining about.
>

You _have_ to do a packet capture to determine where the packets are
getting lost.

While I'm not a developer I have quite a bit of experience with
networking and VPNs (OPenVPN and others) and your issues look like a
bottleneck or packet size issue to me, and others.

If I may be so bold. James has requested that packet caputres be
performed to confirm where the loss is and IMHO this is what you need
to do to prove your point.



--
Leonard Isham, CISSP
Ostendo non ostento.

