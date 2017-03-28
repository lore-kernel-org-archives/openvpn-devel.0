MIME-Version: 1.0
In-Reply-To: <20170328060459.GM93896@...1296...>
References: <1490444478-13188-1-git-send-email-chipitsine@...277...>
	<20170325131746.GC93896@...1296...>
	<5cbc00da-6297-c90a-611c-63ed9b0136a0@...2080...>
	<20170328060459.GM93896@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 28 Mar 2017 11:43:11 +0500
Message-ID: <CAFHpkQEWMDMs9k=6g3e5a2iMuVWMxP6zzOWZayYyL79r1U7vRg@...278...>
Content-Type: multipart/alternative; boundary=94eb2c1b41c40f97d2054bc4c661
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

--94eb2c1b41c40f97d2054bc4c661
Content-Type: text/plain; charset=UTF-8

2017-03-28 11:04 GMT+05:00 Gert Doering <gert@...1296...>:

> Hi,
>
> On Mon, Mar 27, 2017 at 11:40:49PM +0200, David Sommerseth wrote:
> > > On Sat, Mar 25, 2017 at 05:21:18PM +0500, Ilya Shipitsin wrote:
> > >> [src/openvpn/options.c:1163]: (warning) %x in format string (no. 1)
> requires 'unsigned int *' but the argument type is 'signed int *'.
> > >
> > > Please use "uint8_t" then, and also adapt the "ret[i] = (uint8_t)byte"
> > > line - the cast would then be obsolete.
> >
> > I would normally agree to use uint8_t ... but the man page for sscanf()
> > on Linux says:
> >
> >    "Matches an unsigned hexadecimal integer; the next pointer must be a
> >     pointer to unsigned int."
> >
> > And stdint.h declares: typedef unsigned char           uint8_t;
> >
> > AFAIR, char is defined as 8 bits (hence uint*8*), while unsigned int are
> > 32 bits on my system.
>
> Yeah, you're right.  I confused this discussion with our standard
> "char vs. signed char vs. unsigned char" warning.
>
> (See how dangerous "fixing compiler warnings" is?  :-) )
>

this particular warning came from cppcheck, it's not a compiler warning


I hope to address compiler warnings after "travis-ci + mingw" patch applied.
there are a lot of warnings in mingw builds:

https://travis-ci.org/chipitsine/openvpn/jobs/215190933#L1046
https://travis-ci.org/chipitsine/openvpn/jobs/215190933#L1063
https://travis-ci.org/chipitsine/openvpn/jobs/215190933#L1106
https://travis-ci.org/chipitsine/openvpn/jobs/215190933#L1136
https://travis-ci.org/chipitsine/openvpn/jobs/215190933#L1162
https://travis-ci.org/chipitsine/openvpn/jobs/215190933#L1180
https://travis-ci.org/chipitsine/openvpn/jobs/215190933#L1195
https://travis-ci.org/chipitsine/openvpn/jobs/215190933#L1236
https://travis-ci.org/chipitsine/openvpn/jobs/215190933#L1257


>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/ <http://www.muc.de/%7Egert/>
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025                        gert@...1816...
> muenchen.de
>

