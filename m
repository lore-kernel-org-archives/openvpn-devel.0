MIME-Version: 1.0
In-Reply-To: <20161217100520.GR78624@...1296...>
References: <f5ca3f0f-dd01-e82e-b339-68f5791e0928@...1435...>
	<20161216182659.18194-1-jm@...1926...>
	<dfbcd54a-29c2-d8e5-1200-66f217832063@...1435...>
	<44d2e307-1954-de7f-9979-68728de900b3@...1926...>
	<20161217100520.GR78624@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sat, 17 Dec 2016 16:26:46 +0500
Message-ID: <CAFHpkQGMJYrnhCZnvJZf+=c_rsYY6FxG98bO0LHqk_aNSmvsUQ@...278...>
Content-Type: multipart/alternative; boundary=001a11466fd642d6b80543d8f6a6
Subject: Re: [Openvpn-devel] [PATCH] Build with a few -Werror= flags if the
 compiler supports them
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

--001a11466fd642d6b80543d8f6a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

17 =D0=B4=D0=B5=D0=BA. 2016 =D0=B3. 15:07 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=
=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "Gert Doering" <gert@...1296...>
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

Hi,

On Fri, Dec 16, 2016 at 11:16:08PM +0100, Julien Muchembled wrote:
> BTW, instead of failing on these 3 specific warnings, we could go the
opposite way, since -Wall is quite silent. I suggest:
>
>   -Wall -Wno-unused -Wno-pointer-sign -Werror -Wno-error=3Dstrict-aliasing
-Werror=3Dformat-security

NAK to "-Wall -Werror", unless you've tested that this does not break
compilation on any of the supported platforms.

The world is bigger than Linux.



There should be high level autoconf magic, which will add option if chosen
compiler supports it.

I'm particurlarly afraid of cross compilers like mingw


gert

--
USENET is *not* the non-clickable part of WWW!
                                                           //
www.muc.de/~gert/
Gert Doering - Munich, Germany
gert@...1296...
fax: +49-89-35655025                        gert@...1816...
muenchen.de

------------------------------------------------------------
------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--001a11466fd642d6b80543d8f6a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">17 =D0=B4=D0=B5=D0=BA. 2016 =D0=B3. 15:07 =D0=BF=D0=BE=D0=BB=D1=
=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C &quot;Gert Doering&quot=
; &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:<br type=3D"attribution"><blockquote clas=
s=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">Hi,<br>
<div class=3D"quoted-text"><br>
On Fri, Dec 16, 2016 at 11:16:08PM +0100, Julien Muchembled wrote:<br>
&gt; BTW, instead of failing on these 3 specific warnings, we could go the =
opposite way, since -Wall is quite silent. I suggest:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0-Wall -Wno-unused -Wno-pointer-sign -Werror -Wno-error=3Ds=
trict-aliasing -Werror=3Dformat-security<br>
<br>
</div>NAK to &quot;-Wall -Werror&quot;, unless you&#39;ve tested that this =
does not break<br>
compilation on any of the supported platforms.<br>
<br>
The world is bigger than Linux.<br>
<font color=3D"#888888"></font></blockquote></div></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto">There should b=
e high level autoconf magic, which will add option if chosen compiler suppo=
rts it.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I&#39;m particur=
larly afraid of cross compilers like mingw</div><div dir=3D"auto"><div clas=
s=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><font=
 color=3D"#888888"><br>
gert<br>
<br>
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
fax: +49-89-35655025=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...2165...=
6...<wbr>muenchen.de</a><br>
</font><br>------------------------------<wbr>-----------------------------=
-<wbr>------------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, SlashDot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>_________=
_____________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
<br></blockquote></div><br></div></div></div>

--001a11466fd642d6b80543d8f6a6--

