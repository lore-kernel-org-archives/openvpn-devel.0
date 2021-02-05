MIME-Version: 1.0
From: Viktor Oreshkin <me@...2594...>
Date: Fri, 5 Feb 2021 17:34:14 +0300
Message-ID: <CAGtGfm=9TEUDohP4LUDY+NDLAmad60sb=VRXC9AvHthK=UMDTQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000008f234b05ba97b72d"
Subject: [Openvpn-devel] [PATCH 1/1] openvpn3: tunprop.hpp: handle
 dhcp-option DOMAIN-SEARCH
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0000000000008f234b05ba97b72d
Content-Type: text/plain; charset="UTF-8"

Adds support for dhcp-option DOMAIN-SEARCH, which was added to OpenVPN 2
in release 2.5

fixes https://github.com/OpenVPN/openvpn3/issues/145

URL: https://github.com/OpenVPN/openvpn3/pull/146
Signed-off-by: Viktor Oreshkin <imselfish@...2594...>
---
 openvpn/tun/client/tunprop.hpp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/openvpn/tun/client/tunprop.hpp b/openvpn/tun/client/tunprop.hpp
index d9f20f85445b..3e7ab8eab54b 100644
--- a/openvpn/tun/client/tunprop.hpp
+++ b/openvpn/tun/client/tunprop.hpp
@@ -523,7 +523,7 @@ namespace openvpn {
        throw tun_prop_dhcp_option_error("tun_builder_add_dns_server
failed");
      flags |= F_ADD_DNS;
    }
- else if (type == "DOMAIN")
+ else if (type == "DOMAIN" || type == "DOMAIN-SEARCH")
    {
      o.min_args(3);
      for (size_t j = 2; j < o.size(); ++j)
-- 
2.29.2

--0000000000008f234b05ba97b72d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><span style=3D"font-family:monospace">Add=
s support for dhcp-option DOMAIN-SEARCH, which was added to OpenVPN 2</span=
><br><div class=3D"gmail-" style=3D"font-family:Roboto,RobotoDraft,Helvetic=
a,Arial,sans-serif"><div id=3D"gmail-:tn" class=3D"gmail-ii gmail-gt" style=
=3D"margin:8px 0px 0px;padding:0px"><div id=3D"gmail-:to" class=3D"gmail-a3=
s gmail-aiL"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div><font =
face=3D"monospace">in release 2.5</font></div><div><font face=3D"monospace"=
><br></font></div><div><font face=3D"monospace">fixes=C2=A0<a href=3D"https=
://github.com/OpenVPN/openvpn3/issues/145" target=3D"_blank">https://github=
.com/OpenVPN/openvpn3/issues/145</a></font></div><div><font face=3D"monospa=
ce"><br></font></div><div><font face=3D"monospace">URL:=C2=A0<a href=3D"htt=
ps://github.com/OpenVPN/openvpn3/pull/146" target=3D"_blank">https://github=
.com/OpenVPN/openvpn3/pull/146</a></font></div><div><font face=3D"monospace=
">Signed-off-by: Viktor Oreshkin &lt;imselfish@...2594...&gt;</font></div><=
div><font face=3D"monospace">---</font></div><div><font face=3D"monospace">=
=C2=A0openvpn/tun/client/tunprop.hpp | 2 +-</font></div><div><font face=3D"=
monospace">=C2=A01 file changed, 1 insertion(+), 1 deletion(-)</font></div>=
<div><font face=3D"monospace"><br></font></div><div><font face=3D"monospace=
">diff --git a/openvpn/tun/client/tunprop.hpp b/openvpn/tun/client/tunprop.=
hpp</font></div><div><font face=3D"monospace">index d9f20f85445b..3e7ab8eab=
54b 100644</font></div><div><font face=3D"monospace">--- a/openvpn/tun/clie=
nt/tunprop.hpp</font></div><div><font face=3D"monospace">+++ b/openvpn/tun/=
client/tunprop.hpp</font></div><div><font face=3D"monospace">@@ -523,7 +523=
,7 @@ namespace openvpn {</font></div><div><font face=3D"monospace">=C2=A0<=
span style=3D"white-space:pre-wrap">		</span>=C2=A0=C2=A0 =C2=A0 =C2=A0thro=
w tun_prop_dhcp_option_error(&quot;tun_builder_add_dns_server failed&quot;)=
;</font></div><div><font face=3D"monospace">=C2=A0<span style=3D"white-spac=
e:pre-wrap">		</span>=C2=A0=C2=A0 =C2=A0flags |=3D F_ADD_DNS;</font></div><=
div><font face=3D"monospace">=C2=A0<span style=3D"white-space:pre-wrap">		<=
/span>=C2=A0=C2=A0}</font></div><div><font face=3D"monospace">-<span style=
=3D"white-space:pre-wrap">		</span>else if (type =3D=3D &quot;DOMAIN&quot;)=
</font></div><div><font face=3D"monospace">+<span style=3D"white-space:pre-=
wrap">		</span>else if (type =3D=3D &quot;DOMAIN&quot; || type =3D=3D &quot=
;DOMAIN-SEARCH&quot;)</font></div><div><font face=3D"monospace">=C2=A0<span=
 style=3D"white-space:pre-wrap">		</span>=C2=A0=C2=A0{</font></div><div><fo=
nt face=3D"monospace">=C2=A0<span style=3D"white-space:pre-wrap">		</span>=
=C2=A0=C2=A0 =C2=A0o.min_args(3);</font></div><div><font face=3D"monospace"=
>=C2=A0<span style=3D"white-space:pre-wrap">		</span>=C2=A0=C2=A0 =C2=A0for=
 (size_t j =3D 2; j &lt; o.size(); ++j)</font></div><font color=3D"#888888"=
><div><font face=3D"monospace">--=C2=A0</font></div><div><font face=3D"mono=
space">2.29.2</font></div></font></div></div></div></div></div></div></div>=
</div>

--0000000000008f234b05ba97b72d--

