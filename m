Date: Fri, 24 Apr 2009 22:39:21 -0500
From: "Karl O. Pinc" <kop@...1206...>
References: <49F1B322.6030705@...1032...>
In-Reply-To: <49F1B322.6030705@...1032...> (from siim@...1032...
	on Fri Apr 24 07:40:02 2009)
Message-Id: <1240630761l.7894l.0l@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] linux openvpn development job
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; DelSp=Yes; Format=Flowed; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: =?iso-8859-1?q?Siim_P=F5der?= <siim@...1032...>
Cc: openvpn-devel@lists.sourceforge.net


On 04/24/2009 07:40:02 AM, Siim P=F5der wrote:
> Hi
>=20
> We are running a couple of openvpn servers with relatively high load
> (Opterons 2xDC, e1000, recent kerneles) and it seems as if most of the
> CPU time is not used on cryptography, but in softirq (send/recv for
> udp
> and read/write on tun?). This has lead us to suspect that most of the
> time is spent pumping data between userspace and kernelspace.
>=20
> Now, we are still investigating this, but I thought I'd ask around
> too:.
> Does anyone have a take on this, could a considerable (upwards of 10%)
> increase in openvpn capacity be accomplished by optimizing udp/tun
> interfaces of the kernel (a mechanism like ring buffers?) or are we on
> a
> wrong track?

Please pardon me for thinking out loud here...

The problem is that moving data between userspace and kernelspace
is expensive.  (IIRC you can't just use the CPU to filter the bus
between nics, you need to deliver data to/receive data
from RAM because that's where the userland app works
with it.)  OpenVPN runs in userspace so all the VPN data
has to pass out of the kernel into userspace and back again.
To attack the problem directly you need to move all functionality
into the kernel, which raises a number of problems.
Such an OpenVPN would not port between OS platforms
very well.  Someone would have to convince both
the kernel and OpenVPN developers to maintain the
code.  And so forth.

The question then becomes how much optimization can
be made between kernel and userspace beyond what's
already been done, again bearing in mind the both
the kernel and OpenVPN developers must be on-board
with the result.  Of course you could maintain the
resulting code, but you'd need to recognize
that, typically, at least 70% of software labor costs
are in maintenance.

Everybody wants faster userspace/kernelspace transfers
but everybody also wants a standard OS API.  The
Linux kernel developers provide feedback on ideas.
I don't know about the OpenVPN developers but
I've not seem much traffic here in the weeks
I've been subscribed.

I've seen embedded devices use upwards of 50% of
the CPU on the kernel/userspace transition.
Using hardware acceleration reduces performance
because it passes more data across the kernel/user
boundary.

IMO your money is better spent getting redundant hardware
and load balancing.  (E.g. you could run OpenVPN
on OpenBSD/carp and have a loadbalanced hot-failover
cluster.   Or use some other clustering solution.)
At least that's how I'd go without a good plan, and
buy-in from the OpenVPN developers.
After the initial investment the cluster solution will
scale linearly with dollars spent, and you get
increased reliability and fault-tolerance for free.


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                  -- Robert A. Heinlein

