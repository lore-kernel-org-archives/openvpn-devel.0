MIME-Version: 1.0
In-Reply-To: <20150827125842.GL34798@...1296...>
References: <CAAWBBYNiMbWmBgtp1cMc=Pz9V5dBwr71nOfdEOVWYfWg=_HtNA@...278...>
	<55DD7A68.5060603@...1227...> <55DE2D14.7050804@...1490...>
	<20150827125842.GL34798@...1296...>
Date: Thu, 27 Aug 2015 07:48:10 -0700
Message-ID: <CAAF3xa-h+YtJXvHKrScqeiw-D1GhKAEmXa1v5GkP+sM3PVCJ_A@...278...>
From: Marvin <volleynbike@...277...>
Content-Type: multipart/alternative; boundary=089e01229aaa565c69051e4c0ea6
Subject: Re: [Openvpn-devel] [PATCH] Added two features to Network Address
	Translator
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

--089e01229aaa565c69051e4c0ea6
Content-Type: text/plain; charset=UTF-8

In certain cases we did exactly that.  We used a linux appliance optimized
as a router + OpenVPN.  But the instances where we could get away with that
is a small percentage of our installed base.  Unfortunately the majority of
those sites require the Windows box because of other requisite proprietary
software that we have no control over.  I dare say we have long and vast
experience with both.  Both work quite well.  The Windows box version with
OpenVPN and Gava's patches have proven themselves to work well and are
quite stable.

Marvin

On Thu, Aug 27, 2015 at 5:58 AM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Thu, Aug 27, 2015 at 09:18:12AM +1200, Jason Haar wrote:
> > On 26/08/15 20:35, Arne Schwabe wrote:
> > > Okay yes. Active FTP is broken by our simple nat implementation. But I
> > > think FTP, let alone active FTP is dead. I am not sure if we should
> > > support this in our simple NAT implementation.
> > I agree. Surely this would be the beginning of a complete beat-up?
>
> I *could* argue that someone has been asking for a new DHCP option
> recently... :-)
>
> I have not looked at the code yet to see how large or invasive it is,
> but as it obviously has a fairly reasonable use case ("support old
> equipment behind state-of-the-art VPN tunnels"), I can see why the
> feature make some sort of sense.
>
> OTOH I would do it differently altogether - put an OpenWRT box into
> the network in question, OpenVPN on top of it, and use Linux iptables
> NAT to do the actualy natting back and forth and whatever is needed,
> as it will always be more powerful than what we can build into OpenVPN
> (and I'd totally not run important service stuff on windows).
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025
> gert@...1297...
>
>
> ------------------------------------------------------------------------------
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--089e01229aaa565c69051e4c0ea6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">In certain cases we did exactly that.=C2=A0 We used a linu=
x appliance optimized as a router + OpenVPN.=C2=A0 But the instances where =
we could get away with that is a small percentage of our installed base.=C2=
=A0 Unfortunately the majority of those sites require the Windows box becau=
se of other requisite proprietary software that we have no control over.=C2=
=A0 I dare say we have long and vast experience with both.=C2=A0 Both work =
quite well.=C2=A0 The Windows box version with OpenVPN and Gava&#39;s patch=
es have proven themselves to work well and are quite stable.<div><br></div>=
<div>Marvin<br><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On=
 Thu, Aug 27, 2015 at 5:58 AM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
On Thu, Aug 27, 2015 at 09:18:12AM +1200, Jason Haar wrote:<br>
&gt; On 26/08/15 20:35, Arne Schwabe wrote:<br>
&gt; &gt; Okay yes. Active FTP is broken by our simple nat implementation. =
But I<br>
&gt; &gt; think FTP, let alone active FTP is dead. I am not sure if we shou=
ld<br>
&gt; &gt; support this in our simple NAT implementation.<br>
&gt; I agree. Surely this would be the beginning of a complete beat-up?<br>
<br>
I *could* argue that someone has been asking for a new DHCP option<br>
recently... :-)<br>
<br>
I have not looked at the code yet to see how large or invasive it is,<br>
but as it obviously has a fairly reasonable use case (&quot;support old<br>
equipment behind state-of-the-art VPN tunnels&quot;), I can see why the<br>
feature make some sort of sense.<br>
<br>
OTOH I would do it differently altogether - put an OpenWRT box into<br>
the network in question, OpenVPN on top of it, and use Linux iptables<br>
NAT to do the actualy natting back and forth and whatever is needed,<br>
as it will always be more powerful than what we can build into OpenVPN<br>
(and I&#39;d totally not run important service stuff on windows).<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
gert<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<a href=3D"=
http://www.muc.de/~gert/" rel=3D"noreferrer" target=3D"_blank">www.muc.de/~=
gert/</a><br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296...">gert@...1296...</a><br>
fax: <a href=3D"tel:%2B49-89-35655025" value=3D"+498935655025">+49-89-35655=
025</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...1297...</a><br>
</font></span><br>---------------------------------------------------------=
---------------------<br>
<br>_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
<br></blockquote></div><br></div></div></div>

--089e01229aaa565c69051e4c0ea6--

