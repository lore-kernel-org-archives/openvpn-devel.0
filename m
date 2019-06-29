MIME-Version: 1.0
References: <CAKuzo_j6F2+_JxosdVF3iB4kzWsR7Wq2FT8Vgi9Cg3yvT_A1JQ@...278...>
 <20190628210334.GU1097@...1296...>
 <CAKuzo_ji9qNyc1vtQRhuuuYXgmpb6Qey2+L7GRqbhLNqbSwx9A@...278...>
 <20190629095732.GV1097@...1296...>
In-Reply-To: <20190629095732.GV1097@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Sat, 29 Jun 2019 17:34:51 +0300
Message-ID: <CAGyAFMVxD3+jZ+RR_U-x46Z89DV-feqyXcV599=SaogW-0Qgsw@...278...>
Content-Type: multipart/alternative; boundary="000000000000cb4c20058c774cef"
Subject: Re: [Openvpn-devel] Using AllowNonAdmin in the advanced options of
 tap adapter
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000cb4c20058c774cef
Content-Type: text/plain; charset="UTF-8"

Hi,

So Lev's patch proposes to do service calls for wintun *and* tap6, and
> do so "always"?  Or only if the registry key says so?
>

Yep, patch always opens wintun and tap6 via service no matter what
registry key says.

> For some reason that registry key appears to be doing nothing in
> > current versions of tap-windows6. I know this is confusing...
>
> This sounds like a bug...
>

Indeed that registry key is confusing. If we fix it in tap6, won't we break
existing setups, which open tap6
from unprivileged process and do not use --allow-nonadmin?

-- 
-Lev

--000000000000cb4c20058c774cef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div dir=3D"ltr"><br></div><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">So =
Lev&#39;s patch proposes to do service calls for wintun *and* tap6, and<br>
do so &quot;always&quot;?=C2=A0 Or only if the registry key says so?<br></b=
lockquote><div><br></div><div>Yep, patch always opens wintun and tap6 via s=
ervice no matter=C2=A0what</div><div>registry key says.</div><div><br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; For some reason tha=
t registry key appears to be doing nothing in<br>
&gt; current versions of tap-windows6. I know this is confusing...<br>
<br>
This sounds like a bug...<br></blockquote><div><br></div><div>Indeed that r=
egistry key is confusing. If we fix it in tap6, won&#39;t we break existing=
 setups, which open tap6</div><div>from unprivileged process and do not use=
 --allow-nonadmin?</div><div><br></div></div>-- <br><div dir=3D"ltr" class=
=3D"gmail_signature">-Lev</div></div>

--000000000000cb4c20058c774cef--

