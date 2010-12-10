Message-ID: <20101210081613.3086.qmail@...1287...>
Date: Fri, 10 Dec 2010 09:16:13 +0100
From: Peter Stuge <peter@...1287...>
References: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C5F@...1436...>
	<20101210062512.17827.qmail@...1287...>
	<BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3EF3@...1436...>
	<4D01DD1C.5010506@...1114...>
	<BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3EFD@...1436...>
MIME-Version: 1.0
In-Reply-To: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3EFD@...1436...>
Subject: Re: [Openvpn-devel] [Patch] OpenVPN PolarSSL Support Preview [7/8]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Adriaan de Jong wrote:
> > > About the whitespace: it's a tad difficult to split the patches
> > > now. Are you sure it wouldn't be acceptable this way?

I may have misunderstood this. (I read "now" as "this late", but I
guess maybe you meant "this early".)


> > I'd suggest that we primarily do code review now.
..
> > I'd expect Adriaan to also implement our review comments as well.
..
> That's exactly what I was hoping for. I've tried to stay within any
> coding standards that I could find within the code. I'm making a
> note of any comments people have, and will include them in the
> actual 2.2 git rebase. As soon as that's done I can start making
> use of the other git commands.

I'd use git for the patches right away anyway, but that doesn't
matter. My point about whitespace was not that it is a critical
issue at this point, but something I think should be cleaned before
inclusion. git would make it trivial to do (this early) so I think
it's a good idea.

I'm afraid I'm unable to review the patches in greater depth. :\


//Peter