--94eb2c1b41c40f97d2054bc4c661
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-03-28 11:04 GMT+05:00 Gert Doering <span dir=3D"ltr">&lt;<a target=
=3D"_blank" href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt;</span>:=
<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb=
(204,204,204);padding-left:1ex" class=3D"gmail_quote">Hi,<br>
<span class=3D"gmail-"><br>
On Mon, Mar 27, 2017 at 11:40:49PM +0200, David Sommerseth wrote:<br>
</span><span class=3D"gmail-">&gt; &gt; On Sat, Mar 25, 2017 at 05:21:18PM =
+0500, Ilya Shipitsin wrote:<br>
&gt; &gt;&gt; [src/openvpn/options.c:1163]: (warning) %x in format string (=
no. 1) requires &#39;unsigned int *&#39; but the argument type is &#39;sign=
ed int *&#39;.<br>
&gt; &gt;<br>
&gt; &gt; Please use &quot;uint8_t&quot; then, and also adapt the &quot;ret=
[i] =3D (uint8_t)byte&quot;<br>
&gt; &gt; line - the cast would then be obsolete.<br>
&gt;<br>
&gt; I would normally agree to use uint8_t ... but the man page for sscanf(=
)<br>
&gt; on Linux says:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 &quot;Matches an unsigned hexadecimal integer; the next p=
ointer must be a<br>
&gt;=C2=A0 =C2=A0 =C2=A0pointer to unsigned int.&quot;<br>
&gt;<br>
&gt; And stdint.h declares: typedef unsigned char=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0uint8_t;<br>
&gt;<br>
&gt; AFAIR, char is defined as 8 bits (hence uint*8*), while unsigned int a=
re<br>
&gt; 32 bits on my system.<br>
<br>
</span>Yeah, you&#39;re right.=C2=A0 I confused this discussion with our st=
andard<br>
&quot;char vs. signed char vs. unsigned char&quot; warning.<br>
<br>
(See how dangerous &quot;fixing compiler warnings&quot; is?=C2=A0 :-) )<br>=
</blockquote><div><br></div><div>this particular warning came from cppcheck=
, it&#39;s not a compiler warning<br><br><br></div><div>I hope to address c=
ompiler warnings after &quot;travis-ci + mingw&quot; patch applied.<br></di=
v><div>there are a lot of warnings in mingw builds:<br><br><a href=3D"https=
://travis-ci.org/chipitsine/openvpn/jobs/215190933#L1046">https://travis-ci=
.org/chipitsine/openvpn/jobs/215190933#L1046</a><br><a href=3D"https://trav=
is-ci.org/chipitsine/openvpn/jobs/215190933#L1063">https://travis-ci.org/ch=
ipitsine/openvpn/jobs/215190933#L1063</a><br><a href=3D"https://travis-ci.o=
rg/chipitsine/openvpn/jobs/215190933#L1106">https://travis-ci.org/chipitsin=
e/openvpn/jobs/215190933#L1106</a><br><a href=3D"https://travis-ci.org/chip=
itsine/openvpn/jobs/215190933#L1136">https://travis-ci.org/chipitsine/openv=
pn/jobs/215190933#L1136</a><br><a href=3D"https://travis-ci.org/chipitsine/=
openvpn/jobs/215190933#L1162">https://travis-ci.org/chipitsine/openvpn/jobs=
/215190933#L1162</a><br><a href=3D"https://travis-ci.org/chipitsine/openvpn=
/jobs/215190933#L1180">https://travis-ci.org/chipitsine/openvpn/jobs/215190=
933#L1180</a><br><a href=3D"https://travis-ci.org/chipitsine/openvpn/jobs/2=
15190933#L1195">https://travis-ci.org/chipitsine/openvpn/jobs/215190933#L11=
95</a><br><a href=3D"https://travis-ci.org/chipitsine/openvpn/jobs/21519093=
3#L1236">https://travis-ci.org/chipitsine/openvpn/jobs/215190933#L1236</a><=
br><a href=3D"https://travis-ci.org/chipitsine/openvpn/jobs/215190933#L1257=
">https://travis-ci.org/chipitsine/openvpn/jobs/215190933#L1257</a><br></di=
v><div>=C2=A0</div><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote">
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
gert<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<a target=
=3D"_blank" rel=3D"noreferrer" href=3D"http://www.muc.de/%7Egert/">www.muc.=
de/~gert/</a><br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296...">gert@...1296...</a><br>
fax: +49-89-35655025=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...2165...=
6...<wbr>muenchen.de</a><br>
</font></span></blockquote></div><br></div></div>

--94eb2c1b41c40f97d2054bc4c661--

