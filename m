Message-Id: <200302242027.h1OKQxf11449@...41...>
Subject: Re: [Openvpn-devel] MTU
From: "James Yonan" <jim@...41...>
In-Reply-To: <1046076005.1358.38.camel@...2...>
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
Date: Mon Feb 24 12:30:10 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jan Johansson <jan.johansson@...1...>, openvpn-devel@lists.sourceforge.net

Jan Johansson <jan.johansson@...1...> said:

> On Sun, 2003-02-23 at 17:10, James Yonan wrote:
> > Russ,
> > 
> > Have you tried the tracepath utility to attempt to measure the Path MTU?
> > 
> > Are the routers in the path properly forwarding ICMP code 3 (destination
> > unreachable), and ICMP code 4 (fragmentation needed but don't-fragment bit
set)?
> > 
> > Most MTU problems are caused by routers and firewalls which do not handle
> > these ICMP codes correctly, causing path MTU discovery to break.
> > 
> > The symptoms of this problem are as you show below...  Running an app over the
> >  tunnel works fine initially until the first large packet is sent, then the
> > app hangs.
> 
> I have a different theory here. 
> I am experiencing what I believe to be MTU problems, which have made me
> switch from RSA-auth to shared-key, just because the RSA auth stuff
> seems to trigger it also.

That's interesting, though it makes sense that if OpenVPN thinks the MTU is
higher than it really is, that this would occur.  That's because the SSL/TLS
handshake involves some relatively large exchanges (several K octets) that are
fragmented by OpenVPN to the udp-mtu packet size.  In this case, if OpenVPN
thinks that the udp-mtu is 1300 then it will attempt to send packets of
exactly 1300 octets in size, until it reaches the last fragment which will
probably be smaller.  So essentially, OpenVPN's current method of fragmenting
SSL/TLS handshakes guarantees that it will push the MTU parameter it's given
to the limit (udp_mtu in this case).

> My theory is that part of the problem lies in how the Linux kernel
> handles udp. I already got it into the README-file that openbsd firewall
> scrub rules will "kill" openvpn the same way it will kill Linux-nfs, but
> somehow other routers along the route probably do similar things.
> 
> One of the problems is that Linux sometimes (this is more a vague
> feeling and guesswork than the next part) sends fragments in reverse,
> meaning that the second half of the packet will be sent before the first
> part of a split packet. This is why, for instance, you can't netboot Sun
> boxes from Linux tftp-servers. The prom-code (bios sort of) in Sun
> machines can't reassemble fragged packets, at least not packets that
> arrive in reverse. This might make routers and firewalls along the way
> to behave badly, especially with the next part in mind:
> 
> The second part is that linux will tag all UDP (or at least all UDP from
> OpenVPN and NFS) as "Dont fragment". This is sort of ok. The problem is,
> they do get fragmented anyway. I can't prove that it isn't related to
> the transport in between me and the peers I have set up, but I find it
> likely that someone is fragmenting them anyway, perhaps even by the
> sending linux box itself. Since there is a *BSD box in between in my
> case, it will regard any fragmented UDP (or ip) packet with DF set as a
> bug, it silently and without mercy kills them. It may also mean that if
> the second half of a fragment comes first, with the DF flag on, it's
> even more suspicious.

Well actually what you are observing here is RFC 1191 ("Path MTU Discovery")
in action (or inaction as the case may be :)

http://www.faqs.org/rfcs/rfc1191.html

This process causes the DF bit to always be set on outgoing packets, but
assumes that other routers and firewalls in the path will play nice and return
an "ICMP need fragmentation but DF set message" if the packet is too big.

For linux at least, Path MTU discovery can be turned off for a given UDP
socket, causing all packets to be sent with DF cleared and no attempt by the
kernel to offer fragmentation or defragmentation services.

I already have a feature in the CVS under branch MTU_EXPERIMENTAL which gives
command line control over the Path MTU discovery settings on the UDP socket.
 
> As far as I can guess, this probably goes for lots of ISP's and other
> hardware involved in the transport of ip packets between me and my
> peers. 
> For some reason, I seem to get the feeling that RSA negotiation doesn't
> follow the udp-mtu (or tun-mtu-derived udp-mtu) settings, and send too
> large packets, and them getting fragmented leads to me having to revert
> back to precalced secrets.

I will check this, but I doubt that SSL/TLS could go over the udp-mtu (I would
expect lots of errors and/or assertion crashes in OpenVPN if this was the
case).  It seems more likely to me that the udp-mtu might be too large.

> It also means that I get the same error as you've described in the last
> mails. I have a remote-backup-over-rsync that is protected by both
> OpenVPN and ssh inside of that. It goes some 256k and then dies. It dies
> reliably every time, and almost always on the same byte, some 240506
> bytes into the RSYNC-stream. (whatever, the number isn't important).
> If I forego the openvpn and ssh straight into the machine, the rsync
> doesn't die.

I am considering adding a fragmenting feature to OpenVPN where it would
fragment packets using the very efficient RFC 815 algorithm in the event that
it received a packet on the TUN/TAP device that was bigger than the udp_mtu
could accomodate.  In essence, this feature would do fragmentation explicitly
rather than depending on the OS to do the fragmentation correctly.

See http://www.faqs.org/rfcs/rfc815.html for more info.

Matthias Andree suggested that OpenVPN might generate its own "Fragmentation
needed but DF set" ICMP messages and return them to the TUN/TAP device in this
case.

Adding to this, OpenVPN could set the udp_mtu dynamically, based on its
history of successfully transmitting packets of a range of sizes to its peer.

These changes, when taken as a whole, would take OpenVPN down the path of
becoming more like an intelligent router, and move away from the model of
relying on the OS to manage the transport protocol.
 
> So there definately exist some sort of issue with MTU's, which I can't
> seem to solve correctly. The question is, does the SSL-stuff really
> check the mtu's, and can you make the linux kernel not put DF's on UDP
> packets? (since they are ip packets, they can be fragmented and
> reassembled like any other packets I guess)
> 
> "man 7 udp" on RedHat says:
> 
> UDP fragments a packet when its total length  exceeds  the
>        interface MTU (Maximum Transmission Unit).  A more network
>        friendly alternative is  to  use  path  MTU  discovery  as
>        described in the IP_PMTU_DISCOVER section of ip(7).
> 
> From this text, I can't figure out why Linux puts DF on the packets,
> which tcpdump clearly shows it does.
> man 7 ip, udp, socket and friends have never shown me a way to stop DF,
> also none of them mention why Linux puts it there in the first place.

This code will stop Path MTU Discovery and the setting of the DF bit on a
particular UDP socket:

int mtu_type = IP_PMTUDISC_DONT;
setsockopt(udp_socket, SOL_IP, IP_MTU_DISCOVER, &mtu_type, sizeof (mtu_type)));

I know it works on linux, but I'm not sure about other OSes.

James


