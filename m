MIME-Version: 1.0
References: <1538576212-2363-1-git-send-email-lstipakov@...277...>
 <CAKuzo_ijYi_qnpRJmNOUQpg9VEsPeqSwZS5d8VYuMNcMDNgw-w@...278...>
 <CAGyAFMVaLFpBNAdFuvBSMZmw8aFpSMm3dawQRC1Sb+AVTwrY+A@...278...>
In-Reply-To: <CAGyAFMVaLFpBNAdFuvBSMZmw8aFpSMm3dawQRC1Sb+AVTwrY+A@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 3 Oct 2018 13:10:31 -0400
Message-ID: <CAKuzo_iMLOt6Y_iNffbsKQKJQh=Xq2y8feE+BkCUbb=Eu7xa6Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000b946970577561e85"
Subject: Re: [Openvpn-devel] [PATCH] openvpnserv: clarify return values type
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000b946970577561e85
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Oct 3, 2018 at 12:56 PM Lev Stipakov <lstipakov@...277...> wrote:

> Hi,
>
> Wishlist: openvpn_swprintf() with nul termination guarantee. I try to avoid
>> the TCHAR variety be explicit about wide and narrow characters.
>>
>
> Makes sense, at the moment we have 8 swprintf calls all followed by
> something like
>
>  > tmp[_countof(tmp)-1] = L'\0';
>

That must be me --- nul termination paranoia :) Cant blame, given none of
these x[n]printf variants
guarantee nul termination in spite of taking the buffer length as an input..

Selva

--000000000000b946970577561e85
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><br><div class=3D"gmail_quote"><div dir=3D"ltr=
">On Wed, Oct 3, 2018 at 12:56 PM Lev Stipakov &lt;<a href=3D"mailto:lstipa=
kov@...277...">lstipakov@...277...</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br><div class=3D"=
gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"=
ltr"><div class=3D"gmail_quote"><div>Wishlist: openvpn_swprintf() with nul =
termination guarantee. I try to avoid<br>the TCHAR variety be explicit abou=
t wide and narrow characters.</div></div></div></blockquote><div><br></div>=
<div>Makes sense, at the moment we have 8 swprintf calls all followed by so=
mething like</div><div><br></div><div>=C2=A0&gt; tmp[_countof(tmp)-1] =3D L=
&#39;\0&#39;;<br></div></div></div></div></div></blockquote><div><br></div>=
<div>That must be me --- nul termination paranoia :) Cant blame, given none=
 of these x[n]printf variants<br>guarantee nul termination in spite of taki=
ng the buffer length as an input..<br></div><div><br></div><div>Selva</div>=
</div></div></div>

--000000000000b946970577561e85--

