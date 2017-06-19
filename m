MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <201706181321.v5IDL8W8098574@...2054...>
References: <20170612134330.20971-8-logout@...260...>
	<201706181321.v5IDL8W8098574@...2054...>
From: Emmanuel Deloget <logout@...260...>
Date: Mon, 19 Jun 2017 16:06:05 +0200
Message-ID: <CAKh=nwHrUpipAcz8HXgh1XAT2v1RtmmvuRyKukw3hS65EnZ+tw@...278...>
Content-Type: multipart/alternative; boundary="f403045df14acdd8fd055250a241"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: OpenSSL: don't use direct
 access to the internal of HMAC_CTX
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

--f403045df14acdd8fd055250a241
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gert,

On Sun, Jun 18, 2017 at 3:21 PM, Gert Doering <gert@...1296...> wrote:

> Your patch has been applied to the master and release/2.4 branch.
>
> I have not changed anything wrt _init()/reset() to not delay getting
> this in-tree before the upcoming v2.4.3 release - but if you agree to
> Steffan's comment on that, please send a followup patch which can then
> go in later.
>

=E2=80=8BI'm going to do that ASAP. =E2=80=8B


>
> (Thanks for all your work!)
>


=E2=80=8BIt's me who want to thank you all: you did a marvellous job at poi=
nting my
mistakes :) =E2=80=8B

=E2=80=8BSo thanks to you, Steffan, David, and all the other who helped me.=
 =E2=80=8B



>
> commit aba98e9050eb54d72d921e70bcd422cb892b9c6c (master)
> commit 2bf4aee4b043151bd2abe7101421fd74763f1230 (release/2.4)
> Author: Emmanuel Deloget
> Date:   Mon Jun 12 15:43:29 2017 +0200
>
>      OpenSSL: don't use direct access to the internal of HMAC_CTX
>
>      Signed-off-by: Emmanuel Deloget <logout@...260...>
>      Acked-by: Steffan Karger <steffan.karger@...1435...>
>      Message-Id: <20170612134330.20971-8-logout@...260...>
>      URL: https://www.mail-archive.com/openvpn-devel@...1199...
> sourceforge.net/msg14797.html
>      Signed-off-by: Gert Doeri
> =E2=80=8B=E2=80=8B
> ng <gert@...1296...>
>
>
> --
> kind regards,
>
> Gert Doering
>
>
=E2=80=8BBR,

-- Emmanuel Deloget=E2=80=8B

--f403045df14acdd8fd055250a241
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:courier =
new,monospace">Hi Gert,=C2=A0</div><div class=3D"gmail_extra"><br><div clas=
s=3D"gmail_quote">On Sun, Jun 18, 2017 at 3:21 PM, Gert Doering <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1386...=
296...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Your patch h=
as been applied to the master and release/2.4 branch.<br>
<br>
I have not changed anything wrt _init()/reset() to not delay getting<br>
this in-tree before the upcoming v2.4.3 release - but if you agree to<br>
Steffan&#39;s comment on that, please send a followup patch which can then<=
br>
go in later.<br></blockquote><div><br></div><div><div class=3D"gmail_defaul=
t" style=3D"font-family:&quot;courier new&quot;,monospace">=E2=80=8BI&#39;m=
 going to do that ASAP. =E2=80=8B</div></div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
<br>
(Thanks for all your work!)<br></blockquote><div><br></div><div><br></div><=
div><div class=3D"gmail_default" style=3D"font-family:&quot;courier new&quo=
t;,monospace">=E2=80=8BIt&#39;s me who want to thank you all: you did a mar=
vellous job at pointing my mistakes :) =E2=80=8B</div><br></div><div><div c=
lass=3D"gmail_default" style=3D"font-family:&quot;courier new&quot;,monospa=
ce">=E2=80=8BSo thanks to you, Steffan, David, and all the other who helped=
 me. =E2=80=8B</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
<br>
commit aba98e9050eb54d72d921e70bcd422<wbr>cb892b9c6c (master)<br>
commit 2bf4aee4b043151bd2abe7101421fd<wbr>74763f1230 (release/2.4)<br>
Author: Emmanuel Deloget<br>
Date:=C2=A0 =C2=A0Mon Jun 12 15:43:29 2017 +0200<br>
<br>
=C2=A0 =C2=A0 =C2=A0OpenSSL: don&#39;t use direct access to the internal of=
 HMAC_CTX<br>
<br>
=C2=A0 =C2=A0 =C2=A0Signed-off-by: Emmanuel Deloget &lt;<a href=3D"mailto:l=
ogout@...260...">logout@...260...</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0Acked-by: Steffan Karger &lt;<a href=3D"mailto:steffan.=
karger@...1435...">steffan.karger@...1435...</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0Message-Id: &lt;<a href=3D"mailto:20170612134330.20971-=
8-logout@...260...">20170612134330.20971-8-<wbr>logout@...260...</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0URL: <a href=3D"https://www.mail-archive.com/openvpn-de=
vel@lists.sourceforge.net/msg14797.html" rel=3D"noreferrer" target=3D"_blan=
k">https://www.mail-archive.com/<wbr>openvpn-devel@...1199...<wbr>sourcefor=
ge.net/msg14797.html</a><br>
=C2=A0 =C2=A0 =C2=A0Signed-off-by: Gert Doeri<div class=3D"gmail_default" s=
tyle=3D"font-family:&quot;courier new&quot;,monospace;display:inline">=E2=
=80=8B=E2=80=8B</div>ng &lt;<a href=3D"mailto:gert@...1296...">gert@...1726...=
...</a>&gt;<br>
<br>
<br>
--<br>
kind regards,<br>
<br>
Gert Doering<br>
<br>
</blockquote></div><br></div><div class=3D"gmail_extra"><div class=3D"gmail=
_default" style=3D"font-family:&quot;courier new&quot;,monospace">=E2=80=8B=
BR,=C2=A0</div><div class=3D"gmail_default" style=3D"font-family:&quot;cour=
ier new&quot;,monospace"><br></div><div class=3D"gmail_default" style=3D"fo=
nt-family:&quot;courier new&quot;,monospace">-- Emmanuel Deloget=E2=80=8B</=
div><br></div></div>

--f403045df14acdd8fd055250a241--

