MIME-Version: 1.0
In-Reply-To: <4777209f-c480-0404-91c6-cf1bd3b3f507@...1227...>
References: <CAEycoiUeA+zbn3vT9t3F3Df6yxsKp8HmAdiaHCMmLV1ew+d8Xw@...278...>
 <4777209f-c480-0404-91c6-cf1bd3b3f507@...1227...>
From: wang yu <wangyu.cn@...277...>
Date: Wed, 30 Aug 2017 02:53:18 -0700
Message-ID: <CAEycoiVZ+Mdfyr6k9cQt79e46Ts-zdW7B8L=dz7T2qVBrs1=bw@...278...>
Content-Type: multipart/alternative; boundary="001a114096465aa27a0557f57f9d"
Subject: Re: [Openvpn-devel] Please take a second look at "#2 Improve
 TCP-over-TCP performance"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--001a114096465aa27a0557f57f9d
Content-Type: text/plain; charset="UTF-8"

Hi,Arne:

Got it.Thank you very much.

On Tue, Aug 29, 2017 at 6:49 PM, Arne Schwabe <arne@...1227...> wrote:

> Am 29.08.17 um 22:53 schrieb wang yu:
> > URL  https://community.openvpn.net/openvpn/ticket/2
> > <https://community.openvpn.net/openvpn/ticket/2>
> >
> > As I mentioned,the custom TCP protocol(I called FakeTCP) bypasses the
> > TCP over TCP performance issue.Its helpful when UDP is not
> > avaliable(being blocked or being throttled or not well supported by NAT
> > devices).
> >
> > This was your reply:
> >>We are not going to implement it, though. OpenVPN over TCP is needed
> > when you have nasty firewalls out there that do sequence number checking
> > and all that - and then your FakeTCP is not going to work either. If you
> > have no firewalls in the way, OpenVPN over UDP works perfectly well
> > (including "through NAT").
> >
> > Sorry,I cant get the logic behind the sentence.
> >
> > UDP not avaliable is a much more common circumstance,while a nasty
> > firewall which tracks everything of TCP is just a rare circumstance.
> >
> > This method solves most of the troubles when UDP is not avaliable just
> > except the nasty-firewall circumstance you mentioned.
> >
> > It seems like you rejected a commonly workable feature for a rare
> > circumstance.
> >
> > I tried to have a further discussion with you by another reply in the
> > Tracker,but you closed the issue without a word.
> >
> > I am okay wheter or not the feature can be implemented.I just hope its
> > well discussed and there is a convincing reason if it cant
> > be implemented.If this feature is acceptable I can make patches.
> >
> > If you dont have time to discuss with me,plz leave the ticket open for a
> > few days,so that I can possibly get some more convincing feedback from
> > others.
> >
>
> While a fake TCP as UDP sounds like a nice idea, OpenVPN itself is
> probably the wrong place to implement it. It would mean to implement a
> TCP/IP stack in userspace, something that would complicate OpenVPN
> without much gain. Much better would be to teach the kernel to speak
> this fake TCP UDP protocol so openvpn can just set the socket options on
> its tcp socket to enable this special mode.
>
> Take a look at Multipath TCP to get an idea what implementing such a
> fake TCP might entail. Also OpenVSwitch implemts a STT [1], a fake TCP
> protocol but for a very different reason.
>
> [1]
> https://networkheresy.com/2012/03/04/network-virtualization-encapsulation-
> and-stateless-tcp-transport-stt/
>
> In sum and I think I speak for all us, we are not against such a FakeTCP
> protocol but it should be
>
> a) implemented outside openvpn (the kernel)
> b) nobody of the OpenVPN core team will implement it
>
> This protocol will probably help only if people just block all UDP and
> allowed a few TCP protocol. You won't fool a real firewall that checks
> TCP with it.
>
> Arne
>

