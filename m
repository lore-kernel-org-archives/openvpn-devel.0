References: <CAHmME9r1VmJLSqrb8vQN3HOqeVX2QLs1-9wPYQL-UwNU6EJNLA@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <0fe186bb-7df2-e3c4-cccd-b3b624fbc1bf@...1227...>
Date: Mon, 25 Mar 2019 11:23:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAHmME9r1VmJLSqrb8vQN3HOqeVX2QLs1-9wPYQL-UwNU6EJNLA@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [ANNOUNCE] Wintun: Layer 3 TUN Driver for
 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: "Jason A. Donenfeld" <Jason@...2390...>, WireGuard mailing list <wireguard@...2500...>, openvpn-devel@lists.sourceforge.net, dev@...2501..., Simon Rozman <simon@...2293...>

Am 23.03.19 um 02:04 schrieb Jason A. Donenfeld:
> Hi everybody,
> 
> [Cross-posting to WireGuard, OpenVPN, and Nmap/npcap mailing lists.]
> 
> Simon and I are pleased to announce the start of a new project, made
> for WireGuard and for others too: Wintun, a layer 3 TUN driver for
> Windows.

I wish you good luck in this endeavour and welcome the prospect of
having a better tun driver for Windows. We know that our own TAP/TUN
driver is a pain point for us as well and having a better alternative is
something we would definitively like to have/support a more modern driver.

> Wintun is our attempt at making a dumb layer 3 pipe, that doesn't do
> anything fancy, and just shuffles bundles of packets between userspace
> and the kernel driver. It's being used for WireGuard's Windows port.
> We'd like to make it available and easy to use for other projects too
> that need layer 3 userspace tunneling capabilities, like OpenVPN and
> SoftEther. (Also, it may be just a matter of time before somebody
> takes the tiny base of it, sticks the crypto in the kernel, and makes
> WireGuard super fast on Windows.)

If someone does that, it would be nice to have a bit more generic so we
can also push our openvpn keys to the driver. Our AEAD-GCM data format
and Wireshark's data format are reasonable close to use the same code
for it.

The lack of tap is not a big deal for OpenVPN anymore. The world shifted
quite a bit and tap support is not needed that much anymore. Android
does not support it. MacOS client supports tun natively (utun) and tap
requires extra kext. And so on...

> Have we succeeded in accomplishing our goals? Certainly not yet. At
> the present moment [folks reading this in the future: check the date
> of this email], I'd except for Wintun to be slower, buggier, and lower
> quality than anything else out there. But we thought it'd be a good
> idea to release sooner rather than later in order to have some more
> eyeballs on it. It's the kind of codebase that _certainly_ needs some
> cleanup and a thorough security audit. On the plus side, cloc(1) tells
> me that it's only 950 lines. Still, NT programming is hard, and I'm
> pretty certain we've made mistakes and left ugly corners. Consider
> this email a statement of intent rather than an announcement of a
> completed project.

I am afraid our project members are currently busy and cannot really
contribute much to your new shiny driver. We barely have enough time for
OpenVPN itself. But if you have something that is good enough at least
for testing and has a reasonable stable API just an extra mail and I
think we can implement it as alternative to our own driver.

> Details are over on https://www.wintun.net/ where you may also find
> rabbits bringing windows into tunnels. Enjoy!

Frome the site: The source code is provided under the GPL 2.0 and is
available via git:

One detail here. If you have/add a file that defines the API for
external programs, to license it under a freeer license for 3rd party to
include that API file without license worries. Like our tap-windows.h
(https://github.com/OpenVPN/tap-windows6/blob/master/src/tap-windows.h).
This was primarily requested by the Freeswan developer iirc.

Arne

