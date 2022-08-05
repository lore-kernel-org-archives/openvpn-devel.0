MIME-Version: 1.0
References: <Yt2Fdvaom94pVcOQ@...2684...> <Yt2Wqc2zTdyx5Zj5@...1296...>
 <Yt2Zkt1K5ThfAaYn@...1296...>
In-Reply-To: <Yt2Zkt1K5ThfAaYn@...1296...>
From: Angel Abad <angel@...334...>
Date: Fri, 5 Aug 2022 08:58:05 +0200
Message-ID: <CAHV-TD7uaLPC=FcQisWJDL4VWSQx=65r8mAsHJBZMYSk0K7+Cg@...278...>
Content-Type: multipart/alternative; boundary="00000000000090cd6905e578fd88"
Subject: Re: [Openvpn-devel] [PATCH] PUSH_BUNDLE_SIZE is too short
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000090cd6905e578fd88
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, sorry for my late reply!

We use on server side managed AWS Clientvpn product[1], but we havent the
problem with macosX or windows laptops, only with linux (ubuntu, centos and
debian).

Bye,

[1]
https://docs.aws.amazon.com/es_es/vpn/latest/clientvpn-admin/what-is.html

El dom, 24 jul 2022 a las 21:12, Gert Doering (<gert@...1296...>)
escribi=C3=B3:

> Hi,
>
> On Sun, Jul 24, 2022 at 08:59:53PM +0200, Gert Doering wrote:
> > Can you please show a log file that demonstrates the problem?
>
> Oh, and "what software is running on the server side"?  Long push replys
> have to be split, and if there is something non-official which does not
> split the to-be-sent records as the official server does, it's not a
> client side bug.
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
Angel Abad
angel@...334... | angelabad@...2688... | angelabad@...277...
https://angelabad.me
FPR: 4A08 9719 1621 CCF7 FBEE  F752 A6D5 8816 010A 1096

--00000000000090cd6905e578fd88
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, sorry for my=C2=A0late reply!<div><br></div><div>We us=
e on server side managed AWS Clientvpn product[1], but we havent=C2=A0the p=
roblem with macosX or windows laptops, only with linux (ubuntu, centos and =
debian).</div><div><br></div><div>Bye,</div><div><br></div><div>[1]=C2=A0<a=
 href=3D"https://docs.aws.amazon.com/es_es/vpn/latest/clientvpn-admin/what-=
is.html">https://docs.aws.amazon.com/es_es/vpn/latest/clientvpn-admin/what-=
is.html</a></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">El dom, 24 jul 2022 a las 21:12, Gert Doering (&lt;<a href=
=3D"mailto:gert@...1296...">gert@...1296...</a>&gt;) escribi=C3=B3:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Sun, Jul 24, 2022 at 08:59:53PM +0200, Gert Doering wrote:<br>
&gt; Can you please show a log file that demonstrates the problem?<br>
<br>
Oh, and &quot;what software is running on the server side&quot;?=C2=A0 Long=
 push replys<br>
have to be split, and if there is something non-official which does not<br>
split the to-be-sent records as the official server does, it&#39;s not a<br>
client side bug.<br>
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
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Angel Abad<br><a href=3D"m=
ailto:angel@...334..." target=3D"_blank">angel@...334...</a> | <a href=3D"m=
ailto:angelabad@...2688..." target=3D"_blank">angelabad@...2688...</a> | <a=
 href=3D"mailto:angelabad@...277..." target=3D"_blank">angelabad@...277...<=
/a><br><a href=3D"https://angelabad.me" target=3D"_blank">https://angelabad=
.me</a><br>FPR: 4A08 9719 1621 CCF7 FBEE =C2=A0F752 A6D5 8816 010A 1096</di=
v></div></div>

--00000000000090cd6905e578fd88--

