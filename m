References: <7f72b2de-f411-c4a0-bd1e-f343543cb8e2@...2030...>
 <CAAjorqWaFY+XdD5XZ95rPyXJHd9MfPv3Xmv3M1gKfWHbnJXL9w@...278...>
 <6ad04520-6e42-51aa-bd38-b2285e7adaab@...2030...>
 <4da8bb9a-7118-e0ab-ba7d-bc813e33d7c4@...515...>
From: Tom Kunz <tkunz@...2030...>
Message-ID: <d92ef8b9-fb9a-4cd0-ac6c-ebd04853311e@...2030...>
Date: Fri, 5 Jan 2018 14:56:14 -0500
MIME-Version: 1.0
In-Reply-To: <4da8bb9a-7118-e0ab-ba7d-bc813e33d7c4@...515...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] OVPN vs IPSec performance as a transport
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, "Greg Sloop <gregs@...1934...>" <gregs@...1934...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Samuli,

Yes, that was the document that I read before going down this path.=C2=A0 I
did a bunch of testing and found the optimum MTU range in my setup is
47500 to 52500, and 50000 is probably as close to the peak as necessary.

When I have 2 nodes, nothing between them and not routing to elsewhere,
the extra bandwidth from the large MTU gives me 102% or so of wire speed
throughput when I transfer incompressible data (derived from
/dev/urandom).=C2=A0 I can do this very reproducibly and predictably.=C2=A0=
 For
data-compressibility tests, I used two different forms, one was highly
compressible data (derived from /dev/zero) and the other was the tarball
(not gzipped, just tar) of linux kernel source code.=C2=A0 With the file
created from uncompressed linux kernel source, where lzo can do some
work, I can regularly get 140-150% wire speed, and with
highly-compressible data I get just over 400%.=C2=A0 Meaning, I can transfer
all-nulls over a 1Gbps link as if it was a 4Gbps link, and text as if it
was a 1.5Gbps link.=C2=A0 This is good stuff for the bandwidth-constrained!

So really the only problem is getting that data back out of ovpn and
onto a physical hardware interface to another place.=C2=A0 OVPN is absolute=
ly
awesome, otherwise.

The things I have already tried to mess around with to affect performance:
- Toggle comp-lzo on/off.=C2=A0 No effect.
- Change encryption algorithm, including change to "none".=C2=A0 No effect.
- Change sndbuf/rcvbuf socket buffers to 425984(basically doubling
defaults).=C2=A0 No effect.
- Change tun-mtu.=C2=A0 Any changes too far off of my existing 50000 cause
perf degradation.
- Change txqueuelen on all interfaces to 1000000.=C2=A0 Slight effect, maybe
5-10% gains or so. (Possibly trimmed 1-2s off a ~20s transfer)
- Turning off checksumming on all interfaces: ethtool -K {dev} rx off tx
off=C2=A0=C2=A0 No effect.
- No iptables running at all on anything.

Again, keep in mind that full wire speed is realized with no vpn, and
with IPSec.=C2=A0
So, to reason this through a little:
- No vpn =3D fast.
- IPSec =3D fast.
- OVPN->OVPN =3D even faster
- OVPN->OVPN->routing/hardware =3D slow, down to about 200Mbps from 1+Gbps.

I'm wondering if the bottleneck is in the tun/tap driver's ability to
copy data out to the hardware device or to the buffers to be processed
for routing?=C2=A0
BTW, the host OS is Ubuntu server 16.04.3 on all of these, kernel
4.4.0-104-generic and the TUN is built-in to the kernel, not a module.=C2=A0
I have not experimented with other kernel versions.

Thanks for any thoughts,
Tom


On 01/05/2018 01:08 AM, Samuli Sepp=C3=A4nen wrote:
> This does not answer your question, either, but there are more details
> on OpenVPN performance optimization here:
>
> <https://community.openvpn.net/openvpn/wiki/Gigabit_Networks_Linux>
>
> Increasing the MTU helps as it reduces the number of user<->kernel-space
> switches.
>




