MIME-Version: 1.0
In-Reply-To: <8647024.clnTTMXkck@...2289...>
References: <CAEycoiUeA+zbn3vT9t3F3Df6yxsKp8HmAdiaHCMmLV1ew+d8Xw@...278...>
 <4777209f-c480-0404-91c6-cf1bd3b3f507@...1227...>
 <8647024.clnTTMXkck@...2289...>
From: wang yu <wangyu.cn@...277...>
Date: Wed, 30 Aug 2017 04:05:36 -0700
Message-ID: <CAEycoiWaj5rKpi-sXtQKZqRXEe_Vy1YtzJz1ygNQsN45-4FiRg@...278...>
Content-Type: multipart/alternative; boundary="001a1134fc20f001190557f6816e"
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
To: Steven Haigh <netwiz@...2277...>, openvpn-devel@lists.sourceforge.net

--001a1134fc20f001190557f6816e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,Steven:

Thats not very similiar to what I was talking about.

The URL you post,talks about adding UDP headers to TCP packets(by kernel
patch) to make use of  "hardware support for UDP" and other advantages of
UDP.

I was talking about adding TCP headers to UDP packets(by using raw socket)
to send UDP packets as TCP when UDP is not avaliable.It can bypass the
performance issue of TCP over TCP.If you are interested,check my repo:

URL https://github.com/wangyu-/udp2raw-tunnel

Though it may not have a chance to be integrated into OpenVPN,the idea has
been already implemented as an external program which can work stably with
OpenVPN.

Thank you all the same.

On Wed, Aug 30, 2017 at 3:23 AM, Steven Haigh <netwiz@...2277...> wrote:

