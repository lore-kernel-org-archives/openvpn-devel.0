Message-Id: <200211272133.gARLX8f14794@...41...>
From: "James Yonan" <jim@...41...>
In-Reply-To: <111C7A5AB1BCD411918A000103212474FF895C@...56...>
Subject: [Openvpn-devel] RE: [Openvpn-users] OpenVPN w/ TAP device on Linux/FreeBSD
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Nov 27 13:34:02 2002
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Zhen Xu <zhen@...55...>
Cc: openvpn-devel@lists.sourceforge.net

Zhen,

I'm moving this thread to openvpn-devel as it is starting to touch on more 
development oriented issues.

Well the good news is that I was able to reproduce your problem with MTU 
settings on TAP devices (on Linux) and I have a proposed fix.

The problem is that OpenVPN apparently has a flawed assumption about the 
relationship between the MTU size that a TAP device is ifconfiged with, and 
the maximum packet size which might be returned in a read() operation on 
that device.

For example, I ifconfiged a TAP device to an MTU of 1200, did a ping -s 2000 
over the link (through OpenVPN), and found that OpenVPN needed to have a 
large enough buffer on read() to read/write 1210 bytes to/from the TAP 
device.  By contrast, a TUN device MTUed to 1200 would never try to push 
more than 1200 bytes onto a read() operation.

Until now, OpenVPN assumed that if the MTU of TUN/TAP device was x, that it 
would be sufficient to read from that device using read(tun_tap_fd, buffer, 
x) where buffer is of size x.

Given that this assumption is flawed, it is probably necessary to add a new 
variable which I am calling tun_mtu_extra which is the maximum number of 
bytes in excess of the MTU size that a TUN/TAP device might return in a read 
operation.

I've put together a new beta of OpenVPN which allows this parameter to be 
set using a new --tun-mtu-extra option.

In my testing, --tun-mtu-extra 64 worked fine with a wide range of MTU sizes 
on TAP devices.

The tarball is here (also on CVS):

http://openvpn.sourceforge.net/beta/openvpn-1.3.2.2.tar.gz

Zhen, let me know if it works for you.

Also, for other OpenVPN developers, is this the right solution?  It seems 
like a bit of a kludge, though it also seems like a bug that a TAP device 
would expect a reader to accomodate a read greater than its MTU size.  If it 
is the right solution, should it be defaulted to some reasonably 
conservative value and hidden under the hood, or should it be exposed as an 
option (as I have done) to potentially confuse and/or empower end-users?

Comments?

James

Zhen Xu <zhen@...55...> said:

