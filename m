MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 23 Jun 2017 14:59:45 +0500
Message-ID: <CAFHpkQFO7thcucb_iCb2vz2ySvVbDFc0qj2BY2b5B+TG9LG_Gg@...278...>
Content-Type: multipart/alternative; boundary="001a114690643d04d905529da9bd"
Subject: [Openvpn-devel] test usage() ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114690643d04d905529da9bd
Content-Type: text/plain; charset="UTF-8"

Hello,

following to
https://github.com/OpenVPN/openvpn/commit/49629380a7bdba25c24c9d410b79946fe29249f0

I spent some days on trying to get cmocka to test usage(), I gave up :-)
now, I think, we should just add "src/openvpn/openvpn --help" to .travis.yml

the question is - can we rely on exit status "1"  here ?


$ src/openvpn/openvpn --help >/dev/null
$ echo $?
1
$


why does "1" mean "ok" here ?


Cheers,
Ilya Shipitsin

--001a114690643d04d905529da9bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hello,<br><br></div><div>following to <a hr=
ef=3D"https://github.com/OpenVPN/openvpn/commit/49629380a7bdba25c24c9d410b7=
9946fe29249f0">https://github.com/OpenVPN/openvpn/commit/49629380a7bdba25c2=
4c9d410b79946fe29249f0</a><br></div><div><br></div>I spent some days on try=
ing to get cmocka to test usage(), I gave up :-)<br></div>now, I think, we =
should just add &quot;src/openvpn/openvpn --help&quot; to .travis.yml<br><b=
r></div>the question is - can we rely on exit status &quot;1&quot;=C2=A0 he=
re ?<br><br><div><div><br>$ src/openvpn/openvpn --help &gt;/dev/null<br>$ e=
cho $?<br>1<br>$ <br><br><br></div><div>why does &quot;1&quot; mean &quot;o=
k&quot; here ?<br><br><br></div><div>Cheers,<br></div><div>Ilya Shipitsin<b=
r></div><div><br></div></div></div>

--001a114690643d04d905529da9bd--

