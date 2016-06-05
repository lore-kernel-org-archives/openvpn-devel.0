MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 5 Jun 2016 12:33:00 +0500
Message-ID: <CAFHpkQG-er+5B6KXae46eoXb1DVHaNP8qVjkEtFzLDcsHe3qQQ@...278...>
Content-Type: multipart/alternative; boundary=001a114a54ba2e8101053482f76c
Subject: [Openvpn-devel] clang static analysis
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114a54ba2e8101053482f76c
Content-Type: text/plain; charset=UTF-8

Hello,

I performed the following steps

1) cloned master branch of https://github.com/openvpn/openvpn
2) autoreconf -iv
3) ./configure
4) scan-build make

(scan-build is clang tool for static analysis)


report is here:  http://chipitsine.github.io/openvpn-clang-scan/

I think we should take care of those warnings.

Cheers,
Ilya Shipitsin

--001a114a54ba2e8101053482f76c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div><div><div><div>Hello,<b=
r><br></div>I performed the following steps<br><br></div>1) cloned master b=
ranch of <a href=3D"https://github.com/openvpn/openvpn">https://github.com/=
openvpn/openvpn</a><br></div>2) autoreconf -iv<br></div>3) ./configure<br><=
/div>4) scan-build make<br><br></div>(scan-build is clang tool for static a=
nalysis)<br><br><br></div>report is here:=C2=A0 <a href=3D"http://chipitsin=
e.github.io/openvpn-clang-scan/">http://chipitsine.github.io/openvpn-clang-=
scan/</a><br><br></div>I think we should take care of those warnings.<br><b=
r></div>Cheers,<br></div>Ilya Shipitsin<br></div>

--001a114a54ba2e8101053482f76c--

