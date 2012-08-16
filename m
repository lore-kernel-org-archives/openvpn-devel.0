Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1485\))
From: Eric Crist <ecrist@...1286...>
In-Reply-To: <20120815105339.GG18296@...1296...>
Date: Thu, 16 Aug 2012 10:35:52 -0500
Message-Id: <5DDA5487-D6B2-4EF2-8F20-D4324FBEB843@...1286...>
References: <20120814194736.GU2535@...1296...>
	<20120815100012.GD18296@...1296...>
	<20120815105339.GG18296@...1296...>
Subject: Re: [Openvpn-devel] RFC: tun/tap cleanup at program end
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Aug 15, 2012, at 05:53:40, Gert Doering <gert@...1296...> wrote:

> Hi,
> 
> On Wed, Aug 15, 2012 at 12:00:12PM +0200, Gert Doering wrote:
>>  3 - check for the existance of "--dev tap3" and remember, not cleaning
>>      if it existed previously, doing this with RT_NETLINK which should
>>      be sufficiently portable across all BSDs.  Same advantage as "2",
>>      hopefully much nicer implementation.
> 
> Here we go.  I discovered if_nametoindex(), which is really handy for
> this :-)
> 
> Eric, please test whether this solves your issues.
> 
> David, please do *not yet* commit, even if someone ACKs - I need to test
> this on OpenBSD, NetBSD and FreeBSD 9 as well.  So far, only tested on 
> FreeBSD 7.4 (and works).

I'm comfortable giving my ACK to this patch.

-----
Eric F Crist





