MIME-Version: 1.0
References: <CAAUX2SWYWhU-S97Ak-6XdAVQ+hty_Y8RHu_KSM8hZPiKaP7a1w@...278...>
 <e9f619bb-bd36-c77a-5f66-e7c33f6be579@...1227...>
In-Reply-To: <e9f619bb-bd36-c77a-5f66-e7c33f6be579@...1227...>
From: Tony He <huangya90@...277...>
Date: Thu, 4 Mar 2021 10:10:31 +0800
Message-ID: <CAAUX2SVde3STTxGmthXod2-pDzLPYkm+yRYvG1T4yyJGoLMKLw@...278...>
Content-Type: multipart/alternative; boundary="0000000000007d33b905bcac79cd"
Subject: Re: [Openvpn-devel] Segmentation fault in OpenVPN 2.6_git
 [git:dco/fcc852a9b2ea832c]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Antonio Quartulli <antonio@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000007d33b905bcac79cd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Arne Schwabe <arne@...1227...> =E4=BA=8E2021=E5=B9=B43=E6=9C=883=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:56=E5=86=99=E9=81=93=EF=BC=9A

> Am 03.03.21 um 08:46 schrieb Tony He:
> > Hi Arne,
> >
> > I encountered segmentation fault in your dco branch. Master branch is
> > OK. I reverted the commit "Linux data-channel offload support", but it
> > still happens.
> > Anything wrong? Can you reproduce?
>
> OpenVPN without any encryption or TLS is not something I tested.
> Consider this obscure mode broken as part of being a preview release.
>

So can you reproduce this issue at your side? Did you just test static key?
Can you paste your commands or configurations=EF=BC=9F


> Thanks for the report.
>
> Arne
>

--0000000000007d33b905bcac79cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">Arne Schwabe &lt;<a href=3D"mailto:arne@...1227...">a=
rne@...1227...</a>&gt; =E4=BA=8E2021=E5=B9=B43=E6=9C=883=E6=97=A5=E5=91=A8=
=E4=B8=89 =E4=B8=8B=E5=8D=887:56=E5=86=99=E9=81=93=EF=BC=9A<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Am 03.03.21 um 08:46 schrieb To=
ny He:<br>
&gt; Hi Arne,<br>
&gt; <br>
&gt; I encountered segmentation fault in your dco branch. Master branch is<=
br>
&gt; OK. I reverted the commit=C2=A0&quot;Linux data-channel offload suppor=
t&quot;, but it<br>
&gt; still happens.<br>
&gt; Anything wrong? Can you reproduce?<br>
<br>
OpenVPN without any encryption or TLS is not something I tested.<br>
Consider this obscure mode broken as part of being a preview release.<br></=
blockquote><div><br></div><div>So can you reproduce this issue at your side=
? Did you just test static key? Can you paste your commands or configuratio=
ns=EF=BC=9F</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
Thanks for the report.<br>
<br>
Arne<br>
</blockquote></div></div>

--0000000000007d33b905bcac79cd--

