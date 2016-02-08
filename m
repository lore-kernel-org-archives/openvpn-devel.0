MIME-Version: 1.0
In-Reply-To: <20160207215510.GB24952@...1296...>
References: <CAKuzo_gC70Sozt1BZyf6NhMgPi-NpDWR5G-_fcXx0GKk1_JVmg@...278...>
	<CAFHpkQFyVUfK_QLgou0559-MdWn1TD51xda9kf9vYtHuhB6seg@...278...>
	<20160207192752.GZ24952@...1296...>
	<CAFHpkQEpOn0OBHVjJjQJPazHw8a+OPncDKt5jJVSi6cKpzkeJQ@...278...>
	<20160207215510.GB24952@...1296...>
Date: Mon, 8 Feb 2016 08:27:13 +0500
Message-ID: <CAFHpkQFN2Gif6NVF88F78G5ervVEb-BhBdSSrgSeJDN1aAksTQ@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Content-Type: multipart/alternative; boundary=001a1141f926e2724f052b39c623
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

--001a1141f926e2724f052b39c623
Content-Type: text/plain; charset=UTF-8

2016-02-08 2:55 GMT+05:00 Gert Doering <gert@...1296...>:

> Hi,
>
> On Mon, Feb 08, 2016 at 01:12:37AM +0500, ???????? ?????????????? wrote:
> > there's still "Start OpenVPN directly"
> >
> > https://github.com/OpenVPN/openvpn-gui/blob/master/openvpn.c#L724
> >
> > in such case admin rights are still required for routes manipulation.
>
> In this case, it would just not work.
>
> There's basically four cases:
>
>  - you have no admin rights and use the iservice -> works
>  - you have admin rights and do not use the iservice -> works
>  - you have no admin rights and use *tap* with no routes and no v6 -> works
>  - it does not work
>
> I do not see a real problem here.  If you do not want to use the iservice,
> you need to either have admin rights or stick to tap, done.
>

you open a website and see "sql timeout period elapsed prior to
completion". ok, no real problem here. it was actually a timeout and
website tells that.

but how does it look from user point of view ? why do we show that to user
? how do you we want user to interact with that ?

same thing with vpn. people just want to use it. you are right, there're 4
cases. in every case we must provide very good UX/UI approach. if we can
not make it work, ok, let us say to user in intelligent way "you know, we
put security consideration first, your partcular case is very special,
please do so and so".

I do not beleive that "windows route add command failed" is proper way of
telling those things to user. same as for "sql exception" on website.



>
> > maybe we should release two installers (or make a checkbox in installer?)
> >
> > 1) regular mode (with highest priv manifest)
> > 2) paranoya mode (without highest priv)
> >
> >
> > those who really care will choose whatever they want to
>
> Where would the benefit in refusing to use the iservice and sticking to
> "highest priv manifest"?  All you get by doing this is "larger exposed
> surface to exploitable bugs, as more code has to run with elevated privs"
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

--001a1141f926e2724f052b39c623
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-02-08 2:55 GMT+05:00 Gert Doering <span dir=3D"ltr">&lt;<a href=3D=
"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span>:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Mon, Feb 08, 2016 at 01:12:37AM +0500, ???????? ?????????????? wrote:<br>
&gt; there&#39;s still &quot;Start OpenVPN directly&quot;<br>
&gt;<br>
&gt; <a href=3D"https://github.com/OpenVPN/openvpn-gui/blob/master/openvpn.=
c#L724" rel=3D"noreferrer" target=3D"_blank">https://github.com/OpenVPN/ope=
nvpn-gui/blob/master/openvpn.c#L724</a><br>
&gt;<br>
&gt; in such case admin rights are still required for routes manipulation.<=
br>
<br>
</span>In this case, it would just not work.<br>
<br>
There&#39;s basically four cases:<br>
<br>
=C2=A0- you have no admin rights and use the iservice -&gt; works<br>
=C2=A0- you have admin rights and do not use the iservice -&gt; works<br>
=C2=A0- you have no admin rights and use *tap* with no routes and no v6 -&g=
t; works<br>
=C2=A0- it does not work<br>
<br>
I do not see a real problem here.=C2=A0 If you do not want to use the iserv=
ice,<br>
you need to either have admin rights or stick to tap, done.<br></blockquote=
><div><br></div><div>you open a website and see &quot;sql timeout period el=
apsed prior to completion&quot;. ok, no real problem here. it was actually =
a timeout and website tells that.<br><br></div><div>but how does it look fr=
om user point of view ? why do we show that to user ? how do you we want us=
er to interact with that ?<br><br></div><div>same thing with vpn. people ju=
st want to use it. you are right, there&#39;re 4 cases. in every case we mu=
st provide very good UX/UI approach. if we can not make it work, ok, let us=
 say to user in intelligent way &quot;you know, we put security considerati=
on first, your partcular case is very special, please do so and so&quot;.<b=
r><br></div><div>I do not beleive that &quot;windows route add command fail=
ed&quot; is proper way of telling those things to user. same as for &quot;s=
ql exception&quot; on website.<br></div><div><br>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<span class=3D""><br>
&gt; maybe we should release two installers (or make a checkbox in installe=
r?)<br>
&gt;<br>
&gt; 1) regular mode (with highest priv manifest)<br>
&gt; 2) paranoya mode (without highest priv)<br>
&gt;<br>
&gt;<br>
&gt; those who really care will choose whatever they want to<br>
<br>
</span>Where would the benefit in refusing to use the iservice and sticking=
 to<br>
&quot;highest priv manifest&quot;?=C2=A0 All you get by doing this is &quot=
;larger exposed<br>
surface to exploitable bugs, as more code has to run with elevated privs&qu=
ot;<br>
<div class=3D""><div class=3D"h5"><br>
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
</div></div></blockquote></div><br></div></div>

--001a1141f926e2724f052b39c623--

