MIME-Version: 1.0
References: <CAOh3LPOwuAO84y7kUcWNQFVes8rwRg6WZ9dAUBTAqLTrDMtaLQ.ref@...278...>
 <CAOh3LPOwuAO84y7kUcWNQFVes8rwRg6WZ9dAUBTAqLTrDMtaLQ@...278...>
 <ebe735de-ee37-4cc2-aa41-1ac10f8744b4@...1227...>
 <CAOh3LPMj6WQgsUS00Jke0nNvRW8U0hTY78RYG5FTgCVQF38daA@...278...>
 <aJM69j31LSPdL3hN@...1296...>
In-Reply-To: <aJM69j31LSPdL3hN@...1296...>
From: Jon Chiappetta <root@...2904...>
Date: Wed, 6 Aug 2025 07:46:53 -0400
Message-ID: <CAOh3LPOeEYg=BbsJj1SfYSDPi0y3muKy7PGo-vO41zOfwZ9kkw@...278...>
Content-Type: multipart/alternative; boundary="00000000000050292e063bb0e6d8"
Subject: Re: [Openvpn-devel] Modifying OpenVPN Source Code to Allow for
 Bulk-Reads, Max-MTU, and Jumbo-TCP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--00000000000050292e063bb0e6d8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gert,

Thank you for the documentation link, I will try to take a look at it when
I get some free time from work and life. I think my specific use case is a
bit different than other peoples. I think most people run VPN clients
directly on their client host machines which means that their host
operating system and network stack will honor a lower sized MTU directly
before sending network data outbound.

In my use case, I am piping my entire home WiFi network traffic through a
dedicated Linux VM running on a Mac Mini which can result in some serious
issues if I'm not careful enough. The reason why MTU size (1500 bytes) is
important to me is because all of my network clients will auto assume the
standard 1500 bytes once they join a network. This means that if my middle
network VPN link MTU is <1500, it will likely cause fragmentation issues
for my LAN clients which I really don't want performance wise. If the VPN
link MTU is >1500, then my ISP will fragment my packets at the router WAN
side as that is the network standard there also. In addition, the code base
is only performing singular read/write MTU-sized calls and sending them out
right away which also greatly impacts potential performance as well.

With my modifications made, I can specifically and directly target an exact
1500 byte MTU VPN link so that it correctly matches the LAN and WAN side of
the networks which is really important network wise and I can also let TCP
at the kernel level beautifully handle huge streams of bulk data and
ordering and delivery on my behalf as efficiently as possible. This would
be a pretty nice modification if I could make it through to the end.

This is one of the reasons why I dislike WireGuard personally. It's at the
kernel level instead of application level, it enforces a very small sized
MTUs potentially causing fragmentation and performance issues and its UDP
based only. :/

Thanks for your time on this,
Jon Chiappetta








On Wed, Aug 6, 2025 at 7:22=E2=80=AFAM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Wed, Aug 06, 2025 at 07:03:51AM -0400, Jon Chiappetta via Openvpn-devel
> wrote:
> > Is there any development setup guide I could follow in the future which
> > would allow me to submit a pull request to the OpenVPN codebase in an
> > official manner?
>
> https://community.openvpn.net/Development/DeveloperDocumentation
>
> which is outdated in a few places, but the most important thing is
> still correct: we don't do Github PRs, we do "patch on list" or "push
> to gerrit".
>
> Before you spend too much time on actual code, it makes sense to see if
> there is general agreement on the problem statement, and the direction
> to fix it.  For problems that we cannot understand, it's slightly harder
> to convince us to accept the code (and the maintenance and testing
> obligation that comes with each new line of code).
>
> So far I have heard "MTU mumble mumble" and we do have lots of MTUs of
> all sorts already :-)
>
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never
> doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>
> Gert Doering - Munich, Germany
> gert@...1296...
>

--00000000000050292e063bb0e6d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0Gert,<div><br></div><div>Thank you for the documen=
tation link, I will try to take a look at it when I get some free time from=
 work and life. I think my specific use case is a bit different than other =
peoples. I think most people run VPN clients directly on their client host =
machines which means that their host operating system and network stack wil=
l honor a lower sized MTU directly before sending network data outbound.=C2=
=A0</div><div><br></div><div>In my use case, I am piping my entire home WiF=
i network traffic through a dedicated Linux VM running on a Mac Mini which =
can result in some serious issues if I&#39;m not careful enough. The reason=
 why MTU size (1500 bytes) is important to me is because all of my network =
clients will auto assume the standard 1500 bytes once they join a network. =
This means that if my middle network VPN link MTU is &lt;1500, it will like=
ly cause fragmentation issues for my LAN clients which I really don&#39;t w=
ant performance wise. If the VPN link MTU is &gt;1500, then my ISP will fra=
gment my packets at the router WAN side as that is the network standard the=
re also. In addition, the code base is only performing singular read/write =
MTU-sized calls and sending them out right away which also greatly impacts =
potential performance as well.=C2=A0</div><div><br></div><div>With my modif=
ications made, I can specifically and directly target an exact 1500 byte MT=
U VPN link so that it correctly matches the LAN and WAN side of the network=
s which is really important network wise and I can also let TCP at the kern=
el level beautifully handle huge streams of bulk data and ordering and deli=
very on my behalf as efficiently as possible. This would be a pretty nice m=
odification if I could make it through to the end.=C2=A0</div><div><br></di=
v><div>This is one of the reasons why I dislike WireGuard personally. It&#3=
9;s at the kernel level instead of application level, it enforces a very sm=
all sized MTUs potentially causing fragmentation and performance issues and=
 its UDP based only. :/=C2=A0</div><div><br></div><div>Thanks for your time=
 on this,</div><div>Jon Chiappetta</div><div><br></div><div><br></div><div>=
<br></div><div><br></div><div><br></div><div><br></div><div><br></div></div=
><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Wed, Aug 6, 2025 at 7:22=E2=80=AFAM Gert Doering &lt;<a=
 href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);pad=
ding-left:1ex">Hi,<br>
<br>
On Wed, Aug 06, 2025 at 07:03:51AM -0400, Jon Chiappetta via Openvpn-devel =
wrote:<br>
&gt; Is there any development setup guide I could follow in the future whic=
h<br>
&gt; would allow me to submit a pull request to the OpenVPN codebase in an<=
br>
&gt; official manner?<br>
<br>
<a href=3D"https://community.openvpn.net/Development/DeveloperDocumentation=
" rel=3D"noreferrer" target=3D"_blank">https://community.openvpn.net/Develo=
pment/DeveloperDocumentation</a><br>
<br>
which is outdated in a few places, but the most important thing is<br>
still correct: we don&#39;t do Github PRs, we do &quot;patch on list&quot; =
or &quot;push<br>
to gerrit&quot;.<br>
<br>
Before you spend too much time on actual code, it makes sense to see if<br>
there is general agreement on the problem statement, and the direction <br>
to fix it.=C2=A0 For problems that we cannot understand, it&#39;s slightly =
harder<br>
to convince us to accept the code (and the maintenance and testing<br>
obligation that comes with each new line of code).<br>
<br>
So far I have heard &quot;MTU mumble mumble&quot; and we do have lots of MT=
Us of<br>
all sorts already :-)<br>
<br>
gert<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
</blockquote></div>

--00000000000050292e063bb0e6d8--

