MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 8 Jun 2016 17:50:01 +0500
Message-ID: <CAFHpkQFNHWNWZsw+vN=HUQA_MgMEAX9LMa3FMKfoCpTps2k2AQ@...278...>
Content-Type: multipart/alternative; boundary=001a1141e22c7110210534c3be0d
Subject: [Openvpn-devel] how snapshot installers are built ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1141e22c7110210534c3be0d
Content-Type: text/plain; charset=UTF-8

Hello,

I see daily builds like


http://build.openvpn.net/downloads/snapshots/openvpn-install-master-20160607214911-63b3e000c9-x86_64.exe


I used to think they are built with "build-snapshot":
https://github.com/OpenVPN/openvpn-build/blob/master/windows-nsis/build-snapshot

however, when I run it,


....
tap-windows
Fixup libtool files
Restore libtool files
Fixup libtool files
Build openvpn
../generic/build: line 284: cd:
/home/ilia/openvpn-build/windows-nsis/tmp/build-i686/openvpn-2.3.11: No
such file or directory
FATAL: cd openvpn
FATAL: build i686 >&2
FATAL: build-complete >&2
[ilia@...23... windows-nsis]$


somehow it tries to find openvpn-2.3.11 instead of master.


how am I supposed to run that script ?


Cheers,
Ilya Shipitsin

--001a1141e22c7110210534c3be0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div>Hello,<br><br></div>I s=
ee daily builds like <br><br><br><a href=3D"http://build.openvpn.net/downlo=
ads/snapshots/openvpn-install-master-20160607214911-63b3e000c9-x86_64.exe">=
http://build.openvpn.net/downloads/snapshots/openvpn-install-master-2016060=
7214911-63b3e000c9-x86_64.exe</a><br><br><br></div>I used to think they are=
 built with &quot;build-snapshot&quot;: <a href=3D"https://github.com/OpenV=
PN/openvpn-build/blob/master/windows-nsis/build-snapshot">https://github.co=
m/OpenVPN/openvpn-build/blob/master/windows-nsis/build-snapshot</a><br><br>=
</div>however, when I run it, <br><br><br>....<br>tap-windows<br>Fixup libt=
ool files<br>Restore libtool files<br>Fixup libtool files<br>Build openvpn<=
br>../generic/build: line 284: cd: /home/ilia/openvpn-build/windows-nsis/tm=
p/build-i686/openvpn-2.3.11: No such file or directory<br>FATAL: cd openvpn=
<br>FATAL: build i686 &gt;&amp;2<br>FATAL: build-complete &gt;&amp;2<br>[il=
ia@...23... windows-nsis]$ <br><br><br></div>somehow it tries to find openv=
pn-2.3.11 instead of master.<br><br><br></div>how am I supposed to run that=
 script ?<br><br><br></div>Cheers,<br></div>Ilya Shipitsin<br></div>

--001a1141e22c7110210534c3be0d--

