Subject: Re: [Openvpn-devel] MTU
From: Jan Johansson <jan.johansson@...1...>
In-Reply-To: <200302231610.h1NGAKf32688@...41...>
References: <200302231610.h1NGAKf32688@...41...>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VU8EmHxw96jEwWfQz5Kr"
Message-Id: <1046076005.1358.38.camel@...2...>
Mime-Version: 1.0
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
Date: Mon Feb 24 00:45:06 2003
To: openvpn-devel@lists.sourceforge.net

--=-VU8EmHxw96jEwWfQz5Kr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-02-23 at 17:10, James Yonan wrote:
> Russ,
>=20
> Have you tried the tracepath utility to attempt to measure the Path MTU?
>=20
> Are the routers in the path properly forwarding ICMP code 3 (destination
> unreachable), and ICMP code 4 (fragmentation needed but don't-fragment bi=
t set)?
>=20
> Most MTU problems are caused by routers and firewalls which do not handle
> these ICMP codes correctly, causing path MTU discovery to break.
>=20
> The symptoms of this problem are as you show below...  Running an app ove=
r the
>  tunnel works fine initially until the first large packet is sent, then t=
he
> app hangs.

I have a different theory here.=20
I am experiencing what I believe to be MTU problems, which have made me
switch from RSA-auth to shared-key, just because the RSA auth stuff
seems to trigger it also.

My theory is that part of the problem lies in how the Linux kernel
handles udp. I already got it into the README-file that openbsd firewall
scrub rules will "kill" openvpn the same way it will kill Linux-nfs, but
somehow other routers along the route probably do similar things.

One of the problems is that Linux sometimes (this is more a vague
feeling and guesswork than the next part) sends fragments in reverse,
meaning that the second half of the packet will be sent before the first
part of a split packet. This is why, for instance, you can't netboot Sun
boxes from Linux tftp-servers. The prom-code (bios sort of) in Sun
machines can't reassemble fragged packets, at least not packets that
arrive in reverse. This might make routers and firewalls along the way
to behave badly, especially with the next part in mind:

The second part is that linux will tag all UDP (or at least all UDP from
OpenVPN and NFS) as "Dont fragment". This is sort of ok. The problem is,
they do get fragmented anyway. I can't prove that it isn't related to
the transport in between me and the peers I have set up, but I find it
likely that someone is fragmenting them anyway, perhaps even by the
sending linux box itself. Since there is a *BSD box in between in my
case, it will regard any fragmented UDP (or ip) packet with DF set as a
bug, it silently and without mercy kills them. It may also mean that if
the second half of a fragment comes first, with the DF flag on, it's
even more suspicious.

As far as I can guess, this probably goes for lots of ISP's and other
hardware involved in the transport of ip packets between me and my
peers.=20
For some reason, I seem to get the feeling that RSA negotiation doesn't
follow the udp-mtu (or tun-mtu-derived udp-mtu) settings, and send too
large packets, and them getting fragmented leads to me having to revert
back to precalced secrets.

It also means that I get the same error as you've described in the last
mails. I have a remote-backup-over-rsync that is protected by both
OpenVPN and ssh inside of that. It goes some 256k and then dies. It dies
reliably every time, and almost always on the same byte, some 240506
bytes into the RSYNC-stream. (whatever, the number isn't important).
If I forego the openvpn and ssh straight into the machine, the rsync
doesn't die.

So there definately exist some sort of issue with MTU's, which I can't
seem to solve correctly. The question is, does the SSL-stuff really
check the mtu's, and can you make the linux kernel not put DF's on UDP
packets? (since they are ip packets, they can be fragmented and
reassembled like any other packets I guess)

"man 7 udp" on RedHat says:

UDP fragments a packet when its total length  exceeds  the
       interface MTU (Maximum Transmission Unit).  A more network
       friendly alternative is  to  use  path  MTU  discovery  as
       described in the IP_PMTU_DISCOVER section of ip(7).
--=-VU8EmHxw96jEwWfQz5Kr--
