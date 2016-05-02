MIME-Version: 1.0
In-Reply-To: <20160502105957.GX53051@...1296...>
References: <CAFHpkQFtepY8_FD24+VBWV8e6OAe_Ka=eU_n1yHNpMcP-6YSVQ@...278...>
	<CAFHpkQH448HotUH2JwKAPd2ZD6_8cnAf7Ly8Uvmqhtwv7Akv6w@...278...>
	<CAFHpkQG+gvd9cTMphjp6Y8AnaZ3Vn_2rt=XJaAOvfEA4tuH-Og@...278...>
	<572717AD.8060102@...515...>
	<20160502094733.GQ53051@...1296...>
	<CAFHpkQFoch_tEXiQjd5RgSQOokU7093rpNbtt_0nwaGK7=B5Vw@...278...>
	<20160502100924.GR53051@...1296...>
	<CAFHpkQE5EavzNgumLVC8Mg6HjSqDx2RgDWR+w=c-pALuRjm=qA@...278...>
	<20160502105615.GW53051@...1296...>
	<CAFHpkQFVFs8hvq-tdFXWOuw9azJfV9MZPfVVKsOcR7OVUefeyw@...278...>
	<20160502105957.GX53051@...1296...>
Date: Mon, 2 May 2016 16:14:23 +0500
Message-ID: <CAFHpkQGk-D1RL9=Fq8goiTbKaqpjn5QYR3qrT0AXSOtbiaU0gQ@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Content-Type: multipart/alternative; boundary=001a1143a88a4f56690531da18da
Subject: Re: [Openvpn-devel] CI for openvpn
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

--001a1143a88a4f56690531da18da
Content-Type: text/plain; charset=UTF-8

ok, I sent to list bug report, it was somewhere on windows 8.1 beta.
somehow, uninitialized variables were initialized with garbage (it was
fixed to NULL in windows 8.1 release)

bug is there

https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/error.c#L458

if std_redir is defined, so orig_stderr is not unitialized (or, if we are
lucky, it is NULL)

it tends to weird behaviour on windows 8.1 beta, openvpn either get
connected or not.

ok, I will open a bug regarding unitialized variable. if someone will have
a time, he or she will have a look at it.

I was very disapointed with what happened to my report in mailing list. So,
I will not send anything to list until things will change. Or I will ask
Samuli to do so.

2016-05-02 15:59 GMT+05:00 Gert Doering <gert@...1296...>:

> Hi,
>
> On Mon, May 02, 2016 at 03:58:25PM +0500, ???????? ?????????????? wrote:
> > well, I'm not prepared to pass commit procedures, I'm awaiting for Samuli
> > response whether or not he can handle those if I will send patches
> directly
> > to him
>
> Feel free to use PRs to *discuss* patches (I already agreed that this
> might be a good plan), but anything that wants to be committed into the
> main openvpn repo needs to be on the list, and preferrably by the author.
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025
> gert@...1297...
>

--001a1143a88a4f56690531da18da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>ok, I sent to list bug report, it was somewhere =
on windows 8.1 beta.<br></div>somehow, uninitialized variables were initial=
ized with garbage (it was fixed to NULL in windows 8.1 release)<br><br></di=
v>bug is there<br><div><div><br><a href=3D"https://github.com/OpenVPN/openv=
pn/blob/master/src/openvpn/error.c#L458">https://github.com/OpenVPN/openvpn=
/blob/master/src/openvpn/error.c#L458</a><br><br></div><div>if std_redir is=
 defined, so <span class=3D"">orig_stderr is not unitialized (or, if we are=
 lucky, it is NULL)<br><br></span></div><div><span class=3D"">it tends to w=
eird behaviour on windows 8.1 beta, openvpn either get connected or not.<br=
><br></span></div><div><span class=3D"">ok, I will open a bug regarding uni=
tialized variable. if someone will have a time, he or she will have a look =
at it.<br><br></span></div><div><span class=3D"">I was very disapointed wit=
h what happened to my report in mailing list. So, I will not send anything =
to list until things will change. Or I will ask Samuli to do so.<br></span>=
</div></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote"=
>2016-05-02 15:59 GMT+05:00 Gert Doering <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span>:<br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Mon, May 02, 2016 at 03:58:25PM +0500, ???????? ?????????????? wrote:<br>
&gt; well, I&#39;m not prepared to pass commit procedures, I&#39;m awaiting=
 for Samuli<br>
&gt; response whether or not he can handle those if I will send patches dir=
ectly<br>
&gt; to him<br>
<br>
</span>Feel free to use PRs to *discuss* patches (I already agreed that thi=
s<br>
might be a good plan), but anything that wants to be committed into the<br>
main openvpn repo needs to be on the list, and preferrably by the author.<b=
r>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
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
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...1826...=
7...</a><br>
</div></div></blockquote></div><br></div>

--001a1143a88a4f56690531da18da--

