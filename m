MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sat, 19 Nov 2016 21:06:30 +0500
Message-ID: <CAFHpkQGqwWTjggCFP0eAScxq35F3usD38zRNQDb++V+HpmzNuw@...278...>
Content-Type: multipart/alternative; boundary=001a114b7e0c1dd3d90541a99b12
Subject: [Openvpn-devel] openvpn-gui disconnect on suspend ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114b7e0c1dd3d90541a99b12
Content-Type: text/plain; charset=UTF-8

Hello,

I see that option in Changes.rst, but I do not see any reference in code:

[ilia@...23... openvpn-gui]$ grep -r disconnect_on_suspend .
./CHANGES.rst:Registry option "disconnect_on_suspend". Set to zero to
disable the
[ilia@...23... openvpn-gui]$


https://github.com/OpenVPN/openvpn-build/blob/master/windows-nsis/openvpn.nsi#L329

how is it supposed to work ?

Cheers,
Ilya Shipitsin

--001a114b7e0c1dd3d90541a99b12
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hello,<br><br></div>I see that option =
in Changes.rst, but I do not see any reference in code:<br><br>[ilia@...2192...=
.. openvpn-gui]$ grep -r disconnect_on_suspend .<br>./CHANGES.rst:Registry =
option &quot;disconnect_on_suspend&quot;. Set to zero to disable the<br>[il=
ia@...23... openvpn-gui]$ <br><br><br><a href=3D"https://github.com/OpenVPN=
/openvpn-build/blob/master/windows-nsis/openvpn.nsi#L329">https://github.co=
m/OpenVPN/openvpn-build/blob/master/windows-nsis/openvpn.nsi#L329</a><br><b=
r></div>how is it supposed to work ?<br><br></div>Cheers,<br></div>Ilya Shi=
pitsin<br></div>

--001a114b7e0c1dd3d90541a99b12--

