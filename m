MIME-Version: 1.0
References: <20191103053148.18059-1-tom.ty89@...277...>
 <20191103182443.GC40538@...1296...>
 <20191103183351.GD40538@...1296...>
 <CAGnHSEn0jaM3u9LCXxArhQkL9ddZQ9UROOZ8+PXPf+oAwTyswg@...278...>
 <20191103204613.GE40538@...1296...>
In-Reply-To: <20191103204613.GE40538@...1296...>
From: Tom Yan <tom.ty89@...277...>
Date: Mon, 4 Nov 2019 05:10:12 +0800
Message-ID: <CAGnHSE=LcwX6hxHM2sdpWRP6cKyQiuhtc4ZUG2H1rdu-CNHOqQ@...278...>
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

So in master, when net_addr_v4_add is called in tun.c, which
net_addr_v4_add (networking_iproute2.c or networking_sitnl.c) is
actually used depends on how openvpn is built, right?

I think the `if (broadcast)` condition in the one of
networking_sitnl.c needs to be changed to `if (broadcast && prefixlen
< 31)` as well. Also it seems that net_addr_v4_add is called wrongly
in tun.c with `&tt->remote_netmask` instead of `&tt->broadcast` as the
last argument.

I don't really mind it being fixed with any of the approaches: no
broadcast, `broadcast +`, or prefix length check. Don't know if it
counts as a reference to you but I can even see in the code of
systemd-networkd similar prefix length check. As I have no idea
whether under any circumstances the broadcast address matters, the
prefix length check seems to be a more conservative approach to me and
that's why I chose it. (Also, the "conditional" added merely causes
"remove-broadcast-the-bugfix" to apply only on where it is strictly
necessary...) As for `broadcast +`, I am not sure if there's an
equivalence for sitnl, and I wonder if it raises version requirement
on iproute2.

For the record, /31 subnet works fine on Linux and Android as long as
the patch is applied (for Linux). (And again, from OpenVPN point of
view, we don't need to care if /31 subnet works on any platform, as we
never prevented users from setting that up. Well, other than the silly
code in the server directive, which should be fixed in a follow-up;
but it's not like users have to use that anyway.)

On Mon, 4 Nov 2019 at 04:46, Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> On Mon, Nov 04, 2019 at 03:54:49AM +0800, Tom Yan wrote:
> > While the commit message says "support" 31-bit prefix, this patch is a
> > bug fix by nature. Whether one can actually uses a /31 subnet for
> > *anything* (i.e. not just OpenVPN) pretty much depends entirely on the
> > platform itself. This patch is needed simply because broadcast address
> > does not "apply" in a /31 subnet, and having it set *prevents* it from
> > working.
>
> Understood (thought it would be more helpful if the commit message
> said so :-) ).
>
> > In fact, if openvpn tries to set the broadcast address with
> > `+` instead of an explicit address calculated by itself, `ip` can
> > handle it well. I do it with a prefix length check because I am not
> > sure if there's a reason that `broadcast +` wasn't used instead.
>
> I wasn't aware that there is a "broadcast +" setting, but I'm way
> more tempted to just get rid of setting broadcast at all.  This is a
> computer, it can do the math itself.
>
> > Yeah the removal of the p2p topology was one of the reasons. It's
> > actually the fact that ics-openvpn doesn't really parse point-to-point
> > ifconfig that made me aware of this.
>
> I wasn't aware of that, but since Arne is reading here, maybe he can
> comment on it.  It's possible that the Android VPN API just does not
> permit p2p mode, but wants a subnet.
>
> Arne, any idea if /31 works on Android?
>
>
> > I don't know anything about sitnl. Is it available only in 2.5/master?
> > While I have also sent the equivalent fix for that, it's merely a
> > "forwardport". I haven't actually used 2.5/master at all (unless
> > ics-openvpn counts, while I don't see broadcast being set for any case
> > on Android).
>
> Yeah, master.  New functionality always has to go into master, and
> 2.4 backporting is only done under certain conditions (undisputed
> bugfixes, long-term compatibility changes).
>
> Adding conditionals is not a bugfix.  Removing the "broadcast" part
> from "ip add" could be considered as such... it needs testing on
> somewhat ancient Linux systems (I think we aim to support all
> RHEL/CentOS releases that are still supported, which will definitely
> cover "OLD!!").  But seriously I expect this to be totally unnecesary
> historic cruft unless told otherwise.
>
> gert
>
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh Mistress
>
> Gert Doering - Munich, Germany                             gert@...1296...

