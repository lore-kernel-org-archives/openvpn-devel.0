From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20041102173057.GC1542@...30...>
Mime-Version: 1.0
Subject: [Openvpn-devel] The "Assertion failed" problem and a minor patch
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Nov  2 09:38:17 2004
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

Hi James,

Someone else wrote me about the "Assertion failed at crypto.c:147"
problem. This guy's error was on line 149, but that could be due to a
different OpenVPN version. Anyway, I attached the mail to the Debian BTS
[1], and you may want to contact him [2] to get further information.

In another bug report, we got a little patch that solves the problem of
specifying the --daemon option both in the init.d script and in the
configuration file. Specifying both now causes a fatal error, with the
patch, only a warning is issued and the one in the configuration file is
used. [3] I applied the patch for the init.d script, so it won't specify
the --daemon option if it's already in the configuration file, but I
think the one for options.c seems to be a better solution.


Regards,

Alberto

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D265632
[2] Trey Kelso <tkelso[A T]focuspools.com>
[3] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D278302

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.org

Key fingerprint =3D 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

