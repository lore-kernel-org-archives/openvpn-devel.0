MIME-Version: 1.0
References: <CAC8x_z10PT_ToTzVUKQENA5ZJgJ4EMvBJARphDR5_wdytA2JSw@...278...>
 <b7c9a1ac-3322-4eeb-befd-e19c7f72da6b@...1227...>
 <CAC8x_z3Fwf0r-BuvuOo+Vg0708fsaPGWjg-2pnY3xgM+e4QxDg@...278...>
 <Zzm_gUxTAmFZjm_h@...1296...>
 <CAC8x_z1OtkMeuRCHNOHfg-rcJ3Kcj2uHua3pzK5ZqKJDjPvBjQ@...278...>
 <ZzoQ7jXbImL56HL6@...1296...>
 <CAC8x_z2=DL=t2V5oN_hBMLbYcVMH78XqbTLguxFifjDco+zWyQ@...278...>
 <2dae1148-45d8-4f82-8b65-973b81a18645@...1227...>
 <CAC8x_z25-XQEyk0O34nKFMMj-mXNR2r+WbbaseX70mzzZKT+QA@...278...>
 <ZzrpT6DjykCOJwUB@...1296...>
In-Reply-To: <ZzrpT6DjykCOJwUB@...1296...>
From: =?UTF-8?B?16DXqteZINep15jXqNef?= <nsh531@...277...>
Date: Mon, 18 Nov 2024 09:25:47 +0200
Message-ID: <CAC8x_z18gdgGfgSkH4w2hy5KJ8qkbTWXMyjNe592bLGe6ipzsA@...278...>
Content-Type: multipart/alternative; boundary="000000000000f63e0706272ad371"
Subject: Re: [Openvpn-devel] Subject: Potential OpenVPN Vulnerability
 Report: Repeated TLS Handshake Failures Leading to Denial-of-Service
 Conditions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>, SECURITY@...515...

--000000000000f63e0706272ad371
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Do you want the configuration file?

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=D7=
=B3, 18 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-9:14 =D7=9E=D7=90=D7=AA =
=E2=80=AAGert Doering=E2=80=AC=E2=80=8F <=E2=80=AA
gert@...1296...=E2=80=AC=E2=80=8F>:=E2=80=AC

> Hi,
>
> On Mon, Nov 18, 2024 at 09:09:57AM +0200, ?????? ???????? wrote:
> > I don't have access to server logs, I sent you the client logs as well =
as
> > the line pointing to the DoS:
> > TLS Error: TLS key negotiation failed to occur within 5 seconds
> > SIGUSR1[soft,tls-error] received, process restarting
>
> What makes you think it's a DoS that can be fixed by a code change?
>
> If you break the network, programs will not be able to connect - and there
> is nothing "a patch to the software" will be able to fix.
>
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never
> doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>
> Gert Doering - Munich, Germany
> gert@...1296...
>


--=20
<https://netanel.ml>

--000000000000f63e0706272ad371
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"rtl"><div dir=3D"ltr">Do you want the configuration file?</div>=
</div><br><div class=3D"gmail_quote"><div dir=3D"rtl" class=3D"gmail_attr">=
=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=D7=
=B3, 18 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-9:14 =D7=9E=D7=90=D7=AA =
=E2=80=AAGert Doering=E2=80=AC=E2=80=8F &lt;=E2=80=AA<a href=3D"mailto:gert=
@...1296...">gert@...1296...</a>=E2=80=AC=E2=80=8F&gt;:=E2=80=AC<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Mon, Nov 18, 2024 at 09:09:57AM +0200, ?????? ???????? wrote:<br>
&gt; I don&#39;t have access to server logs, I sent you the client logs as =
well as<br>
&gt; the line pointing to the DoS:<br>
&gt; TLS Error: TLS key negotiation failed to occur within 5 seconds<br>
&gt; SIGUSR1[soft,tls-error] received, process restarting<br>
<br>
What makes you think it&#39;s a DoS that can be fixed by a code change?<br>
<br>
If you break the network, programs will not be able to connect - and there<=
br>
is nothing &quot;a patch to the software&quot; will be able to fix.<br>
<br>
gert<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"rtl" class=3D"gmail_s=
ignature"><div dir=3D"rtl"><a href=3D"https://netanel.ml" target=3D"_blank"=
><img width=3D"200" height=3D"51" src=3D"https://ci3.googleusercontent.com/=
mail-sig/AIorK4y1ahZg0mqH5UnDCjKIkW6FTSni5R5bezS1idSRECO6GXQ1uH3RgELXk8RqqC=
oNk3985_jsnIQnnclo"></a></div></div>

--000000000000f63e0706272ad371--

