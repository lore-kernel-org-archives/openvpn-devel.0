MIME-Version: 1.0
References: <20200924064452.1001-1-simon@...2293...>
 <20200924064452.1001-2-simon@...2293...>
 <CAGyAFMVnvSgHrw0cbvdzmeE5Orp7wg26cPcGi8f0x0_Kcz-2MA@...278...>
In-Reply-To: <CAGyAFMVnvSgHrw0cbvdzmeE5Orp7wg26cPcGi8f0x0_Kcz-2MA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 28 Sep 2020 14:37:11 -0400
Message-ID: <CAKuzo_jecDupeJyq9ndyaM6TC8rwV1M9HG1=N9t+c5OA4ie+_A@...278...>
Content-Type: multipart/alternative; boundary="000000000000448e0105b063f50e"
Subject: Re: [Openvpn-devel] [PATCH 2/3] netsh: Clear existing IPv6 DNS
 servers before configuring new ones
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Simon Rozman <simon@...2293...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000448e0105b063f50e
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Sep 24, 2020 at 4:57 AM Lev Stipakov <lstipakov@...277...> wrote:

> Hi,
>
> > When there are no IPv6 DNS published, the adapter state is not
> > sanitized and might contain IPv6 DNS server from a previous session.
>
> In this case, shouldn't the "set dns" call below overwrite the previous
> value?


> > netsh_ifconfig_options() clears DNS servers for IPv4 already.
>
> Agreed, let's do it for consistency.
>
> >   * The list of dns servers currently set on the interface
> >   * are cleared first.
>
> Either existing comment lied or "implicit clear" was assumed because
> of the "set dns" call.
>

The clearing happened only if at least one DNS address was specified using
--dhcp-option DNS.


> But now it is fine, since we have real clearing.
>

Now that this has been merged, should we make DNS settings using iservice
consistent with this? Currently, when using the service, we do not touch
any existing dns servers if none are specified using --dhcp-option. Same
approach was taken in my patch for setting the domain suffix. The original
logic was that any statically set values should not be overwritten unless
explicitly asked for. At the same time, we do delete all addresses for v4
(not v6) while closing tun.

But, if we want to ensure a clean state for the adapter, as argued here, we
should be clearing current values regardless of whether new one's are being
set or not.

Selva


> Stared and the code, built and tested on MSVC/Win10.
>
> Acked-by: Lev Stipakov <lstipakov@...277...>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000448e0105b063f50e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Thu, Sep 24, 2020 at 4:57 AM Lev Stipakov &lt;<=
a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...277...=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Hi,<br>
<br>
&gt; When there are no IPv6 DNS published, the adapter state is not<br>
&gt; sanitized and might contain IPv6 DNS server from a previous session.<b=
r>
<br>
In this case, shouldn&#39;t the &quot;set dns&quot; call below overwrite th=
e previous value?=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
&gt; netsh_ifconfig_options() clears DNS servers for IPv4 already.<br>
<br>
Agreed, let&#39;s do it for consistency.<br>
<br>
&gt;=C2=A0 =C2=A0* The list of dns servers currently set on the interface<b=
r>
&gt;=C2=A0 =C2=A0* are cleared first.<br>
<br>
Either existing comment lied or &quot;implicit clear&quot; was assumed beca=
use<br>
of the &quot;set dns&quot; call.<br></blockquote><div><br></div><div>The cl=
earing happened only if at least one DNS address was specified using --dhcp=
-option DNS.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
But now it is fine, since we have real clearing.<br></blockquote><div><br><=
/div><div>Now that this has been merged, should we make DNS settings using =
iservice consistent with this? Currently, when using the service, we do not=
 touch any existing dns servers if none are specified using --dhcp-option. =
Same approach was taken in my patch for setting the domain suffix. The orig=
inal logic was that any statically set values should not be overwritten unl=
ess explicitly asked for. At the same time, we do delete all addresses for =
v4 (not v6) while closing tun.</div><div><br></div><div>But, if we want to =
ensure a clean state for the adapter, as argued here, we should be clearing=
 current values regardless of whether new one&#39;s are being set or not.=
=C2=A0</div><div><br></div><div>Selva</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
Stared and the code, built and tested on MSVC/Win10.<br>
<br>
Acked-by: Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...277..." target=3D=
"_blank">lstipakov@...277...</a>&gt;<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--000000000000448e0105b063f50e--

