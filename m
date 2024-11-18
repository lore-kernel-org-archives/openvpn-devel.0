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
In-Reply-To: <CAC8x_z25-XQEyk0O34nKFMMj-mXNR2r+WbbaseX70mzzZKT+QA@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 18 Nov 2024 08:26:46 +0100
Message-ID: <CAFHpkQHu_Mdt8e-0qpRwJaUAODqsodGUpAGXAwjgh7-9SZbuLA@...278...>
Content-Type: multipart/alternative; boundary="0000000000006cdf2106272ad75f"
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
To: =?UTF-8?B?16DXqteZINep15jXqNef?= <nsh531@...277...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Gert Doering <gert@...1296...>, Antonio Quartulli <antonio@...515...>, SECURITY@...515...

--0000000000006cdf2106272ad75f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That must be investigated together with server side logs.

Generally, some packet lost can lead to this, I see similar issues from
time to time.

On Mon, Nov 18, 2024, 08:11 =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=9F <ns=
h531@...277...> wrote:

> Hello,
> I don't have access to server logs, I sent you the client logs as well as
> the line pointing to the DoS:
> TLS Error: TLS key negotiation failed to occur within 5 seconds
> SIGUSR1[soft,tls-error] received, process restarting
>
> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=90=
=D7=B3, 17 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-21:09 =D7=9E=D7=90=D7=
=AA =E2=80=AAArne Schwabe=E2=80=AC=E2=80=8F <=E2=80=AA
> arne@...1227...=E2=80=AC=E2=80=8F>:=E2=80=AC
>
>> We asked you for many things in the past mails. We expect to do ALL these
>> things to properly report the issue. Not just one of them. E.g. logs of
>> server, usage of a modern version, a description what the DoS vulnerabil=
ity
>> actually is and so on are still missing. Just sending the client is just
>> not enough.
>> Am 17.11.2024 um 17:16 schrieb =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=
=9F:
>>
>> i attached logs
>>
>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=90=
=D7=B3, 17 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-17:51 =D7=9E=D7=90=D7=
=AA =E2=80=AAGert Doering=E2=80=AC=E2=80=8F <=E2=80=AA
>> gert@...1296...=E2=80=AC=E2=80=8F>:=E2=80=AC
>>
>>
>
> --
> <https://netanel.ml>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--0000000000006cdf2106272ad75f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">That must be investigated together with server side logs.=
<div dir=3D"auto"><br></div><div dir=3D"auto">Generally, some packet lost c=
an lead to this, I see similar issues from time=C2=A0to time.=C2=A0</div></=
div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Mon, Nov 18, 2024, 08:11 =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=9F &lt;<=
a href=3D"mailto:nsh531@...277...">nsh531@...277...</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex"><div dir=3D"rtl"><div dir=3D"rtl"><div styl=
e=3D"direction:ltr">Hello,</div><div style=3D"direction:ltr">I don&#39;t ha=
ve access to server logs, I sent you the client logs as well as the line po=
inting to the DoS:</div><div style=3D"direction:ltr">TLS Error: TLS key neg=
otiation failed to occur within 5 seconds</div><div style=3D"direction:ltr"=
>SIGUSR1[soft,tls-error] received, process restarting</div></div><div style=
=3D"direction:ltr"><br></div><div class=3D"gmail_quote"><div dir=3D"rtl" cl=
ass=3D"gmail_attr" style=3D"direction:ltr">=E2=80=AB=D7=91=D7=AA=D7=90=D7=
=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=90=D7=B3, 17 =D7=91=D7=A0=D7=95=D7=
=91=D7=B3 2024 =D7=91-21:09 =D7=9E=D7=90=D7=AA =E2=80=AAArne Schwabe=E2=80=
=AC=E2=80=8F &lt;=E2=80=AA<a href=3D"mailto:arne@...1227..." target=3D"_bla=
nk" rel=3D"noreferrer">arne@...1227...</a>=E2=80=AC=E2=80=8F&gt;:=E2=80=AC<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><u></u>

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
=80=8F &lt;=E2=80=AA<a href=3D"mailto:gert@...1296..." target=3D"_blank" re=
l=3D"noreferrer">gert@...1296...</a>=E2=80=AC=E2=80=8F&gt;:=E2=80=AC</div>
      </div>
    </blockquote>
  </div>

</blockquote></div><div style=3D"direction:ltr"><br clear=3D"all"></div><di=
v style=3D"direction:ltr"><br></div><span class=3D"gmail_signature_prefix">=
<div style=3D"direction:ltr">--</div></span><div dir=3D"rtl" class=3D"gmail=
_signature"><div dir=3D"rtl" style=3D"direction:ltr"><a href=3D"https://net=
anel.ml" target=3D"_blank" rel=3D"noreferrer"><img width=3D"200" height=3D"=
51" src=3D"https://ci3.googleusercontent.com/mail-sig/AIorK4y1ahZg0mqH5UnDC=
jKIkW6FTSni5R5bezS1idSRECO6GXQ1uH3RgELXk8RqqCoNk3985_jsnIQnnclo"></a></div>=
</div></div>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank" re=
l=3D"noreferrer">Openvpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://lists.sourceforge.net/=
lists/listinfo/openvpn-devel</a><br>
</blockquote></div>

--0000000000006cdf2106272ad75f--

