Date: Wed, 12 Oct 2022 08:39:31 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Y0ZhI7jZ0/aXQ4l0@...1296...>
References: <20220812134154.16729-3-kprovost@...2661...>
 <202208201401.27KE12Cm014083@...2054...>
 <YwDwvG++hK0nJI2F@...1296...>
 <21B552DE-38FE-41F0-8FC7-606EA4C06093@...1376...>
 <Yz72rrCsJCjBgE4T@...1296...>
 <3B9F182D-0936-4799-B1B0-D269DBB3C2E6@...1376...>
 <Yz/35K6JddVNg9F9@...1296...> <Y0W/3bWLuTuYZvxs@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XJvyErSHwXqKEagi"
Content-Disposition: inline
In-Reply-To: <Y0W/3bWLuTuYZvxs@...1296...>
Subject: Re: [Openvpn-devel] route/iroute handling on FreeBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristof Provost <kp@...1249...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--XJvyErSHwXqKEagi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 11, 2022 at 09:11:25PM +0200, Gert Doering wrote:
> OTOH, in "not peer2peer mode", we only support topology subnet anyway,
> so maybe it should autoconfigure that, depending on the mode OpenVPN
> requests (p2p mode -> IFF_POINTOPOINT, p2mp mode -> IFF_BROADCAST),
> so we don't even need TUNSIFMODE.

It's not that easy - there are two factors coming into play here, which
are orthogonal.

Factor 1: single-peer (client or p2p) vs. multi-peer

 single-peer -> DCO has only 1 peer, all packets that go into the=20
                tun/dco interface are sent out to the single peer
                ("dumb pipe mode") - exactly like tun(4) behaves

                If a subnet is configured on the interface, packets to
                ALL IPs (!=3D local) in that subnet are sent to the other
                side.  No next-hop lookup is done.

 multi-peer -> DCO has 0..N peers.  Packets that go into the tun/dco
               interface get mapped according to route next-hop <->
               peer[]->vpn_v4 (or v6) address and sent to that peer.

               If a subnet is configured on the interface (only supported
               mode :-) ), packets to IP addresses in that subnet that
               have no mapped-to peer are DROPPED.

 On Linux this is controlled by openvpn_dco_init() setting dco->ifmode
 to OVPN_MODE_MP/OVPN_MODE_P2P, and net_iface_new() passing this parameter
 to kernel DCO.

 On FreeBSD, OpenVPN does not signal the p2p/p2mp mode to kernel yet
 (if I am not misreading the code), and if I am reading ovpn_route_peer()
 in if_ovpn.c correctly, "single-peer mode" will drop packets where a
 corresponding peer can neither be found by ovpn_find_peer_by_ip, using
 target IP or Route->Gateway lookup.

 (*) ovpn_find_peer_by_ip() is using a sequential search, for every=20
 single packet, which will perform poorly on servers with 1000s of
 clients... room for optimization.



Factor 2: IFF_POINTOPOINT vs. IFF_BROADCAST

 This seems to be a *BSD-specific thing, aka "there is nothing in the
 Linux specific code that seems to bother with this".

 An Interface can be put to point-to-point mode (by ioctl(TUNSIFMODE)
 with the IFF_POINTOPOINT flag set).  In that case, there is no "on-link"
 subnet, just "us" and "them", and ifconfig wants two IPv4 addresses
 as parameter

     ifconfig tun0 10.2.3.77 10.2.3.1

 ... that do not need to be adjacent.  It takes a "netmask" argument, but
 that does not have a real effect.  To simulate "subnet" mode, OpenVPN
 will add a 10.2.3.0/24 -> 10.2.3.1 route.

 In "dumb pipe mode", this works nicely - the /24 route shoves all packets
 towards the tun0 interface, and the tun(4) sends them over, without lookin=
