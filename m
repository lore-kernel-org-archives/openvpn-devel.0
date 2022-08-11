From: Kristof Provost <kprovost@...2661...>
Date: Thu, 11 Aug 2022 17:25:05 +0200
Message-ID: <2DCBB302-1FB4-4EC0-8B4A-8D6EA075B0FD@...2661...>
In-Reply-To: <YvPdlCSxQ6wvfIna@...1296...>
References: <20220808143424.65924-1-kprovost@...2661...>
 <20220808143424.65924-3-kprovost@...2661...>
 <YvPdlCSxQ6wvfIna@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 1/2] ovpn-dco: introduce FreeBSD
 data-channel offload support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 10 Aug 2022, at 18:32, Gert Doering wrote:
> as promised, here's test results and code review.
>
> Test results:
>
>  - running openvpn over TCP gives me a kernel panic - this is not so
>    nice... (see attached .png from the vmware console) - userland seems
>    to assume "kernel can do TCP", kernel panics on "if !udp, panic()"
>    (so intentional panic, not corruption panic).
>
>    This is on freebsd git FreeBSD 14.0-CURRENT #1 main-n257130-c0665d5c824
>
I=E2=80=99ve pushed a fix for this panic in fd6b3bede5a5c210f327e5c9bd3e415=
ee905048b.
I simply didn=E2=80=99t think that user space might give us a non-UDP socke=
t, so checking for that and rejecting the peer in that case fixes the panic=
. Thanks for finding that.

>  - running openvpn over UDP has issues with fragmentation - almost all
>    t_client tests that *do* use DCO fail the "big ping" test
>
>     run IPv4 ping tests (want_ok), 64 byte packets...
>     run IPv4 ping tests (want_ok), 1440 byte packets...
>     run IPv4 ping tests (want_ok), 3000 byte packets...
>
>     FAIL: IPv4 ping test (3000 bytes) failed, but should succeed.
>     run IPv6 ping tests (want_ok), 64 byte packets...
>     run IPv6 ping tests (want_ok), 1440 byte packets...
>     run IPv6 ping tests (want_ok), 3000 byte packets...
>
>     FAIL: IPv6 ping test (3000 bytes) failed, but should succeed.
>
>    this is "with no special mtu related options to OpenVPN", so the
>    tun interface is MTU 1500, and the pings are created by
>
>         fping -b 3000 -C 20 -p 250 -q -C 5 -p 400 10.194.5.1 10.194.0.1
>         fping6 -b 3000 -C 20 -p 250 -q -C 5 -p 400 fd00:abcd:194:5::1 fd0=
0:abcd:194:0::1
>
>    (testing the host "on the p2p link" and "something behind a --route
>     pushed by the server")
>
I=E2=80=99m failing to reproduce this in my own test setup. With a simple =
=E2=80=98ping -c 2000=E2=80=99 on a 1500 MTU tunnel I see two layers of fra=
gmentation (the ICMP packet gets fragmented before it goes through the tunn=
el, and then the outer UDP packet gets fragmented as well), as I=E2=80=99d =
expect. Traffic flows in both directions. (i.e. the ping succeeds).

Is there any documentation on how t_client.sh works? It=E2=80=99s not at al=
l clear to me what goes in t_client.in (e.g. in OPENVPN_BASE_P2P).

>    I have not investigated exactly what happens at which point yet, but
>    with Linux DCO, we had a similar effect where a fragmented *inside*
>    packet ("ICMP") carried over a flag in the sk_buff that resulted in
>    the kernel refusing to fragment the resulting *outside* packet.
>
>    (Inside MTU 1500 -> fping -s 3000 -> 3 "inside" fragments,
>     1500+1500+68, adding openvpn overhead -> packet > 1500 ->
>     external fragmentation needed for the first two)
>
>    Inside tcpdump (tun0):
>
> 17:28:37.342050 IP (tos 0x0, ttl 64, id 50758, offset 0, flags [+], proto=
 ICMP (1), length 1500)
>     10.194.5.222 > 10.194.5.1: ICMP echo request, id 2433, seq 0, length =
1480
> 17:28:37.342142 IP (tos 0x0, ttl 64, id 50758, offset 1480, flags [+], pr=
oto ICMP (1), length 1500)
>     10.194.5.222 > 10.194.5.1: ip-proto-1
> 17:28:37.342270 IP (tos 0x0, ttl 64, id 50758, offset 2960, flags [none],=
 proto ICMP (1), length 68)
>     10.194.5.222 > 10.194.5.1: ip-proto-1
>
>    Outside tcpdump (em0):
>
> 17:28:37.342103 IP (tos 0x0, ttl 64, id 50759, offset 0, flags [+], proto=
 UDP (17), length 1500)
>     194.97.140.5.15738 > 199.102.77.82.51197: UDP, bad length 1528 > 1472
> 17:28:37.342123 IP (tos 0x0, ttl 64, id 50759, offset 1480, flags [none],=
 proto UDP (17), length 76)
>     194.97.140.5 > 199.102.77.82: ip-proto-17
> 17:28:37.342185 IP (tos 0x0, ttl 64, id 50760, offset 0, flags [+], proto=
 UDP (17), length 1500)
>     194.97.140.5.15738 > 199.102.77.82.51197: UDP, bad length 1528 > 1472
> 17:28:37.342228 IP (tos 0x0, ttl 64, id 50760, offset 1480, flags [none],=
 proto UDP (17), length 76)
>     194.97.140.5 > 199.102.77.82: ip-proto-17
> 17:28:37.342300 IP (tos 0x0, ttl 64, id 50761, offset 0, flags [none], pr=
oto UDP (17), length 132)
>     194.97.140.5.15738 > 199.102.77.82.51197: UDP, length 104
>
>
>    ... this *does* look correct, but there is never a reply from the other
>    end, so something is not right.  Either inside or outside.
>
Is your server in this scenario a FreeBSD DCO machine, or Linux DCO or some=
thing else?
In my setup the server is non-DCO FreeBSD.

Best regards,
Kristof

