MIME-Version: 1.0
In-Reply-To: <938A4CDB-D912-421E-8059-4B40E0CD0791@...2127...>
References: <CAFHpkQHNu9qOVeQjco9ywL1iFUZqCjU5-LFt8PsYra1usyjkVA@...278...>
	<938A4CDB-D912-421E-8059-4B40E0CD0791@...2127...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 5 Jun 2016 12:29:36 +0500
Message-ID: <CAFHpkQHa0Q2mB12+=_sDMJeijhZGkJY=ECVynwWi5vwcuoG4Jw@...278...>
Content-Type: multipart/alternative; boundary=047d7b5d31c804dce5053482eb84
Subject: Re: [Openvpn-devel] travis-ci (smoke testing)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jens Neuhalfen <openvpn-devel@...2127...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7b5d31c804dce5053482eb84
Content-Type: text/plain; charset=UTF-8

I marked xcode6.4 as failures for a while (I've no idea what's wrong there,
time is correct, certificate is correct, I'll dive into that later)

as for Mac OS X, we can choose build matrix as wide as we want to, I do not
insist on using xcode6.4 image, it is just as example.

we can pick any combination from
https://github.com/mattock/openvpn-buildbot/blob/master/master.cfg.sample#L79

travis has several disadvantages, for example, it does not support ipv6 at
all, even as ::1, also you cannot add NetBSD, Windows, etc.

however, it might be good for smoke testing. and you are right, you can
clone repo to https://github.com/neuhalje, add .travis.yml and voila, you
have your own build farm.

2016-06-05 5:16 GMT+05:00 Jens Neuhalfen <openvpn-devel@...2127...>:

> Hi
>
>
> Hello,
>
> I was impressed by unit testing efforts, so I suggest to implement
> something like that
>
> https://travis-ci.org/chipitsine/openvpn/builds/135318558
>
> ( https://github.com/OpenVPN/openvpn/pull/52 )
>
> we can use Linux, Mac OSX, gcc, clang, various configure options.
>
>
> nice! I did not know, that travis supports MacOS!  Travis has the
> additional bonus, that it also works for cloned repositories.
>
>
> (unfortunately, ssl cert at mbed tls website was expired and Xcode7.3 does
> not compile openvpn with openssl)
>
>
> Very strange, the cert is valid till 2017.
>
> Jens
>

--047d7b5d31c804dce5053482eb84
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>I marked xcode6.4 as failures for a wh=
ile (I&#39;ve no idea what&#39;s wrong there, time is correct, certificate =
is correct, I&#39;ll dive into that later)<br><br></div>as for Mac OS X, we=
 can choose build matrix as wide as we want to, I do not insist on using xc=
ode6.4 image, it is just as example.<br><br></div>we can pick any combinati=
on from <a href=3D"https://github.com/mattock/openvpn-buildbot/blob/master/=
master.cfg.sample#L79">https://github.com/mattock/openvpn-buildbot/blob/mas=
ter/master.cfg.sample#L79</a><br><br></div>travis has several disadvantages=
, for example, it does not support ipv6 at all, even as ::1, also you canno=
t add NetBSD, Windows, etc.<br><br></div>however, it might be good for smok=
e testing. and you are right, you can clone repo to <a href=3D"https://gith=
ub.com/neuhalje">https://github.com/neuhalje</a>, add .travis.yml and voila=
, you have your own build farm.<br></div><div class=3D"gmail_extra"><br><di=
v class=3D"gmail_quote">2016-06-05 5:16 GMT+05:00 Jens Neuhalfen <span dir=
=3D"ltr">&lt;<a href=3D"mailto:openvpn-devel@...2127..." target=3D"_blank">=
openvpn-devel@...2127...</a>&gt;</span>:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<div style=3D"word-wrap:break-word"><div>Hi</div><div><span class=3D""><br>=
<blockquote type=3D"cite"><br><div><div dir=3D"ltr"><div><div><div>Hello,<b=
r><br></div>I was impressed by unit testing efforts, so I suggest to implem=
ent something like that<br><br><a href=3D"https://travis-ci.org/chipitsine/=
openvpn/builds/135318558" target=3D"_blank">https://travis-ci.org/chipitsin=
e/openvpn/builds/135318558</a><br><br>( <a href=3D"https://github.com/OpenV=
PN/openvpn/pull/52" target=3D"_blank">https://github.com/OpenVPN/openvpn/pu=
ll/52</a> )<br><br></div>we can use Linux, Mac OSX, gcc, clang, various con=
figure options.<br><br></div></div></div></blockquote><div><br></div></span=
>nice! I did not know, that travis supports MacOS!=C2=A0 Travis has the add=
itional bonus, that it also works for cloned repositories.=C2=A0</div><div>=
<span class=3D""><br><blockquote type=3D"cite"><div><div dir=3D"ltr"><div><=
br></div><div>(unfortunately, ssl cert at mbed tls website was expired and =
Xcode7.3 does not compile openvpn with openssl)<br></div></div></div></bloc=
kquote><div><br></div></span><span class=3D"">Very strange, the cert is val=
id till 2017.</span></div><span class=3D"HOEnZb"><font color=3D"#888888"><d=
iv><br></div><div>Jens</div></font></span></div></blockquote></div><br></di=
v>

--047d7b5d31c804dce5053482eb84--

