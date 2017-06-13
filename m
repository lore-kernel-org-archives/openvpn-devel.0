MIME-Version: 1.0
In-Reply-To: <f910a64e-235f-56ad-52b4-aff5dae46acf@...277...>
References: <c97c0fd6-3d34-fb94-40e4-3ec8dc7af0c9@...277...>
	<f910a64e-235f-56ad-52b4-aff5dae46acf@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 13 Jun 2017 15:19:59 -0400
Message-ID: <CAKuzo_hUiYVxZSEnB=8=ijO86_VbiZep2mR=1_FCi2pFJYLYmg@...278...>
Content-Type: multipart/alternative; boundary="001a1136fa548b64020551dc532e"
Subject: Re: [Openvpn-devel] W10 Client assigns old AND new IPv6 address to
 TAP with GUI+Service but not with cmd prompt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1136fa548b64020551dc532e
Content-Type: text/plain; charset="UTF-8"

On Tue, Jun 13, 2017 at 2:01 PM, debbie10t <debbie10t@...277...> wrote:

> As client:
>    Config-1 assigns 12fc:1918::10:36:101:110/112 to TAP (in tun mode)
>    Config-2 assigns 12fc:1918::10:8:0:110/112 to TAP (in tun mode)
>
> Following:
>
> 1. Administrator command prompt - execute openvp config-1.ovpn
>    TAP is assigned 12fc:1918::10:36:101:110/112
> 2. Terminate by closing [X] the command prompt
> 3. Using GUI + Interactive-service start config-2.ovpn
>    TAP is assigned 12fc:1918::10:36:101:110/112
>  & TAP is assigned 12fc:1918::10:8:0:110/112
>
> Please try for yourself and post results.
>

I haven't tested this, but if both connections use the same adapter, this
looks possible as you kill the first process without giving it a chance to
remove the IP first. Addresses are added with store=active so would
disappear on reboot as you saw.

Selva

--001a1136fa548b64020551dc532e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Jun 13, 2017 at 2:01 PM, debbie10t <span dir=3D"ltr">&lt;<a href=3D=
"mailto:debbie10t@...277..." target=3D"_blank">debbie10t@...277...</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":2fq" class=3D"a=
3s aXjCH m15ca29fbf20f343e">As client:<br>
=C2=A0 =C2=A0Config-1 assigns 12fc:1918::10:36:101:110/112 to TAP (in tun m=
ode)<br>
=C2=A0 =C2=A0Config-2 assigns 12fc:1918::10:8:0:110/112 to TAP (in tun mode=
)<br>
<br>
Following:<br>
<br>
1. Administrator command prompt - execute openvp config-1.ovpn<br>
=C2=A0 =C2=A0TAP is assigned 12fc:1918::10:36:101:110/112<br>
2. Terminate by closing [X] the command prompt<br>
3. Using GUI + Interactive-service start config-2.ovpn<br>
=C2=A0 =C2=A0TAP is assigned 12fc:1918::10:36:101:110/112<br>
=C2=A0&amp; TAP is assigned 12fc:1918::10:8:0:110/112<br>
<br>
Please try for yourself and post results.</div></blockquote></div><br>I hav=
en&#39;t tested this, but if both connections use the same adapter, this lo=
oks possible as you kill the first process without giving it a chance to re=
move the IP first. Addresses are added with store=3Dactive so would disappe=
ar on reboot as you saw.</div><div class=3D"gmail_extra"><br></div><div cla=
ss=3D"gmail_extra">Selva</div><div class=3D"gmail_extra"><br></div></div>

--001a1136fa548b64020551dc532e--

