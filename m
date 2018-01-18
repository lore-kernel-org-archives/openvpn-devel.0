MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 18 Jan 2018 13:49:15 +0500
Message-ID: <CAFHpkQGe-aeaV2we=M_xB41W36dwAa8rRRzmt6rteVvAHuXFKA@...278...>
Content-Type: multipart/alternative; boundary="001a114b65bceb8bb705630909bc"
Subject: [Openvpn-devel] consider exe_path optional ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001a114b65bceb8bb705630909bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

changes https://github.com/OpenVPN/openvpn-gui/pull/197 actually make
openvpn-gui less dependent on registry


we sometimes see similar issue with interactive service:

openvpnserv error: =D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=B5=D1=82=D1=81=D1=8F =
=D0=BD=D0=B0=D0=B9=D1=82=D0=B8 =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BD=
=D1=8B=D0=B9 =D1=84=D0=B0=D0=B9=D0=BB. (0x2) Error querying
registry value: HKLM\SOFTWARE\OpenVPN\exe_path

(I've no idea why "exe_path" was deleted)

@selvanair , what do you think if we'll try to guess exe_path by picking
directory from where openvpnserv was started ? (it is a good guess to
assume openvpn.exe is in the same directory)

Cheers,
Ilya Shipitsin

--001a114b65bceb8bb705630909bc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div>Hello,<br><br></div>changes =
<a href=3D"https://github.com/OpenVPN/openvpn-gui/pull/197">https://github.=
com/OpenVPN/openvpn-gui/pull/197</a> actually make openvpn-gui less depende=
nt on registry<br><br><br></div>we sometimes see similar issue with interac=
tive service:<br><br>openvpnserv error: =D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=
=B5=D1=82=D1=81=D1=8F =D0=BD=D0=B0=D0=B9=D1=82=D0=B8 =D1=83=D0=BA=D0=B0=D0=
=B7=D0=B0=D0=BD=D0=BD=D1=8B=D0=B9 =D1=84=D0=B0=D0=B9=D0=BB. (0x2) Error que=
rying registry value: HKLM\SOFTWARE\OpenVPN\exe_path<br><br></div>(I&#39;ve=
 no idea why &quot;exe_path&quot; was deleted)<br><br></div>@selvanair , wh=
at do you think if we&#39;ll try to guess exe_path by picking directory fro=
m where openvpnserv was started ? (it is a good guess to assume openvpn.exe=
 is in the same directory)<br><br></div>Cheers,<br></div>Ilya Shipitsin<br>=
</div>

--001a114b65bceb8bb705630909bc--

