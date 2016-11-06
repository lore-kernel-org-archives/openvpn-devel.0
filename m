MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 6 Nov 2016 23:26:37 +0500
Message-ID: <CAFHpkQFqbsod+BrJ3VCt8UVjhwj8u=+SYG=0G2NVHWn9h9etpw@...278...>
Content-Type: multipart/alternative; boundary=047d7b5d98ab46f6220540a60ce0
Subject: [Openvpn-devel] mingw cross build on travis-ci
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7b5d98ab46f6220540a60ce0
Content-Type: text/plain; charset=UTF-8

Hello,

https://travis-ci.org/OpenVPN/openvpn/builds/173710684   :)

everybody is welcome to comment (and make PR) here:

https://github.com/OpenVPN/openvpn/pull/66


why cross compile can be useful (even without "make check"):

(*) it could catch 'c99 patch'
(*) (after I add lzo, pkcs11) it will be the same as release build, so we
can be sure, we didn't break the way windows installer is built

Cheers,
Ilya Shipitsin

--047d7b5d98ab46f6220540a60ce0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div>Hello,<br><br><a href=3D"htt=
ps://travis-ci.org/OpenVPN/openvpn/builds/173710684">https://travis-ci.org/=
OpenVPN/openvpn/builds/173710684</a>=C2=A0=C2=A0 :)<br><br></div>everybody =
is welcome to comment (and make PR) here:<br><br><a href=3D"https://github.=
com/OpenVPN/openvpn/pull/66">https://github.com/OpenVPN/openvpn/pull/66</a>=
<br><br><br></div>why cross compile can be useful (even without &quot;make =
check&quot;):<br><br></div>(*) it could catch &#39;c99 patch&#39;<br></div>=
(*) (after I add lzo, pkcs11) it will be the same as release build, so we c=
an be sure, we didn&#39;t break the way windows installer is built<br><br><=
/div>Cheers,<br></div>Ilya Shipitsin<br><div><div><br><br></div></div></div>

--047d7b5d98ab46f6220540a60ce0--

