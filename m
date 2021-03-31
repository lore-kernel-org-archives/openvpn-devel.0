MIME-Version: 1.0
References: <CAAUX2SVQRn4zuDC947HE9M38nDNK1oNqyUv0GKeAw2dasHo62Q@...278...>
 <ad7e8624-6f87-2874-9786-d5de521bc6a2@...2181...>
 <f10fc09e-5d7b-c678-02f8-04f80f004b24@...2181...>
 <CAAUX2SUZ3X6VUiASQePp2WCX-hr7A21B6ZW5GnFQzr8jUP0+Xw@...278...>
 <82a1a09d-e557-144f-7f08-307a11877018@...2181...>
In-Reply-To: <82a1a09d-e557-144f-7f08-307a11877018@...2181...>
From: Tony He <huangya90@...277...>
Date: Wed, 31 Mar 2021 15:56:13 +0800
Message-ID: <CAAUX2SWjyUoZ2YLkSPNawW51Pfnjs8A4uhH8A25gX9f2MffCBg@...278...>
Content-Type: multipart/alternative; boundary="00000000000094133905bed073d1"
Subject: Re: [Openvpn-devel] [ovpn-dco] sudden network disconnection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000094133905bed073d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Antonio Quartulli <a@...2181...> =E4=BA=8E2021=E5=B9=B43=E6=9C=8831=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=883:32=E5=86=99=E9=81=93=EF=BC=9A

> Hi,
>
> On 31/03/2021 09:29, Tony He wrote:
> > Hi Arne,
> >
> > I'm going to test encryption "none" to narrow down this issue, but I
> > found your dco branch doesn't support this.
> > Can you support?
>
> For the sake of this test, could you use the ovpn-cli.c tool in the
> ovpn-dco/tests folder? Or that's not an option?
>
Because of cross-compilation,  I need to put ovpn-cli.c into the buildroot.
This needs some work.
But Arne's openvpn dco branch is already in. Anyway, I will have a try.

Tony

--00000000000094133905bed073d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Antonio Quartulli &lt;a@...2181...&gt=
; =E4=BA=8E2021=E5=B9=B43=E6=9C=8831=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=
=E5=8D=883:32=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Hi,<br>
<br>
On 31/03/2021 09:29, Tony He wrote:<br>
&gt; Hi Arne,<br>
&gt; <br>
&gt; I&#39;m going to test encryption &quot;none&quot; to narrow down this =
issue, but I<br>
&gt; found your dco branch doesn&#39;t support this.=C2=A0<br>
&gt; Can you support?<br>
<br>
For the sake of this test, could you use the ovpn-cli.c tool in the<br>
ovpn-dco/tests folder? Or that&#39;s not an option?<br></blockquote><div>Be=
cause of cross-compilation,=C2=A0 I need to put ovpn-cli.c into the buildro=
ot. This needs some work.</div><div>But Arne&#39;s openvpn dco branch is al=
ready in. Anyway, I will have a try.</div><div><br></div><div>Tony=C2=A0</d=
iv></div></div>

--00000000000094133905bed073d1--

