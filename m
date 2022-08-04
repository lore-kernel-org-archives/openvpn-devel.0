MIME-Version: 1.0
References: <20220728111712.94-1-lstipakov@...277...>
In-Reply-To: <20220728111712.94-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 4 Aug 2022 10:13:20 -0400
Message-ID: <CAKuzo_idZX4Aj0KrWqdLegYJXdxxxt5nFqxpHzBY9Dg_rFCztw@...278...>
Content-Type: multipart/alternative; boundary="0000000000007f764d05e56af5b5"
Subject: Re: [Openvpn-devel] [PATCH] openvpnmsica: remove OpenVPNService
 state check code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--0000000000007f764d05e56af5b5
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Jul 28, 2022 at 7:19 AM Lev Stipakov <lstipakov@...277...> wrote:

> From: Lev Stipakov <lev@...515...>
>
> This code reads the state of OpenVPNService,
> such as startup mode and running, and sets MSI
> property value. If that property is set, installer
> selects OpenVPNService as a feature to be installed.
>
> This has been superseded by change in installer:
>
>   https://github.com/OpenVPN/openvpn-build/pull/261
>
> which, in addition to checking the state of OpenVPNService,
> applies that state to the newly installed service.
>
>   - by default, OpenVPNService feature is now checked
> and service is installed
>
>   - in clean installation, service startup mode is set to "manual"
> and service is not started
>
>   - in upgrade, installer preserves the service state, such
> as startup mode and started/stopped
>
> With all those changes to installer, we don't need this code
> in openvpnmsica.
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpnmsica/openvpnmsica.c | 115 --------------------------------
>  1 file changed, 115 deletions(-)
>

With PR261 in openvpn-build merged, this is now ready.

Acked-by: Selva Nair <selva.nair@...277...>

--0000000000007f764d05e56af5b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Thu, Jul 28, 2022 at 7:19 AM Lev Stipakov &lt;<=
a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...277...=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_blank">l=
ev@...515...</a>&gt;<br>
<br>
This code reads the state of OpenVPNService,<br>
such as startup mode and running, and sets MSI<br>
property value. If that property is set, installer<br>
selects OpenVPNService as a feature to be installed.<br>
<br>
This has been superseded by change in installer:<br>
<br>
=C2=A0 <a href=3D"https://github.com/OpenVPN/openvpn-build/pull/261" rel=3D=
"noreferrer" target=3D"_blank">https://github.com/OpenVPN/openvpn-build/pul=
l/261</a><br>
<br>
which, in addition to checking the state of OpenVPNService,<br>
applies that state to the newly installed service.<br>
<br>
=C2=A0 - by default, OpenVPNService feature is now checked<br>
and service is installed<br>
<br>
=C2=A0 - in clean installation, service startup mode is set to &quot;manual=
&quot;<br>
and service is not started<br>
<br>
=C2=A0 - in upgrade, installer preserves the service state, such<br>
as startup mode and started/stopped<br>
<br>
With all those changes to installer, we don&#39;t need this code<br>
in openvpnmsica.<br>
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0src/openvpnmsica/openvpnmsica.c | 115 -------------------------------=
-<br>
=C2=A01 file changed, 115 deletions(-)<br></blockquote><div><br></div><div>=
With PR261 in openvpn-build merged, this is now ready.</div><div><br></div>=
<div>Acked-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277...">selva=
.nair@...277...</a>&gt;</div></div></div>

--0000000000007f764d05e56af5b5--

