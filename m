MIME-Version: 1.0
In-Reply-To: <20161206211818.GQ78624@...1296...>
References: <CAFHpkQFgmWBhUb6YZOGFeR7Eyz34tFbN5BQEzafj0tpqtbmwyQ@...278...>
	<20161206211818.GQ78624@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 7 Dec 2016 16:51:36 +0500
Message-ID: <CAFHpkQGqHrFwCLMEvu9tEAQg3heWaAWcEQDyidG5z0ZLNgkL_Q@...278...>
Content-Type: multipart/alternative; boundary=089e0102e3daa2ba4605431024a8
Subject: Re: [Openvpn-devel] fuzz testing by google ?
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

--089e0102e3daa2ba4605431024a8
Content-Type: text/plain; charset=UTF-8

2016-12-07 2:18 GMT+05:00 Gert Doering <gert@...1296...>:

> Hi,
>
> On Fri, Dec 02, 2016 at 08:48:29AM +0500, ???????? ?????????????? wrote:
> > https://opensource.googleblog.com/2016/12/announcing-oss-
> fuzz-continuous-fuzzing.html
>
> This is generally interesting, of course.
>
> Fuzzing openvpn "as a whole" is quite complicated, though - we do check
> our input very well, so the last time someone tried to fuzz TLS packets
> to make openvpn "do bad things", all he got was "go away, you stink,
> session destroyed" :-)
>

at least, I recall this commit
https://github.com/OpenVPN/openvpn/commit/0d8da22ae36d5efd03fba36c1d783b907589e321
it used to crash on simple tcp connect (after immediate disconnect), it was
reproducible to running login/password authentication mode

it might have been caught by fuzz testing.



>
> Anyway - so what's necessary to make this google fuzz testing work?  Do
> we instrument our code, or just tell them "hey, here's a useful piece
> of software, go figure it out yourself"?
>

we can start with PR to
https://github.com/google/oss-fuzz/tree/master/projects
it must been done by someone from "OpenVPN" github organization.

if google machinery will not figure out anything, it might be long way with
libfuzz-helpers (if we implement such helpers, we can add them to cmoka and
travis-ci)


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

--089e0102e3daa2ba4605431024a8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-12-07 2:18 GMT+05:00 Gert Doering <span dir=3D"ltr">&lt;<a href=3D=
"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span>:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Fri, Dec 02, 2016 at 08:48:29AM +0500, ???????? ?????????????? wrote:<br>
&gt; <a href=3D"https://opensource.googleblog.com/2016/12/announcing-oss-fu=
zz-continuous-fuzzing.html" rel=3D"noreferrer" target=3D"_blank">https://op=
ensource.googleblog.<wbr>com/2016/12/announcing-oss-<wbr>fuzz-continuous-fu=
zzing.html</a><br>
<br>
This is generally interesting, of course.<br>
<br>
Fuzzing openvpn &quot;as a whole&quot; is quite complicated, though - we do=
 check<br>
our input very well, so the last time someone tried to fuzz TLS packets<br>
to make openvpn &quot;do bad things&quot;, all he got was &quot;go away, yo=
u stink,<br>
session destroyed&quot; :-)<br></blockquote><div><br></div><div>at least, I=
 recall this commit=C2=A0 <a href=3D"https://github.com/OpenVPN/openvpn/com=
mit/0d8da22ae36d5efd03fba36c1d783b907589e321">https://github.com/OpenVPN/op=
envpn/commit/0d8da22ae36d5efd03fba36c1d783b907589e321</a><br></div><div>it =
used to crash on simple tcp connect (after immediate disconnect), it was re=
producible to running login/password authentication mode<br><br></div><div>=
it might have been caught by fuzz testing.<br></div><div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Anyway - so what&#39;s necessary to make this google fuzz testing work?=C2=
=A0 Do<br>
we instrument our code, or just tell them &quot;hey, here&#39;s a useful pi=
ece<br>
of software, go figure it out yourself&quot;?<br></blockquote><div><br></di=
v><div>we can start with PR to <a href=3D"https://github.com/google/oss-fuz=
z/tree/master/projects">https://github.com/google/oss-fuzz/tree/master/proj=
ects</a><br></div><div>it must been done by someone from &quot;OpenVPN&quot=
; github organization.<br><br></div><div>if google machinery will not figur=
e out anything, it might be long way with libfuzz-helpers (if we implement =
such helpers, we can add them to cmoka and travis-ci)<br></div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
gert<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<a href=3D"=
http://www.muc.de/%7Egert/" rel=3D"noreferrer" target=3D"_blank">www.muc.de=
/~gert/</a><br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296...">gert@...1296...</a><br>
fax: +49-89-35655025=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...2165...=
6...<wbr>muenchen.de</a><br>
</font></span></blockquote></div><br></div></div>

--089e0102e3daa2ba4605431024a8--

