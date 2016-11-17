MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 17 Nov 2016 23:57:41 +0500
Message-ID: <CAFHpkQH8b3PMTh6KEB7CbO2HaUnJ94aNwHt+RHTqXkEUKoAbdg@...278...>
Content-Type: multipart/alternative; boundary=001a11417a9a9b944b054183c30a
Subject: [Openvpn-devel] why do we include openssl.exe in windows installer ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11417a9a9b944b054183c30a
Content-Type: text/plain; charset=UTF-8

Hello,

I noticed that openssl.exe is included

https://github.com/OpenVPN/openvpn-build/blob/master/windows-nsis/openvpn.nsi#L348

and it can be checked independently from easy rsa.

what is use case from user point of view of openssl.exe ?

Cheers,
Ilya Shipitsin

--001a11417a9a9b944b054183c30a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>Hello,<br><br></div>I noticed tha=
t openssl.exe is included<br><br><a href=3D"https://github.com/OpenVPN/open=
vpn-build/blob/master/windows-nsis/openvpn.nsi#L348">https://github.com/Ope=
nVPN/openvpn-build/blob/master/windows-nsis/openvpn.nsi#L348</a><br><br></d=
iv>and it can be checked independently from easy rsa.<br><br></div>what is =
use case from user point of view of openssl.exe ?<br><br></div>Cheers,<br><=
/div>Ilya Shipitsin<br></div>

--001a11417a9a9b944b054183c30a--