--001a114096465aa27a0557f57f9d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:12.8px">Hi,Arne:</span><div style=
=3D"font-size:12.8px"><br><div>Got it.Thank you very much.</div></div></div=
><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Aug 29, =
2017 at 6:49 PM, Arne Schwabe <span dir=3D"ltr">&lt;<a href=3D"mailto:arne@=
...1227..." target=3D"_blank">arne@...1227...</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">Am 29.08.17 um 22:53 schrieb wang yu:<br>
&gt; URL =C2=A0<a href=3D"https://community.openvpn.net/openvpn/ticket/2" r=
el=3D"noreferrer" target=3D"_blank">https://community.openvpn.<wbr>net/open=
vpn/ticket/2</a><br>
<div><div class=3D"h5">&gt; &lt;<a href=3D"https://community.openvpn.net/op=
envpn/ticket/2" rel=3D"noreferrer" target=3D"_blank">https://community.open=
vpn.<wbr>net/openvpn/ticket/2</a>&gt;<br>
&gt;<br>
&gt; As I mentioned,the custom TCP protocol(I called FakeTCP)=C2=A0bypasses=
 the<br>
&gt; TCP over TCP performance issue.Its helpful when UDP is not<br>
&gt; avaliable(being=C2=A0blocked or being=C2=A0throttled or not well suppo=
rted by NAT<br>
&gt; devices).<br>
&gt;<br>
&gt; This was your reply:<br>
&gt;&gt;We are not going to implement it, though. OpenVPN over TCP is neede=
d<br>
&gt; when you have nasty firewalls out there that do sequence number checki=
ng<br>
&gt; and all that - and then your FakeTCP is not going to work either. If y=
ou<br>
&gt; have no firewalls in the way, OpenVPN over UDP works perfectly well<br>
&gt; (including &quot;through NAT&quot;).<br>
&gt;<br>
&gt; Sorry,I cant get the logic behind the sentence.<br>
&gt;<br>
&gt; UDP not avaliable is a much more common=C2=A0circumstance,while a=C2=
=A0nasty<br>
&gt; firewall which tracks everything of TCP is just a rare=C2=A0circumstan=
ce.<br>
&gt;<br>
&gt; This method solves most of the troubles when UDP is not avaliable just=
<br>
&gt; except the nasty-firewall=C2=A0circumstance you mentioned.<br>
&gt;<br>
&gt; It seems like you rejected a=C2=A0commonly workable feature for a rare=
<br>
&gt; circumstance.<br>
&gt;<br>
&gt; I tried to have a further discussion with you by another reply in the<=
br>
&gt; Tracker,but you closed the issue without a word.<br>
&gt;<br>
&gt; I am okay=C2=A0wheter or not=C2=A0the feature can be implemented.I jus=
t hope its<br>
&gt; well=C2=A0discussed and=C2=A0there is a convincing reason if it cant<b=
r>
&gt; be=C2=A0implemented.If this feature is acceptable I can make patches.<=
br>
&gt;<br>
&gt; If you dont have time to discuss with me,plz leave the ticket open for=
 a<br>
&gt; few days,so that I can possibly=C2=A0get some more=C2=A0convincing=C2=
=A0feedback from<br>
&gt; others.<br>
&gt;<br>
<br>
</div></div>While a fake TCP as UDP sounds like a nice idea, OpenVPN itself=
 is<br>
probably the wrong place to implement it. It would mean to implement a<br>
TCP/IP stack in userspace, something that would complicate OpenVPN<br>
without much gain. Much better would be to teach the kernel to speak<br>
this fake TCP UDP protocol so openvpn can just set the socket options on<br>
its tcp socket to enable this special mode.<br>
<br>
Take a look at Multipath TCP to get an idea what implementing such a<br>
fake TCP might entail. Also OpenVSwitch implemts a STT [1], a fake TCP<br>
protocol but for a very different reason.<br>
<br>
[1]<br>
<a href=3D"https://networkheresy.com/2012/03/04/network-virtualization-enca=
psulation-and-stateless-tcp-transport-stt/" rel=3D"noreferrer" target=3D"_b=
lank">https://networkheresy.com/<wbr>2012/03/04/network-<wbr>virtualization=
-encapsulation-<wbr>and-stateless-tcp-transport-<wbr>stt/</a><br>
<br>
In sum and I think I speak for all us, we are not against such a FakeTCP<br>
protocol but it should be<br>
<br>
a) implemented outside openvpn (the kernel)<br>
b) nobody of the OpenVPN core team will implement it<br>
<br>
This protocol will probably help only if people just block all UDP and<br>
allowed a few TCP protocol. You won&#39;t fool a real firewall that checks<=
br>
TCP with it.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Arne<br>
</font></span></blockquote></div><br></div>

--001a114096465aa27a0557f57f9d--

