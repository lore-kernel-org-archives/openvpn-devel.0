Message-ID: <1e6368e80509300544h3d4f5541gc8b01ba40b5adaa5@...278...>
From: Leonard Isham <leonard.isham@...277...>
Reply-To: Leonard Isham <leonard.isham@...277...>
Subject: Re: [Openvpn-devel] 400 vpn clients 20% of them loosing the route frequently
In-Reply-To: <1128082114.7399.113.camel@...399...>
MIME-Version: 1.0
References: <1127848987.6861.117.camel@...399...>
	 <1e6368e80509271858682178b5@...278...>
	 <1128082114.7399.113.camel@...399...>
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
Date: Fri Sep 30 05:47:10 2005
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Marcelo Toledo <marcelo@...461...>
Cc: openvpn-devel@lists.sourceforge.net

On 9/30/05, Marcelo Toledo <marcelo@...461...> wrote:
> Em Ter, 2005-09-27 =E0s 21:58 -0400, Leonard Isham escreveu:
> > On 9/27/05, Marcelo Toledo <marcelo@...461...> wrote:
> > > I have one OpenVPN server version 2.0.2 using TCP port 1194 with TLS
> > > with about 400 clients connected to it. From time to time it's
> > > impossible to ping the client from the server, but if you log into the
> > > client and ping the server, the server now became able to ping the
> > > client. I made a lot of tests removing the bridge and trying a older
> > > versions of openvpn and the problem still hapenning with about 20% of
> > > the clients connected to the vpn.
> > >
> > > here is the config of the client and server:
> > >
> > > # SERVER CONFIG
> > > mode server
> > > port 1194
> > > proto tcp-server
> > > dev tap
> > [snip]
> >
> > Observations:
> > 1. 400 clients... 1 server only?
>
> Yes, 400 clients and only 1 server.

What are the stats on the server?  Are there any resource issues?=20
CPU, TCP. etc.

> > 2. TAP means additional overhead full ethernet packet encapsulated in
> > TCP/IP packet.  Broadcasts, fragmented ethernet datagrams  and for 400
> > clients....
>
> We don't use TUN because from what I know it opens one connection per
> port and also one configuration per client, which is insane for a 400
> clients and growing (we're going to reach 600 by the end of this year).

OpenVPN 1.X was one port per connection TUN or TAP.  OpenVPN 2.x
supports the old setup, but was designed with a server mode for _both_
TUN and TAP.  You can either dynamically hand out IP addresses or
statically with either method.

> > 3. TCP over TCP is not recommended. The internal congestion control
> > can conflict with the external congestion control.
>
> We already used OpenVPN with UDP, but the oscillations were much higher
> then today, that's why we migrated to TCP.

This indicates that you are experiencing connectivity issues, outside
of the tunnel.  UDP is connection less, and OpenVPN will not
retransmit.  Broadcasts or connectionless and usually have no
retransmission capacity.  TCP is is connection oriented and will
resend packets, even the broadcast packets as they are just payload to
TCP.  Connectivity problems can still cause TCP failures.  To many
failures and reconnection attempts will use up TCP sockets, an
unintentional self inflicted DOS.

> > 4. What is your full bandwidth and usable bandwidth at the server?
>
> We have 3MB and we're using half of it (1.5).

What is the bandwidth at the client sites?

> what do you think?

Are these site-to-site or road warriors?  Are the 20% always the same
or random?  Do the 20% have anything in common.  Ant NAT devices or
firewalls in between that may be having periodic resource issues?

Have you considered setting up cacti or other system to monitor
resources and provide graphs?

Consider setting up a second server or OpenVPN instance and use TUN
with UDP and migrate.

Do you have any packet captures of the traffic out the TAP interface
on the server and client that experiences the failures?

I don't know your workload or any other details, but what about
another person to take some of your workload so you can concentrate on
this issue.  Or a second set of eyes to work on this issue with you (I
would look for someone with at least as much networking experience as
you have).

--
Leonard Isham, CISSP
Ostendo non ostento.

