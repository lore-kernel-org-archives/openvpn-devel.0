MIME-Version: 1.0
In-Reply-To: <CAFHpkQEeLcCtu3RrbzQLEzS8-2B74DTT_5yh1MRnVL7CZ3xcdg@...278...>
References: <CAFHpkQEeLcCtu3RrbzQLEzS8-2B74DTT_5yh1MRnVL7CZ3xcdg@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 29 Dec 2016 10:19:04 +0500
Message-ID: <CAFHpkQG_UxEzrqZtTV+RhXz8gyEgm8oKmKObghwWe90csexCdg@...278...>
Content-Type: multipart/alternative; boundary=001a114b16b853929a0544c5398d
Subject: Re: [Openvpn-devel] couple of questions on trac#665
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114b16b853929a0544c5398d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2016-12-29 9:56 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD <chipitsine@...277...>:

> Hello,
>
> I seem to see several times issues like described in #665
>
> what seems to be strange is couple of things:
>
> 1) "OR" clause. why not "AND" ?  https://github.com/OpenVPN/
> openvpn/blob/master/src/openvpn/tun.c#L6012-L6013
>

I will answer myself.

!read || !write - is proper use of "OR"


>
>
> 2) error message seems to be irrelevant  https://github.com/OpenVPN/
> openvpn/blob/master/src/openvpn/tun.c#L6034
>
> it might be an error from earlier function calls, not only FlushIpNetTable
> itself.
>
>
> any ideas ?
>
>
> Cheers,
> Ilya Shipitsin
>

--001a114b16b853929a0544c5398d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-12-29 9:56 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"ltr">&lt;<a href=3D"mailto:chipitsine=
@...277..." target=3D"_blank">chipitsine@...277...</a>&gt;</span>:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><div dir=3D"ltr"><div><div><div>Hello,<br><br></d=
iv>I seem to see several times issues like described in #665<br></div><br><=
/div>what seems to be strange is couple of things:<br><div><div><div><div><=
div><div><br>1) &quot;OR&quot; clause. why not &quot;AND&quot; ?=C2=A0 <a h=
ref=3D"https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/tun.c#L60=
12-L6013" target=3D"_blank">https://github.com/OpenVPN/<wbr>openvpn/blob/ma=
ster/src/<wbr>openvpn/tun.c#L6012-L6013</a></div></div></div></div></div></=
div></div></blockquote><div><br></div><div>I will answer myself.<br><br></d=
iv><div>!read || !write - is proper use of &quot;OR&quot;<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><div><div><di=
v><div><div><br><br></div><div>2) error message seems to be irrelevant=C2=
=A0 <a href=3D"https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/t=
un.c#L6034" target=3D"_blank">https://github.com/OpenVPN/<wbr>openvpn/blob/=
master/src/<wbr>openvpn/tun.c#L6034</a><br><br></div><div>it might be an er=
ror from earlier function calls, not only <span class=3D"m_-214816879449858=
541gmail-pl-s">FlushIpNetTable itself. <br><br><br></span></div><div><span =
class=3D"m_-214816879449858541gmail-pl-s">any ideas ?<br></span></div><div>=
<span class=3D"m_-214816879449858541gmail-pl-s"><br><br></span></div><div><=
span class=3D"m_-214816879449858541gmail-pl-s">Cheers,<br></span></div><div=
><span class=3D"m_-214816879449858541gmail-pl-s">Ilya Shipitsin<br></span><=
/div></div></div></div></div></div></div>
</blockquote></div><br></div></div>

--001a114b16b853929a0544c5398d--

