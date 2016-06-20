MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 20 Jun 2016 14:08:55 +0500
Message-ID: <CAFHpkQEVSSivEEYUaodCHSS-oYz11=7uzTq4JmQhZ4YsA9EE4Q@...278...>
Content-Type: multipart/alternative; boundary=047d7b5d4fc2cde53a0535b20d60
Subject: [Openvpn-devel] openvpn/openvpn-build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7b5d4fc2cde53a0535b20d60
Content-Type: text/plain; charset=UTF-8

Hello,

I see issues are closed at https://github.com/openvpn/openvpn-build
what is preffered way of reporting bugs ?

somehow, I managed to run it on cygwin without wget installed (I installed
curl),
so I see 'curl' branch is broken, curl does not follow redirects

do we really need both wget and curl there ?

I'd remove curl at all, it will make scripts more readable and predictible.
Or, ok, remove wget.

actually, we can fix it. and even I'll expand travis-ci matrix for
curl/wget, but I do not really understand why do we need both wget and curl
there.

Cheers,
Ilya Shipitsin

--047d7b5d4fc2cde53a0535b20d60
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div><div>Hello,<br><br></di=
v>I see issues are closed at <a href=3D"https://github.com/openvpn/openvpn-=
build">https://github.com/openvpn/openvpn-build</a><br></div>what is preffe=
red way of reporting bugs ?<br><br></div>somehow, I managed to run it on cy=
gwin without wget installed (I installed curl),<br></div>so I see &#39;curl=
&#39; branch is broken, curl does not follow redirects<br><br></div>do we r=
eally need both wget and curl there ?<br><br></div>I&#39;d remove curl at a=
ll, it will make scripts more readable and predictible. Or, ok, remove wget=
.<br><br></div><div>actually, we can fix it. and even I&#39;ll expand travi=
s-ci matrix for curl/wget, but I do not really understand why do we need bo=
th wget and curl there.<br></div><div><br></div>Cheers,<br></div>Ilya Shipi=
tsin<br></div>

--047d7b5d4fc2cde53a0535b20d60--

