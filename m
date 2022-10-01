MIME-Version: 1.0
References: <CAEBHyEV1TvxTF5rPg8NaUkd8D80er-K50TYf_f42smwCgW8-Wg@...278...>
In-Reply-To: <CAEBHyEV1TvxTF5rPg8NaUkd8D80er-K50TYf_f42smwCgW8-Wg@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sat, 1 Oct 2022 09:07:05 +0500
Message-ID: <CAFHpkQEx5AGKiK8N5VoawpAqjsU7Q-zNQ5LCx7PT=i_Aq9G0+w@...278...>
Content-Type: multipart/alternative; boundary="000000000000d8b6d905e9f13ea5"
Subject: Re: [Openvpn-devel] Multiple Openvpn servers using same port + Nginx
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Daniel Lando <daniel.sorridi@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000d8b6d905e9f13ea5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

there's brilliant piece of software:
https://github.com/StreisandEffect/streisand

among other ideas, there's openvpn port sharing.

=D0=BF=D1=82, 30 =D1=81=D0=B5=D0=BD=D1=82. 2022 =D0=B3. =D0=B2 20:22, Danie=
l Lando <daniel.sorridi@...277...>:

> Hi everyone,
>
> As described in this
> <https://github.com/OpenVPN/openvpn/pull/166#issuecomment-1263600751>
> comment, what I would like to know is if it's possible (and how) I could
> proxy requests using nginx to multiple openvpn servers. I'm actually using
> docker-compose to start the openvpn servers and also nginx is running in a
> docker container.
>
> The possible solutions I have in mind could be by using subdomains or sni
> but cannot find a way to make them working as sni support is only availab=
le
> on openvpn 3.
>
> There is also a webserver that should share the same port
>
> Any suggestions? Thanks in advance
>
> --
> --
> *Daniel Lando*
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000d8b6d905e9f13ea5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">there&#39;s brilliant piece of software:=
=C2=A0<a href=3D"https://github.com/StreisandEffect/streisand">https://gith=
ub.com/StreisandEffect/streisand</a></div><div dir=3D"ltr"><br></div><div>a=
mong other ideas, there&#39;s openvpn port sharing.</div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D1=82, 30 =
=D1=81=D0=B5=D0=BD=D1=82. 2022 =D0=B3. =D0=B2 20:22, Daniel Lando &lt;<a hr=
ef=3D"mailto:daniel.sorridi@...277...">daniel.sorridi@...277...</a>&gt;:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">H=
i everyone,<div><br></div><div>As described in <a href=3D"https://github.co=
m/OpenVPN/openvpn/pull/166#issuecomment-1263600751" target=3D"_blank">this<=
/a> comment, what I would like to know is if it&#39;s possible (and how) I =
could proxy requests using nginx to multiple openvpn servers. I&#39;m actua=
lly using docker-compose to start the openvpn servers and also nginx is run=
ning in a docker container.</div><div><br></div><div>The possible solutions=
 I have in mind could be by using subdomains or sni but cannot find a way t=
o make them working as sni support is only available on openvpn 3.</div><di=
v><br></div><div>There is also a webserver=C2=A0that should share the same =
port</div><div><br></div><div>Any suggestions? Thanks in advance</div><div>=
<div><br></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><span style=3D"font=
-size:13px;color:rgb(0,0,0);font-family:Lato,Helvetica,Arial,sans-serif">--=
=C2=A0</span><div style=3D"font-size:13px;outline:none;color:rgb(0,0,0);fon=
t-family:Lato,Helvetica,Arial,sans-serif"><div dir=3D"ltr" style=3D"outline=
:none"><div style=3D"outline:none;font-size:12.8px"><font face=3D"Tahoma" s=
tyle=3D"outline:none"><font color=3D"#999999" style=3D"outline:none"><stron=
g style=3D"outline:none"><em style=3D"outline:none">Daniel Lando</em></stro=
ng></font></font></div></div></div></div></div></div></div>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div>

--000000000000d8b6d905e9f13ea5--

