MIME-Version: 1.0
In-Reply-To: <1449454660-20050-1-git-send-email-selva.nair@...277...>
References: <1449454660-20050-1-git-send-email-selva.nair@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 17 Feb 2016 17:16:56 -0500
Message-ID: <CAKuzo_ieowadKGNzRgCUNkMLJBhEYjTWqQKiVs7bWHK9UrqbbA@...278...>
Content-Type: multipart/alternative; boundary=089e011762d1cfa7bb052bfe9c69
Subject: Re: [Openvpn-devel] [PATCH] Make default dhcp server ip offset = 0
	for subnet topology
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e011762d1cfa7bb052bfe9c69
Content-Type: text/plain; charset=UTF-8

Hi,

On Sun, Dec 6, 2015 at 9:17 PM, Selva Nair <selva.nair@...277...> wrote:

> This makes the default choice for the emulated dhcp server
> address to be the network address, same as in the TAP mode. Also
> change the default ifconfig_pool_end to broadcast - 1.
>
> Currently the default ip for the dhcp server is the broadcast
> address - 1, making that address not available for windows clients.
> This change also brings the code in agreement with the comments in
> helper.c and the documentation.
>
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/helper.c |    2 +-
>  src/openvpn/tun.c    |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>

A gentle nudge to see if anyone can review this. If you don't like the
change we could edit the manpage to match the code..

Ref: http://article.gmane.org/gmane.network.openvpn.devel/10687

Thanks,

Selva

--089e011762d1cfa7bb052bfe9c69
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra"><div class=3D"gmail_quote">On Sun=
, Dec 6, 2015 at 9:17 PM, Selva Nair <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-=
style:solid;padding-left:1ex"><div style=3D"overflow:hidden">This makes the=
 default choice for the emulated dhcp server<br>
address to be the network address, same as in the TAP mode. Also<br>
change the default ifconfig_pool_end to broadcast - 1.<br>
<br>
Currently the default ip for the dhcp server is the broadcast<br>
address - 1, making that address not available for windows clients.<br>
This change also brings the code in agreement with the comments in<br>
helper.c and the documentation.<br>
<br>
Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." targe=
t=3D"_blank">selva.nair@...277...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/helper.c |=C2=A0 =C2=A0 2 +-<br>
=C2=A0src/openvpn/tun.c=C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +-<br>
=C2=A02 files changed, 2 insertions(+), 2 deletions(-)</div></blockquote></=
div><div class=3D"gmail_extra"><br></div>A gentle nudge to see if anyone ca=
n review this. If you don&#39;t like the change we could edit the manpage t=
o match the code..</div><div class=3D"gmail_extra"><br></div><div class=3D"=
gmail_extra">Ref: <a href=3D"http://article.gmane.org/gmane.network.openvpn=
.devel/10687">http://article.gmane.org/gmane.network.openvpn.devel/10687</a=
><br></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">=
Thanks,</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra=
">Selva<br><br></div></div>

--089e011762d1cfa7bb052bfe9c69--

