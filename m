MIME-Version: 1.0
In-Reply-To: <044c01d264f3$225e1f70$671a5e50$@gmail.com>
References: <024d01d26459$2589a3d0$709ceb70$@gmail.com>
	<20170101182035.GE78624@...1296...>
	<028801d2645d$6c491270$44db3750$@gmail.com>
	<82a76c5a-f03d-2b6c-a729-8417ca31dabc@...515...>
	<044c01d264f3$225e1f70$671a5e50$@gmail.com>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 2 Jan 2017 15:47:31 +0300
Message-ID: <CAFHpkQF-o5p63-XviFQrZ+B1mqyvweUTsASOZgt6GCDtJvSgBQ@...278...>
Content-Type: multipart/alternative; boundary=047d7bf10b4e84cbe505451bf456
Subject: Re: [Openvpn-devel] Visual Studio support?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fish Wang <fish.thss@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7bf10b4e84cbe505451bf456
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-01-02 15:24 GMT+03:00 Fish Wang <fish.thss@...277...>:

> Hi Samuli,
>
> I have my own building scripts. I think they are based on an old version =
of
> openvpn-build/msvc. I definitely made quite a few changes to make them
> work.
>

can you try them at https://ci.appveyor.com ?
if we will not run those scripts on every build, it will become broken soon


