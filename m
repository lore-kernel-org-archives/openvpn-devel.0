MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 15 Mar 2017 20:15:08 +0500
Message-ID: <CAFHpkQGseLH-+NFRxgrF7KNdZ8Fc4A4HQGBOTEktwABW9ZALTw@...278...>
Content-Type: multipart/alternative; boundary=001a1147ded804df06054ac66993
Subject: [Openvpn-devel] why "ifconfig" is required during build ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1147ded804df06054ac66993
Content-Type: text/plain; charset=UTF-8

Hello,

I'm playing with AppVeyor, and I figured out that I have no idea why does
"ifconfig" is checked during build process:

[ilia@...23... openvpn]$ grep ifconfig configure.ac
AC_PATH_PROGS([IFCONFIG], [ifconfig],,
[$PATH:/usr/local/sbin:/usr/sbin:/sbin])
AC_DEFINE_UNQUOTED([IFCONFIG_PATH], ["$IFCONFIG"], [Path to ifconfig tool])
        test -z "${IFCONFIG}" && AC_MSG_ERROR([ifconfig utility is required
but missing])
[ilia@...23... openvpn]$



well, it makes sense that it might be required for running openvpn. but why
to check it during build ?

Cheers,
Ilya Shipitsin

--001a1147ded804df06054ac66993
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hello,<br><br></div>I&#39;m playing wi=
th AppVeyor, and I figured out that I have no idea why does &quot;ifconfig&=
quot; is checked during build process:<br><br>[ilia@...23... openvpn]$ grep=
 ifconfig <a href=3D"http://configure.ac">configure.ac</a><br>AC_PATH_PROGS=
([IFCONFIG], [ifconfig],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])<br>AC_DE=
FINE_UNQUOTED([IFCONFIG_PATH], [&quot;$IFCONFIG&quot;], [Path to ifconfig t=
ool])<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 test -z &quot;${IFCONFIG}&qu=
ot; &amp;&amp; AC_MSG_ERROR([ifconfig utility is required but missing])<br>=
[ilia@...23... openvpn]$ <br><br><br><br></div>well, it makes sense that it=
 might be required for running openvpn. but why to check it during build ?<=
br><br></div>Cheers,<br></div>Ilya Shipitsin<br></div>

--001a1147ded804df06054ac66993--

