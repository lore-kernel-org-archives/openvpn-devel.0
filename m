MIME-Version: 1.0
References: <CAC8x_z0gMKW1b33J3HGL-9pQnXgpf9O6pRu+M2=xP03JyJMm6g@...278...>
 <ZzZvEOjQ4PQ3gF-2@...1296...>
 <CAC8x_z3reFPQWPNuoB-GjqkQtEgcgGapHWKUVt=OXvMoW6NCFg@...278...>
In-Reply-To: <CAC8x_z3reFPQWPNuoB-GjqkQtEgcgGapHWKUVt=OXvMoW6NCFg@...278...>
From: =?UTF-8?B?16DXqteZINep15jXqNef?= <nsh531@...277...>
Date: Fri, 15 Nov 2024 14:37:14 +0200
Message-ID: <CAC8x_z1jmeg+4DvahuMhc5AsEg=-Kkq9G6m08LtPQWX0FkDgPw@...278...>
Content-Type: multipart/alternative; boundary="00000000000042a67c0626f2d4a4"
Subject: Re: [Openvpn-devel] Subject: OpenVPN Client Vulnerability - TLS Key
 Negotiation Timeout Leading to DoS (Black Box Pentest)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Openvpn-devel@lists.sourceforge.net
Cc: SECURITY@...515...

--00000000000042a67c0626f2d4a4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=95=D7=
=B3, 15 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-14:31 =D7=9E=D7=90=D7=AA=
 =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=9F <=E2=80=AAnsh531@...277...=E2=
=80=AC=E2=80=8F>:=E2=80=AC

> Is it cve/vdp?
> Whether it is or not, I would appreciate it if you could guide me on how
> to develop a patch that will close the aforementioned loophole
>
>
> thanks,
>
> Netanel
>
> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=94=
=D7=B3, 14 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-23:43 =D7=9E=D7=90=D7=
=AA =E2=80=AAGert Doering=E2=80=AC=E2=80=8F <=E2=80=AA
> gert@...1296...=E2=80=AC=E2=80=8F>:=E2=80=AC
>
>> Hi,
>>
>> On Thu, Nov 14, 2024 at 10:12:35PM +0200, ?????? ???????? wrote:
>> > I am writing to responsibly disclose a vulnerability discovered during=
 a
>> > black box penetration testing engagement. The vulnerability affects the
>> > OpenVPN client (v2.4.12, x86_64-pc-linux-gnu) and can lead to a
>> > denial-of-service (DoS) condition due to repeated TLS key negotiation
>> > timeouts.
>>
>> 2.4.x is end of everything since March 2022.
>>
>> The current stable branch is 2.6.x, and we do maintain 2.5.x for severe
>> bugs.
>>
>>   https://community.openvpn.net/openvpn/wiki/SupportedVersions
>>
>> Quite a bit of effort has been put into making the TLS handshake
>> (assuming tls-crypt-v2 is used) more robust in 2.6.0 - so if your
>> results are applicatble to 2.6.0 with tls-crypt-v2, we're happy to
>> listen.
>>
>> gert
>> --
>> "If was one thing all people took for granted, was conviction that if you
>>  feed honest figures into a computer, honest figures come out. Never
>> doubted
>>  it myself till I met a computer with a sense of humor."
>>                              Robert A. Heinlein, The Moon is a Harsh
>> Mistress
>>
>> Gert Doering - Munich, Germany
>> gert@...1296...
>>
>
>
> --
> <https://netanel.ml>
>


--=20
<https://netanel.ml>

--00000000000042a67c0626f2d4a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"rtl"><br></div><br><div class=3D"gmail_quote"><div dir=3D"rtl" =
class=3D"gmail_attr">=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=
=D7=95=D7=9D =D7=95=D7=B3, 15 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-14=
:31 =D7=9E=D7=90=D7=AA =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=9F &lt;=E2=
=80=AA<a href=3D"mailto:nsh531@...277...">nsh531@...277...</a>=E2=80=AC=E2=
=80=8F&gt;:=E2=80=AC<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div dir=3D"rtl"><div dir=3D"rtl"><div dir=3D"rtl"><div style=3D"direc=
tion:ltr">Is it cve/vdp?</div><div style=3D"direction:ltr">Whether it is or=
 not, I would appreciate it if you could guide me on how to develop a patch=
 that will close the aforementioned loophole</div><div style=3D"direction:l=
