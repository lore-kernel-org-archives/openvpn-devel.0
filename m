MIME-Version: 1.0
References: <CAC8x_z10PT_ToTzVUKQENA5ZJgJ4EMvBJARphDR5_wdytA2JSw@...278...>
 <b7c9a1ac-3322-4eeb-befd-e19c7f72da6b@...1227...>
 <CAC8x_z3Fwf0r-BuvuOo+Vg0708fsaPGWjg-2pnY3xgM+e4QxDg@...278...>
 <Zzm_gUxTAmFZjm_h@...1296...>
 <CAC8x_z1OtkMeuRCHNOHfg-rcJ3Kcj2uHua3pzK5ZqKJDjPvBjQ@...278...>
 <ZzoQ7jXbImL56HL6@...1296...>
 <CAC8x_z2=DL=t2V5oN_hBMLbYcVMH78XqbTLguxFifjDco+zWyQ@...278...>
 <2dae1148-45d8-4f82-8b65-973b81a18645@...1227...>
In-Reply-To: <2dae1148-45d8-4f82-8b65-973b81a18645@...1227...>
From: =?UTF-8?B?16DXqteZINep15jXqNef?= <nsh531@...277...>
Date: Mon, 18 Nov 2024 09:09:57 +0200
Message-ID: <CAC8x_z25-XQEyk0O34nKFMMj-mXNR2r+WbbaseX70mzzZKT+QA@...278...>
Content-Type: multipart/alternative; boundary="00000000000049cdc106272a9b6d"
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
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, Antonio Quartulli <antonio@...515...>, openvpn-devel@lists.sourceforge.net, SECURITY@...515...

--00000000000049cdc106272a9b6d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
I don't have access to server logs, I sent you the client logs as well as
the line pointing to the DoS:
TLS Error: TLS key negotiation failed to occur within 5 seconds
SIGUSR1[soft,tls-error] received, process restarting

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=90=D7=
=B3, 17 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-21:09 =D7=9E=D7=90=D7=AA=
 =E2=80=AAArne Schwabe=E2=80=AC=E2=80=8F <=E2=80=AAarne@...1227...
=E2=80=AC=E2=80=8F>:=E2=80=AC

> We asked you for many things in the past mails. We expect to do ALL these
> things to properly report the issue. Not just one of them. E.g. logs of
> server, usage of a modern version, a description what the DoS vulnerabili=
ty
> actually is and so on are still missing. Just sending the client is just
> not enough.
> Am 17.11.2024 um 17:16 schrieb =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=
=9F:
>
> i attached logs
>
> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=90=
=D7=B3, 17 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-17:51 =D7=9E=D7=90=D7=
=AA =E2=80=AAGert Doering=E2=80=AC=E2=80=8F <=E2=80=AA
> gert@...1296...=E2=80=AC=E2=80=8F>:=E2=80=AC
>
>

--
<https://netanel.ml>

--00000000000049cdc106272a9b6d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"rtl"><div dir=3D"rtl"><div style=3D"direction:ltr">Hello,</div>=
<div style=3D"direction:ltr">I don&#39;t have access to server logs, I sent=
 you the client logs as well as the line pointing to the DoS:</div><div sty=
le=3D"direction:ltr">TLS Error: TLS key negotiation failed to occur within =
5 seconds</div><div style=3D"direction:ltr">SIGUSR1[soft,tls-error] receive=
d, process restarting</div></div><div style=3D"direction:ltr"><br></div><di=
v class=3D"gmail_quote"><div dir=3D"rtl" class=3D"gmail_attr" style=3D"dire=
ction:ltr">=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D=
 =D7=90=D7=B3, 17 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-21:09 =D7=9E=
=D7=90=D7=AA =E2=80=AAArne Schwabe=E2=80=AC=E2=80=8F &lt;=E2=80=AA<a href=
=3D"mailto:arne@...1227...">arne@...1227...</a>=E2=80=AC=E2=80=8F&gt;:=E2=
=80=AC<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><u></u>

=20=20
=20=20=20=20
=20=20
  <div>
    <p style=3D"direction:ltr">We asked you for many things in the past mai=
ls. We expect to do
      ALL these things to properly report the issue. Not just one of
      them. E.g. logs of server, usage of a modern version, a
      description what the DoS vulnerability actually is and so on are
      still missing. Just sending the client is just not enough. <br>
    </p>
    <div style=3D"direction:ltr">Am 17.11.2024 um 17:16 schrieb =D7=A0=D7=
=AA=D7=99
      =D7=A9=D7=98=D7=A8=D7=9F:<br>
    </div>
    <blockquote type=3D"cite">
=20=20=20=20=20=20
      <div dir=3D"rtl">
        <div dir=3D"ltr">i attached logs <br>
        </div>
      </div>
      <div style=3D"direction:ltr"><br></div>
      <div class=3D"gmail_quote">
        <div dir=3D"rtl" class=3D"gmail_attr" style=3D"direction:ltr">=E2=
=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=90=D7=B3,=
 17 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024
          =D7=91-17:51 =D7=9E=D7=90=D7=AA =E2=80=AAGert Doering=E2=80=AC=E2=
=80=8F &lt;=E2=80=AA<a href=3D"mailto:gert@...1296..." target=3D"_blank">ge=
rt@...1296...</a>=E2=80=AC=E2=80=8F&gt;:=E2=80=AC</div>
      </div>
    </blockquote>
  </div>

</blockquote></div><div style=3D"direction:ltr"><br clear=3D"all"></div><di=
v style=3D"direction:ltr"><br></div><span class=3D"gmail_signature_prefix">=
<div style=3D"direction:ltr">--</div></span><div dir=3D"rtl" class=3D"gmail=
_signature"><div dir=3D"rtl" style=3D"direction:ltr"><a href=3D"https://net=
anel.ml" target=3D"_blank"><img width=3D"200" height=3D"51" src=3D"https://=
ci3.googleusercontent.com/mail-sig/AIorK4y1ahZg0mqH5UnDCjKIkW6FTSni5R5bezS1=
idSRECO6GXQ1uH3RgELXk8RqqCoNk3985_jsnIQnnclo"></a></div></div></div>

--00000000000049cdc106272a9b6d--