> James,
> 
> Tried out the method you suggested by setting tun-mtu and let the udp-mtu
> float does not work. I have tried tun-mtu at 1200, 1300, 1400, and none of
> them work. The way I am testing it is to do a "ping -c 1 -s 4000 <peer>".
> The tcpdump on the tap device will show trucated-ip missing bytes.
> 
> zxu
> 
> -----Original Message-----
> From: James Yonan
> To: Zhen Xu; ''openvpn-users@lists.sourceforge.net' '
> Sent: 11/25/02 1:22 PM
> Subject: RE: [Openvpn-users] OpenVPN w/ TAP device on Linux/FreeBSD
> 
> Zhen Xu <zhen@...55...> said:
> 
> > Hi all,
> > 
> > This is just a follow up on my discoveries on OpenVPN with TAP
> interfaces.
> > As I have said in the previous email, the caculated tun-mtu by OpenVPN
> does
> > not work. My statement in the previous email regarding OpenVPN is not
> > caculating the tun-mtu when udp-mtu is specified maybe wrong. By
> looking at
> > the source, it seems that udp-mtu/tun-mtu is only calculated when
> encryption
> > is used. As the example I am using in the previous email is not using
> any
> > encryption, OpenVPN will just use the same mtu for both udp/tun.
> However,
> > the result is the same--the calculated tun-mtu does not work with the
> TAP
> > interface. By debugging the connection, packet transfers between two
> peers
> > at the UDP level is working fine. The problem is actually at the
> tun/tap
> > level. By using the calculated tun-mtu, tcpdump will show truncated-ip
> > missing byte error when large packets need to be fragmented into
> smaller
> > ones and then de-fragmented at the other end. As it is truncated-ip
> with
> > missing byte, the checksum will be wrong and the peer will simply drop
> the
> > packet. Consequently, the message of the day in ssh will crash the ssh
> > client. Why the calculated tun-mtu will not work with TAP drivers, I
> am not
> > sure and James may give more insight. 
> > 
> > To get around the problem, I managed to use --udp-mtu 1300 in the
> config
> > file and use a hard coded mtu for the tun interface in the --up
> script. For
> > any given udp-mtu in the config file, (udp-mtu size - 100) will work
> > perfectly for your tun-mtu. For example, with udp-mtu set to 1300, I
> will
> > use 1200 as the mtu for the tap interface (OpenVPN will calculate and
> > recommend 1258). In my --up script, I will have "ifconfig $1 inet
> x.x.x.x
> > netmask x.x.x.x mtu 1200 up" instead of "ifconfig $1 inet x.x.x.x
> netmask
> > x.x.x.x mtu $2 up". This will resolve all the problems I am having
> with
> > OpenVPN/TAP interface. Why this? I have not figured out yet.
> > 
> > With the above resolved, I am happy to report that Zebra/OSPF works
> perfect
> > with OpenVPN. I can not have 4 sites running with a mix of
> FreeBSD/Linux and
> > the virtual network routes automatically with OSPF. 
> > 
> > zxu
> 
> Zxu,
> 
> Just to clarify how OpenVPN handles MTU, there are 3 variables of
> interest, with 2 degrees of freedom:
> 
> (1) udp-mtu is the max size of an encapsulated packet + encryption
> related overhead.  Thus, udp-mtu is the max size of a UDP datagram which
> will be exchanged between the peers.
> 
> (2) tun-mtu is the MTU size of the TUN or TAP device, i.e. the max frame
> size of the underlying transport (IP in the case of a TUN device, or
> Ethernet in the case of a TAP device).
> 
> (3) A parameter we will call "delta" is the size of the encapsulation
> overhead, including encryption overhead.
> 
> As you probably surmised from reading the code, the MTU equation is as
> follows: udp_mtu = tun_mtu + delta.
> 
> OpenVPN allows either (1) or (2), but not both, to be explicitly defined
> on the command line or config file.  (3) is calculated internally based
> on the amount of encryption overhead which OpenVPN will need, given a
> set of encryption options.  As you correctly observed, when OpenVPN is
> run without encryption, obviously there will be no encryption-related
> overhead, therefore delta == 0 and (1) == (2).
> 
> For reasons of flexibility, OpenVPN allows either udp-mtu or tun-mtu to
> be explicitly defined.  OpenVPN will then calculate the other variable
> based on the MTU equation above.  This flexibility is important, because
> setting the MTU in an encapsulated protocol environment is a complex
> exercise given the issues of fragmentation and other constraints.  For
> example, when you use the udp-mtu parameter, OpenVPN assumes that
> (udp_mtu - delta) is a legal MTU size for the TUN or TAP device.  In
> practice this might not be the case, as you observed with a TAP driver
> in your example above.
> 
> The intended solution to the problem of the TUN or TAP device only
> accepting certain MTU values is to set the value explicitly using the
> tun-mtu parameter, and let the udp-mtu "float" according to the equation
> udp_mtu = tun_mtu + delta.
> 
> In your example above, this could be accomplished by setting tun-mtu
> (the tun-mtu parameter in OpenVPN means the MTU of the TUN _or_ TAP
> device) to 1200 and then leave the up file as 
> 
> ifconfig $1 inet x.x.x.x netmask x.x.x.x mtu $2 up
> 
> OpenVPN would then use 1200 as the TAP MTU and approximately 1242
> (depending on encapsulation overhead) as the UDP MTU.  In the script
> above, $2 would be set to 1200 by OpenVPN.
> 
> Does that make sense (and more importantly does it work for you)?
> 
> James
> 
> > 
> > -----Original Message-----
> > From: James Yonan
> > To: Zhen Xu; 'openvpn-users@lists.sourceforge.net'
> > Sent: 11/23/02 2:26 PM
> > Subject: Re: [Openvpn-users] OpenVPN w/ TAP device on Linux/FreeBSD
> > 
> > Zhen Xu <zhen@...55...> said:
> > 
> > > Hi all,
> > > 
> > > Is anyone using OpenVPN with TAP device on either Linux or FreeBSD
> > with
> > > success? If not, I like to know if OpenVPN is well tested with the
> TAP
> > > driver. 
> > > 
> > > I was trying to use OpenVPN with TAP driver, but ran into some weird
> > > problems that I could not solve myself. The situation is this:
> > > 
> > > * Setup VPN with OpenVPN with a mix of Linux (2.4.7/2.4.19) and
> > FreeBSD
> > > (4.4)
> > > * Use TAP driver so that Zebra/OSPFD can see it and do OSPF routing
> > across a
> > > couple VPN sites (for some weird reason, Zebra/OSPFD does not see
> tun
> > > point-to-point devices and can not run OSPF over it)
> > > 
> > > The setup of OpenVPN is as smooth as it could be and bringing up the
> > link
> > > between two sites went just fine. For site A, we have "ifconfig $1
> > inet
> > > 10.0.0.1 netmask 255.255.255.252 mtu $2 up". For site B, we have
> > "ifconfig
> > > $1 inet 10.0.0.2 netmask 255.255.255.252 mtu $2 up". On either site
> A
> > or B,
> > > pinging the remote site went through just fine without any problem.
> > However,
> > > the problem occurs once one of them starts to transfer large data.
> For
> > > example, if you run ssh on site A to connect to site B, the ssh
> > > authentication will pass, but right after login, the remote site is
> > sending
> > > over the message of the day, the ssh session will die. Tried to
> debug
> > the
> > > link by using --verb 8, each key strok you type on the ssh client
> that
> > you
> > > are running on site A is actually sent to the site B, however, the
> ssh
> > > screen will freez with just one or two lines of the message of the
> > day.
> > > Trying the same with ftp and scp, the same result will happen. For
> > ftp, the
> > > ftp client will give out message like connection timeout. To isolate
> > > problems, I have tried to run OpenVPN without encryption or anything
> > special
> > > options except lzo compression across LAN on the same switch. Both
> > sides are
> > > Linux 2.4.19. If the TAP driver is used, the VPN link will behave
> the
> > same.
> > > To dig further, I have tried the tun driver with the above setup,
> > everything
> > > works great even transfering 100+M data across scp. For tun setup,
> > instead
> > > of using the up script, the config file has "ifconfig 10.0.0.1
> > 10.0.0.2".
> > > Originally, I am suspecting the MTU size, however, changing from
> > udp-mtu
> > > 1000 to 1500 does not fix the problem I am having. As the same
> problem
> > > occurrs even with two machine setup on the same switch, MTU patch
> > discovery
> > > blocked by firewall inbetween is not part of the problem. Could
> anyone
> > give
> > > me any hints? Thanks much!
> > > 
> > > zxu
> > 
> > Zhen,
> > 
> > Unfortunately I haven't used TAP devices other than in a simple
> testing
> > situation, so I can't give you very much feedback.  From what you
> > report, it sounds like some kind of MTU problem.  You said that small
> > packets like ssh keystrokes work fine, but the "message of the day"
> > locks up the connection.  With OpenVPN running --verb 8, does the
> > message of the day actually transit the UDP link between the OpenVPN
> > peers?  Where exactly in the chain of transmission is the message
> > dropped?  Since a TUN based connection works perfectly, I would
> suspect
> > some kind of problem in the way you are using the TAP device.  Are you
> > bridging the TAP device with an ethernet NIC?  If so, are you ensuring
> > MTU compatibility between the real and virtual ethernets.  Have you
> > checked the linux brctl list for the usual gotchas regarding this type
> > of configuration?  Have you tried a Linux <-> Linux TAP connection
> > (perhaps some problem between Linux and FreeBSD TAP drivers -- in the
> > past, I have encounter!
> > ed fragmentation incompatibilities between TUN drivers of different
> > OSes.  See the note in INSTALL about OpenBSD and the "scrub"
> directive)?
> > Are you only using a TAP driver instead of a TUN driver to get around
> > the problem of Zebra/OSPFD not seeing TUN devices?  If so, you might
> > look deeper into the problem of how to solve this problem, because TAP
> > drivers are usually only used by people who want to do ethernet
> > bridging, and as such they introduce some extra complexity which is
> not
> > present in the simpler case of the TUN driver.
> > 
> > It is an interesting problem, making Zebra/OSPFD work over virtual
> > links, and I don't recall this topic being discussed here before.  If
> > you figure it out, be sure to let us know how you made it work!
> > 
> > James
> > 
> > 
> > -------------------------------------------------------
> > This sf.net email is sponsored by:ThinkGeek
> > Welcome to geek heaven.
> > http://thinkgeek.com/sf
> > _______________________________________________
> > Openvpn-users mailing list
> > Openvpn-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-users
> > 
> 
> 
> 
> -- 
> 
> 



-- 






