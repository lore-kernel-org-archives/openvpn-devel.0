MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 29 Dec 2016 09:56:44 +0500
Message-ID: <CAFHpkQEeLcCtu3RrbzQLEzS8-2B74DTT_5yh1MRnVL7CZ3xcdg@...278...>
Content-Type: multipart/alternative; boundary=089e013c656a802e830544c4e917
Subject: [Openvpn-devel] couple of questions on trac#665
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e013c656a802e830544c4e917
Content-Type: text/plain; charset=UTF-8

Hello,

I seem to see several times issues like described in #665

what seems to be strange is couple of things:

1) "OR" clause. why not "AND" ?
https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/tun.c#L6012-L6013

2) error message seems to be irrelevant
https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/tun.c#L6034

it might be an error from earlier function calls, not only FlushIpNetTable
itself.


any ideas ?


Cheers,
Ilya Shipitsin

--089e013c656a802e830544c4e917
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hello,<br><br></div>I seem to see several t=
imes issues like described in #665<br></div><br></div>what seems to be stra=
nge is couple of things:<br><div><div><div><div><div><div><br>1) &quot;OR&q=
uot; clause. why not &quot;AND&quot; ?=C2=A0 <a href=3D"https://github.com/=
OpenVPN/openvpn/blob/master/src/openvpn/tun.c#L6012-L6013">https://github.c=
om/OpenVPN/openvpn/blob/master/src/openvpn/tun.c#L6012-L6013</a><br><br></d=
iv><div>2) error message seems to be irrelevant=C2=A0 <a href=3D"https://gi=
thub.com/OpenVPN/openvpn/blob/master/src/openvpn/tun.c#L6034">https://githu=
b.com/OpenVPN/openvpn/blob/master/src/openvpn/tun.c#L6034</a><br><br></div>=
<div>it might be an error from earlier function calls, not only <span class=
=3D"gmail-pl-s">FlushIpNetTable itself. <br><br><br></span></div><div><span=
 class=3D"gmail-pl-s">any ideas ?<br></span></div><div><span class=3D"gmail=
-pl-s"><br><br></span></div><div><span class=3D"gmail-pl-s">Cheers,<br></sp=
an></div><div><span class=3D"gmail-pl-s">Ilya Shipitsin<br></span></div></d=
iv></div></div></div></div></div>

--089e013c656a802e830544c4e917--

