Date: Mon, 17 Jun 2013 13:00:03 +0200
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20130617110003.GX4767@...1330...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Fix for CVE-2013-2061 breaks multihome?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net
Cc: 712414@...40...

Hi,

I applied the fix for CVE-2013-2061 [0] to Debian's stable version of
openvpn (2.2.1) [1]. When the new package was sent to the mirrors I got
a couple of reports of broken VPNs [2]. After some testing I think the
problem arises with the use of "multihome" option. The server daemon
starts to log lots of these:
Jun 17 12:43:52 srv ovpn-srv[31073]: write UDPv4 []: Invalid argument (code=
=3D22)
Jun 17 12:43:53 srv ovpn-srv[31073]: write UDPv4 []: Invalid argument (code=
=3D22)

If the "multihome" option is removed, the VPN comes back to live.

Could a patch to fix this be made or should we go back to 2.2.1 without
the patch to fix CVE-2013-2061?

Thanks,

Alberto



[0] https://github.com/OpenVPN/openvpn/commit/11d21349a4e7e38a025849479b36a=
ce7c2eec2ee
[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D707329
[2] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D712414
--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 5347 CBD8 3E30 A9EB 4D7D  4BF2 009B 3375 6B9A AA55

