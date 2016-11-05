MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sat, 5 Nov 2016 10:52:16 +0500
Message-ID: <CAFHpkQFzZRLQhOTqoOakUuwUURo4=-Jf-FPiYfi-de86=6Q1Pw@...278...>
Content-Type: multipart/alternative; boundary=001a114c245eace57e054087646d
Subject: [Openvpn-devel] any reason to not adding tap-windows.h to
 https://github.com/OpenVPN/openvpn/tree/master/include ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114c245eace57e054087646d
Content-Type: text/plain; charset=UTF-8

Hello,

I'm geting "build only" travis-ci mingw cross compile config
and I came to idea that I do not understand why "tap-windows.h" must be
downloaded separately

1) if we use some functions, we should include prototypes. it is not very
common to download prototypes from different location
2) such way requires also complicated things like configure checks (which
in turn may be avoided if we include tap-windows.h)


so, I guess, there're might be legal issue ?
if not, I vote for adding tap-windows.h into openvpn repo.
it will simplify things a lot

Cheers,
Ilya Shipitsin

--001a114c245eace57e054087646d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div><div><div>Hello,<br><br=
></div>I&#39;m geting &quot;build only&quot; travis-ci mingw cross compile =
config <br></div>and I came to idea that I do not understand why &quot;tap-=
windows.h&quot; must be downloaded separately<br><br></div>1) if we use som=
e functions, we should include prototypes. it is not very common to downloa=
d prototypes from different location<br></div>2) such way requires also com=
plicated things like configure checks (which in turn may be avoided if we i=
nclude tap-windows.h)<br><br><br></div>so, I guess, there&#39;re might be l=
egal issue ?<br></div>if not, I vote for adding tap-windows.h into openvpn =
repo.<br></div>it will simplify things a lot<br><br></div>Cheers,<br></div>=
Ilya Shipitsin<br></div>

--001a114c245eace57e054087646d--

