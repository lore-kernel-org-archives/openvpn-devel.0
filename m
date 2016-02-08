MIME-Version: 1.0
In-Reply-To: <20160208074238.GE24952@...1296...>
References: <CAKuzo_gX4qwZg01UR2k=_g1yEY93z3wc1LiyqTXn=WBm3aZvwQ@...278...>
	<20160207215605.GC24952@...1296...>
	<CAFHpkQEzCUDpHgRZhxYqTBUkvSe7ra5-CiS06Auzke+6vB=dkg@...278...>
	<20160208074238.GE24952@...1296...>
Date: Mon, 8 Feb 2016 13:22:47 +0500
Message-ID: <CAFHpkQF9=9Oa=eXU3Vccu4pJVO=1B-Bw+GmeLfebp3HZzvpL0w@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Content-Type: multipart/alternative; boundary=001a11c3efdeef4f93052b3de7d4
Subject: Re: [Openvpn-devel] GUI repo
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

--001a11c3efdeef4f93052b3de7d4
Content-Type: text/plain; charset=UTF-8

I saw few cases when openvpn.exe remains running even after openvpn-gui
told it to stop (and it was awful).
is iservice magic of start/stop openvpn.exe  the same as for openvpn-gui ?

if yes, I would say that it is ok to switch to iservice by default.

2016-02-08 12:42 GMT+05:00 Gert Doering <gert@...1296...>:

> Hi,
>
> On Mon, Feb 08, 2016 at 08:35:54AM +0500, ???????? ?????????????? wrote:
> > I have one question regarding that.
> > when we deployed openvpn, we used to supply our users a config file
> without
> > "nobind" keyword.
> >
> > it worked for most of our users, however, those who needed 2 or more vpn
> > connections complained that "port already bind". so, we added "nobind" to
> > client config files and people become happy.
> >
> > what about that PR. there might be cases when
> >
> > 1) interactive service installed
> > 2) user is administrator
> >
> > how many openvpn processes will be running ? how many of them will
> attempt
> > to bind to 1194 ?
>
> You still seem to misunderstand what iservice does - iservice does not
> automatically run "thousands of OpenVPN processes".  It will do what the
> GUI tells it to.
>
> So if it does not work without iservice because GUI tries to start two
> jobs with "bind 1194", it will not work with iservice either - no
> difference here.  First bind will succeed, second one will not.
>
> What is "first" depends on what the GUI starts first - it's all controlled
> by the GUI, the service does not start anything on its own.
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

--001a11c3efdeef4f93052b3de7d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>I saw few cases when openvpn.exe remains running=
 even after openvpn-gui told it to stop (and it was awful).<br></div>is ise=
rvice magic of start/stop openvpn.exe=C2=A0 the same as for openvpn-gui ?<b=
r><br></div>if yes, I would say that it is ok to switch to iservice by defa=
ult.<br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">201=
6-02-08 12:42 GMT+05:00 Gert Doering <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span>:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Mon, Feb 08, 2016 at 08:35:54AM +0500, ???????? ?????????????? wrote:<br>
&gt; I have one question regarding that.<br>
&gt; when we deployed openvpn, we used to supply our users a config file wi=
thout<br>
&gt; &quot;nobind&quot; keyword.<br>
&gt;<br>
&gt; it worked for most of our users, however, those who needed 2 or more v=
pn<br>
&gt; connections complained that &quot;port already bind&quot;. so, we adde=
d &quot;nobind&quot; to<br>
&gt; client config files and people become happy.<br>
&gt;<br>
&gt; what about that PR. there might be cases when<br>
&gt;<br>
&gt; 1) interactive service installed<br>
&gt; 2) user is administrator<br>
&gt;<br>
&gt; how many openvpn processes will be running ? how many of them will att=
empt<br>
&gt; to bind to 1194 ?<br>
<br>
</span>You still seem to misunderstand what iservice does - iservice does n=
ot<br>
automatically run &quot;thousands of OpenVPN processes&quot;.=C2=A0 It will=
 do what the<br>
GUI tells it to.<br>
<br>
So if it does not work without iservice because GUI tries to start two<br>
jobs with &quot;bind 1194&quot;, it will not work with iservice either - no=
<br>
difference here.=C2=A0 First bind will succeed, second one will not.<br>
<br>
What is &quot;first&quot; depends on what the GUI starts first - it&#39;s a=
ll controlled<br>
by the GUI, the service does not start anything on its own.<br>
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

--001a11c3efdeef4f93052b3de7d4--

