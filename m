MIME-Version: 1.0
In-Reply-To: <20160502111748.GY53051@...1296...>
References: <CAFHpkQG+gvd9cTMphjp6Y8AnaZ3Vn_2rt=XJaAOvfEA4tuH-Og@...278...>
	<572717AD.8060102@...515...>
	<20160502094733.GQ53051@...1296...>
	<CAFHpkQFoch_tEXiQjd5RgSQOokU7093rpNbtt_0nwaGK7=B5Vw@...278...>
	<20160502100924.GR53051@...1296...>
	<CAFHpkQE5EavzNgumLVC8Mg6HjSqDx2RgDWR+w=c-pALuRjm=qA@...278...>
	<20160502105615.GW53051@...1296...>
	<CAFHpkQFVFs8hvq-tdFXWOuw9azJfV9MZPfVVKsOcR7OVUefeyw@...278...>
	<20160502105957.GX53051@...1296...>
	<CAFHpkQGk-D1RL9=Fq8goiTbKaqpjn5QYR3qrT0AXSOtbiaU0gQ@...278...>
	<20160502111748.GY53051@...1296...>
Date: Mon, 2 May 2016 16:23:40 +0500
Message-ID: <CAFHpkQHwS0R3eWsCf3jKMJXqC9a55-mQnp_b=5zRg9kAW3qimw@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Content-Type: multipart/alternative; boundary=14dae93a11eb7c6b670531da3933
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

--14dae93a11eb7c6b670531da3933
Content-Type: text/plain; charset=UTF-8

ok, we are running 1000+ users installation, just couple of them
experienced that behaviour.

and, after I investigated it in details, I came to uninitilized variable
(which by chance was "almost always" initialized with NULL)

from that point of view, 2 out of 1000 is almost nothing and I could tell
to them "have a look at other 998, everything works, what do you want from
me"

and, there's no point in having variables uninitialized actually. you
depend on vary strange issues like OS decision to initialize them with NULL
or whatever.

2016-05-02 16:17 GMT+05:00 Gert Doering <gert@...1296...>:

> Hi,
>
> On Mon, May 02, 2016 at 04:14:23PM +0500, ???????? ?????????????? wrote:
> > I was very disapointed with what happened to my report in mailing list.
> So,
> > I will not send anything to list until things will change. Or I will ask
> > Samuli to do so.
>
> If I remember right, you got a clear response that your report did not
> make sense - and you never followed up on it.  But I'll go back and
> re-read.
>
> Given the fact that OpenVPN is working perfectly fine on windows for
> large numbers of people, and the main issue on win8.1 and up has been
> "TAP driver installation", I tend to concur that this was a non-issue.
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

--14dae93a11eb7c6b670531da3933
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>ok, we are running 1000+ users installation=
, just couple of them experienced that behaviour.<br><br></div>and, after I=
 investigated it in details, I came to uninitilized variable (which by chan=
ce was &quot;almost always&quot; initialized with NULL)<br><br></div>from t=
hat point of view, 2 out of 1000 is almost nothing and I could tell to them=
 &quot;have a look at other 998, everything works, what do you want from me=
&quot;<br><br></div>and, there&#39;s no point in having variables uninitial=
ized actually. you depend on vary strange issues like OS decision to initia=
lize them with NULL or whatever.<br></div><div class=3D"gmail_extra"><br><d=
iv class=3D"gmail_quote">2016-05-02 16:17 GMT+05:00 Gert Doering <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1386...=
296...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Mon, May 02, 2016 at 04:14:23PM +0500, ???????? ?????????????? wrote:<br>
&gt; I was very disapointed with what happened to my report in mailing list=
. So,<br>
&gt; I will not send anything to list until things will change. Or I will a=
sk<br>
&gt; Samuli to do so.<br>
<br>
</span>If I remember right, you got a clear response that your report did n=
ot<br>
make sense - and you never followed up on it.=C2=A0 But I&#39;ll go back an=
d re-read.<br>
<br>
Given the fact that OpenVPN is working perfectly fine on windows for<br>
large numbers of people, and the main issue on win8.1 and up has been<br>
&quot;TAP driver installation&quot;, I tend to concur that this was a non-i=
ssue.<br>
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

--14dae93a11eb7c6b670531da3933--

