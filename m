MIME-Version: 1.0
In-Reply-To: <1479746562-751-1-git-send-email-gert@...1296...>
References: <1479660357-12843-1-git-send-email-gert@...1296...>
	<1479746562-751-1-git-send-email-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 21 Nov 2016 12:20:41 -0500
Message-ID: <CAKuzo_icJA4OPTjTeX9nUOMXskTCG0xg8Gtf0z+fTQjwz5Ki0w@...278...>
Content-Type: multipart/alternative; boundary=001a1149b9a84bdb340541d2e1af
Subject: Re: [Openvpn-devel] [PATCH v2] Stub implementation of
 "--dhcp-option DNS6 <v6addr>"
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

--001a1149b9a84bdb340541d2e1af
Content-Type: text/plain; charset=UTF-8

On Mon, Nov 21, 2016 at 11:42 AM, Gert Doering <gert@...1296...> wrote:

> +
> +      /* flag that we have options to give to the TAP driver's DHCPv4
> server
> +       *  - skipped for "DNS6", as that's not a DHCPv4 option
> +       */
> +      if (!streq (p[1], "DNS6"))
> +       {
> +         o->dhcp_options = true;
> +       }
>

This will fix it. Hopefully non DHCPv4 options like this wont proliferate.
ACK.

--001a1149b9a84bdb340541d2e1af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Nov 21, 2016 at 11:42 AM, Gert Doering <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><div id=3D":256" class=3D"a3s a=
XjCH m15887c6e6a56e4e6">+<br>
+=C2=A0 =C2=A0 =C2=A0 /* flag that we have options to give to the TAP drive=
r&#39;s DHCPv4 server<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*=C2=A0 - skipped for &quot;DNS6&quot;, as that=
&#39;s not a DHCPv4 option<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 if (!streq (p[1], &quot;DNS6&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0o-&gt;dhcp_options =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}</div></blockquote></div><br>This will fix it.=
 Hopefully non DHCPv4 options like this wont proliferate.</div><div class=
=3D"gmail_extra">ACK.<br></div></div>

--001a1149b9a84bdb340541d2e1af--

