MIME-Version: 1.0
From: Tony He <huangya90@...277...>
Date: Tue, 30 Mar 2021 15:36:30 +0800
Message-ID: <CAAUX2SXSu=izbxjAiUNfuezsrv6NbQrrL7R7pQh8P4uumzQemw@...278...>
Content-Type: multipart/alternative; boundary="0000000000003b698e05bebc0fa6"
Subject: [Openvpn-devel] [ovpn-dco] try to port to kernel 4.14.76,
 but can not join AF_NETLINK group
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <antonio@...515...>, Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000003b698e05bebc0fa6
Content-Type: text/plain; charset="UTF-8"

Hi Antonio, Arne,

Sorry to bother you. I have a router based on Linux kernel 4.14.76(4.14.x
is LTS version). Because of some reasons,
it's hard to upgrade to v5.x to play ovpn-dco. So I am porting ovpn-dco to
4.14.76 kernel. After some hacking, it's almost done.
Now it seems that  only one issue needs to be resolved. The issue is
openvpn 2.6 dco fails to join AF_NETLINK group.

openvpn 2.6 dco:
/* Register for Ovpn dco specific messages and to RTNLGRP_LINK to
     * receive RTM_DELLINK */
    int ret = nl_socket_add_memberships(dco->nl_sock,
dco->ovpn_dco_mcast_id,
                                        RTNLGRP_LINK, RTNLGRP_NOTIFY,
RTNLGRP_NONE);
    if (ret)
    {
        msg(M_ERR, "%s: failed to join groups: %d", __func__, ret);
    }

value of ret is -2.

The corresponding code In the kernel:
https://elixir.bootlin.com/linux/v4.14.76/source/net/netlink/af_netlink.c#L1631

The value of err is -2, which means No such file or directory.
according to
https://elixir.bootlin.com/linux/v4.14.76/source/include/uapi/asm-generic/errno-base.h#L6

If only join RTNLGRP_NOTIFY group, it's OK. Do you have any idea? Any input
is very appreciated. Thank you!

Tony

--0000000000003b698e05bebc0fa6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Antonio, Arne,<div><br></div><div>Sorry to bother you. =
I have a router based on Linux kernel 4.14.76(4.14.x is LTS version). Becau=
se of some reasons,=C2=A0</div><div>it&#39;s hard to upgrade to v5.x to pla=
y ovpn-dco. So I am porting ovpn-dco to 4.14.76 kernel. After some hacking,=
 it&#39;s almost done.</div><div>Now it seems that=C2=A0 only one issue nee=
ds to be resolved. The issue is openvpn 2.6 dco fails to join AF_NETLINK gr=
oup.</div><div><br></div><div>openvpn 2.6 dco:<br></div>/* Register for Ovp=
n dco specific messages and to RTNLGRP_LINK to<br>=C2=A0 =C2=A0 =C2=A0* rec=
eive RTM_DELLINK */<br>=C2=A0 =C2=A0 int ret =3D nl_socket_add_memberships(=
dco-&gt;nl_sock, dco-&gt;ovpn_dco_mcast_id,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTNLGRP_LINK, RTNLGRP_NOTIFY, RTNLGR=
P_NONE);<br>=C2=A0 =C2=A0 if (ret)<br>=C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 msg(M_ERR, &quot;%s: failed to join groups: %d&quot;, __func__, =
ret);<br>=C2=A0 =C2=A0 }<br><div>=C2=A0</div><div>value of ret is -2.</div>=
<div><br></div><div>The corresponding code In the kernel:</div><div><a href=
=3D"https://elixir.bootlin.com/linux/v4.14.76/source/net/netlink/af_netlink=
.c#L1631">https://elixir.bootlin.com/linux/v4.14.76/source/net/netlink/af_n=
etlink.c#L1631</a><br></div><div><br></div><div>The value of err is -2, whi=
ch means=C2=A0<span style=3D"color:slategray;font-style:italic;font-family:=
&quot;Ubuntu Mono&quot;,monospace;font-size:0.9em">No such file or director=
y.</span></div><div>according to <a href=3D"https://elixir.bootlin.com/linu=
x/v4.14.76/source/include/uapi/asm-generic/errno-base.h#L6">https://elixir.=
bootlin.com/linux/v4.14.76/source/include/uapi/asm-generic/errno-base.h#L6<=
/a></div><div><br></div><div>If only join=C2=A0RTNLGRP_NOTIFY group, it&#39=
;s OK. Do you have any idea? Any input is very=C2=A0<span style=3D"font-fam=
ily:&quot;Times New Roman&quot;;font-size:10.5pt">appreciated. Thank you!</=
span></div><div><span style=3D"font-family:&quot;Times New Roman&quot;;font=
-size:10.5pt"><br></span></div><div><span style=3D"font-family:&quot;Times =
New Roman&quot;;font-size:10.5pt">Tony</span></div></div>

--0000000000003b698e05bebc0fa6--

