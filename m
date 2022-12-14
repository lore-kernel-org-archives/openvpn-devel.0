MIME-Version: 1.0
References: <20221214164824.172-1-lstipakov@...277...>
 <CAKuzo_iZPLJvSyK53oziTO99ZW6ua-DFvEWMoPAK3MjrjQ5PdA@...278...>
In-Reply-To: <CAKuzo_iZPLJvSyK53oziTO99ZW6ua-DFvEWMoPAK3MjrjQ5PdA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 14 Dec 2022 18:23:46 -0500
Message-ID: <CAKuzo_hRukEOpzZA1WkCJGSpObCYWna+NJ-4zhpSx9Xq0RMQfg@...278...>
Content-Type: multipart/alternative; boundary="00000000000023865405efd2083e"
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
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--00000000000023865405efd2083e
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Dec 14, 2022 at 1:55 PM Selva Nair <selva.nair@...277...> wrote:

> Hi,
>
> On Wed, Dec 14, 2022 at 11:49 AM Lev Stipakov <lstipakov@...277...> wrote:
>
>> From: Lev Stipakov <lev@...515...>
>>
>> dco_get_peer_stats fetches stats for a single peer. This is mostly
>> useful in client mode. So far only Windows implements that.
>>
>
> Good to see this happening.. Do you have a link to a build including this
> patch for a quick test?
>

At last I built this and gave it a quick test including the patch for
management i/f. Also used the latest dco-win driver (0.8.3) with the
stats fixes. I see two issues:

(1) Bytes out for data are still not getting reported -- I see a small
number even after transferring large amount of data indicating only control
channel bytes shown
(2) On reconnect, the stats revert back to what looks like the accumulated
control channel stats. As if the stats in the driver is getting reset. This
happens even on SIGUSR1 restart which can happen automatically on
auth-failure  token expiry, for example.

Selva

P.S.
I couldn't compare this with the non-dco behaviour as it seems
reconnecting with the wintun adapter is no longer working -- I get all
wintun adapters are currently in use error on reconnect while a
disconnect/connect fixes it.  This is unrelated -- will test further and
report separately.

--00000000000023865405efd2083e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div></div><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 14, 2022 at 1:5=
5 PM Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blan=
k">selva.nair@...277...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 14, 2022 at 11:=
49 AM Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...277..." target=3D"_bl=
ank">lstipakov@...277...</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">From: Lev Stipakov &lt;<a href=3D"mailto:lev@...2146...=
..." target=3D"_blank">lev@...515...</a>&gt;<br>
<br>
dco_get_peer_stats fetches stats for a single peer. This is mostly<br>
useful in client mode. So far only Windows implements that.<br></blockquote=
><div><br></div><div>Good to see this happening.. Do you have a link to a b=
uild including this patch for a quick test?</div></div></div></blockquote><=
div><br></div><div>At last I built this and gave it a quick test including =
the patch for management i/f. Also used the latest dco-win driver (0.8.3) w=
ith the stats=C2=A0fixes. I see two issues:</div><div><br></div><div>(1) By=
tes out for data are still not getting reported -- I see a small number eve=
n after transferring large amount of data indicating only control channel b=
ytes=C2=A0shown</div><div>(2) On reconnect, the stats revert back to what l=
ooks like the accumulated control channel stats. As if the stats in the dri=
ver is getting reset. This happens even=C2=A0on SIGUSR1 restart=C2=A0which =
can happen automatically on auth-failure=C2=A0 token expiry, for example.=
=C2=A0</div><div><br></div><div>Selva</div><div><br></div><div>P.S.</div><d=
iv>I couldn&#39;t=C2=A0compare this with the non-dco behaviour as it seems =
reconnecting=C2=A0with the wintun adapter is no longer working -- I get all=
 wintun adapters are currently in use error on reconnect while a disconnect=
/connect fixes it.=C2=A0 This is unrelated -- will test further and report =
separately.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
</blockquote></div></div>

--00000000000023865405efd2083e--

