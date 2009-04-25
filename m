Date: Sat, 25 Apr 2009 17:42:50 -0500
From: "Karl O. Pinc" <kop@...1206...>
References: <49F1B322.6030705@...1032...> <1240630761l.7894l.0l@...1207...>
	<49F34D62.4000302@...1114...>
In-Reply-To: <49F34D62.4000302@...1114...> (from
	openvpn.list@...1114... on Sat Apr 25 12:50:26 2009)
Message-Id: <1240699370l.7894l.4l@...1207...>
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net


On 04/25/2009 12:50:26 PM, David Sommerseth wrote:
>=20
> Karl O. Pinc wrote:
> > On 04/24/2009 07:40:02 AM, Siim P=F5der wrote:
>=20
> [snip]
>=20
> > Please pardon me for thinking out loud here...
>=20
> I'll follow in this path, thinking out loud ...
>=20
> > The problem is that moving data between userspace and kernelspace
> > is expensive.  (IIRC you can't just use the CPU to filter the bus
> > between nics, you need to deliver data to/receive data
> > from RAM because that's where the userland app works
> > with it.)  OpenVPN runs in userspace so all the VPN data
> > has to pass out of the kernel into userspace and back again.
> > To attack the problem directly you need to move all functionality
> > into the kernel, which raises a number of problems.

> What if OpenVPN on selected platforms also provided it's own kernel
> driver
> which would do practically the same as the upstream tun.ko modules -
> except it provides a direct API which OpenVPN can utilize, to avoid
> the
> kernel-userspace-kernel ping-pong.

That actually sounds approachable, from a thinking
out loud perspective.  I don't really know the
important details so can't judge.

In order to reduce latency and work the kernel
need only examine the IP headers.  The rest of the
datagrams can stay on the card.  Once the routing decision
is made the bus can deliver the datagram directly to the
appropriate nic's buffer.  This could be on the same
card if you've multiport nic cards or could be assisted
by dma or some such. This keeps down latency and offloads
the CPU.

As long as you're putting parts of OpenVPN in the kernel
it would be nice to leave as much of the tun module
alone as possible and have a separate OpenVPN kernel module.
You'd split out the part of OpenVPN that does the data channel
and put that in the kernel module, it would talk to the
kernel tun interface etc.  Everything else, all the
control channel auth stuff and the like, does not have
to be in the kernel because it's not high
performance/high volume.

As Siim pointed out you do need to move the whole datagram
into RAM if you're going to operate on it.  But if there's
encryption hardware support in the kernel additional
operations involving system RAM may not be required..
You may be able to go directly between the nic and the hardware
encryption engine and avoid RAM.  I've really no idea.

(I do know that one reason why I saw such bad
kernel/userspace performance in an embedded device
is due to sucky nic hardware.  It may require
good hardware to offload the CPU.)

I don't know how this would play with the OpenSSL API.
Ideally OpenSSL has provisions for being used inside
kernelspace so that it can directly access any hardware
engines.   Moving all the crypto calls from the OpenSSL
API to the kernel API sounds prohibitive although
you never know until you look.  Worst case
you'd not be able to use hardware acceleration if you
used a kernel module version of OpenVPN based on OpenSSL.

And of course, as you say, there's all sorts of opportunity
for insecurity when you introduce code into the kernel.
But the data channel code that goes in the kernel module
should already be hardened.

Regards the political considerations, if successful
such an approach could be attractive enough
that the OpenVPN developers couldn't ignore it.
Greatly improved performance could create enough
interest to support a fork, especially if the
necessary changes were minimal and could be ported
into future OpenVPN versions.  I don't want to
be seen in any way as agitating for such a fork,
and I certainly don't want to cast
any aspersions on the management of the OpenVPN
project.  My point here is only to explore
the prospects of the long-term maintenance of
an OpenVPN kernel module.

In the long-term the other aspect of such an approach
that needs addressing is the API between the kernel
module and the rest of OpenVPN.  Ideally the kernel
module would eventually be made part of the official
kernel.  I don't know the policy of the kernel
maintainers but I would think that an OpenVPN
kernel module would be more attractive if it
were usable by something besides the OpenVPN
application.  The big attraction of getting
a kernel module sanctioned by the kernel devs
is that there's no headaces with respect to
kernel version incompatibilities.  The in-kernel
API is not static so changes to any of the
nic drivers could affect system stability.

The above is an awful lot of thinking out loud,
especially because I don't really have any
involvement or familiarity with any internals.
Or any of the politics involved for that matter.
My intention here is to explore the entire
problem space; and when people become involved
politics ensues.  It's always a bad idea to
speak on political matters when you are not
on familiar ground, and that is what I've
done here.  I hope I have not stepped into
sensitive matters and apologize in advance
for any offense.

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                  -- Robert A. Heinlein

