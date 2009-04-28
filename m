Message-ID: <49F6FA03.6070608@...1032...>
Date: Tue, 28 Apr 2009 15:43:47 +0300
From: =?ISO-8859-1?Q?Siim_P=F5der?= <siim@...1032...>
MIME-Version: 1.0
References: <49F1B322.6030705@...1032...>
	<1240630761l.7894l.0l@...1207...>	<49F34D62.4000302@...1114...>
	<m3zle2cwmx.fsf@...1176...> <1240846947l.13043l.1l@...1207...>
In-Reply-To: <1240846947l.13043l.1l@...1207...>
Subject: Re: [Openvpn-devel] linux openvpn development job
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net, Benny Amorsen <benny+usenet@...1175...>

Hi

Karl O. Pinc wrote:
> So, I believe it's easy and cheap to add hardware
> to a OpenVPN box and create a situation where
> the kernel/userspace transition cost does matter.

It's easy and cheap if you add a second box or third. But if you are
approaching tens of openvpn boxes (at various locations) and you want to
maintain rendundancy, it is not especially cheap nor is it especially
easy. Maintaining the system gets a bit trickier and simply relying on
ssh and grep doesn't cut it any more.

Regarding the idea of moving openvpn to kernel, I think there are MUCH
easier ways to improve the situation. As a large part of time is spent
in moving data between kernel/user, that interface could be improved.

There are two interfaces, udp sockets and tun devices. For both of them,
experimental proposed rx/tx ring implementations exist:

http://lwn.net/Articles/276856/ vringfd() is a genering buffer ring
interface, developed for lguest and seems to be implemented for tun
device. Not sure how much it would improve the situation, but I'm
guessing quite a bit.

http://wiki.ipxwarzone.com/index.php5?title=Linux_packet_mmap
packet_ring_tx (and rx, IIRC) interface written by Johann Baudy. Quoting
that wiki "I've reached 107Mo/S using a small embedded target
(PPC405-300Mhz) where I've never exceeded 20Mo/s with normal raw socket."


Also our own test show that using standard (ie, not neccessarily
optimized for routing) Opteron servers and intel e1000, we can saturate
1G easilly (with up to 300Kpps in one direction), with about 10% of a
single core working in softirq (50% if conntrack is in the picture).
However, with openvpn, we can go up to ~80 Kpps without encryption and
in that case, rougly half of the load goes into softirq and the other
half goes into userland. Most of the drop from 300 to 80 should be
wasted work.

With encryption, something along the lines of 50Kpps could be maintained
(this is an estimation from another earlier test). Furthermore, roughly
half of the CPU time goes into user and the other half into kernelland.

Thinking out loud - if the machine can route much higher packet rates
without breaking a sweat and encryption takes about half of the load,
then optimizing the user/kernel interaction could improve performance up
to 50%. Even if the ring buffers turn out to be less effective than I
optimistically presume, 10% performance increase wouldn't be too shabby
either.

It doesn't seem too hard to implement at the first glance and if someone
wants to try it a compensation could be arranged for that effort.

Siim

