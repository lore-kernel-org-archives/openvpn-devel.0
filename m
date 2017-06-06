MIME-Version: 1.0
In-Reply-To: <20170526165606.GQ97029@...1296...>
References: <8737brk7vm.fsf@...2274...>
	<20170526165606.GQ97029@...1296...>
From: Anatoly Pugachev <matorola@...277...>
Date: Tue, 6 Jun 2017 12:59:18 +0300
Message-ID: <CADxRZqwYw0RLxCDB-u3NmrLUBONng5DyT-1e9q-37HDHPpnCrQ@...278...>
Subject: Re: [Openvpn-devel] Alignement crash on sparc64
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, Stefan Sperling <stsp@...2273...>

On Fri, May 26, 2017 at 7:56 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Fri, May 26, 2017 at 04:30:53PM +0200, Jeremie Courreges-Anglas wrote:
>> I am the maintainer of openvpn in the OpenBSD ports tree.  Here's
>> a report from Stefan Sperling (Cc'ed).
>>
>> > An openvpn server running on OpenBSD/sparc64 6.1 crashes when a client
>> > connects and starts doing traffic. Is anyone else seeing this?
>
> Thanks for the report.  I'll look into it.
>
> Copying around the IP header doesn't feel like the proper solution,
> though - it's basically replacing an unaligned access somewhere with
> a larger (unaligned!) mem copy, where most likely changing a word
> access to 2x byte access (etc) might achieve the same thing without
> copying.
>
>> To work around this, the patch below (also written by Stefan) was
>> committed in our ports tree.  TARGET_FREEBSD and TARGET_DRAGONFLY seem
>> to be affected too.
>
> FreeBSD/Sparc64 traps unaligned memory accesses and handles them
> kernel-side.  So you'll see a slowdown, but no signal.
>
> Linux/Sparc64 has the same restrictions (unaligned access causing a
> signal), but nobody has reported that yet, so maybe the underlying
> memory alignment of the allocated buffer happens to be good enough
> there.

Using mostly with linux sparc64, but I have openbsd sparc64 installed
and I can't reproduce it here....

we are using openvpn (2.4.0-6) on sparc64 linux (debian sid/unstable)
as clients to x86_64 server (openvpn-2.3.14-137.4.x86_64) - works
without errors.

I made a few tests yesterday with openvpn static key:

1. server openvpn (2.4.0-6) on sparc64 linux, client is linux
openvpn-2.3.14-1.fc25.x86_64 - works

2. server openvpn (2.4.0-6) on sparc64 linux, client openvpn 2.3.11
openbsd 6.1 sparc64 - works

3. server 2.3.11 (old 6.0 version) openbsd 6.1 sparc64, client openvpn
(2.4.0-6) on sparc64 linux - works

4. server 2.4.1 (6.1 version) openbsd 6.1 sparc64, client openvpn
(2.4.0-6) on sparc64 linux - works


checked all 4 with copying back and forth 100Mbyte test file over vpn
connection...

bash-4.3# openvpn l1.conf
Tue Jun  6 13:12:13 2017 disabling NCP mode (--ncp-disable) because
not in P2MP client or server mode
Tue Jun  6 13:12:13 2017 OpenVPN 2.4.1 sparc64-unknown-openbsd6.1 [SSL
(OpenSSL)] [LZO] [LZ4] [MH/RECVDA] [AEAD] built on May 19 2017
Tue Jun  6 13:12:13 2017 library versions: LibreSSL 2.6.0, LZO 2.09
Tue Jun  6 13:12:13 2017 WARNING: INSECURE cipher with block size less
than 128 bit (64 bit).  This allows attacks like SWEET32.  Mitigate by
using a --cipher with a larger block size (e.g. AES-256-CBC).
Tue Jun  6 13:12:13 2017 WARNING: INSECURE cipher with block size less
than 128 bit (64 bit).  This allows attacks like SWEET32.  Mitigate by
using a --cipher with a larger block size (e.g. AES-256-CBC).
Tue Jun  6 13:12:13 2017 TUN/TAP device /dev/tun0 opened
Tue Jun  6 13:12:13 2017 do_ifconfig, tt->did_ifconfig_ipv6_setup=0
Tue Jun  6 13:12:13 2017 /sbin/ifconfig tun0 10.9.0.2 10.9.0.1 mtu
1500 netmask 255.255.255.255 up
Tue Jun  6 13:12:13 2017 Could not determine IPv4/IPv6 protocol. Using AF_INET
Tue Jun  6 13:12:13 2017 UDPv4 link local (bound): [AF_INET][undef]:1194
Tue Jun  6 13:12:13 2017 UDPv4 link remote: [AF_UNSPEC]
Tue Jun  6 13:12:14 2017 Peer Connection Initiated with
[AF_INET]192.168.158.92:1194
Tue Jun  6 13:12:14 2017 Initialization Sequence Completed

...
-bash-4.3$ ls -lh /tmp/test-file.bin
-rw-r--r--  1 mator  wheel   100M Jun  6 13:03 /tmp/test-file.bin
-bash-4.3$ scp /tmp/test-file.bin 10.9.0.1:/tmp/1.bin
mator@...2276...'s password:
test-file.bin
                                           100%  100MB   6.4MB/s
00:15

-bash-4.3$ cat l1.conf
dev tun
ifconfig 10.9.0.2 10.9.0.1
comp-lzo
mute-replay-warnings
<secret>
...
</secret>

PS: if someone needs a sparc64 shell for more tests or build (CI)
machine, just email me. Thanks.

