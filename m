MIME-Version: 1.0
References: <20191103053148.18059-1-tom.ty89@...277...>
 <20191103182443.GC40538@...1296...>
 <20191103183351.GD40538@...1296...>
 <CAGnHSEn0jaM3u9LCXxArhQkL9ddZQ9UROOZ8+PXPf+oAwTyswg@...278...>
 <20191103204613.GE40538@...1296...>
 <a991a966-039e-c171-7201-01b90a23d2b7@...1227...>
In-Reply-To: <a991a966-039e-c171-7201-01b90a23d2b7@...1227...>
From: Tom Yan <tom.ty89@...277...>
Date: Tue, 5 Nov 2019 11:41:20 +0800
Message-ID: <CAGnHSEm+3Kos3Qe22nFkHLv+sWhrvq+mZXAhL=RgyDCTSh_v5w@...278...>
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
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hmm btw, not sure you are talking about the same thing, but at least
my device the "proto kernel scope link" subnet route is added for the
tun. While I can ping the "peer" out-of-the-box with /31 subnet and
the subnet topology, with p2p topology and 255.255.255.255 mask, I
need to add route in ics-openvpn for its peer before I can ping it.
(The server is configured with topology and ifconfig corresponds to
the client's in both tests.)

On Tue, 5 Nov 2019 at 01:01, Arne Schwabe <arne@...1227...> wrote:
>
>  >> Yeah the removal of the p2p topology was one of the reasons. It's
> >> actually the fact that ics-openvpn doesn't really parse point-to-point
> >> ifconfig that made me aware of this.
> >
> > I wasn't aware of that, but since Arne is reading here, maybe he can
> > comment on it.  It's possible that the Android VPN API just does not
> > permit p2p mode, but wants a subnet.
> >
> > Arne, any idea if /31 works on Android?
>
> Yes. But Android is special here anyway. It always wants a subnet mask
> but the mask can be also be 255.255.255.255. And you also don't have a
> gateway address and Android also does not set a route to the tun
> interface (On Android 4.4+). So basically you always operate in p2p mode
> and emulate other modes by adding routes to the tun interface.
>
> Arne
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

