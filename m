MIME-Version: 1.0
In-Reply-To: <20161124102829.GI28918@...1296...>
References: <CAKuzo_gyYfD=YsV-GCU+-g93sctikfR+zC_4_E3vHfVo1oREMA@...278...>
	<20161124102829.GI28918@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 24 Nov 2016 08:02:50 -0500
Message-ID: <CAKuzo_ivUQ9Dce5bKCx5xuexinPXbPSDNoPH_8syy4777OHsMg@...278...>
Content-Type: multipart/alternative; boundary=001a114cb96aa0955205420ba082
Subject: Re: [Openvpn-devel] IPv6 route addition error on SIGHUP restarts
	(Windows)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114cb96aa0955205420ba082
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, Nov 24, 2016 at 5:28 AM, Gert Doering <gert@...1296...> wrote:

>
> On Wed, Nov 23, 2016 at 10:43:20PM -0500, Selva Nair wrote:
> > I see the following route addition error during SIGHUP restarts on
> Windows.
> >
> > Wed Nov 23 21:44:39 2016 add_route_ipv6(xxxx:xxxx:e001:3b08::/64 ->
> > xxxx:xxxx:e001:3b08::1001 metric 0) dev SanSel-VPN
> > Wed Nov 23 21:44:39 2016 ROUTE: route addition failed using service: The
> > object already exists.   [status=5010 if_index=24]
> > Wed Nov 23 21:44:39 2016 IPv6 route addition via service failed
> >
> > I'm not familiar with the relevant code, but looks like the route added
> by
> > add_route_connected_v6_net() is not deleted on disconnect. Probably this
> > route doesn't make it into the route_list.
>
> Right, the "locally connected" routes are set directly, bypassing the
> route_list infrastructure (for no particular reason than "it was easier
> to do that way, than to try to understand all the machinery involved"
> and I was not familiar with the code yet).
>
> Is this a fatal error (= openvpn ends), or just a nuisance?
>
> We should fix it in any case, but if this is just a nuisance in the
> logs, I'd treat it as a cosmetic bug and postpone for a few weeks.


Its not fatal and looks like its a harmless (the route already exists).

Selva

--001a114cb96aa0955205420ba082
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Thu, Nov 24, 2016 at 5:28 AM, Ge=
rt Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><span class=3D""><br>
On Wed, Nov 23, 2016 at 10:43:20PM -0500, Selva Nair wrote:<br>
&gt; I see the following route addition error during SIGHUP restarts on Win=
dows.<br>
&gt;<br>
&gt; Wed Nov 23 21:44:39 2016 add_route_ipv6(xxxx:xxxx:e001:<wbr>3b08::/64 =
-&gt;<br>
&gt; xxxx:xxxx:e001:3b08::1001 metric 0) dev SanSel-VPN<br>
&gt; Wed Nov 23 21:44:39 2016 ROUTE: route addition failed using service: T=
he<br>
&gt; object already exists.=C2=A0 =C2=A0[status=3D5010 if_index=3D24]<br>
&gt; Wed Nov 23 21:44:39 2016 IPv6 route addition via service failed<br>
&gt;<br>
&gt; I&#39;m not familiar with the relevant code, but looks like the route =
added by<br>
&gt; add_route_connected_v6_net() is not deleted on disconnect. Probably th=
is<br>
&gt; route doesn&#39;t make it into the route_list.<br>
<br>
</span>Right, the &quot;locally connected&quot; routes are set directly, by=
passing the<br>
route_list infrastructure (for no particular reason than &quot;it was easie=
r<br>
to do that way, than to try to understand all the machinery involved&quot;<=
br>
and I was not familiar with the code yet).<br>
<br>
Is this a fatal error (=3D openvpn ends), or just a nuisance?<br>
<br>
We should fix it in any case, but if this is just a nuisance in the<br>
logs, I&#39;d treat it as a cosmetic bug and postpone for a few weeks.</blo=
ckquote></div><br></div><div class=3D"gmail_extra">Its not fatal and looks =
like its a harmless (the route already exists).<br><br></div><div class=3D"=
gmail_extra">Selva<br></div></div>

--001a114cb96aa0955205420ba082--

