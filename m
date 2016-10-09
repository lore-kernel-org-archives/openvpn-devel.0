References: <20161009100929.46472-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <e84ce7fc-51c5-e0d6-b743-b7a0d23bfe10@...1227...>
Date: Sun, 9 Oct 2016 12:47:56 +0200
MIME-Version: 1.0
In-Reply-To: <20161009100929.46472-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix --multihome for IPv6 on 64bit BSD
 systems.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 09.10.16 um 12:09 schrieb Gert Doering:
> The old code only worked if "struct openvpn*pktinfo" happened to use
> the same structure packing as the CMSG_SPACE() / CMSG_LEN() macros
> (which are part of the official API, see RFC 2292).
> 
> Get rid of "struct openvpn_*_pktinfo" definitions, replace them by
> an opaque buffer sized large enough to fit IPv4 and IPv6 packet info
> messages, as defined by CMSG_SPACE(sizeof(struct ...)).
> 
> On 32 bit platforms, the net result is the same.  On 64 bit platforms,
> the new buffer is bigger than openvpn_pktinfo was, fixing an overflow
> with ipi6_ifindex corruption on reception, and EINVAL on sendmsg().
> 
> The IPv4 related changes are only side effects of using the new buffer.
> 
> Fixes: FreeBSD 10.3/amd64, FreeBSD 9.3/sparc64, OpenBSD 6.0/amd64,
>        NetBSD 7.0.1/i386.
> 
> Note: --multihome for IPv4 on NetBSD is still broken and non-fixable(!)
>        as NetBSD lacks the necessary kernel code for the sendmsg() side.
> 
> Verified that "--multihome works as well as before" on FreeBSD 7.4/amd64,
>        NetBSD 5.1/amd64, OpenBSD 4.9/i386, Linux/x86_64, Linux/i386,
>        OpenSolaris 10 (--multihome needs -D_XPG4_2, see trac #750)
>

ACK. The last time I looked at the code (Hackathon) I also disliked
these helper structures.

Arne