g.

 In "openvpn non-dco p2mp server mode" this *also* works nicely, because
 the tun(4) interface is still in "dumb pipe mode" and OpenVPN will do
 an iroute lookup in the p2mp server forwarding path, sending to the proper
 client.

 In DCO mode with iroutes, this does not work at all anymore.  Say, there
 is a client on 10.2.3.50, using iroute 10.22.33.0/24, so OpenVPN tries
 to install a route via

    route add 10.22.33.0/24 10.2.3.50

 and FreeBSD *refuses* to install this route, because "10.2.3.50" is not
 adjacent.  In my initial tests I did not notice this, because the only
 client with iroute was assigned the .2 address,

 One option that sounds like it would work: always use "remote_addr"=20
 (=3D second parameter to IFF_POINTOPOINT ifconfig) as next-hop for all=20
 iroute-originated routes - this would make FreeBSD accept the route, and
 send packets towards the ovpn(4) interface.  Alas, the next-hop would
 be "remote_addr", not "the right p2mp peer", so the "what peer do I need
 to send this packet to?" search in ovpn(4) would find the peer on the
 "remote_addr" IP, not the correct one (=3D lookup happens in normal=20
 routing table).  So, it wouldn't work [AND it would add more ugly bits
 to OpenVPN].


 Option #2: set the interface to IFF_BROADCAST, which means "true
 multi-IP interface, with subnet, and Kernel considers all IPs of that
 subnet to be adjacent, and acceptable route next-hops".

 This is what the patch I sent yesterday does to tun(4) interfaces, and=20
 the result is amazingly well-behaved - "it just works" and gets *rid*
 of quite a bit of special-case hack-around code.  Want.

 Unfortunately, this breaks for two reasons with FreeBSD DCO as of
 today:

  - no TUNSIFMODE support in ovpn(4), so stuck to IFF_POINTOPOINT mode
    (I think I can add that, copy-pasting code from if_tuntap.c)

  - no single-peer mode in ovpn(4)
    -> this will break "I am on client .5 and want to send packets to
    client .6" because vpn_v4 peer lookup won't find ".6", and no route
    towards .1 (server) either, so packet drop.
    (I'm not sure I can make this happen, but I'll give it a try,=20
     following the Linux DCO approach described above)


 (There is another option here that I think I could mention - we can,
 of course, do IFF_BROADCAST only on the openvpn p2mp server, and stick
 to IFF_POINTOPOINT on client/p2p instances.  BUT that implies we'd get
 yet another case for FreeBSD ifconfig - p2p, p2p-simulated subnet, subnet
 - so the OpenVPN code will get more complex, not simpler - and we still
 need IFF_BROADCAST support in ovpn(4) - so we can do it properly all
 the way, I'd say)


 Note that Aspect 2 is only about IPv4.  IPv6 always uses true subnet mode,
 and all these considerations are of no concern...


Phew, what a long mail :-) - hope it clarifies what we're missing today
and how to move forward.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--XJvyErSHwXqKEagi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjRmEjAAoJEB2Cnv7KVigSHlgL/j7vkksNTk+O8qkxmusVtWgQ
yvsUtAozGoeIlP60TkeD45sNUSqI1AVFfESp+oPvlEAM8JHcoHFA+24CRL0n3wpb
mJHsIXJNJU1mei26CSai//Y9hrhLlnTC/mi1kT6v9weJeiiVSWfUkvsOhy71dUJS
T0FvwQ1P03L1rGV5c/GaRwRDcEqUhuB5jDUhrF+9tSWqCNZByWamN6QqKM0SELwn
7lp6Y5+zPu9HWrojiCqtsEW3Hk7EnZhjkp5JjHQLd5Jv6uOTnYuMhFOHYYLWgEqq
wdX9ORY05BkE4H9eH5gl8S/Xsa1l42zsV+S6CQni8BsTBxHWxJ/EVNRbJ/uHhs2d
AZM7xib9chdN/rNJ4CQTkPsw9VAbcb/r0UCg5cDOl7u5H4KhWgI3IBrBK+Bau6BD
1sa3DG4Yl9pu61zRN2IQCt83JmarBOYABS+zjVnNfgwCSuzxiERtI5SECM6rWxFS
TJH6RQp92qKVxqJkKvQGRUAknF95u4qdWcH+/PkWOw==
=kwxe
-----END PGP SIGNATURE-----

--XJvyErSHwXqKEagi--

