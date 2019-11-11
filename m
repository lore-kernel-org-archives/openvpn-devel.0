MIME-Version: 1.0
References: <20191103053148.18059-1-tom.ty89@...277...>
 <20191103182443.GC40538@...1296...>
 <20191103183351.GD40538@...1296...>
 <CAGnHSEn0jaM3u9LCXxArhQkL9ddZQ9UROOZ8+PXPf+oAwTyswg@...278...>
 <20191103204613.GE40538@...1296...>
 <CAGnHSE=LcwX6hxHM2sdpWRP6cKyQiuhtc4ZUG2H1rdu-CNHOqQ@...278...>
 <20191110180755.GQ40538@...1296...>
In-Reply-To: <20191110180755.GQ40538@...1296...>
From: Tom Yan <tom.ty89@...277...>
Date: Mon, 11 Nov 2019 23:12:38 +0800
Message-ID: <CAGnHSEkL5UY+q9p3j-UoOrBPcrhoNPyzSbEAMA4+x72jH46HGQ@...278...>
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
Cc: openvpn-devel@lists.sourceforge.net, Arne Schwabe <arne@...1227...>, Antonio Quartulli <a@...2181...>

Yes both iproute2 and sitnl works perfectly as expected. Will the fix
be backported to the 2.4 branch?

P.S. For the record, if the client is ics-openvpn with openvpn3,
somehow you need push route (either host or subnet will do) anyway.
This is not necessary with ics-openvpn with openvpn2 or OpenVPN
Connect (AFAIK its core is openvpn3 as well, albeit different
snapshot). The problem/behaviour is not specific to /31 subnet though,
apparently. I guess the main route table is ignored/masked.

On Mon, 11 Nov 2019 at 02:07, Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> On Mon, Nov 04, 2019 at 05:10:12AM +0800, Tom Yan wrote:
> > So in master, when net_addr_v4_add is called in tun.c, which
> > net_addr_v4_add (networking_iproute2.c or networking_sitnl.c) is
> > actually used depends on how openvpn is built, right?
>
> Can you have a look at the current "master" branch?  Antonio has ripped
> out *all* broadcast setting - so this should now do /31s just fine?
>
> More radical than your approach, but "less old code" is better than
> "yet another special condition added" :-)
>
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh Mistress
>
> Gert Doering - Munich, Germany                             gert@...1296...

