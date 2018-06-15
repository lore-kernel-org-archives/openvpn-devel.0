MIME-Version: 1.0
References: <99D61A626FDA8A4B90A270669121BE1089628FC9@...2294...>
 <DM5PR2101MB11127F120677A779CB43A8D4B07D0@...2412...>
 <431d0dae-f48c-a550-a2fc-5e9ec78206e7@...515...>
In-Reply-To: <431d0dae-f48c-a550-a2fc-5e9ec78206e7@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 15 Jun 2018 12:14:21 +0500
Message-ID: <CAFHpkQF8aUA+nbcj-LY5VugUP5Oq8iBsnKWW25CxsgEW05hnpw@...278...>
Content-Type: multipart/alternative; boundary="000000000000baf590056ea8f7a6"
Subject: Re: [Openvpn-devel] tap-windows6 and AppVeyor
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: jkunkee@...2393..., Simon Rozman <simon@...2293...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000baf590056ea8f7a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi,

I have some very amazing expirience with app veyor when I was playing with
mingw builds.
there was an issue related to mingw and I saw it between builds (mingw
upgraded), so I first decided "could it be app veyor ?!"

people from app veyor were very helpful in troubleshooting that.


so, I guess we can try to open an issue in their tracker this time as well.


as for network share - due to "wanna cry" and similar malwares, network
shares are blocked over internet usually.
another option might be to try build services at https://visualstudio.com

=D0=BF=D1=82, 15 =D0=B8=D1=8E=D0=BD. 2018 =D0=B3. =D0=B2 11:28, Samuli Sepp=
=C3=A4nen <samuli@...515...>:

> Perhaps we could make the ISO available as a network share?
>
> Il 14/06/2018 23:43, Jon Kunkee ha scritto:
> > As I read the license (IANAL), consumers of the EWDK can copy,
> 'install', and run
> > it pretty much anywhere in support of building software for Windows,
> just not
> > as a public download.
> >
> > A 5GB download is prohibitive, but do note that 'unpacking' is as simple
> as
> > mounting the ISO file.
> >
> > -----Original Message-----
> > From: Simon Rozman <simon@...2293...>
> > Sent: Thursday, June 14, 2018 10:35 AM
> > To: chipitsine@...277...; Jon Kunkee <jkunkee@...2393...>
> > Cc: Samuli Sepp=C3=A4nen (samuli@...515...) <samuli@...515...>;
> openvpn-devel (openvpn-devel@lists.sourceforge.net) <
> openvpn-devel@lists.sourceforge.net>
> > Subject: tap-windows6 and AppVeyor
> >
> > Hi!
> >
> > Given all the recent updates to tap-windows6 building process, the
> AppVeyor
> > integration needs an update too.
> >
> > Now the Microsoft EWDK is used to build the driver, I wasn't able to fi=
nd
> > any such build environment on AppVeyor.
> >
> > If the EWDK licence allows us, we could put EWDK online and have the
> > AppVeyor download and unpack it before build. Although portable, the
> EWDK is
> > 5GB making this option far from ideal.
> >
> > Or, we could politely ask AppVeyor to introduce an EWDK building
> > environment. :)
> >
> > Does anybody have any idea how to address this challenge?
> >
> > Best regards,
> > Simon
> >
>
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>

--000000000000baf590056ea8f7a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>hi,</div><div><br></div><div>I have some very amazing=
 expirience with app veyor when I was playing with mingw builds.</div><div>=
there was an issue related to mingw and I saw it between builds (mingw upgr=
aded), so I first decided &quot;could it be app veyor ?!&quot;</div><div><b=
r></div><div>people from app veyor were very helpful in troubleshooting tha=
t.</div><div><br></div><div><br></div><div>so, I guess we can try to open a=
n issue in their tracker this time as well.</div><div><br></div><div><br></=
div><div>as for network share - due to &quot;wanna cry&quot; and similar ma=
lwares, network shares are blocked over internet usually.</div><div>another=
 option might be to try build services at <a href=3D"https://visualstudio.c=
om">https://visualstudio.com</a><br></div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr">=D0=BF=D1=82, 15 =D0=B8=D1=8E=D0=BD. 2018 =D0=B3. =D0=
=B2 11:28, Samuli Sepp=C3=A4nen &lt;<a href=3D"mailto:samuli@...515...">sam=
uli@...515...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Perhaps we c=
ould make the ISO available as a network share?<br>
<br>
Il 14/06/2018 23:43, Jon Kunkee ha scritto:<br>
&gt; As I read the license (IANAL), consumers of the EWDK can copy, &#39;in=
stall&#39;, and run <br>
&gt; it pretty much anywhere in support of building software for Windows, j=
ust not <br>
&gt; as a public download.<br>
&gt; <br>
&gt; A 5GB download is prohibitive, but do note that &#39;unpacking&#39; is=
 as simple as <br>
&gt; mounting the ISO file.<br>
&gt; <br>
&gt; -----Original Message-----<br>
&gt; From: Simon Rozman &lt;<a href=3D"mailto:simon@...2293..." target=3D"_=
blank">simon@...2293...</a>&gt; <br>
&gt; Sent: Thursday, June 14, 2018 10:35 AM<br>
&gt; To: <a href=3D"mailto:chipitsine@...277..." target=3D"_blank">chipitsi=
ne@...277...</a>; Jon Kunkee &lt;<a href=3D"mailto:jkunkee@...2393..." targ=
et=3D"_blank">jkunkee@...2393...</a>&gt;<br>
&gt; Cc: Samuli Sepp=C3=A4nen (<a href=3D"mailto:samuli@...515..." target=
=3D"_blank">samuli@...515...</a>) &lt;<a href=3D"mailto:samuli@...515..." t=
arget=3D"_blank">samuli@...515...</a>&gt;; openvpn-devel (<a href=3D"mailto=
:openvpn-devel@lists.sourceforge.net" target=3D"_blank">openvpn-devel@...1697...=
.sourceforge.net</a>) &lt;<a href=3D"mailto:openvpn-devel@...282...=
.net" target=3D"_blank">openvpn-devel@lists.sourceforge.net</a>&gt;<br>
&gt; Subject: tap-windows6 and AppVeyor<br>
&gt; <br>
&gt; Hi!<br>
&gt; <br>
&gt; Given all the recent updates to tap-windows6 building process, the App=
Veyor<br>
&gt; integration needs an update too.<br>
&gt; <br>
&gt; Now the Microsoft EWDK is used to build the driver, I wasn&#39;t able =
to find<br>
&gt; any such build environment on AppVeyor.<br>
&gt; <br>
&gt; If the EWDK licence allows us, we could put EWDK online and have the<b=
r>
&gt; AppVeyor download and unpack it before build. Although portable, the E=
WDK is<br>
&gt; 5GB making this option far from ideal.<br>
&gt; <br>
&gt; Or, we could politely ask AppVeyor to introduce an EWDK building<br>
&gt; environment. :)<br>
&gt; <br>
&gt; Does anybody have any idea how to address this challenge?<br>
&gt; <br>
&gt; Best regards,<br>
&gt; Simon<br>
&gt; <br>
<br>
<br>
-- <br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
</blockquote></div>

--000000000000baf590056ea8f7a6--

