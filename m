MIME-Version: 1.0
In-Reply-To: <20160203074446.GQ24952@...1296...>
References: <6A88A2ADF6B64829BF9DA9EAA97BF3B0@...2089...>
	<9C407472-153C-40F9-ACE4-0A1045B23F19@...1127...>
	<0BD23D4B562943FD8C84B960FD3F4FA3@...2089...>
	<20160203074446.GQ24952@...1296...>
Date: Thu, 4 Feb 2016 08:48:10 +0800
Message-ID: <CAPTYJts=64a22vi-8X07TV7-OPKgqw+5cT7xZ-z-XU4k9A_XzA@...278...>
From: Daniel Sim <daniel.ssq89@...277...>
Content-Type: multipart/alternative; boundary=e89a8ff25462b90212052ae71610
Subject: Re: [Openvpn-devel] Just a thought - config hashing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: David Sommerseth <david@...1127...>, openvpn-devel@lists.sourceforge.net

--e89a8ff25462b90212052ae71610
Content-Type: text/plain; charset=UTF-8

It seems like... As far as the GUI is concerned, if it's already running as
admin, it should just start OpenVPN.exe directly. If it's not admin, it
should try to connect to the IService.
Hi,

On Wed, Feb 03, 2016 at 01:44:10AM -0000, debbie10t@...277... wrote:
> thankyou for your detailed reply ..I looked up eurephia :-) nice
> and did a little more research and discovered anonyproz.com
> The idea has some merit but it is not for the core openvpn team.
> I see that now .. I am, as ever, still learning and, on this occasion,
> maybe seeing things a little more clearly ..
> Ironically, this maybe one idea where open vs closed source
> "shows it's teeth" a little. C'est la vie and thanks for your time ..
> mvh :D

Well, with a "closed" package, the VPN server could (sort of) trust the
VPN client - but the *user* cannot trust the client, so hast to believe
the vendor claims "it is totally secure!"...

gert
--
USENET is *not* the non-clickable part of WWW!
                                                           //
www.muc.de/~gert/
Gert Doering - Munich, Germany
gert@...1296...
fax: +49-89-35655025
gert@...1297...

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--e89a8ff25462b90212052ae71610
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">It seems like... As far as the GUI is concerned, if it&#39;s=
 already running as admin, it should just start OpenVPN.exe directly. If it=
&#39;s not admin, it should try to connect to the IService.</p>
<div class=3D"gmail_quot&lt;blockquote class=3D" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
On Wed, Feb 03, 2016 at 01:44:10AM -0000, <a href=3D"mailto:debbie10t@...1664...=
7...">debbie10t@...277...</a> wrote:<br>
&gt; thankyou for your detailed reply ..I looked up eurephia :-) nice<br>
&gt; and did a little more research and discovered <a href=3D"http://anonyp=
roz.com" rel=3D"noreferrer" target=3D"_blank">anonyproz.com</a><br>
&gt; The idea has some merit but it is not for the core openvpn team.<br>
&gt; I see that now .. I am, as ever, still learning and, on this occasion,=
<br>
&gt; maybe seeing things a little more clearly ..<br>
&gt; Ironically, this maybe one idea where open vs closed source<br>
&gt; &quot;shows it&#39;s teeth&quot; a little. C&#39;est la vie and thanks=
 for your time ..<br>
&gt; mvh :D<br>
<br>
Well, with a &quot;closed&quot; package, the VPN server could (sort of) tru=
st the<br>
VPN client - but the *user* cannot trust the client, so hast to believe<br>
the vendor claims &quot;it is totally secure!&quot;...<br>
<br>
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
<br>-----------------------------------------------------------------------=
-------<br>
Site24x7 APM Insight: Get Deep Visibility into Application Performance<br>
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month<br>
Monitor end-to-end web transactions and take corrective actions now<br>
Troubleshoot faster and improve end-user experience. Signup Now!<br>
<a href=3D"http://pubads.g.doubleclick.net/gampad/clk?id=3D267308311&amp;iu=
=3D/4140" rel=3D"noreferrer" target=3D"_blank">http://pubads.g.doubleclick.=
net/gampad/clk?id=3D267308311&amp;iu=3D/4140</a><br>_______________________=
________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
<br></div>

--e89a8ff25462b90212052ae71610--

