From: <openvpn@...1315...>
Date: Wed, 15 Sep 2010 11:37:06 -0500
Message-id: <1284568626450227500@...1315...>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="===axigen=1317172144156885327013986446358889362986=axigen==="
Subject: Re: [Openvpn-devel] TCP Window Size - Impact on Data Throughput
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?utf-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a MIME message. You may need a MIME compliant mail user agent.
--===axigen=1317172144156885327013986446358889362986=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline





Hi,

My apologies, as I haven't gotten back on this yet. I have been trying to t=
est, but my results are consistently inconsistent ... :-(. I have tried tun=
ing the settings, as Windows doesn't seem to show any default setting - but=
 it's not showing any consistent deltas in performance.

Has anyone else tried this?

Thanks,
... Russell


On Mon, Sep 13, 2010 02:24  AM, Samuli Sepp=C3=A4nen <samuli@...515...> wro=
te:

>=20
> Hi,
> >
> > On Thu, Sep 09, 2010 at 06:32:14PM -0500, openvpn@...1315... wrote:
> >=20
> >> I can't explain the information below, but hopefully someone a whole=20
> >> bunch smarter than me understands it - as it seems to help with=20
> >> TCP throughput in OpenVPN (the holy grail??? ... :-)).
> >>=20
> >
> > Did you change TCP window size on the client, or on the OpenVPN process?
> >
> > If changing the TCP window size on the client helps, this is somewhat
> > unsurprising - OpenVPN adds delay, and TCP with a too-small window size
> > breaks down miserably if the delay goes up.
> >
> > What's the "default" TCP window size here?
> >
> > Given that you can even see an effect in the "direct" case, I suspect t=
hat
> > your machines' TCP window sizes are *way* too small - and this has not =
much
> > to do with TCP-over-TCP, but you would see the same effect for UDP-based
> > OpenVPN as well.
> >
> > Simple example, to clarify the effect of round trip time (delay) on
> > TCP throughput:
> >
> > TCP uses a sliding window, that is, the sender can send as many packets
> > as the "window size" permits before the sender has to wait for an ackno=
wledge
> > from the receiver. Now, if the link has a noticeable delay AND lots of
> > bandwidth, the bandwidth * time product adds up to the minimum window s=
ize
> > you need to use:
> >
> > 1000 Mbit/s link
> > 1 ms delay (1/1000s)
> >
> > 1000 Mbit/s * 1ms =3D 1 Mbit =3D 100 Kbyte "in flight" - that is, if th=
e sender=20
> > keeps sending packets back to back, with no pause in between, it needs =
to
> > send out 100 kbyte before the first ACK packet comes back.
> >
> > If the sender only sends 10 kbyte because the TCP window size doesn't p=
ermit
> > sending more, these 10 kbyte are sent in ~ 0.1 ms, and then it has to=20
> > wait for 0.9 ms for the ACKs to come in - send again for 0.1 ms, wait 0=
.9 ms
> > (roughly). So it's only using 10% of the available sending capacity, and
> > the performance sucks.
> >
> >
> > So, in your examples, my guess is that the TCP window size is "barely l=
arge
> > enough" for the "direct" case (but the link is not fully saturated unle=
ss
> > you increase the window size) - and since OpenVPN adds some noticeable
> > delay, the bandwidth * delay product goes up, and so needs the window s=
ize
> > to be able to fully saturate the link...
> >=20
> I wonder if the iPerf results only apply to iPerf tests... Linux
> autotunes TCP parameters, including send and receive windows[1].
> However, increasing the maximum TCP buffer / memory size may be useful
> sometimes [2]. Also, an application can choose to use a smaller buffer
> than the OS default [2]: apparently iPerf does this. Windows also
> autotunes it's TCP parameters[3], although manual editing is an option[4].
>=20
> Russell: perhaps you could try tuning the OS-level TCP buffer size and
> then test the results with a few different real-world applications (e.g.
> netcat, scp)?
>=20
> [1] <http://www.psc.edu/networking/projects/tcptune/#Linux>
> [2] <http://www.psc.edu/networking/projects/tcptune/#options>
> [3] <http://fasterdata.es.net/TCP-tuning/>
> [4]
> <http://www.psc.edu/networking/projects/tcptune/OStune/winxp/winxp_stepby=
step.html>
>=20
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>=20
> irc freenode net: mattock
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Start uncovering the many advantages of virtual appliances
> and start using them to simplify application deployment and
> accelerate your shift to cloud computing
> http://p.sf.net/sfu/novell-sfdev2dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20=

