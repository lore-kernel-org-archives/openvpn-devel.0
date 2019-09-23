MIME-Version: 1.0
References: <1568724293-5069-1-git-send-email-lstipakov@...277...>
 <CAGyAFMVjqC4mdjy83v+UqgLBnv3yLGwRT5Hg_PAB+_PwEMoDZw@...278...>
 <CAA1Abx+u=ZRaVVfwSfrSJOJYhFdRbX8q-amMt8LV+jL+du+2dw@...278...>
 <CAGyAFMVQy9U09nXkr1Q66qpHrBNoX99b_dF93kd+0w9w4sqC5Q@...278...>
 <CAKuzo_givujmu0hSZzYhooGDgdYTxRtv_6OqzfkvhSGNLq866Q@...278...>
 <CAGyAFMVr_nYE1h6BhVFRz6Ld4DMKOekDXFcbGmqfuAEQ+dL7VA@...278...>
In-Reply-To: <CAGyAFMVr_nYE1h6BhVFRz6Ld4DMKOekDXFcbGmqfuAEQ+dL7VA@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 23 Sep 2019 12:26:58 +0300
Message-ID: <CAGyAFMUMeANMf0P-AXDb8XL4dTbckw3beWSJwXvV0HCamVytLg@...278...>
Content-Type: multipart/alternative; boundary="000000000000efa53205933505ed"
Subject: Re: [Openvpn-devel] [PATCH 1/7] Visual Studio: upgrade project
 files to VS2019
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Steffan Karger <steffan@...1856...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000efa53205933505ed
Content-Type: text/plain; charset="UTF-8"

Since distributing own wintun binaries goes against recommended way (which
is MSM modules), here are steps to try out openvpn with wintun (which is
even simpler than previous way):

 - Install wireguard windows client from https://www.wireguard.com/install/
 - Download patched openvpn binaries from
https://staging.openvpn.net/openvpn2/openvpn2-wintun-support.zip
 - Unpack downloaded archive and run in administrative command prompt:
    c:\Temp\openvpn>tapctl.exe create --hwid wintun
 - That's it! You have created wintun network adapter and ready to use
openvpn with wintun.

This uses tapctl, which is openvpn 2.5+ tool to manipulate tun/tap
adapters, which I have patched to work with wintun (
https://patchwork.openvpn.net/patch/833/).

See more detailed instruction here: http://staging.openvpn.net/openvpn2/

-- 
-Lev

--000000000000efa53205933505ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Since distributing own wintun binaries go=
es against recommended way (which is MSM modules), here are steps to try ou=
t openvpn with wintun (which is even simpler than previous way):<div><br></=
div><div>=C2=A0- Install wireguard windows client from <a href=3D"https://w=
ww.wireguard.com/install/">https://www.wireguard.com/install/</a></div><div=
>=C2=A0- Download patched openvpn binaries from=C2=A0<a href=3D"https://sta=
ging.openvpn.net/openvpn2/openvpn2-wintun-support.zip">https://staging.open=
vpn.net/openvpn2/openvpn2-wintun-support.zip</a></div><div>=C2=A0- Unpack d=
ownloaded archive and run in administrative=C2=A0command prompt:</div>=C2=
=A0 =C2=A0 c:\Temp\openvpn&gt;tapctl.exe create --hwid wintun<div>=C2=A0- T=
hat&#39;s it! You have created wintun network adapter and ready to use open=
vpn with wintun.</div><div><br></div><div>This uses tapctl, which is openvp=
n 2.5+ tool to manipulate tun/tap adapters, which I have patched to work=C2=
=A0with wintun (<a href=3D"https://patchwork.openvpn.net/patch/833/">https:=
//patchwork.openvpn.net/patch/833/</a>).</div><div><div><br></div><div>See =
more detailed=C2=A0instruction here:=C2=A0<a href=3D"http://staging.openvpn=
.net/openvpn2/">http://staging.openvpn.net/openvpn2/</a>=C2=A0</div></div><=
div><br></div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">-Lev<=
/div></div>

--000000000000efa53205933505ed--

