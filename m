MIME-Version: 1.0
References: <20221214164824.172-1-lstipakov@...277...>
 <CAKuzo_iZPLJvSyK53oziTO99ZW6ua-DFvEWMoPAK3MjrjQ5PdA@...278...>
 <CAGyAFMV=QqUUPj8-Z8_U3JWG3qoBOZOKpMMVAztpdc-8qT+0HQ@...278...>
 <CAKuzo_g6Pc6djBCu05-k5oJFWYuTYBFa60Ucay+z1BebJK=9Gg@...278...>
 <CAGyAFMUTjZuN+W8FagK+F=4P+iuUAEYS0qmieb3kNQYKN-z=gg@...278...>
 <Y5pEEhAGyKzbNn8u@...1296...>
 <CAGyAFMUQUx_oL_Qi6SBcAdB94VCW+1tmTQVkoCh5B0BnYThkLg@...278...>
In-Reply-To: <CAGyAFMUQUx_oL_Qi6SBcAdB94VCW+1tmTQVkoCh5B0BnYThkLg@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 14 Dec 2022 18:34:19 -0500
Message-ID: <CAKuzo_imcQLV60uJN9mXTR8ti7gctgR=iZVpi+2AvDvSTJ_x0g@...278...>
Content-Type: multipart/alternative; boundary="000000000000e1425a05efd22d66"
Subject: Re: [Openvpn-devel] [PATCH] Introduce dco_get_peer_stats API and
 Windows implementation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, Lev Stipakov <lev@...515...>, openvpn-devel@lists.sourceforge.net

--000000000000e1425a05efd22d66
Content-Type: text/plain; charset="UTF-8"

Hi

On Wed, Dec 14, 2022 at 6:09 PM Lev Stipakov <lstipakov@...277...> wrote:

> Hi,
>
> Selva has asked about a build which includes this patch.
>
> Here is MSI installer which incorporates required client patches
>
>  - management: add timer to output BYTECOUNT
>  - Introduce dco_get_peer_stats API and Windows implementation
>
> and a new driver version (0.8.3) with stats fixes.
>
> https://github.com/lstipakov/openvpn-build/actions/runs/3699097077


Thanks.

Tested again using this. Ignore my previous comment about Out bytes not
reported. Something must be wrong with my build --- this one shows in and
out bytes correctly. But the problem with data getting reset on
reconnect is real.

Selva

--000000000000e1425a05efd22d66
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Dec 14, 2022 at 6:09 PM Lev Stipakov &lt;<a=
 href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...277...<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">H=
i,<br>
<br>
Selva has asked about a build which includes this patch.<br>
<br>
Here is MSI installer which incorporates required client patches<br>
<br>
=C2=A0- management: add timer to output BYTECOUNT<br>
=C2=A0- Introduce dco_get_peer_stats API and Windows implementation<br>
<br>
and a new driver version (0.8.3) with stats fixes.<br>
<br>
<a href=3D"https://github.com/lstipakov/openvpn-build/actions/runs/36990970=
77" rel=3D"noreferrer" target=3D"_blank">https://github.com/lstipakov/openv=
pn-build/actions/runs/3699097077</a></blockquote><div><br></div><div>Thanks=
.</div><div><br></div><div>Tested again using this. Ignore my previous comm=
ent about Out bytes not reported. Something must be wrong with my build ---=
 this one shows in and out bytes correctly. But the problem with data getti=
ng reset on reconnect=C2=A0is real.</div><div>=C2=A0</div><div>Selva</div><=
/div></div>

--000000000000e1425a05efd22d66--

