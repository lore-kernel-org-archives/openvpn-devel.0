MIME-Version: 1.0
In-Reply-To: <20100703081711.GA5858@...1276...>
References: <AANLkTima8VCnIP08BwlXrwvbtZRcRM-ZLeOM6FPty5Jc@...278...> 
	<4C2E2652.8000607@...1114...>
	<AANLkTintkNT0hY8cRHz-MEbfAFdd25mfMNOH-r3FTbE0@...278...> 
	<20100703081711.GA5858@...1276...>
From: =?UTF-8?Q?Henno_T=C3=A4ht?= <henno.taht@...277...>
Date: Sun, 4 Jul 2010 21:07:05 +0300
Message-ID: <AANLkTin8JKrl9x6Z4CStHCAUyLDBcLgFlQVhCa_4-34b@...278...>
Content-Type: multipart/alternative; boundary=0016e6d9a2ce3f253a048a93b1c4
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN server listening both
	on udp and tcp?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--0016e6d9a2ce3f253a048a93b1c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2010/7/3 Till Maas <opensource@...519...>

> Hi,
>
> On Fri, Jul 02, 2010 at 09:51:12PM +0300, Henno T=C3=A4ht wrote:
> > Hello!
> >
> > 2010/7/2 David Sommerseth <openvpn.list@...1114...>
> >
> > > On 02/07/10 19:38, Henno T=C3=A4ht wrote:
> > > > Hello!
> > > >
> > > > Can anyone experienced and helpful scribble a little guide how to
> have
> > > > the same OpenVPN server listening both on 1194 UDP (reason: fast,
> > > > preferable) and 443 TCP (reason: always works, fallback)?
> > >
> > > That is not possible.  OpenVPN can only listen to TCP or UDP, not bot=
h.
> > >  To do this, you will need two independent OpenVPN configurations and
> > > run two separate OpenVPN daemons
>
> there exists a PHP-script that is supposed to translate a TCP connection
> to UDP one. I did not test it:
>
> http://oss.tiggerswelt.net/openvpn_proxy.php
>
> A German blog post about it is available here:
>
> http://wohnzimmerhostblogger.de/archives/1244-OpenVPN-via-TCP-und-UDP-ben=
utzen.html
>
> Regards
> Till
>

Good to know. Unfortunately I need to use --port-share as I have OWA running
on port 443 and I need to run OpenVPN also on port 443 (some hotels allow
only 80 and 443). I could add another IP but I'm already tight on IP's.

--0016e6d9a2ce3f253a048a93b1c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2010/7/3 Till Maas <span dir=3D"ltr">&lt;<a href=3D"mailto:opensource@...1387...=
9...">opensource@...519...</a>&gt;</span><br><div class=3D"gmail_quote"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex;">

Hi,<br>
<div class=3D"im"><br>
On Fri, Jul 02, 2010 at 09:51:12PM +0300, Henno T=C3=A4ht wrote:<br>
&gt; Hello!<br>
&gt;<br>
&gt; 2010/7/2 David Sommerseth &lt;<a href=3D"mailto:openvpn.list@...1332...=
.">openvpn.list@...1114...</a>&gt;<br>
&gt;<br>
&gt; &gt; On 02/07/10 19:38, Henno T=C3=A4ht wrote:<br>
&gt; &gt; &gt; Hello!<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Can anyone experienced and helpful scribble a little guide h=
ow to have<br>
&gt; &gt; &gt; the same OpenVPN server listening both on 1194 UDP (reason: =
fast,<br>
&gt; &gt; &gt; preferable) and 443 TCP (reason: always works, fallback)?<br>
&gt; &gt;<br>
&gt; &gt; That is not possible. =C2=A0OpenVPN can only listen to TCP or UDP=
, not both.<br>
&gt; &gt; =C2=A0To do this, you will need two independent OpenVPN configura=
tions and<br>
&gt; &gt; run two separate OpenVPN daemons<br>
<br>
</div>there exists a PHP-script that is supposed to translate a TCP connect=
ion<br>
to UDP one. I did not test it:<br>
<br>
<a href=3D"http://oss.tiggerswelt.net/openvpn_proxy.php" target=3D"_blank">=
http://oss.tiggerswelt.net/openvpn_proxy.php</a><br>
<br>
A German blog post about it is available here:<br>
<a href=3D"http://wohnzimmerhostblogger.de/archives/1244-OpenVPN-via-TCP-un=
d-UDP-benutzen.html" target=3D"_blank">http://wohnzimmerhostblogger.de/arch=
ives/1244-OpenVPN-via-TCP-und-UDP-benutzen.html</a><br>
<br>
Regards<br>
<font color=3D"#888888">Till<br>
</font></blockquote></div><br><div>Good to know. Unfortunately I need to us=
e --port-share as I have OWA running on port 443 and I need to run OpenVPN =
also on port 443 (some hotels allow only 80 and 443). I could add another I=
P but I&#39;m already tight on IP&#39;s.</div>


--0016e6d9a2ce3f253a048a93b1c4--

