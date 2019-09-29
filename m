MIME-Version: 1.0
References: <1568724293-5069-1-git-send-email-lstipakov@...277...>
 <CAGyAFMVjqC4mdjy83v+UqgLBnv3yLGwRT5Hg_PAB+_PwEMoDZw@...278...>
 <CAA1Abx+u=ZRaVVfwSfrSJOJYhFdRbX8q-amMt8LV+jL+du+2dw@...278...>
 <CAGyAFMVQy9U09nXkr1Q66qpHrBNoX99b_dF93kd+0w9w4sqC5Q@...278...>
 <CAKuzo_givujmu0hSZzYhooGDgdYTxRtv_6OqzfkvhSGNLq866Q@...278...>
 <CAGyAFMVr_nYE1h6BhVFRz6Ld4DMKOekDXFcbGmqfuAEQ+dL7VA@...278...>
 <CAGyAFMUMeANMf0P-AXDb8XL4dTbckw3beWSJwXvV0HCamVytLg@...278...>
In-Reply-To: <CAGyAFMUMeANMf0P-AXDb8XL4dTbckw3beWSJwXvV0HCamVytLg@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Sun, 29 Sep 2019 12:27:13 +0300
Message-ID: <CAGyAFMXdtShRSQz0FF7_SnUr+_hyWpSm=6WBxSmguRGnVj1XUw@...278...>
Content-Type: multipart/alternative; boundary="000000000000ff6fab0593adb91a"
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

--000000000000ff6fab0593adb91a
Content-Type: text/plain; charset="UTF-8"

I have added wintun's MSM (official distribution way) to windows client
installer:

https://staging.openvpn.net/openvpn2/openvpn-install-2.5_git-I607-Win10.exe

To use wintun driver instead of tap-window6, add "windows-driver wintun" to
your VPN profile.

Fresh performance numbers (with recent -O2 fix to windows build system):

Server - openvpn 2.4.4
    tap-windows6: 390Mbit/s
    wintun: 730Mbit/s

Server - openvpn3 with kernel acceleration
    tap-windows6: 405Mbit/s
    wintun: 1.05Gbit/s

-- 
-Lev

--000000000000ff6fab0593adb91a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">I have added wintun&#39;s MSM (official d=
istribution way) to windows client installer:<div><br></div><div><a href=3D=
"https://staging.openvpn.net/openvpn2/openvpn-install-2.5_git-I607-Win10.ex=
e">https://staging.openvpn.net/openvpn2/openvpn-install-2.5_git-I607-Win10.=
exe</a><br></div><br>To use wintun driver instead of tap-window6, add &quot=
;windows-driver wintun&quot; to your VPN profile.<br><br>Fresh performance =
numbers (with recent -O2 fix to windows build system):<br><br>Server - open=
vpn 2.4.4<br>=C2=A0 =C2=A0 tap-windows6: 390Mbit/s<br>=C2=A0 =C2=A0 wintun:=
 730Mbit/s<br><br>Server - openvpn3 with kernel acceleration<div>=C2=A0 =C2=
=A0 tap-windows6: 405Mbit/s<br>=C2=A0 =C2=A0 wintun: 1.05Gbit/s</div><div><=
br></div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">-Lev</div>=
</div>

--000000000000ff6fab0593adb91a--

