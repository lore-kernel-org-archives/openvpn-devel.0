MIME-Version: 1.0
References: <20191103053148.18059-1-tom.ty89@...277...>
 <20191103182443.GC40538@...1296...>
 <20191103183351.GD40538@...1296...>
 <CAGnHSEn0jaM3u9LCXxArhQkL9ddZQ9UROOZ8+PXPf+oAwTyswg@...278...>
 <20191103204613.GE40538@...1296...>
 <CAGnHSE=LcwX6hxHM2sdpWRP6cKyQiuhtc4ZUG2H1rdu-CNHOqQ@...278...>
 <20191110180755.GQ40538@...1296...>
 <CAGnHSEkL5UY+q9p3j-UoOrBPcrhoNPyzSbEAMA4+x72jH46HGQ@...278...>
 <5dbf208f-3a4d-7732-e09b-36b1b2466a67@...1227...>
In-Reply-To: <5dbf208f-3a4d-7732-e09b-36b1b2466a67@...1227...>
From: Tom Yan <tom.ty89@...277...>
Date: Wed, 13 Nov 2019 11:35:40 +0800
Message-ID: <CAGnHSEkoJbeUtOZVrNVvfEwtkWRMo=ZS6WH0VZpOR=BMNRsqGA@...278...>
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
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net, Antonio Quartulli <a@...2181...>

Details like...?

If you configure/push an IP with a subnet (i.e. non /32 prefix or
255.255.255.255 subnet mask) to a client, a subnet route will be added
to main route table (as show by `ip r`) by the kernel just like on
Desktop Linux (at least that's what would happen on my device). When I
use ics-openvpn without openvpn3 box checked or OpenVPN Connect, the
route would be in effect so I don't need to push/configure one
explicitly to the client for it to be able to reach the server (or
vice versa) via the tunnel. But if I use ics-openvpn with the openvpn3
box checked, apparently the route is not in effect (but still added),
and therefore for it to be able to reach the server, I would need to
push/configure a route explicitly.

On Tue, 12 Nov 2019 at 02:02, Arne Schwabe <arne@...1227...> wrote:
>
> Am 11.11.19 um 16:12 schrieb Tom Yan:
> > Yes both iproute2 and sitnl works perfectly as expected. Will the fix
> > be backported to the 2.4 branch?
> >
> > P.S. For the record, if the client is ics-openvpn with openvpn3,
> > somehow you need push route (either host or subnet will do) anyway.
>
> I am not aware of this issue. Could you go more into detail?
>
> > This is not necessary with ics-openvpn with openvpn2 or OpenVPN
> > Connect (AFAIK its core is openvpn3 as well, albeit different
> > snapshot). The problem/behaviour is not specific to /31 subnet though,
> > apparently. I guess the main route table is ignored/masked.
>
> ics-openvpn is a) OpenVPN master b) uses a completely different logic to
> handle network config (in OpenVPNService.java). So this patch does not
> affect ics-openvpn in any way.
>
> Arne
>
>
>