>
> Best,
> Fish
>
> -----Original Message-----
> From: Samuli Sepp=C3=A4nen [mailto:samuli@...515...]
> Sent: Monday, January 2, 2017 2:54 AM
> To: Fish Wang <fish.thss@...277...>; 'Gert Doering' <gert@...1296...>
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] Visual Studio support?
>
> Hi,
>
> Il 01/01/2017 20:32, Fish Wang ha scritto:
> > Thanks for your (and Steffan's) reply.
> >
> > I also noticed that 2.4 and 2.5 only supports Vista+, so it might make
> > sense to remove dynamic function loading for WPF in openvpnserv (see
> > all those LoadLibrary and GetProcAddress code in [1]). But somehow I
> > have an impression that openvpnserv is no longer supported and
> > openvpnserv2 should be used instead, so such a patch is not useful. What
> do you think?
> >
> > Best,
> > Fish
>
> How do you build OpenVPN using Visual Studio? I'm asking because we have
> the
> "left-to-rot" MSVC build scripts here:
>
> <https://github.com/OpenVPN/openvpn-build/tree/master/msvc>
>
> Do you use the above scripts, or just import the code to Visual Studio and
> set some settings there to make it all work?
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>
> >
> > [1]
> > https://github.com/OpenVPN/openvpn/blob/master/src/openvpnserv/interac
> > tive.c
> >
> > -----Original Message-----
> > From: Gert Doering [mailto:gert@...1296...]
> > Sent: Sunday, January 1, 2017 10:21 AM
> > To: Fish Wang <fish.thss@...277...>
> > Cc: openvpn-devel@lists.sourceforge.net
> > Subject: Re: [Openvpn-devel] Visual Studio support?
> >
> > Hi,
> >
> > On Sun, Jan 01, 2017 at 10:01:57AM -0800, Fish Wang wrote:
> >> I'm finishing up a patch to make sure OpenVPN compiles under Visual
> > Studio.
> >> I have several questions;
> >>
> >> - Do you want to apply such a patch to master and/or release/2.4, or
> >> should I maintain it separately?
> >
> > Unless it's highly intrusive, it makes sense to merge it.
> >
> > Since we're not compiling with VS, we sometimes break stuff, but this
> > is not intentional :-)
> >
> >> - What is the minimum version of Visual Studio do we want to support?
> >
> > I have no idea.  Something recent, which can do C99, as that's the
> > coding standard we've change to for 2.4 and master-after-2.4
> >
> >> - Should such a patch be developed against maste, release/2.4 branch,
> >> or both?
> >
> > Master (as always).
> >
> > gert
> >
> > --
> > USENET is *not* the non-clickable part of WWW!
> >
> > //www.muc.de/~gert/ <http://www.muc.de/%7Egert/>
> > Gert Doering - Munich, Germany
> > gert@...1296...
> > fax: +49-89-35655025
> > gert@...1297...
> >
> >
> > ----------------------------------------------------------------------
> > -------- Check out the vibrant tech community on one of the world's
> > most engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >
>
>
>
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--047d7bf10b4e84cbe505451bf456
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-01-02 15:24 GMT+03:00 Fish Wang <span dir=3D"ltr">&lt;<a target=3D=
"_blank" href=3D"mailto:fish.thss@...277...">fish.thss@...277...</a>&gt;</s=
pan>:<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote">Hi Samuli,<br>
<br>
I have my own building scripts. I think they are based on an old version of=
<br>
openvpn-build/msvc. I definitely made quite a few changes to make them work=
.<br></blockquote><div><br></div><div>can you try them at <a href=3D"https:=
//ci.appveyor.com">https://ci.appveyor.com</a> ?<br></div><div>if we will n=
ot run those scripts on every build, it will become broken soon<br></div><d=
iv>=C2=A0</div><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote">
<br>
Best,<br>
Fish<br>
<span class=3D"gmail-"><br>
-----Original Message-----<br>
From: Samuli Sepp=C3=A4nen [mailto:<a href=3D"mailto:samuli@...515...">samu=
li@...515...</a>]<br>
Sent: Monday, January 2, 2017 2:54 AM<br>
To: Fish Wang &lt;<a href=3D"mailto:fish.thss@...277...">fish.thss@...1663...=
.</a>&gt;; &#39;Gert Doering&#39; &lt;<a href=3D"mailto:gert@...1296...">ge=
rt@...1296...</a>&gt;<br>
Cc: <a href=3D"mailto:openvpn-devel@lists.sourceforge.net">openvpn-devel@...1186...=
.1199...<wbr>sourceforge.net</a><br>
Subject: Re: [Openvpn-devel] Visual Studio support?<br>
<br>
Hi,<br>
<br>
</span><div><div class=3D"gmail-h5">Il 01/01/2017 20:32, Fish Wang ha scrit=
to:<br>
&gt; Thanks for your (and Steffan&#39;s) reply.<br>
&gt;<br>
&gt; I also noticed that 2.4 and 2.5 only supports Vista+, so it might make=
<br>
&gt; sense to remove dynamic function loading for WPF in openvpnserv (see<b=
r>
&gt; all those LoadLibrary and GetProcAddress code in [1]). But somehow I<b=
r>
&gt; have an impression that openvpnserv is no longer supported and<br>
&gt; openvpnserv2 should be used instead, so such a patch is not useful. Wh=
at<br>
do you think?<br>
&gt;<br>
&gt; Best,<br>
&gt; Fish<br>
<br>
How do you build OpenVPN using Visual Studio? I&#39;m asking because we hav=
e the<br>
&quot;left-to-rot&quot; MSVC build scripts here:<br>
<br>
&lt;<a target=3D"_blank" rel=3D"noreferrer" href=3D"https://github.com/Open=
VPN/openvpn-build/tree/master/msvc">https://github.com/OpenVPN/<wbr>openvpn=
-build/tree/master/msvc</a><wbr>&gt;<br>
<br>
Do you use the above scripts, or just import the code to Visual Studio and<=
br>
set some settings there to make it all work?<br>
<br>
--<br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
<br>
<br>
&gt;<br>
&gt; [1]<br>
&gt; <a target=3D"_blank" rel=3D"noreferrer" href=3D"https://github.com/Ope=
nVPN/openvpn/blob/master/src/openvpnserv/interac">https://github.com/OpenVP=
N/<wbr>openvpn/blob/master/src/<wbr>openvpnserv/interac</a><br>
&gt; tive.c<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: Gert Doering [mailto:<a href=3D"mailto:gert@...1296...">gert@...493...=
1296...</a>]<br>
&gt; Sent: Sunday, January 1, 2017 10:21 AM<br>
&gt; To: Fish Wang &lt;<a href=3D"mailto:fish.thss@...277...">fish.thss@...493...=
277...</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:openvpn-devel@lists.sourceforge.net">openvpn-dev=
el@...1199...<wbr>sourceforge.net</a><br>
&gt; Subject: Re: [Openvpn-devel] Visual Studio support?<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; On Sun, Jan 01, 2017 at 10:01:57AM -0800, Fish Wang wrote:<br>
&gt;&gt; I&#39;m finishing up a patch to make sure OpenVPN compiles under V=
isual<br>
&gt; Studio.<br>
&gt;&gt; I have several questions;<br>
&gt;&gt;<br>
&gt;&gt; - Do you want to apply such a patch to master and/or release/2.4, =
or<br>
&gt;&gt; should I maintain it separately?<br>
&gt;<br>
&gt; Unless it&#39;s highly intrusive, it makes sense to merge it.<br>
&gt;<br>
&gt; Since we&#39;re not compiling with VS, we sometimes break stuff, but t=
his<br>
&gt; is not intentional :-)<br>
&gt;<br>
&gt;&gt; - What is the minimum version of Visual Studio do we want to suppo=
rt?<br>
&gt;<br>
&gt; I have no idea.=C2=A0 Something recent, which can do C99, as that&#39;=
s the<br>
&gt; coding standard we&#39;ve change to for 2.4 and master-after-2.4<br>
&gt;<br>
&gt;&gt; - Should such a patch be developed against maste, release/2.4 bran=
ch,<br>
&gt;&gt; or both?<br>
&gt;<br>
&gt; Master (as always).<br>
&gt;<br>
&gt; gert<br>
&gt;<br>
&gt; --<br>
&gt; USENET is *not* the non-clickable part of WWW!<br>
&gt;<br>
&gt; //<a target=3D"_blank" rel=3D"noreferrer" href=3D"http://www.muc.de/%7=
Egert/">www.muc.de/~gert/</a><br>
&gt; Gert Doering - Munich, Germany<br>
&gt; <a href=3D"mailto:gert@...1296...">gert@...1296...</a><br>
&gt; fax: +49-89-35655025<br>
&gt; <a href=3D"mailto:gert@...1297...">gert@...1816...<wbr>muenchen.de</a>=
<br>
&gt;<br>
&gt;<br>
&gt; ------------------------------<wbr>------------------------------<wbr>=
----------<br>
</div></div>&gt; -------- Check out the vibrant tech community on one of th=
e world&#39;s<br>
<div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5">&gt; most engaging tech=
 sites, SlashDot.org! <a target=3D"_blank" rel=3D"noreferrer" href=3D"http:=
//sdm.link/slashdot">http://sdm.link/slashdot</a><br>
&gt; ______________________________<wbr>_________________<br>
&gt; Openvpn-devel mailing list<br>
&gt; <a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...220...=
..1199...<wbr>sourceforge.net</a><br>
&gt; <a target=3D"_blank" rel=3D"noreferrer" href=3D"https://lists.sourcefo=
rge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/<wbr>li=
sts/listinfo/openvpn-devel</a><br>
&gt;<br>
<br>
<br>
<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, SlashDot.org! <a target=3D"_blank" rel=3D"noreferrer" =
href=3D"http://sdm.link/slashdot">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a target=3D"_blank" rel=3D"noreferrer" href=3D"https://lists.sourceforge.n=
et/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/<wbr>lists/l=
istinfo/openvpn-devel</a><br>
</div></div></blockquote></div><br></div></div>

--047d7bf10b4e84cbe505451bf456--

