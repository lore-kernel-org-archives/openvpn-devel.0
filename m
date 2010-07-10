MIME-Version: 1.0
Sender: ichiga2@...277...
In-Reply-To: <20100710121754.GB361@...1296...>
References: <4C3843A5.50700@...1388...>
	<20100710102921.GZ361@...1296...> 
	<4C3862BF.40401@...1388...> <20100710121754.GB361@...1296...>
From: Kazuyoshi Aizawa <admin2@...628...>
Date: Sat, 10 Jul 2010 22:21:06 +0900
Message-ID: <AANLkTilD4ljKisYrGFq2pnnMszNRdHMbgg-MeWZPT1Z3@...278...>
Content-Type: multipart/alternative; boundary=0016362843d28725dc048b0865e7
Subject: Re: [Openvpn-devel] feat_ipv6_payload problems on Solaris 10
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--0016362843d28725dc048b0865e7
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I'm happy to hear that the driver worked fine.
Please let me know if there's any problem on it.

Regards,

Kazuyoshi

2010/7/10 Gert Doering <gert@...1296...>

> Hi,
>
> On Sun, Jul 11, 2010 at 12:08:31AM +1200, Michal Ludvig wrote:
> > >> I'm having a problem with feat_ipv6_payload branch (checked out from
> git
> > >> yesterday). One end is Solaris 10 (sparc) and the other end is Linux.
> > > Which version of the tun driver are you using for Solaris?
> > >
> > > My test solaris machine (Solaris 10 on Sparc64, but not the very latest
> > > version) uses the driver from
> http://www.whiteboard.ne.jp/~admin2/tuntap/<http://www.whiteboard.ne.jp/%7Eadmin2/tuntap/>
> > > and IPv6 works fine there.  The web page says that this driver did not
> > > support IPv6 before 11/16/2009 - so maybe this is the problem.
> > That was it! Works now:
> >
> > [Linux] ~ # ping6 -n 2001:cafe::1
> > PING 2001:cafe::1(2001:cafe::1) 56 data bytes
> > 64 bytes from 2001:cafe::1: icmp_seq=343 ttl=255 time=54.3 ms
> > 64 bytes from 2001:cafe::1: icmp_seq=344 ttl=255 time=50.1 ms
> > ^C
>
> Cool :-) - congratulations!
>
> (And thanks for testing point-to-point tun mode - I assumed it would
> work, but it's still on my test-plan...)
>
> > I used to have CSWtun from Blastwave - it's labeled as version 1.1 as
> > well so I believed it was the right thing.
>
> Hmmm.  I wasn't aware that that one exists - but it might be worth a try
> to send them a note that they might want to do some updates.
>
> > Is there any way to check that the right module is loaded at runtime?
> > That may help avoid some confusion in the future...
>
> Good questions.  I don't know right now, but I'll try to find out.
>
> > (BTW is there any work in progress for a v6 transport?)
>
> Well, there's feat_ipv6_transport by jjo, and of course, the "allmerged"
> branch which has both v6 payload and v6 transport.  As far as I understand,
> the v6 transport stuff works on all "major" platforms supported by
> OpenVPN and generally gets the job done :-)
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                           //
> www.muc.de/~gert/ <http://www.muc.de/%7Egert/>
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025
> gert@...1297...
>
>
> ------------------------------------------------------------------------------
> This SF.net email is sponsored by Sprint
> What will you do first with EVO, the first 4G phone?
> Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--0016362843d28725dc048b0865e7
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I&#39;m happy to hear that the driver worked fine.<br>Please let=
 me know if there&#39;s any problem on it.<br><br>Regards,<br><br>Kazuyoshi=
<br><br><div class=3D"gmail_quote">2010/7/10 Gert Doering <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt;</span><br>

<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">Hi,<br>
<div class=3D"im"><br>
On Sun, Jul 11, 2010 at 12:08:31AM +1200, Michal Ludvig wrote:<br>
&gt; &gt;&gt; I&#39;m having a problem with feat_ipv6_payload branch (check=
ed out from git<br>
&gt; &gt;&gt; yesterday). One end is Solaris 10 (sparc) and the other end i=
s Linux.<br>
&gt; &gt; Which version of the tun driver are you using for Solaris?<br>
&gt; &gt;<br>
&gt; &gt; My test solaris machine (Solaris 10 on Sparc64, but not the very =
latest<br>
&gt; &gt; version) uses the driver from <a href=3D"http://www.whiteboard.ne=
.jp/%7Eadmin2/tuntap/" target=3D"_blank">http://www.whiteboard.ne.jp/~admin=
2/tuntap/</a><br>
&gt; &gt; and IPv6 works fine there. =A0The web page says that this driver =
did not<br>
&gt; &gt; support IPv6 before 11/16/2009 - so maybe this is the problem.<br>
&gt; That was it! Works now:<br>
&gt;<br>
&gt; [Linux] ~ # ping6 -n 2001:cafe::1<br>
&gt; PING 2001:cafe::1(2001:cafe::1) 56 data bytes<br>
&gt; 64 bytes from 2001:cafe::1: icmp_seq=3D343 ttl=3D255 time=3D54.3 ms<br>
&gt; 64 bytes from 2001:cafe::1: icmp_seq=3D344 ttl=3D255 time=3D50.1 ms<br>
&gt; ^C<br>
<br>
</div>Cool :-) - congratulations!<br>
<br>
(And thanks for testing point-to-point tun mode - I assumed it would<br>
work, but it&#39;s still on my test-plan...)<br>
<div class=3D"im"><br>
&gt; I used to have CSWtun from Blastwave - it&#39;s labeled as version 1.1=
 as<br>
&gt; well so I believed it was the right thing.<br>
<br>
</div>Hmmm. =A0I wasn&#39;t aware that that one exists - but it might be wo=
rth a try<br>
to send them a note that they might want to do some updates.<br>
<div class=3D"im"><br>
&gt; Is there any way to check that the right module is loaded at runtime?<=
br>
&gt; That may help avoid some confusion in the future...<br>
<br>
</div>Good questions. =A0I don&#39;t know right now, but I&#39;ll try to fi=
nd out.<br>
<div class=3D"im"><br>
&gt; (BTW is there any work in progress for a v6 transport?)<br>
<br>
</div>Well, there&#39;s feat_ipv6_transport by jjo, and of course, the &quo=
t;allmerged&quot;<br>
branch which has both v6 payload and v6 transport. =A0As far as I understan=
d,<br>
the v6 transport stuff works on all &quot;major&quot; platforms supported b=
y<br>
OpenVPN and generally gets the job done :-)<br>
<div class=3D"im"><br>
gert<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 //<a href=3D"http://www.muc.de/=
%7Egert/" target=3D"_blank">www.muc.de/~gert/</a><br>
Gert Doering - Munich, Germany =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 <a href=3D"mailto:gert@...1296...">gert@...1296...</a><br>
fax: +49-89-35655025 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<a href=
=3D"mailto:gert@...1297...">gert@...1297...</a><br>
<br>
</div><div><div></div><div class=3D"h5">-----------------------------------=
-------------------------------------------<br>
This SF.net email is sponsored by Sprint<br>
What will you do first with EVO, the first 4G phone?<br>
Visit <a href=3D"http://sprint.com/first" target=3D"_blank">sprint.com/firs=
t</a> -- <a href=3D"http://p.sf.net/sfu/sprint-com-first" target=3D"_blank"=
>http://p.sf.net/sfu/sprint-com-first</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a=
><br>
<br>
</div></div></blockquote></div><br>

--0016362843d28725dc048b0865e7--

