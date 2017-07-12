MIME-Version: 1.0
In-Reply-To: <28dad8fd-eda8-028d-530a-8c2aece8de84@...1227...>
References: <20170709144646.10352-1-chipitsine@...277...>
	<CAFHpkQEPAzvnkRAZLPgLwt8i8LjJrVcKwTp6H32v7Dxz4Jb0Lg@...278...>
	<28dad8fd-eda8-028d-530a-8c2aece8de84@...1227...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 12 Jul 2017 14:14:00 +0500
Message-ID: <CAFHpkQHgxoyODzNCoVEa=-nvAoLEDiqGH3JSWE0=4yAfc9cogg@...278...>
Content-Type: multipart/alternative; boundary="94eb2c1936ec979a9405541b3c53"
Subject: Re: [Openvpn-devel] [PATCH] win32 build: check for ENETUNREACH
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c1936ec979a9405541b3c53
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-07-12 13:59 GMT+05:00 Arne Schwabe <arne@...1227...>:

> Am 12.07.17 um 10:46 schrieb =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD:
> > No interest ?
> >
>
> We are slow, you should know that by now. The code looks code so from
> that it looks good. If we get an ACK from someone who testedthis I think
> then it is safe to merge.
>


I tested it.
it neither breaks compilation where it should work

https://travis-ci.org/chipitsine/openvpn/builds/251726778

nor it passes where it should not (I tested on Debian 7 on https://dply.co )


>
> Arne
>
>

--94eb2c1936ec979a9405541b3c53
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-07-12 13:59 GMT+05:00 Arne Schwabe <span dir=3D"ltr">&lt;<a href=
=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt;</span=
>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Am 12.07.17 um 10:4=
6 schrieb =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=
=BD:<br>
&gt; No interest ?<br>
&gt;<br>
<br>
We are slow, you should know that by now. The code looks code so from<br>
that it looks good. If we get an ACK from someone who testedthis I think<br>
then it is safe to merge.<br></blockquote><div><br><br></div><div>I tested =
it.<br></div><div>it neither breaks compilation where it should work<br><br=
><a href=3D"https://travis-ci.org/chipitsine/openvpn/builds/251726778">http=
s://travis-ci.org/chipitsine/openvpn/builds/251726778</a><br><br></div><div=
>nor it passes where it should not (I tested on Debian 7 on <a href=3D"http=
s://dply.co">https://dply.co</a> )<br></div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
Arne<br>
<br>
</font></span></blockquote></div><br></div></div>

--94eb2c1936ec979a9405541b3c53--

