Subject: Re: [Openvpn-devel] ipv6 netbsd support
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1075436187.7346@...41...>
In-Reply-To: <Pine.LNX.4.31.0401281414440.15882-100000@...161...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Jan 30 10:19:16 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: 6bone@...161..., openvpn-devel@lists.sourceforge.net

6bone@...161... said:

> Hello,
> 
> is there an ipv6-netbsd support planed ?
> 
> Can you give me detailed information what must be changed so that I can
> try to write a patch?

Currently IPv6 over IPv4 tun support exists for Linux and OpenBSD.  Take a
look a tun.c -- that's where the patch would go.

James


