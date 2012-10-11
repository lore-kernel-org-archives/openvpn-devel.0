Date: Thu, 11 Oct 2012 17:21:35 +0200
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20121011152135.GW4969@...1330...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Using --mlock and --user makes openvpn "run out of
	memory"
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

Hi,

There's an open bug in Debian [1] since 2007, that seems to be quite
documented right now. To sum up, when you run openvpn with --mlock and
--user, the daemon will die with "out of memory", possibly due to
mlock(2):

BUGS
Since  kernel  2.6.9, if a privileged process calls mlockall(MCL_FUTURE)
and later drops privileges (loses the CAP_IPC_LOCK capability by, for
example,  setting  its effective  UID  to  a  nonzero  value),  then
subsequent memory allocations (e.g., mmap(2), brk(2)) will fail if the
RLIMIT_MEMLOCK resource limit is encountered.

The bug report contains a workaround (editing PAM limits) and a plea to
document this behaviour. I guess it's better to document this (after
verification of the facts) in OpenVPN's man page rather than just
Debian's package.

Regards,

Alberto


[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D406895
--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

