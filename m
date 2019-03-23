MIME-Version: 1.0
From: "Jason A. Donenfeld" <Jason@...2390...>
Date: Fri, 22 Mar 2019 19:04:02 -0600
Message-ID: <CAHmME9r1VmJLSqrb8vQN3HOqeVX2QLs1-9wPYQL-UwNU6EJNLA@...278...>
Subject: [Openvpn-devel] [ANNOUNCE] Wintun: Layer 3 TUN Driver for Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: WireGuard mailing list <wireguard@...2500...>, openvpn-devel@lists.sourceforge.net, dev@...2501..., Simon Rozman <simon@...2293...>

Hi everybody,

[Cross-posting to WireGuard, OpenVPN, and Nmap/npcap mailing lists.]

Simon and I are pleased to announce the start of a new project, made
for WireGuard and for others too: Wintun, a layer 3 TUN driver for
Windows.

Homepage: https://www.wintun.net/

A TUN driver lets userspace programs act as virtual network cards,
reading and writing packets directly into the network stack, as though
they came from a real network adapter. While Linux and the BSDs have
had /dev/tun for ages, Windows typically hasn't had any native
facilities.

Recently, Microsoft released a VPN UWP API, but it's lacking in
features, documentation is under NDA, and after reversing it for a
bit, it doesn't seem capable of doing many of the more advanced
routing and roaming things we want. Indeed it turns out that having a
real network adapter and some basic file handles is much preferable to
layers of API and abstraction.

On the flipside, OpenVPN's tap-windows6 project and the numerous
drivers from SoftEther have all provided similar functionality for
many years, and these efforts have produced something moderately
stable. We were, in fact, quite inspired by SoftEther's Neo6 driver.
However, these projects were written in a different age, the era of
NDIS5, and then ported later to NDIS6. This means they haven't
benefited from things like Windows 7's NdisMediumIP, which allows for
native layer 3 tunneling, without having to do layer 2 emulation.
Drivers like OpenVPN's tap-windows6 also do some somewhat nasty
things, like emulate DHCP from inside the kernel for network
configuration. The code is old and complicated. As usual, I wanted
instead something tiny and dumb that we can reason about, which does
things in a "right" and "boring" way for a narrower use case: layer 3
TUN.

Wintun is our attempt at making a dumb layer 3 pipe, that doesn't do
anything fancy, and just shuffles bundles of packets between userspace
and the kernel driver. It's being used for WireGuard's Windows port.
We'd like to make it available and easy to use for other projects too
that need layer 3 userspace tunneling capabilities, like OpenVPN and
SoftEther. (Also, it may be just a matter of time before somebody
takes the tiny base of it, sticks the crypto in the kernel, and makes
WireGuard super fast on Windows.)

Have we succeeded in accomplishing our goals? Certainly not yet. At
the present moment [folks reading this in the future: check the date
of this email], I'd except for Wintun to be slower, buggier, and lower
quality than anything else out there. But we thought it'd be a good
idea to release sooner rather than later in order to have some more
eyeballs on it. It's the kind of codebase that _certainly_ needs some
cleanup and a thorough security audit. On the plus side, cloc(1) tells
me that it's only 950 lines. Still, NT programming is hard, and I'm
pretty certain we've made mistakes and left ugly corners. Consider
this email a statement of intent rather than an announcement of a
completed project.

So, if you're interested in NDIS programming and want to lend a hand,
don't hesitate to get in touch. We're eager for smart NT folks to help
us out.

Details are over on https://www.wintun.net/ where you may also find
rabbits bringing windows into tunnels. Enjoy!

Regards,
Jason