> On Wednesday, 30 August 2017 11:49:33 AM AEST Arne Schwabe wrote:
> > Am 29.08.17 um 22:53 schrieb wang yu:
> > > URL  https://community.openvpn.net/openvpn/ticket/2
> > > <https://community.openvpn.net/openvpn/ticket/2>
> > >
> > > As I mentioned,the custom TCP protocol(I called FakeTCP) bypasses the
> > > TCP over TCP performance issue.Its helpful when UDP is not
> > > avaliable(being blocked or being throttled or not well supported by N=
AT
> > > devices).
> > >
> > > This was your reply:
> > >>We are not going to implement it, though. OpenVPN over TCP is needed
> > >>
> > > when you have nasty firewalls out there that do sequence number
> checking
> > > and all that - and then your FakeTCP is not going to work either. If
> you
> > > have no firewalls in the way, OpenVPN over UDP works perfectly well
> > > (including "through NAT").
> > >
> > > Sorry,I cant get the logic behind the sentence.
> > >
> > > UDP not avaliable is a much more common circumstance,while a nasty
> > > firewall which tracks everything of TCP is just a rare circumstance.
> > >
> > > This method solves most of the troubles when UDP is not avaliable just
> > > except the nasty-firewall circumstance you mentioned.
> > >
> > > It seems like you rejected a commonly workable feature for a rare
> > > circumstance.
> > >
> > > I tried to have a further discussion with you by another reply in the
> > > Tracker,but you closed the issue without a word.
> > >
> > > I am okay wheter or not the feature can be implemented.I just hope its
> > > well discussed and there is a convincing reason if it cant
> > > be implemented.If this feature is acceptable I can make patches.
> > >
> > > If you dont have time to discuss with me,plz leave the ticket open for
> a
> > > few days,so that I can possibly get some more convincing feedback from
> > > others.
> >
> > While a fake TCP as UDP sounds like a nice idea, OpenVPN itself is
> > probably the wrong place to implement it. It would mean to implement a
> > TCP/IP stack in userspace, something that would complicate OpenVPN
> > without much gain. Much better would be to teach the kernel to speak
> > this fake TCP UDP protocol so openvpn can just set the socket options on
> > its tcp socket to enable this special mode.
> >
> > Take a look at Multipath TCP to get an idea what implementing such a
> > fake TCP might entail. Also OpenVSwitch implemts a STT [1], a fake TCP
> > protocol but for a very different reason.
> >
> > [1]
> > https://networkheresy.com/2012/03/04/network-
> virtualization-encapsulation-an
> > d-stateless-tcp-transport-stt/
> >
> > In sum and I think I speak for all us, we are not against such a FakeTCP
> > protocol but it should be
> >
> > a) implemented outside openvpn (the kernel)
> > b) nobody of the OpenVPN core team will implement it
> >
> > This protocol will probably help only if people just block all UDP and
> > allowed a few TCP protocol. You won't fool a real firewall that checks
> > TCP with it.
>
> Something like this?
>
> https://lwn.net/Articles/614348/
>
> --
> Steven Haigh
>
> =F0=9F=93=A7 netwiz@...2277...       =F0=9F=92=BB http://www.crc.id.au
> =F0=9F=93=9E +61 (3) 9001 6090    =F0=9F=93=B1 0412 935 897
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--001a1134fc20f001190557f6816e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,Steven:<div><br></div><div>Thats not very similiar to w=
hat I was talking about.</div><div><br></div><div>The URL you post,talks ab=
out adding UDP headers to TCP packets(by kernel patch) to make use of =C2=
=A0&quot;<span style=3D"color:rgb(0,0,0);font-family:&quot;Times New Roman&=
quot;;font-size:medium">hardware support for UDP</span>&quot; and other adv=
antages of UDP.</div><div><br></div><div>I was talking about adding=C2=A0TC=
P headers to UDP packets(by using raw socket) to send UDP packets as TCP wh=
en UDP is not avaliable.It can bypass the performance issue of TCP over TCP=
.If you are interested,check my repo:</div><div><br></div><div>URL=C2=A0<a =
href=3D"https://github.com/wangyu-/udp2raw-tunnel">https://github.com/wangy=
u-/udp2raw-tunnel</a></div><div><br></div><div>Though it may not have a cha=
nce to be integrated into OpenVPN,the idea has been already implemented as =
an external program which can work stably with OpenVPN.</div><div><br></div=
><div>Thank you all the same.<br></div></div><div class=3D"gmail_extra"><br=
><div class=3D"gmail_quote">On Wed, Aug 30, 2017 at 3:23 AM, Steven Haigh <=
span dir=3D"ltr">&lt;<a href=3D"mailto:netwiz@...2277..." target=3D"_blank"=
>netwiz@...2277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<div class=3D"HOEnZb"><div class=3D"h5">On Wednesday, 30 August 2017 11:49:=
33 AM AEST Arne Schwabe wrote:<br>
&gt; Am 29.08.17 um 22:53 schrieb wang yu:<br>
&gt; &gt; URL=C2=A0 <a href=3D"https://community.openvpn.net/openvpn/ticket=
/2" rel=3D"noreferrer" target=3D"_blank">https://community.openvpn.net/<wbr=
>openvpn/ticket/2</a><br>
&gt; &gt; &lt;<a href=3D"https://community.openvpn.net/openvpn/ticket/2" re=
l=3D"noreferrer" target=3D"_blank">https://community.openvpn.<wbr>net/openv=
pn/ticket/2</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; As I mentioned,the custom TCP protocol(I called FakeTCP) bypasses=
 the<br>
&gt; &gt; TCP over TCP performance issue.Its helpful when UDP is not<br>
&gt; &gt; avaliable(being blocked or being throttled or not well supported =
by NAT<br>
&gt; &gt; devices).<br>
&gt; &gt;<br>
&gt; &gt; This was your reply:<br>
&gt; &gt;&gt;We are not going to implement it, though. OpenVPN over TCP is =
needed<br>
&gt; &gt;&gt;<br>
&gt; &gt; when you have nasty firewalls out there that do sequence number c=
hecking<br>
&gt; &gt; and all that - and then your FakeTCP is not going to work either.=
 If you<br>
