MIME-Version: 1.0
References: <20221214164824.172-1-lstipakov@...277...>
In-Reply-To: <20221214164824.172-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 14 Dec 2022 13:55:03 -0500
Message-ID: <CAKuzo_iZPLJvSyK53oziTO99ZW6ua-DFvEWMoPAK3MjrjQ5PdA@...278...>
Content-Type: multipart/alternative; boundary="0000000000001da31c05efce479c"
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

--0000000000001da31c05efce479c
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Dec 14, 2022 at 11:49 AM Lev Stipakov <lstipakov@...277...> wrote:

> From: Lev Stipakov <lev@...515...>
>
> dco_get_peer_stats fetches stats for a single peer. This is mostly
> useful in client mode. So far only Windows implements that.
>

Good to see this happening.. Do you have a link to a build including this
patch for a quick test?

Does this data from the driver include both control and data channel
bytes? Right now what the GUI receives as bytecount  is not zero, I suppose
the daemon is reporting the control channel traffic.

By the way:

+        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_SET_PEER)
failed");

That would be OVPN_IOCTL_GET_STATS

Selva

--0000000000001da31c05efce479c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Wed, Dec 14, 2022 at 11:49 AM Lev Stipakov &lt;=
<a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...1663...=
.</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_blank">=
lev@...515...</a>&gt;<br>
<br>
dco_get_peer_stats fetches stats for a single peer. This is mostly<br>
useful in client mode. So far only Windows implements that.<br></blockquote=
><div><br></div><div>Good to see this happening.. Do you have a link to a b=
uild including this patch for a quick test?</div><div><br></div><div>Does t=
his data from the driver include both control and data channel=C2=A0 bytes?=
 Right now what the GUI receives as bytecount=C2=A0 is not zero, I suppose =
the daemon is reporting the control channel traffic.</div><div><br></div><d=
iv>By the way:</div><div><br></div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN =
| M_ERRNO, &quot;DeviceIoControl(OVPN_IOCTL_SET_PEER) failed&quot;);<br><di=
v><br></div><div>That would be OVPN_IOCTL_GET_STATS</div><div><br></div><di=
v>Selva</div></div></div>

--0000000000001da31c05efce479c--

