MIME-Version: 1.0
In-Reply-To: <CAKuzo_jHka7eDtb4We0SvLX9kTN3x=1ae917NZHkweWpij94sA@...278...>
References: <1483152307-15687-1-git-send-email-selva.nair@...277...>
	<20170103171747.GR78624@...1296...>
	<CAKuzo_jHka7eDtb4We0SvLX9kTN3x=1ae917NZHkweWpij94sA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 3 Jan 2017 14:36:47 -0500
Message-ID: <CAKuzo_hnrsHcJoUKsKcKR6ZfYXsJPrww0=aDbem5_m+ukiJAug@...278...>
Content-Type: multipart/alternative; boundary=001a114fe7142ebc5e054535cb61
Subject: Re: [Openvpn-devel] [PATCH] Always release dhcp address in
	close_tun()
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

--001a114fe7142ebc5e054535cb61
Content-Type: text/plain; charset=UTF-8

On Tue, Jan 3, 2017 at 12:55 PM, Selva Nair <selva.nair@...277...> wrote:

> Hi,
>
> On Tue, Jan 3, 2017 at 12:17 PM, Gert Doering <gert@...1296...> wrote:
>
>> On Fri, Dec 30, 2016 at 09:45:07PM -0500, selva.nair@...277... wrote:
>> > From: Selva Nair <selva.nair@...277...>
>> >
>> > Also make sure --dhcp-pre-release results in not just dhcp_release()
>> > in open_tun() but a subsequent dhcp_renew() as well. Else dhcp
>> transaction
>> > gets aborted as this call to release() happens after the adapter status
>> > is changed to connected.
>> >
>> > Alternatively, the undocumented --dhcp-pre-release may be removed.
>> >
>> > Fixes Trac #807 (but can't say the same for Trac #665 without knowing
>> > how to reproduce it)
>>
>> After thinking about this for a while, I agree we should do this, so
>> ACK (even if Debbie10t already has ACKed it).
>>
>> I'd ask for a few changes, though :-) - if I'm reading this correctly,
>> tt->options.dhcp_release is now unused, so I think we should do it
>> all the way - get rid of that flag variable, print a message
>> ("obsolete option detected, already on" or so) if --dhcp-release
>> is configured, and update the man page ("this option is a no-op now,
>> as the functionality is enabled by default starting in 2.4.1").
>>
>
> Agreed. Will send a v2 later today.
>

There is one corner case that I realized only now: what
happens when a real dhcp server is in use (say in bridge mode).
Current dhcp_release() function is a no-op unless the
masquerading dhcp server in the tap driver is active (it checks
ltt->options.ip_win32_type == IPW32_SET_DHCP_MASQ)

Simply removing that restriction may be risky as its unclear
to me whether IpReleaseAddress()  is a synchronous or async
call (MSDN doesn't say). If it blocks until the address is
released (like 'ipconfig /renew' appears to do) then it won't work with
an external dhcp server as our process is also the router for
packets through the tunnel. Internal one should be ok, as those
packets are handled in the tap driver.

Anyway this is beyond the current patch as it just uses
dhcp_release() as coded (which looks safe). So I suppose we just
go ahead and handle other cases as and when they show up..

Selva

--001a114fe7142ebc5e054535cb61
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Jan 3, 2017 at 12:55 PM, Selva Nair <span dir=3D"ltr">&lt;<a href=
=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bor=
der-left-style:solid;padding-left:1ex"><div class=3D"gmail_extra">Hi,</div>=
<div class=3D"gmail_extra"><span class=3D"gmail-"><br><div class=3D"gmail_q=
uote">On Tue, Jan 3, 2017 at 12:17 PM, Gert Doering <span dir=3D"ltr">&lt;<=
a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-=
left-style:solid;padding-left:1ex"><span>On Fri, Dec 30, 2016 at 09:45:07PM=
 -0500, <a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nai=
r@...277...</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt;<br>
&gt; Also make sure --dhcp-pre-release results in not just dhcp_release()<b=
r>
&gt; in open_tun() but a subsequent dhcp_renew() as well. Else dhcp transac=
tion<br>
&gt; gets aborted as this call to release() happens after the adapter statu=
s<br>
&gt; is changed to connected.<br>
&gt;<br>
&gt; Alternatively, the undocumented --dhcp-pre-release may be removed.<br>
&gt;<br>
&gt; Fixes Trac #807 (but can&#39;t say the same for Trac #665 without know=
ing<br>
&gt; how to reproduce it)<br>
<br>
</span>After thinking about this for a while, I agree we should do this, so=
<br>
ACK (even if Debbie10t already has ACKed it).<br>
<br>
I&#39;d ask for a few changes, though :-) - if I&#39;m reading this correct=
ly,<br>
tt-&gt;options.dhcp_release is now unused, so I think we should do it<br>
all the way - get rid of that flag variable, print a message<br>
(&quot;obsolete option detected, already on&quot; or so) if --dhcp-release<=
br>
is configured, and update the man page (&quot;this option is a no-op now,<b=
r>
as the functionality is enabled by default starting in 2.4.1&quot;).<br></b=
lockquote><div>=C2=A0</div></div></span>Agreed. Will send a v2 later today.=
</div><div class=3D"gmail_extra"></div></blockquote></div><br>There is one =
corner case that I realized only now: what</div><div class=3D"gmail_extra">=
happens when a real dhcp server is in use (say in bridge mode).=C2=A0</div>=
<div class=3D"gmail_extra">Current dhcp_release() function is a no-op unles=
s the=C2=A0</div><div class=3D"gmail_extra">masquerading dhcp server in the=
 tap driver is active (it checks</div><div class=3D"gmail_extra">ltt-&gt;op=
tions.ip_win32_type =3D=3D IPW32_SET_DHCP_MASQ)</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra">Simply removing that restriction =
may be risky as its unclear</div><div class=3D"gmail_extra">to me whether I=
pReleaseAddress() =C2=A0is a synchronous or async</div><div class=3D"gmail_=
extra">call (MSDN doesn&#39;t say). If it blocks until the address is</div>=
<div class=3D"gmail_extra">released (like &#39;ipconfig /renew&#39; appears=
 to do) then it won&#39;t work with</div><div class=3D"gmail_extra">an exte=
rnal dhcp server as our process is also the router for</div><div class=3D"g=
mail_extra">packets through the tunnel. Internal one should be ok, as those=
</div><div class=3D"gmail_extra">packets are handled in the tap driver.</di=
v><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Anyway th=
is is beyond the current patch as it just uses</div><div class=3D"gmail_ext=
ra">dhcp_release() as coded (which looks safe). So I suppose we just</div><=
div class=3D"gmail_extra">go ahead and handle other cases as and when they =
show up..</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_ext=
ra">Selva</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_ext=
ra"><br></div></div>

--001a114fe7142ebc5e054535cb61--