&gt; &gt; have no firewalls in the way, OpenVPN over UDP works perfectly we=
ll<br>
&gt; &gt; (including &quot;through NAT&quot;).<br>
&gt; &gt;<br>
&gt; &gt; Sorry,I cant get the logic behind the sentence.<br>
&gt; &gt;<br>
&gt; &gt; UDP not avaliable is a much more common circumstance,while a nast=
y<br>
&gt; &gt; firewall which tracks everything of TCP is just a rare circumstan=
ce.<br>
&gt; &gt;<br>
&gt; &gt; This method solves most of the troubles when UDP is not avaliable=
 just<br>
&gt; &gt; except the nasty-firewall circumstance you mentioned.<br>
&gt; &gt;<br>
&gt; &gt; It seems like you rejected a commonly workable feature for a rare=
<br>
&gt; &gt; circumstance.<br>
&gt; &gt;<br>
&gt; &gt; I tried to have a further discussion with you by another reply in=
 the<br>
&gt; &gt; Tracker,but you closed the issue without a word.<br>
&gt; &gt;<br>
&gt; &gt; I am okay wheter or not the feature can be implemented.I just hop=
e its<br>
&gt; &gt; well discussed and there is a convincing reason if it cant<br>
&gt; &gt; be implemented.If this feature is acceptable I can make patches.<=
br>
&gt; &gt;<br>
&gt; &gt; If you dont have time to discuss with me,plz leave the ticket ope=
n for a<br>
&gt; &gt; few days,so that I can possibly get some more convincing feedback=
 from<br>
&gt; &gt; others.<br>
&gt;<br>
&gt; While a fake TCP as UDP sounds like a nice idea, OpenVPN itself is<br>
&gt; probably the wrong place to implement it. It would mean to implement a=
<br>
&gt; TCP/IP stack in userspace, something that would complicate OpenVPN<br>
&gt; without much gain. Much better would be to teach the kernel to speak<b=
r>
&gt; this fake TCP UDP protocol so openvpn can just set the socket options =
on<br>
&gt; its tcp socket to enable this special mode.<br>
&gt;<br>
&gt; Take a look at Multipath TCP to get an idea what implementing such a<b=
r>
&gt; fake TCP might entail. Also OpenVSwitch implemts a STT [1], a fake TCP=
<br>
&gt; protocol but for a very different reason.<br>
&gt;<br>
&gt; [1]<br>
&gt; <a href=3D"https://networkheresy.com/2012/03/04/network-virtualization=
-encapsulation-an" rel=3D"noreferrer" target=3D"_blank">https://networkhere=
sy.com/<wbr>2012/03/04/network-<wbr>virtualization-encapsulation-<wbr>an</a=
><br>
&gt; d-stateless-tcp-transport-stt/<br>
&gt;<br>
&gt; In sum and I think I speak for all us, we are not against such a FakeT=
CP<br>
&gt; protocol but it should be<br>
&gt;<br>
&gt; a) implemented outside openvpn (the kernel)<br>
&gt; b) nobody of the OpenVPN core team will implement it<br>
&gt;<br>
&gt; This protocol will probably help only if people just block all UDP and=
<br>
&gt; allowed a few TCP protocol. You won&#39;t fool a real firewall that ch=
ecks<br>
&gt; TCP with it.<br>
<br>
</div></div>Something like this?<br>
<br>
<a href=3D"https://lwn.net/Articles/614348/" rel=3D"noreferrer" target=3D"_=
blank">https://lwn.net/Articles/<wbr>614348/</a><br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Steven Haigh<br>
<br>
=F0=9F=93=A7 <a href=3D"mailto:netwiz@...2277...">netwiz@...2277...</a>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0=F0=9F=92=BB <a href=3D"http://www.crc.id.au" rel=
=3D"noreferrer" target=3D"_blank">http://www.crc.id.au</a><br>
=F0=9F=93=9E <a href=3D"tel:%2B61%20%283%29%209001%206090" value=3D"+613900=
16090">+61 (3) 9001 6090</a>=C2=A0 =C2=A0 =F0=9F=93=B1 0412 935 897</font><=
/span><br>------------------------------<wbr>------------------------------=
<wbr>------------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>_________=
_____________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
<br></blockquote></div><br></div>

--001a1134fc20f001190557f6816e--

