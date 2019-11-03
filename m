MIME-Version: 1.0
References: <20191103053148.18059-1-tom.ty89@...277...>
 <20191103182443.GC40538@...1296...>
 <20191103183351.GD40538@...1296...>
In-Reply-To: <20191103183351.GD40538@...1296...>
From: Tom Yan <tom.ty89@...277...>
Date: Mon, 4 Nov 2019 03:54:49 +0800
Message-ID: <CAGnHSEn0jaM3u9LCXxArhQkL9ddZQ9UROOZ8+PXPf+oAwTyswg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] tun/iproute2: support 31-bit ipv4
 prefix (RFC 3021)
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
Cc: openvpn-devel@lists.sourceforge.net

While the commit message says "support" 31-bit prefix, this patch is a
bug fix by nature. Whether one can actually uses a /31 subnet for
*anything* (i.e. not just OpenVPN) pretty much depends entirely on the
platform itself. This patch is needed simply because broadcast address
does not "apply" in a /31 subnet, and having it set *prevents* it from
working. In fact, if openvpn tries to set the broadcast address with
`+` instead of an explicit address calculated by itself, `ip` can
handle it well. I do it with a prefix length check because I am not
sure if there's a reason that `broadcast +` wasn't used instead.

Yeah the removal of the p2p topology was one of the reasons. It's
actually the fact that ics-openvpn doesn't really parse point-to-point
ifconfig that made me aware of this.

I don't know anything about sitnl. Is it available only in 2.5/master?
While I have also sent the equivalent fix for that, it's merely a
"forwardport". I haven't actually used 2.5/master at all (unless
ics-openvpn counts, while I don't see broadcast being set for any case
on Android).

On Mon, 4 Nov 2019 at 02:33, Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> On Sun, Nov 03, 2019 at 07:24:43PM +0100, Gert Doering wrote:
> > I tend to NAK this, on a number of reasons - we support arbitrary
> > point-to-point links "since ever" if you do "topology p2p" (can be
> > out of the same /31, or just arbitrary addresses on both ends), so
> > I do not see why doing this in "topology subnet" would be beneficial.
>
> I do see where you're coming from - the man page talks about depreciating
> p2p, in which case you need to make sure topology subnet does /31s.
>
> It might certainly be a useful excercise to investigate our current
> ifconfig (etc) calls - in the 2.5 branch - and possibly get rid of all
> the "broadcast" settings, across all platforms that do not need them.
>
> Personally I've never understood why people are so keen on explicitly
> configuring broadcast addresses everywhere (like in the network config
> files, etc.) - the standard address can be computed and "just works"
> (and on a tun interface, there are no link-layer broadcasts anyway, even
> if we pretend it were differently).
>
> The code was that way when David and I inherited the project, so I can't
> explain *why* it is - but this might be the opportunity to kick out a bit
> of needless garbage.
>
>
> Out of curiosity: does the sitnl code path handle /31s?
>
> gert
>
>
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh Mistress
>
> Gert Doering - Munich, Germany                             gert@...1296...

