MIME-Version: 1.0
In-Reply-To: <1479660357-12843-1-git-send-email-gert@...1296...>
References: <1479660357-12843-1-git-send-email-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 20 Nov 2016 16:53:28 -0500
Message-ID: <CAKuzo_jkzXos8+rsOdLEDL1gnn=LL7Vo5KcN9WdefJ=tub4M_A@...278...>
Content-Type: multipart/alternative; boundary=001a114c894600afe50541c293ca
Subject: Re: [Openvpn-devel] [PATCH] Stub implementation of "--dhcp-option
 DNS6 <v6addr>"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114c894600afe50541c293ca
Content-Type: text/plain; charset=UTF-8

On Sun, Nov 20, 2016 at 11:45 AM, Gert Doering <gert@...1296...> wrote:

> This defines a new DHCP suboption "DNS6", but does not actually
> implement anything but "document the option and understand it".
>
> If received, it will be put into an "foreign_option_<n>" environment
> variable where an --up script or plugin could receive and act upon it.
>
> On non-Windows platforms, all "dhcp-option" sub-options end up there,
> so v4 and v6 DNS options will be reflected like this:
>
>    foreign_option_1=dhcp-option DNS6 2001:608::2
>    foreign_option_2=dhcp-option DNS 195.30.0.2
>


Good enough to get the ball rolling. ACK.

Selva

--001a114c894600afe50541c293ca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sun, Nov 20, 2016 at 11:45 AM, Gert Doering <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><div id=3D":272" class=3D"a3s a=
XjCH m15882a388e36b14b">This defines a new DHCP suboption &quot;DNS6&quot;,=
 but does not actually<br>
implement anything but &quot;document the option and understand it&quot;.<b=
r>
<br>
If received, it will be put into an &quot;foreign_option_&lt;n&gt;&quot; en=
vironment<br>
variable where an --up script or plugin could receive and act upon it.<br>
<br>
On non-Windows platforms, all &quot;dhcp-option&quot; sub-options end up th=
ere,<br>
so v4 and v6 DNS options will be reflected like this:<br>
<br>
=C2=A0 =C2=A0foreign_option_1=3Ddhcp-option DNS6 2001:608::2<br>
=C2=A0 =C2=A0foreign_option_2=3Ddhcp-option DNS 195.30.0.2</div></blockquot=
e></div><br><br></div><div class=3D"gmail_extra">Good enough to get the bal=
l rolling. ACK.<br><br></div><div class=3D"gmail_extra">Selva<br></div></di=
v>

--001a114c894600afe50541c293ca--

