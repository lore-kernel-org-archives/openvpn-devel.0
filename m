MIME-Version: 1.0
In-Reply-To: <20170328065648.GR93896@...1296...>
References: <1490444478-13188-1-git-send-email-chipitsine@...277...>
	<20170325131746.GC93896@...1296...>
	<5cbc00da-6297-c90a-611c-63ed9b0136a0@...2080...>
	<20170328060459.GM93896@...1296...>
	<CAFHpkQEWMDMs9k=6g3e5a2iMuVWMxP6zzOWZayYyL79r1U7vRg@...278...>
	<20170328065648.GR93896@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 28 Mar 2017 12:04:52 +0500
Message-ID: <CAFHpkQE9uFNLvTpmoUb3wKadQG4QHyQ6iu1dDsQnRh3hoPGOvA@...278...>
Content-Type: multipart/alternative; boundary=94eb2c1b41c49987de054bc51319
Subject: Re: [Openvpn-devel] [PATCH] resolve format string warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c1b41c49987de054bc51319
Content-Type: text/plain; charset=UTF-8

2017-03-28 11:56 GMT+05:00 Gert Doering <gert@...1296...>:

> Hi,
>
> On Tue, Mar 28, 2017 at 11:43:11AM +0500, ???????? ?????????????? wrote:
> > > (See how dangerous "fixing compiler warnings" is?  :-) )
> >
> > this particular warning came from cppcheck, it's not a compiler warning
>
> Same thing.  A tool that issues a warning which is not relevant the
> way the variables in question are used (because the values stored are
> always way below where signed/unsiged gets relevant) - but trying to fix
> it, I've misread the surrounding code and the "fixed" code would quite
> likely have crashed, or silently corrupted nearby variables.
>
>
cppcheck says "variable is signed, but format specification is unsigned"
so, I had a look around, it is "byte" variable, which cannot be signed, so
I decided to change it "int" --> "unsigned int"

later, Gert Doering suggested to switch to uit8_t

probably, we need to leave variable as is, just change format specification
"%x" --> "%d" ?



> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025                        gert@...1816...
> muenchen.de
>

--94eb2c1b41c49987de054bc51319
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-03-28 11:56 GMT+05:00 Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Tue, Mar 28, 2017 at 11:43:11AM +0500, ???????? ?????????????? wrote:<br>
&gt; &gt; (See how dangerous &quot;fixing compiler warnings&quot; is?=C2=A0=
 :-) )<br>
&gt;<br>
&gt; this particular warning came from cppcheck, it&#39;s not a compiler wa=
rning<br>
<br>
</span>Same thing.=C2=A0 A tool that issues a warning which is not relevant=
 the<br>
way the variables in question are used (because the values stored are<br>
always way below where signed/unsiged gets relevant) - but trying to fix<br>
it, I&#39;ve misread the surrounding code and the &quot;fixed&quot; code wo=
uld quite<br>
likely have crashed, or silently corrupted nearby variables.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br></div></div></blockquote><div><=
br></div><div>cppcheck says &quot;variable is signed, but format specificat=
ion is unsigned&quot;<br></div><div>so, I had a look around, it is &quot;by=
te&quot; variable, which cannot be signed, so I decided to change it &quot;=
int&quot; --&gt; &quot;unsigned int&quot;<br><br></div><div>later, Gert Doe=
ring suggested to switch to uit8_t<br><br></div><div>probably, we need to l=
eave variable as is, just change format specification &quot;%x&quot; --&gt;=
 &quot;%d&quot; ?<br></div><div><br>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><div class=3D"HOEnZb"><div class=3D"h5">
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
fax: +49-89-35655025=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...2165...=
6...<wbr>muenchen.de</a><br>
</div></div></blockquote></div><br></div></div>

--94eb2c1b41c49987de054bc51319--

