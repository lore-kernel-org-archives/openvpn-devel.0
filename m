Date: Thu, 21 Aug 2008 20:18:37 +0200
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20080821181836.GE2516@...30...>
MIME-Version: 1.0
Subject: [Openvpn-devel] rc9 and external commands
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
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

Hi James,

It seems that tightening the security on OpenVPN brought some surprises
[1] to users and broke some features [2].

As for [1], I included a note in the Debian NEWS file on the new
--script-security option. But those updating a VPN using the very same
VPN (and without previous knowledge of this option) may find themselves
without access to the remote system (if the VPN/system is restarted, and
a script is to be executed). Also, those using NetworkManager [3] aren't
able to specify the '--script-security' option, and since NetworkManager
may/will call external scripts, this new security feature will break
their VPNs. The option is really useful, but 2 would be a more sensible
default IMHO.

Regarding [2] an strace shows that calls to external commands with
arguments include the arguments as part of the command filename:
For:=20
--up "/tmp/foo up"

The call is:
[pid  3519] execve("/tmp/foo up", ["/tmp/foo up", "tun0", "1500", "1542",
"10.XXX.XXX.X", "10.XXX.XXX.X", "init"], [/* 30 vars */]) =3D -1 ENOENT
(No such file or directory)

Where in previous versions the call was:
[pid  4074] execve("/tmp/kk", ["/tmp/kk", "up", "tun0", "1500", "1542",
"10.XXX.XXX.X", "10.XXX.XXX.X", "init"], [/* 51 vars */]) =3D 0

Please let me know what's your opinion regarding [1].

Thanks a lot,

Alberto

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D494998
[2] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D495964
[3] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D494998#10

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

