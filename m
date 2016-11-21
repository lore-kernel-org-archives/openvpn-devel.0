MIME-Version: 1.0
In-Reply-To: <20161121194602.GR28918@...1296...>
References: <CAFHpkQFdwy++P48HOOAeEO8fKr8uc6y-en0z73JtoOMO1c4q7Q@...278...>
	<20161116183502.GK28918@...1296...>
	<CAFHpkQEkvbq1AGSYN-kYqfDjMbUXJhe1gysp4g6s1EOQku6JOQ@...278...>
	<20161116184717.GL28918@...1296...>
	<CAFHpkQHaDiP9Wk49ja3p_Oix=1fAtANzpqmPbT6hLZw6FVqLiw@...278...>
	<CAFHpkQHdgDAELAHwkYysyyGf5_sGFO-bkCuSVY=zwPKz1pLOwQ@...278...>
	<20161121194602.GR28918@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 22 Nov 2016 00:51:21 +0500
Message-ID: <CAFHpkQEFma=G_K3Y4FN+=vVSEQgyUySrR9HxBa6JejhimQxiNg@...278...>
Content-Type: multipart/alternative; boundary=001a114b7e0ce1c52b0541d4fafd
Subject: Re: [Openvpn-devel] launch openvpn-gui at windows startup
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

--001a114b7e0ce1c52b0541d4fafd
Content-Type: text/plain; charset=UTF-8

2016-11-22 0:46 GMT+05:00 Gert Doering <gert@...1296...>:

> Hi,
>
> On Tue, Nov 22, 2016 at 12:41:24AM +0500, ???????? ?????????????? wrote:
> > should we also start openvpn-gui if "launch gui on windows startup" is
> > selected ?
>
> I tend to de-couple this - what about a second checkbox "launch gui now"?
>

I like the approach of starting services:

https://github.com/OpenVPN/openvpn-build/blob/master/windows-nsis/openvpn.nsi#L540

if there's a service, ok, start it, why to ask user ?


the same with gui. if user selected to launch it automatically, why wait
for reboot ?


>
> (With both defaulting to [X] checked)
>
> gert
>
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/ <http://www.muc.de/%7Egert/>
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025                        gert@...1816...
> muenchen.de
>

--001a114b7e0ce1c52b0541d4fafd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-11-22 0:46 GMT+05:00 Gert Doering <span dir=3D"ltr">&lt;<a target=
=3D"_blank" href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt;</span>:=
<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb=
(204,204,204);padding-left:1ex" class=3D"gmail_quote">Hi,<br>
<span class=3D"gmail-"><br>
On Tue, Nov 22, 2016 at 12:41:24AM +0500, ???????? ?????????????? wrote:<br>
&gt; should we also start openvpn-gui if &quot;launch gui on windows startu=
p&quot; is<br>
&gt; selected ?<br>
<br>
</span>I tend to de-couple this - what about a second checkbox &quot;launch=
 gui now&quot;?<br></blockquote><div><br></div><div>I like the approach of =
starting services:<br><br><a href=3D"https://github.com/OpenVPN/openvpn-bui=
ld/blob/master/windows-nsis/openvpn.nsi#L540">https://github.com/OpenVPN/op=
envpn-build/blob/master/windows-nsis/openvpn.nsi#L540</a><br><br></div><div=
>if there&#39;s a service, ok, start it, why to ask user ?<br><br><br></div=
><div>the same with gui. if user selected to launch it automatically, why w=
ait for reboot ?<br></div><div>=C2=A0</div><blockquote style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex" clas=
s=3D"gmail_quote">
<br>
(With both defaulting to [X] checked)<br>
<div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5"><br>
gert<br>
<br>
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
</div></div></blockquote></div><br></div></div>

--001a114b7e0ce1c52b0541d4fafd--

