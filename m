MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 8 Jan 2017 17:56:32 +0500
Message-ID: <CAFHpkQHV6b--hrbWPSo+sj-8T+v4GP-hQ-SABp9BUOn6+rYKiQ@...278...>
Content-Type: multipart/alternative; boundary=001a113bef56c645ef054594c7fd
Subject: [Openvpn-devel] testers wanted! (trac#806)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113bef56c645ef054594c7fd
Content-Type: text/plain; charset=UTF-8

Hello,

I want https://github.com/OpenVPN/openvpn-build/pull/70 to be merged before
2.4.1

while change itself does not look intrusive, we never did it, so "/OEM"
switch may have any side effect on RTL (arabic or hebrew) or multibyte
(like chinese) windows build.

I created test installer:

https://chipitsine.github.io/oem/openvpn-install-2.4.0-I601.exe


can you please test on as many windows as possible ?

note for @mattock, current community installer is built using nsis-2.46, I
created test installer with nsis-2.50, can you please have a look at
changes, should we upgrade nsis to 2.50 ?


Cheers,
Ilya Shipitsin

--001a113bef56c645ef054594c7fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hello,<br><br></div>I want <a href=3D"https=
://github.com/OpenVPN/openvpn-build/pull/70">https://github.com/OpenVPN/ope=
nvpn-build/pull/70</a> to be merged before 2.4.1 <br><br></div>while change=
 itself does not look intrusive, we never did it, so &quot;/OEM&quot; switc=
h may have any side effect on RTL (arabic or hebrew) or multibyte (like chi=
nese) windows build.<br><br></div>I created test installer:<br><div><div><b=
r><a href=3D"https://chipitsine.github.io/oem/openvpn-install-2.4.0-I601.ex=
e">https://chipitsine.github.io/oem/openvpn-install-2.4.0-I601.exe</a><br><=
br><br></div><div>can you please test on as many windows as possible ?<br><=
br></div><div>note for @mattock, current community installer is built using=
 nsis-2.46, I created test installer with nsis-2.50, can you please have a =
look at changes, should we upgrade nsis to 2.50 ?<br><br><br></div><div>Che=
ers,<br></div><div>Ilya Shipitsin<br></div></div></div>

--001a113bef56c645ef054594c7fd--

