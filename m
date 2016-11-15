MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 16 Nov 2016 00:44:52 +0500
Message-ID: <CAFHpkQGt=0+UOgKV2Tcezqn9Zs=3tA5r_BB=OW4rbcZ2g-vWsg@...278...>
Content-Type: multipart/alternative; boundary=001a114b16b8ac2c3205415c302a
Subject: [Openvpn-devel] moving to openssl-1.0.2 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114b16b8ac2c3205415c302a
Content-Type: text/plain; charset=UTF-8

Hello,

as accidently was figured out, travis-ci currently runs openvpn/openvpn
with openssl-1.0.2

however, openvpn (windows) installer is built using openssl-1.0.1 (which is
EOL soon).
I guess we should move to 1.0.2, right?


Cheers,
Ilya Shipitsin

--001a114b16b8ac2c3205415c302a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>Hello,<br><br></div>as accidently=
 was figured out, travis-ci currently runs openvpn/openvpn with openssl-1.0=
.2<br><br></div>however, openvpn (windows) installer is built using openssl=
-1.0.1 (which is EOL soon).<br></div>I guess we should move to 1.0.2, right=
?<br><br><br></div>Cheers,<br></div>Ilya Shipitsin<br></div>

--001a114b16b8ac2c3205415c302a--

