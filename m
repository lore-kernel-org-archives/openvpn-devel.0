MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 29 Jun 2016 13:05:17 +0500
Message-ID: <CAFHpkQGrube6hF3+hab3NdNhcifjV15ZSefdUWCcXJPg_CApKw@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0d4b98d71d2c053666367c
Subject: [Openvpn-devel] git master: no more WinXP ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0d4b98d71d2c053666367c
Content-Type: text/plain; charset=UTF-8

Hello,

I'm trying to install openvpn git master on WinXP, no luck, it complains on
missing fwpuclnt.dll

there's no such dll in WinXP (and it is not possible to supply dll within
installer)



https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/Makefile.am#L130


however, I do not see, where it is called in code.
what is it for ?


Cheers,
Ilya Shipitsin

--94eb2c0d4b98d71d2c053666367c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hello,<br><br></div>I&#39;m trying to install op=
envpn git master on WinXP, no luck, it complains on missing fwpuclnt.dll<br=
><br></div>there&#39;s no such dll in WinXP (and it is not possible to supp=
ly dll within installer)<br><br><div><br><br><a href=3D"https://github.com/=
OpenVPN/openvpn/blob/master/src/openvpn/Makefile.am#L130">https://github.co=
m/OpenVPN/openvpn/blob/master/src/openvpn/Makefile.am#L130</a><br><br><br><=
/div><div>however, I do not see, where it is called in code.<br></div><div>=
what is it for ?<br><br><br></div><div>Cheers,<br></div><div>Ilya Shipitsin=
<br></div></div>

--94eb2c0d4b98d71d2c053666367c--