--===axigen=1317172144156885327013986446358889362986=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;"><BR>
<DIV style=3D"FONT-FAMILY: Arial; FONT-SIZE: 10pt">
<STYLE id=3Daxi-htmleditor-style type=3Dtext/css>p { margin: 0px; }</STYLE>
Hi,
<DIV><BR></DIV>
<DIV>My apologies, as I haven't gotten back on this yet. I have been trying=
 to test, but my results are consistently inconsistent ... :-(. I have trie=
d tuning the settings, as Windows doesn't seem to show any default setting =
- but it's not showing any consistent deltas in performance.</DIV>
<DIV><BR></DIV>
<DIV>Has anyone else tried this?</DIV>
<DIV><BR></DIV>
<DIV>Thanks,</DIV>
<DIV>... Russell</DIV>
<DIV><BR></DIV>
<DIV><BR></DIV><BR>On Mon,&nbsp;Sep&nbsp;13,&nbsp;2010&nbsp;02:24&nbsp;&nbs=
p;AM, Samuli&nbsp;Sepp=C3=A4nen&nbsp;&lt;samuli@...515...&gt; wrote:<BR>
<BLOCKQUOTE style=3D"BORDER-LEFT: rgb(0,0,204) 2px solid; PADDING-LEFT: 4px=
; MARGIN-LEFT: 16px">
<DIV style=3D"FONT-FAMILY: Arial; FONT-SIZE: 10pt">&gt; Hi,<BR>&gt;<BR>&gt;=
 On Thu, Sep 09, 2010 at 06:32:14PM -0500,<A href=3D"mailto:%20openvpn@...1386...=
315..."> openvpn@...1315...</A> wrote:<BR>&gt; <BR>&gt;&gt; I can't explain=
 the information below, but hopefully someone a whole <BR>&gt;&gt; bunch sm=
arter than me understands it - as it seems to help with <BR>&gt;&gt; TCP th=
roughput in OpenVPN (the holy grail??? ... :-)).<BR>&gt;&gt; <BR>&gt;<BR>&g=
t; Did you change TCP window size on the client, or on the OpenVPN process?=
<BR>&gt;<BR>&gt; If changing the TCP window size on the client helps, this =
is somewhat<BR>&gt; unsurprising - OpenVPN adds delay, and TCP with a too-s=
mall window size<BR>&gt; breaks down miserably if the delay goes up.<BR>&gt=
;<BR>&gt; What's the "default" TCP window size here?<BR>&gt;<BR>&gt; Given =
that you can even see an effect in the "direct" case, I suspect that<BR>&gt=
; your machines' TCP window sizes are *way* too small - and this has not mu=
ch<BR>&gt; to do with TCP-over-TCP, but you would see the same effect for U=
DP-based<BR>&gt; OpenVPN as well.<BR>&gt;<BR>&gt; Simple example, to clarif=
y the effect of round trip time (delay) on<BR>&gt; TCP throughput:<BR>&gt;<=
BR>&gt; TCP uses a sliding window, that is, the sender can send as many pac=
kets<BR>&gt; as the "window size" permits before the sender has to wait for=
 an acknowledge<BR>&gt; from the receiver. Now, if the link has a noticeabl=
e delay AND lots of<BR>&gt; bandwidth, the bandwidth * time product adds up=
 to the minimum window size<BR>&gt; you need to use:<BR>&gt;<BR>&gt; 1000 M=
bit/s link<BR>&gt; 1 ms delay (1/1000s)<BR>&gt;<BR>&gt; 1000 Mbit/s * 1ms =
=3D 1 Mbit =3D 100 Kbyte "in flight" - that is, if the sender <BR>&gt; keep=
s sending packets back to back, with no pause in between, it needs to<BR>&g=
t; send out 100 kbyte before the first ACK packet comes back.<BR>&gt;<BR>&g=
t; If the sender only sends 10 kbyte because the TCP window size doesn't pe=
rmit<BR>&gt; sending more, these 10 kbyte are sent in ~ 0.1 ms, and then it=
 has to <BR>&gt; wait for 0.9 ms for the ACKs to come in - send again for 0=
