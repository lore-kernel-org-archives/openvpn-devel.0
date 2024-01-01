Message-ID: <89f5dd40-02a7-4cb3-99d3-4385ce646fb5@...1227...>
Date: Mon, 1 Jan 2024 14:36:27 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20240101092714.18992-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20240101092714.18992-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] get_default_gateway() HWADDR overhaul
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 01.01.24 um 10:27 schrieb Gert Doering:
> commit f13331005d5a7 (gerrit/454) most painfully works around the limitations
> of the SIOCGIFCONF API, with struct member access on an unaligned buffer,
> possibly overrunning sockaddr structures, etc. - and the result still did
> not work on OpenSolaris and OpenBSD (no AF_LINK in the returned elements).
> 
> Reading through OpenBSD "ifconfig" source, I found getifaddrs(3), which
> is exactly what we want here - it works on FreeBSD, NetBSD, OpenBSD and
> MacOS, and all returned pointers are properly aligned, so the code gets
> shorter, easier to read, and UBSAN is still happy.
> 
> OpenSolaris does have getifaddrs(3), but (surprise) it does not work, as
> in "it does not return AF_LINK addresses".  It does have SIOCGIFHWADDR,
> instead, and "man if_tcp" claims "should behave in a manner compatible
> with Linux" - so TARGET_SOLARIS gets a copy of the Linux code now (works).
> 

> -            if (!strncmp(ifr.ifr_name, rgi->iface, IFNAMSIZ))

Mini nitpick from clang-tidy:

Clang-Tidy: No header providing "strncmp" is directly included.

Adding string.h would could be done if we want a v2 of the patch

Tested also on macOS.

Acked-By: Arne Schwabe <arne@...1227...>


