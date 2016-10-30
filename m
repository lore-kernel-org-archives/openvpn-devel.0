MIME-Version: 1.0
In-Reply-To: <1a5fa7e8-d359-9128-c9b5-bb7049339aef@...1227...>
References: <a76fef6e-6cc6-0878-4cf6-293d84b4edd3@...277...>
	<deb274b8-709f-9bec-40f3-279d75d114a0@...2070...>
	<20161030101616.GV28918@...1296...>
	<1a5fa7e8-d359-9128-c9b5-bb7049339aef@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 30 Oct 2016 15:23:06 -0400
Message-ID: <CAKuzo_ihMpz6bYjcV1T8v6e8yhU+iWNsHOb7ngM_bxPL583LDg@...278...>
Content-Type: multipart/alternative; boundary=94eb2c05839888a57205401a0685
Subject: Re: [Openvpn-devel] dhcp-option DNS IPv6 server address for windows
	client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c05839888a57205401a0685
Content-Type: text/plain; charset=UTF-8

On Sun, Oct 30, 2016 at 2:08 PM, Arne Schwabe <arne@...1227...> wrote:

> Am 30.10.16 um 11:16 schrieb Gert Doering:
> > Hi,
> >
> > On Sun, Oct 30, 2016 at 12:18:39PM +0300, ValdikSS wrote:
> >> ?probably not only DHCPv6, but also Router Advertisement too. I doubt
> that DHCPv6 could be used without RA on Windows.
> >
> > It's a somewhat multi-stage thing
> >
> >  - first, define a new dhcp-option (like, "DNS6") that will take a
> >    v6 address, and put it into the environment variables on the client
> >    (so scripts and networkmanger etc. can pick it up and do the right
> >    thing wrt resolv.conf)
> >
> >  - then, figure out how to inject this into windows - as far as I know,
> >    windows will always try to do DHCPv6, even if no RA seen, but this is
> >    something easily tested.   Maybe it can be done without DHCPv6 by
> >    just calling an API call ("hey, here's DNS info!") on recent systems,
> >    maybe we need to implement a fake DHCPv6 server - someone needs to
> >    look into this, and come up with an implementation.
> >
> > #1 could easily make 2.4, #2 is very likely to not make it.
>
> #1 is also something I would like to have for Android.
>

Looks like #1 is useful to have on Windows too -- we could then use netsh
to set the dns server until we have a built-in dhcpv6 server implementation.

Selva

--94eb2c05839888a57205401a0685
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sun, Oct 30, 2016 at 2:08 PM, Arne Schwabe <span dir=3D"ltr">&lt;<a href=
=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div id=3D":1q6" class=3D"a3s aX=
jCH m15816c97065a50db">Am <span class=3D"aBn" tabindex=3D"0"><span class=3D=
"aQJ">30.10.16</span></span> um <span class=3D"aBn" tabindex=3D"0"><span cl=
ass=3D"aQJ">11:16</span></span> schrieb Gert Doering:<br>
<span class=3D"">&gt; Hi,<br>
&gt;<br>
&gt; On Sun, Oct 30, 2016 at 12:18:39PM +0300, ValdikSS wrote:<br>
&gt;&gt; ?probably not only DHCPv6, but also Router Advertisement too. I do=
ubt that DHCPv6 could be used without RA on Windows.<br>
&gt;<br>
&gt; It&#39;s a somewhat multi-stage thing<br>
&gt;<br>
&gt;=C2=A0 - first, define a new dhcp-option (like, &quot;DNS6&quot;) that =
will take a<br>
&gt;=C2=A0 =C2=A0 v6 address, and put it into the environment variables on =
the client<br>
&gt;=C2=A0 =C2=A0 (so scripts and networkmanger etc. can pick it up and do =
the right<br>
&gt;=C2=A0 =C2=A0 thing wrt resolv.conf)<br>
&gt;<br>
&gt;=C2=A0 - then, figure out how to inject this into windows - as far as I=
 know,<br>
&gt;=C2=A0 =C2=A0 windows will always try to do DHCPv6, even if no RA seen,=
 but this is<br>
&gt;=C2=A0 =C2=A0 something easily tested.=C2=A0 =C2=A0Maybe it can be done=
 without DHCPv6 by<br>
&gt;=C2=A0 =C2=A0 just calling an API call (&quot;hey, here&#39;s DNS info!=
&quot;) on recent systems,<br>
&gt;=C2=A0 =C2=A0 maybe we need to implement a fake DHCPv6 server - someone=
 needs to<br>
&gt;=C2=A0 =C2=A0 look into this, and come up with an implementation.<br>
&gt;<br>
&gt; #1 could easily make 2.4, #2 is very likely to not make it.<br>
<br>
</span>#1 is also something I would like to have for Android.</div></blockq=
uote></div><br>Looks like #1 is useful to have on Windows too -- we could t=
hen use netsh to set the dns server until we have a built-in dhcpv6 server =
implementation.<br><br></div><div class=3D"gmail_extra">Selva<br></div><div=
 class=3D"gmail_extra"><br></div></div>

--94eb2c05839888a57205401a0685--

