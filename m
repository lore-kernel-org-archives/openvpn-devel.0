MIME-Version: 1.0
In-Reply-To: <CAA1Abx+PCBhZM_wt_UTN6Kw=JZNJ7eUYt_tOpvVAuHqwnnmZbw@...278...>
References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
	<CAKuzo_iSwvk8MTW0ACT+n5JRkNDNyOoHHvmYw+fonN=ASUPuCw@...278...>
	<CAKuzo_hLdWaxZau_KtBhO1LvTivmurinrdqPsNTrjUfWnrZBvA@...278...>
	<20160204093823.GX24952@...1296...>
	<CAKuzo_isz+mde2P6=D=mMPQNEmcRQKmU-XNySVJxBK2eNzU-CA@...278...>
	<CAA1Abx+PCBhZM_wt_UTN6Kw=JZNJ7eUYt_tOpvVAuHqwnnmZbw@...278...>
Date: Fri, 5 Feb 2016 13:44:38 +0800
Message-ID: <CAPTYJtsrqCCSfdTEtUkWGw7T-YPqJ3foQROvCDu-byeDA43F3g@...278...>
From: Daniel Sim <daniel.ssq89@...277...>
Content-Type: multipart/alternative; boundary=089e013a04a8d1b15c052aff5830
Subject: Re: [Openvpn-devel] [PATCH v3] interactive service v3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e013a04a8d1b15c052aff5830
Content-Type: text/plain; charset=UTF-8

May I ask a more generic question about the implementation of the
interactive service?

So I understand that the patch allows clients to instruct the service to
modify the routing table. In short, it allows ordinary users (since any
program could impersonate the openvpn client) to modify the routing table.
Is this a good idea?

Imagine a rogue MITM client that somehow got onto a user's PC. It then uses
the Interactive Service to divert all traffic to a C&C server. Now all
Internet traffic can be eavesdropped upon.

Wouldn't it be better as debbie10t suggested to restrict ordinary users to
only the VPN configurations that are permitted by the administrator?

Daniel



On Fri, Feb 5, 2016 at 2:57 AM, Steffan Karger <steffan@...1856...> wrote:

> On Thu, Feb 4, 2016 at 4:40 PM, Selva Nair <selva.nair@...277...> wrote:
> > On Thu, Feb 4, 2016 at 4:38 AM, Gert Doering <gert@...1296...>
> wrote:
> >> Thanks.  I take this as an ACK from your for the service change, and
> >> Arne's mail as an ACK for the openvpn side, and merge it tonight.
> >>
> >> Then we can go about improving things further (... while we wait for
> >> the other large 2.4 feature to fully show up, AEAD...)
> >
> > Sounds good!
>
> Yes, I think the same.  I also briefly looked at the openvpn bits, and
> those look good to me too.  I did not check the openvpnserv bits, but
> I think Selva has that covered (and more experience).
>
> -Steffan
>
>
> ------------------------------------------------------------------------------
> Site24x7 APM Insight: Get Deep Visibility into Application Performance
> APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
> Monitor end-to-end web transactions and take corrective actions now
> Troubleshoot faster and improve end-user experience. Signup Now!
> http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--089e013a04a8d1b15c052aff5830
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>May I ask a more generic question about the implement=
ation of the interactive service?</div><div><br></div><div>So I understand =
that the patch allows clients to instruct the service to modify the routing=
 table. In short, it allows ordinary users (since any program could imperso=
nate=C2=A0the openvpn=C2=A0client) to modify the routing table. Is this a g=
ood idea?</div><div><br></div><div>Imagine a rogue MITM client that somehow=
 got onto a user&#39;s PC. It then uses the Interactive Service to divert a=
ll traffic to a C&amp;C server. Now all Internet traffic can be eavesdroppe=
d upon.</div><div><br></div><div>Wouldn&#39;t it be better as debbie10t sug=
gested to restrict ordinary users to only the VPN configurations that are p=
ermitted by the administrator?</div><div><br></div><div>Daniel</div><div><b=
r></div><div><br></div></div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Fri, Feb 5, 2016 at 2:57 AM, Steffan Karger <span dir=3D"ltr=
">&lt;<a href=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1883...=
56...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span>On Thu,=
 Feb 4, 2016 at 4:40 PM, Selva Nair &lt;<a href=3D"mailto:selva.nair@...1482...=
...">selva.nair@...277...</a>&gt; wrote:<br>
&gt; On Thu, Feb 4, 2016 at 4:38 AM, Gert Doering &lt;<a href=3D"mailto:ger=
t@...1296...">gert@...1296...</a>&gt; wrote:<br>
</span><span>&gt;&gt; Thanks.=C2=A0 I take this as an ACK from your for the=
 service change, and<br>
&gt;&gt; Arne&#39;s mail as an ACK for the openvpn side, and merge it tonig=
ht.<br>
&gt;&gt;<br>
&gt;&gt; Then we can go about improving things further (... while we wait f=
or<br>
&gt;&gt; the other large 2.4 feature to fully show up, AEAD...)<br>
&gt;<br>
&gt; Sounds good!<br>
<br>
</span>Yes, I think the same.=C2=A0 I also briefly looked at the openvpn bi=
ts, and<br>
those look good to me too.=C2=A0 I did not check the openvpnserv bits, but<=
br>
I think Selva has that covered (and more experience).<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Steffan<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
---------------------------------------------------------------------------=
---<br>
Site24x7 APM Insight: Get Deep Visibility into Application Performance<br>
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month<br>
Monitor end-to-end web transactions and take corrective actions now<br>
Troubleshoot faster and improve end-user experience. Signup Now!<br>
<a href=3D"http://pubads.g.doubleclick.net/gampad/clk?id=3D272487151&amp;iu=
=3D/4140" target=3D"_blank" rel=3D"noreferrer">http://pubads.g.doubleclick.=
net/gampad/clk?id=3D272487151&amp;iu=3D/4140</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" targ=
et=3D"_blank" rel=3D"noreferrer">https://lists.sourceforge.net/lists/listin=
fo/openvpn-devel</a><br>
</div></div></blockquote></div><br></div>

--089e013a04a8d1b15c052aff5830--

