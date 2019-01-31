MIME-Version: 1.0
References: <1548863600-491-1-git-send-email-selva.nair@...277...>
 <201901311622.x0VGMh9W035496@...2054...>
In-Reply-To: <201901311622.x0VGMh9W035496@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 31 Jan 2019 11:28:52 -0500
Message-ID: <CAKuzo_imizbBHBYHrNMb+8UP3auvin7R6u9UXTbHOEt9u1wpFQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000a186eb0580c386a2"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Handle PSS padding in
 cryptoapicert
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000a186eb0580c386a2
Content-Type: text/plain; charset="UTF-8"

Thanks.

So now the question -- do we want to support Windows builds with OpenSSL
1.1.1 in 2.4?

Selva

On Thu, Jan 31, 2019 at 11:22 AM Gert Doering <gert@...1296...> wrote:

> Your patch has been applied to the master branch.
>
> (Test built on ubuntu 16.04 / mingw, not really tested as such)
>
> commit ce1c1beef1eb9ea776e00861117f72c4a1a6f1f8
> Author: Selva Nair
> Date:   Wed Jan 30 10:53:20 2019 -0500
>
>      Handle PSS padding in cryptoapicert
>
>      Signed-off-by: Selva Nair <selva.nair@...277...>
>      Acked-by: Arne Schwabe <arne@...1227...>
>      Message-Id: <1548863600-491-1-git-send-email-selva.nair@...277...>
>      URL:
> https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18188.html
>      Signed-off-by: Gert Doering <gert@...1296...>
>
>
> --
> kind regards,
>
> Gert Doering
>
>

--000000000000a186eb0580c386a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Thanks.<br><br></div>So now the question -- do w=
e want to support Windows builds with OpenSSL 1.1.1 in 2.4?<br><br></div>Se=
lva<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Thu, Jan 31, 2019 at 11:22 AM Gert Doering &lt;<a href=3D"mailto:=
gert@...1296...">gert@...1296...</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Your patch has been applied to the master =
branch.<br>
<br>
(Test built on ubuntu 16.04 / mingw, not really tested as such)<br>
<br>
commit ce1c1beef1eb9ea776e00861117f72c4a1a6f1f8<br>
Author: Selva Nair<br>
Date:=C2=A0 =C2=A0Wed Jan 30 10:53:20 2019 -0500<br>
<br>
=C2=A0 =C2=A0 =C2=A0Handle PSS padding in cryptoapicert<br>
<br>
=C2=A0 =C2=A0 =C2=A0Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.n=
air@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0Acked-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1711...=
27..." target=3D"_blank">arne@...1227...</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0Message-Id: &lt;<a href=3D"mailto:1548863600-491-1-git-=
send-email-selva.nair@...277..." target=3D"_blank">1548863600-491-1-git-sen=
d-email-selva.nair@...277...</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0URL: <a href=3D"https://www.mail-archive.com/openvpn-de=
vel@lists.sourceforge.net/msg18188.html" rel=3D"noreferrer" target=3D"_blan=
k">https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg1818=
8.html</a><br>
=C2=A0 =C2=A0 =C2=A0Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@=
...1296..." target=3D"_blank">gert@...1296...</a>&gt;<br>
<br>
<br>
--<br>
kind regards,<br>
<br>
Gert Doering<br>
<br>
</blockquote></div>

--000000000000a186eb0580c386a2--