tr"><br></div><div style=3D"direction:ltr"><br></div><div dir=3D"ltr">thank=
s,</div><div dir=3D"ltr"><br></div><div style=3D"direction:ltr">Netanel</di=
v></div><div style=3D"direction:ltr"><br></div><div class=3D"gmail_quote"><=
div dir=3D"rtl" class=3D"gmail_attr" style=3D"direction:ltr">=E2=80=AB=D7=
=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=94=D7=B3, 14 =D7=
=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-23:43 =D7=9E=D7=90=D7=AA =E2=80=AAG=
ert Doering=E2=80=AC=E2=80=8F &lt;=E2=80=AA<a href=3D"mailto:gert@...2132...=
." target=3D"_blank">gert@...1296...</a>=E2=80=AC=E2=80=8F&gt;:=E2=80=AC<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><div style=3D"dire=
ction:ltr">Hi,</div>
<div style=3D"direction:ltr"><br></div><div style=3D"direction:ltr">On Thu,=
 Nov 14, 2024 at 10:12:35PM +0200, ?????? ???????? wrote:</div><div style=
=3D"direction:ltr">&gt; I am writing to responsibly disclose a vulnerabilit=
y discovered during a</div><div style=3D"direction:ltr">&gt; black box pene=
tration testing engagement. The vulnerability affects the</div><div style=
=3D"direction:ltr">&gt; OpenVPN client (v2.4.12, x86_64-pc-linux-gnu) and c=
an lead to a</div><div style=3D"direction:ltr">&gt; denial-of-service (DoS)=
 condition due to repeated TLS key negotiation</div><div style=3D"direction=
:ltr">&gt; timeouts.</div>
<div style=3D"direction:ltr"><br></div><div style=3D"direction:ltr">2.4.x i=
s end of everything since March 2022.</div>
<div style=3D"direction:ltr"><br></div><div style=3D"direction:ltr">The cur=
rent stable branch is 2.6.x, and we do maintain 2.5.x for severe bugs.</div>
<div style=3D"direction:ltr"><br></div><div style=3D"direction:ltr">=C2=A0=
=C2=A0<a href=3D"https://community.openvpn.net/openvpn/wiki/SupportedVersio=
ns" rel=3D"noreferrer" target=3D"_blank">https://community.openvpn.net/open=
vpn/wiki/SupportedVersions</a></div>
<div style=3D"direction:ltr"><br></div><div style=3D"direction:ltr">Quite a=
 bit of effort has been put into making the TLS handshake</div><div style=
=3D"direction:ltr">(assuming tls-crypt-v2 is used) more robust in 2.6.0 - s=
o if your</div><div style=3D"direction:ltr">results are applicatble to 2.6.=
0 with tls-crypt-v2, we&#39;re happy to</div><div style=3D"direction:ltr">l=
isten.</div>
<div style=3D"direction:ltr"><br></div><div style=3D"direction:ltr">gert</d=
iv><div style=3D"direction:ltr">--</div><div style=3D"direction:ltr">&quot;=
If was one thing all people took for granted, was conviction that if you</d=
iv><div style=3D"direction:ltr">=C2=A0feed honest figures into a computer, =
honest figures come out. Never doubted</div><div style=3D"direction:ltr">=
=C2=A0it myself till I met a computer with a sense of humor.&quot;</div><di=
v style=3D"direction:ltr">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, =
The Moon is a Harsh Mistress</div>
<div style=3D"direction:ltr"><br></div><div style=3D"direction:ltr">Gert Do=
ering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:gert@=
...1296..." target=3D"_blank">gert@...1296...</a></div>
</blockquote></div></div><div style=3D"direction:ltr"><br clear=3D"all"></d=
iv><div style=3D"direction:ltr"><br></div><span class=3D"gmail_signature_pr=
efix"><div style=3D"direction:ltr">--</div></span><div dir=3D"rtl" class=3D=
"gmail_signature"><div dir=3D"rtl" style=3D"direction:ltr"><a href=3D"https=
://netanel.ml" target=3D"_blank"><img width=3D"200" height=3D"51" src=3D"ht=
tps://ci3.googleusercontent.com/mail-sig/AIorK4y1ahZg0mqH5UnDCjKIkW6FTSni5R=
5bezS1idSRECO6GXQ1uH3RgELXk8RqqCoNk3985_jsnIQnnclo"></a></div></div>
</div>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"rtl" class=3D"gmail_s=
ignature"><div dir=3D"rtl"><a href=3D"https://netanel.ml" target=3D"_blank"=
><img width=3D"200" height=3D"51" src=3D"https://ci3.googleusercontent.com/=
mail-sig/AIorK4y1ahZg0mqH5UnDCjKIkW6FTSni5R5bezS1idSRECO6GXQ1uH3RgELXk8RqqC=
oNk3985_jsnIQnnclo"></a></div></div>

--00000000000042a67c0626f2d4a4--

