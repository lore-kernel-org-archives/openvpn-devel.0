MIME-Version: 1.0
References: <CADkMwqTKd1tjTboxmvgrvk9kVtHDtubvQmEQ0m=nt4GB-RtoqA@...278...>
 <CAFHpkQG10QOhGUb4R4VyPHwCNMfkVSQgCVgmypsBidsgNcsBaw@...278...>
 <CADkMwqQ+F-rLr3V5_BxjixbvnyOW6T+Y6tP---3PBaOcHkRBpA@...278...>
 <CAFHpkQExnJLdr1kNMkXoYxXjOdX4+M3KTcOfBp1ZQwmV3CkkXA@...278...>
 <CADkMwqS7AUDVz_tj0_6ewhJ7YgfJmph71dK-hCVhgOY=5+z3oA@...278...>
 <CAFHpkQHhy_w=0vSag_cqwQ=BiPStuVBzK0GOheMpjvpFFY_wAQ@...278...>
 <CADkMwqQCC_5=tWyX5HPQpPBVqwm8eoisYY=GtjLYcwx7KpN2Hg@...278...>
 <CAFHpkQHpaLNwfWvm3C6YsWE1wTRndXMJPa4QkBqcvMGTwk7=dw@...278...>
 <CADkMwqRaW_7VrDg+k0ok6ZNqaZo=FheJFz+ZW958E5HD4xX_cQ@...278...>
 <CAFHpkQGOV+g7-Fe+ANHCPAE4_Ew8fgWo3DOoeYhExyVzdr5Dfg@...278...>
 <CADkMwqTZ9F8wbYrJjmoQQ56yf+e2DwRc3MQ7y6R0E3gSL4Zf2g@...278...>
 <CAKuzo_iVf7zOFV7b-5d0gR=6Ea9RR3o0420jhNtmSAuAq1MegA@...278...>
 <CADkMwqT8_Y8C4MSw7Jxjm+D+A9irBPVtouC9o+XE+EuzP0J6Fg@...278...>
 <CAKuzo_j3z2qSsxw1G_EYFtZCqch+nNd-9=gu9MKRXX+eP2LhYQ@...278...>
 <DM5PR2101MB11120B19BDCDCC39A3C834D3B0E40@...2412...>
 <CAKuzo_iFdNEOKsBq3tJ8VKye-zh5se6LSS5BpeJxoSP5J7EK-A@...278...>
In-Reply-To: <CAKuzo_iFdNEOKsBq3tJ8VKye-zh5se6LSS5BpeJxoSP5J7EK-A@...278...>
From: Rostyslav Maryliak <rostyslav.maryliak@...2454...>
Date: Mon, 8 Oct 2018 21:13:53 +0300
Message-ID: <CADkMwqSmonP074Xu-Wgex=gQ=K89VGXDAEc-efNqD0iLGu29zQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000004d62b10577bb96bf"
Subject: Re: [Openvpn-devel] Slow outbound network speed for Windows Server
 2016 only via the OpenVPN tunnel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Jon Kunkee <jkunkee@...2393...>, openvpn-devel@lists.sourceforge.net

--0000000000004d62b10577bb96bf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Jon and Selva,

Is there any update on this?

=D0=A1=D0=B1, 6 =D0=B6=D0=BE=D0=B2=D1=82. 2018 07:24 =D0=BA=D0=BE=D1=80=D0=
=B8=D1=81=D1=82=D1=83=D0=B2=D0=B0=D1=87 Selva Nair <selva.nair@...277...> =
=D0=BF=D0=B8=D1=88=D0=B5:

> Hi
>
> On Fri, Oct 5, 2018 at 8:41 PM Jon Kunkee <jkunkee@...2393...> wrote:
>
>> > I don't know what causes this (the TAP driver?) but hopefully others
>> may chime in with some clue.
>>
>> I wonder if this will be addressed by adding the missing buffer-remaining
>> query OIDs. Unfortunately I don=E2=80=99t know enough to say for sure, b=
ut they are
>> used for protocol behavior hinting.
>>
>
> That was what I was hinting at too, but in the same boat here: not knowing
> enough about NDIS architecture I'm not in a position to make a patch for
> the missing OIDs.
>
> That said, as server 2016 uses the same kernel as Windows 10 (doesn't it?)
> such issues should show up on that platform too. Or are there some network
> protocol improvements that are enabled only on server 2016?
>
> Selva
>

--=20
CONFIDENTIALITY NOTE:
The information transmitted, including attachments,

is intended only for the person(s) or entity to which it is addressed and

may contain confidential and/or privileged material. Any review,

retransmission, dissemination or other use of, or taking of any action in

reliance upon this information by persons or entities other than the

intended recipient is prohibited. If you received this in error, please

contact the sender and destroy any copies of this information.

--0000000000004d62b10577bb96bf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Dear Jon and Selva,<div dir=3D"auto"><br></div><div dir=
=3D"auto">Is there any update on this?</div></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr">=D0=A1=D0=B1, 6 =D0=B6=D0=BE=D0=B2=D1=82. 2018 07:24=
 =D0=BA=D0=BE=D1=80=D0=B8=D1=81=D1=82=D1=83=D0=B2=D0=B0=D1=87 Selva Nair &l=
t;<a href=3D"mailto:selva.nair@...277...">selva.nair@...277...</a>&gt; =D0=
=BF=D0=B8=D1=88=D0=B5:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"=
ltr">Hi<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, Oct 5, 2=
018 at 8:41 PM Jon Kunkee &lt;<a href=3D"mailto:jkunkee@...2393..." target=
=3D"_blank" rel=3D"noreferrer">jkunkee@...2393...</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">&gt; I don&#39;t know what causes this (the T=
AP driver?) but hopefully others may chime in with some clue.<br>
<br>
I wonder if this will be addressed by adding the missing buffer-remaining q=
uery OIDs. Unfortunately I don=E2=80=99t know enough to say for sure, but t=
hey are used for protocol behavior hinting.<br></blockquote><div><br></div>=
<div>That was what I was hinting at too, but in the same boat here: not kno=
wing enough about NDIS architecture I&#39;m not in a position to make a pat=
ch for the missing OIDs.</div><div><br></div><div>That said, as server 2016=
 uses the same kernel as Windows 10 (doesn&#39;t it?) such issues should sh=
ow up on that platform too. Or are there some network protocol improvements=
 that are enabled only on server 2016?</div><div><br></div><div>Selva</div>=
</div></div>
</blockquote></div>

<br>
<span style=3D"font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;fo=
nt-size:12pt"><font face=3D"Trebuchet" size=3D"2">CONFIDENTIALITY NOTE:
The information transmitted, including attachments,
is intended only for the person(s) or entity to which it is addressed and
may contain confidential and/or privileged material. Any review,
retransmission, dissemination or other use of, or taking of any action in
reliance upon this information by persons or entities other than the
intended recipient is prohibited. If you received this in error, please
contact the sender and destroy any copies of this information.</font></span=
>=

--0000000000004d62b10577bb96bf--

