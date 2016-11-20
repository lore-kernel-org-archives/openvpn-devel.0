MIME-Version: 1.0
In-Reply-To: <CAKuzo_jkzXos8+rsOdLEDL1gnn=LL7Vo5KcN9WdefJ=tub4M_A@...278...>
References: <1479660357-12843-1-git-send-email-gert@...1296...>
	<CAKuzo_jkzXos8+rsOdLEDL1gnn=LL7Vo5KcN9WdefJ=tub4M_A@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 20 Nov 2016 18:53:54 -0500
Message-ID: <CAKuzo_gH-JW4i4hqGHnQyL8QO+c-Uc-EKe4wxPKAfG4Cjh-PDQ@...278...>
Content-Type: multipart/alternative; boundary=94eb2c05946eafe21e0541c441a4
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

--94eb2c05946eafe21e0541c441a4
Content-Type: text/plain; charset=UTF-8

Hi,

On Sun, Nov 20, 2016 at 4:53 PM, Selva Nair <selva.nair@...277...> wrote:

>
>
> On Sun, Nov 20, 2016 at 11:45 AM, Gert Doering <gert@...1296...>
> wrote:
>
>> This defines a new DHCP suboption "DNS6", but does not actually
>> implement anything but "document the option and understand it".
>>
>> If received, it will be put into an "foreign_option_<n>" environment
>> variable where an --up script or plugin could receive and act upon it.
>>
>> On non-Windows platforms, all "dhcp-option" sub-options end up there,
>> so v4 and v6 DNS options will be reflected like this:
>>
>>    foreign_option_1=dhcp-option DNS6 2001:608::2
>>    foreign_option_2=dhcp-option DNS 195.30.0.2
>>
>
>
> Good enough to get the ball rolling. ACK.
>

I spoke too fast... There is a subtle problem here

+      else if (streq (p[1], "DNS6") && p[2])
> +       {
> +         /* this is somewhat of a placeholder - we understand the option,
> +          * but cannot act upon it - so we'll just accept it and put it
> +          * into the environment, as we would do on all non-win32
> platforms
> +          */
> +         foreign_option (options, p, 3, es);
> +       }
>

At the end of the "dhcp-option" parsing block there is a

o->dhcp_options = true;

which should be set only if there is a true DHCP option in the config. When
DNS6 is the only dhcp-option this causes an empty dhcp-option string being
created and the tap IOCTL to set dhcp fails.

Ading a "goto err;", though ugly and confusing, will fix it..

Selva

--94eb2c05946eafe21e0541c441a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Sun, Nov 20, 2016 at 4:53 PM, Selva Nair <span dir=3D"ltr">&=
lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...493...=
277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><br><div dir=3D"ltr"><span class=3D"m_-8407264605345459077gmail-"><d=
iv class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sun, Nov 20, 201=
6 at 11:45 AM, Gert Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1186...=
.1296..." target=3D"_blank">gert@...1296...</a>&gt;</span> wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex"><div id=3D"m_-84072646053454590=
77gmail-m_2923638137719968395:272" class=3D"m_-8407264605345459077gmail-m_2=
923638137719968395a3s m_-8407264605345459077gmail-m_2923638137719968395aXjC=
H m_-8407264605345459077gmail-m_2923638137719968395m15882a388e36b14b">This =
defines a new DHCP suboption &quot;DNS6&quot;, but does not actually<br>
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
e></div><br><br></div></span><div class=3D"gmail_extra">Good enough to get =
the ball rolling. ACK.</div></div></blockquote><div><br>I spoke too fast...=
 There is a subtle problem here<br><br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><div>+=C2=A0 =C2=A0 =C2=A0 else if (streq (p[1], &quot;=
DNS6&quot;) &amp;&amp; p[2])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* this is somewhat of a placeholder - w=
e understand the option,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * but cannot act upon it - so we&#39;ll=
 just accept it and put it<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * into the environment, as we would do =
on all non-win32 platforms<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0foreign_option (options, p, 3, es);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} <br></div></blockquote></div><br></div><div c=
lass=3D"gmail_extra">At the end of the &quot;dhcp-option&quot; parsing bloc=
k there is a <br><br>o-&gt;dhcp_options =3D true;<br><br>which should be se=
t only if there is a true DHCP option in the config. When DNS6 is the only =
dhcp-option this causes an empty dhcp-option string being created and the t=
ap IOCTL to set dhcp fails. <br><br>Ading a &quot;goto err;&quot;, though u=
gly and confusing, will fix it..<br><br></div><div class=3D"gmail_extra">Se=
lva<br></div></div></div>

--94eb2c05946eafe21e0541c441a4--

