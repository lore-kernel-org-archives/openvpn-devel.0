MIME-Version: 1.0
In-Reply-To: <20170613192559.GX97029@...1296...>
References: <c97c0fd6-3d34-fb94-40e4-3ec8dc7af0c9@...277...>
	<f910a64e-235f-56ad-52b4-aff5dae46acf@...277...>
	<CAKuzo_hUiYVxZSEnB=8=ijO86_VbiZep2mR=1_FCi2pFJYLYmg@...278...>
	<20170613192559.GX97029@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 13 Jun 2017 15:33:35 -0400
Message-ID: <CAKuzo_gGy8xWAwBCzrxshHBPyzV=iMA=17vxnfSngfZ_b5MUrQ@...278...>
Content-Type: multipart/alternative; boundary="001a113bfbbe2ceab40551dc848f"
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113bfbbe2ceab40551dc848f
Content-Type: text/plain; charset="UTF-8"

On Tue, Jun 13, 2017 at 3:25 PM, Gert Doering <gert@...1296...> wrote:

> > I haven't tested this, but if both connections use the same adapter, this
> > looks possible as you kill the first process without giving it a chance
> to
> > remove the IP first. Addresses are added with store=active so would
> > disappear on reboot as you saw.
>
> Right.  If you a) run as admin, and b) force-kill openvpn (which "close
> the command window" might do), yes, there is no way to clean up.
>
> In that case, it's just plain PEBKAC :-)


Right :)  But we could probably do better using Set instead of Add while
the address is set using the service. I'm not that familiar with ipapi, but
looks like SetUnicastIpAddressEnrty instead of AddUnicastIpAddressEntry
may be the right thing.

The netsh command used when service is not in use does correctly do a set
not add.

Selva

--001a113bfbbe2ceab40551dc848f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Jun 13, 2017 at 3:25 PM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span class=3D"">&gt; I haven&#3=
9;t tested this, but if both connections use the same adapter, this<br>
&gt; looks possible as you kill the first process without giving it a chanc=
e to<br>
&gt; remove the IP first. Addresses are added with store=3Dactive so would<=
br>
&gt; disappear on reboot as you saw.<br>
<br>
</span>Right.=C2=A0 If you a) run as admin, and b) force-kill openvpn (whic=
h &quot;close<br>
the command window&quot; might do), yes, there is no way to clean up.<br>
<br>
In that case, it&#39;s just plain PEBKAC :-)</blockquote></div><br>Right :)=
 =C2=A0But we could probably do better using Set instead of Add while</div>=
<div class=3D"gmail_extra">the address is set using the service. I&#39;m no=
t that familiar with ipapi, but</div><div class=3D"gmail_extra">looks like =
SetUnicastIpAddressEnrty instead of AddUnicastIpAddressEntry</div><div clas=
s=3D"gmail_extra">may be the right thing.</div><div class=3D"gmail_extra"><=
br></div><div class=3D"gmail_extra">The netsh command used when service is =
not in use does correctly do a set not add.</div><div class=3D"gmail_extra"=
><br></div><div class=3D"gmail_extra">Selva</div></div>

--001a113bfbbe2ceab40551dc848f--