.1 ms, wait 0.9 ms<BR>&gt; (roughly). So it's only using 10% of the availab=
le sending capacity, and<BR>&gt; the performance sucks.<BR>&gt;<BR>&gt;<BR>=
&gt; So, in your examples, my guess is that the TCP window size is "barely =
large<BR>&gt; enough" for the "direct" case (but the link is not fully satu=
rated unless<BR>&gt; you increase the window size) - and since OpenVPN adds=
 some noticeable<BR>&gt; delay, the bandwidth * delay product goes up, and =
so needs the window size<BR>&gt; to be able to fully saturate the link...<B=
R>&gt; <BR>I wonder if the iPerf results only apply to iPerf tests... Linux=
<BR>autotunes TCP parameters, including send and receive windows[1].<BR>How=
ever, increasing the maximum TCP buffer / memory size may be useful<BR>some=
times [2]. Also, an application can choose to use a smaller buffer<BR>than =
the OS default [2]: apparently iPerf does this. Windows also<BR>autotunes i=
t's TCP parameters[3], although manual editing is an option[4].<BR><BR>Russ=
ell: perhaps you could try tuning the OS-level TCP buffer size and<BR>then =
test the results with a few different real-world applications (e.g.<BR>netc=
at, scp)?<BR><BR>[1] &lt;<A href=3D"http://server.home:8080/redir.hsp?url=
=3Dhttp%3A%2F%2Fwww.psc.edu%2Fnetworking%2Fprojects%2Ftcptune%2F#Linux" tar=
get=3D_blank>http://www.psc.edu/networking/projects/tcptune/#Linux</A>&gt;<=
BR>[2] &lt;<A href=3D"http://server.home:8080/redir.hsp?url=3Dhttp%3A%2F%2F=
www.psc.edu%2Fnetworking%2Fprojects%2Ftcptune%2F#options" target=3D_blank>h=
ttp://www.psc.edu/networking/projects/tcptune/#options</A>&gt;<BR>[3] &lt;<=
A href=3D"http://server.home:8080/redir.hsp?url=3Dhttp%3A%2F%2Ffasterdata.e=
s.net%2FTCP-tuning%2F" target=3D_blank>http://fasterdata.es.net/TCP-tuning/=
</A>&gt;<BR>[4]<BR>&lt;<A href=3D"http://server.home:8080/redir.hsp?url=3Dh=
ttp%3A%2F%2Fwww.psc.edu%2Fnetworking%2Fprojects%2Ftcptune%2FOStune%2Fwinxp%=
2Fwinxp_stepbystep.html" target=3D_blank>http://www.psc.edu/networking/proj=
ects/tcptune/OStune/winxp/winxp_stepbystep.html</A>&gt;<BR><BR><FONT color=
=3D#999999>--<BR>Samuli Sepp=C3=A4nen<BR>Community Manager<BR>OpenVPN Techn=
ologies, Inc<BR><BR>irc freenode net: mattock<BR><BR><BR>------------------=
------------------------------------------------------------<BR>Start uncov=
ering the many advantages of virtual appliances<BR>and start using them to =
simplify application deployment and<BR>accelerate your shift to cloud compu=
ting<BR><A href=3D"http://server.home:8080/redir.hsp?url=3Dhttp%3A%2F%2Fp.s=
f.net%2Fsfu%2Fnovell-sfdev2dev" target=3D_blank>http://p.sf.net/sfu/novell-=
sfdev2dev</A><BR>_______________________________________________<BR>Openvpn=
-devel mailing list<BR><A href=3D"mailto:Openvpn-devel@...475...=
t">Openvpn-devel@lists.sourceforge.net</A><BR><A href=3D"http://server.home=
:8080/redir.hsp?url=3Dhttps%3A%2F%2Flists.sourceforge.net%2Flists%2Flistinf=
o%2Fopenvpn-devel" target=3D_blank>https://lists.sourceforge.net/lists/list=
info/openvpn-devel</A><BR></FONT></DIV></BLOCKQUOTE></DIV></body></html>=

--===axigen=1317172144156885327013986446358889362986=axigen===--


