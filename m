From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20041102173519.GD1542@...30...>
Mime-Version: 1.0
Subject: [Openvpn-devel] When the link used for openvpn goes down, the daemon hangs
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
Date: Tue Nov  2 09:41:32 2004
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

Hi again,

Another bug report received in the Debian BTS [1]. Quoting:
|when the link which was used for openvpn transport goes down, it hangs
|in a D state
|
|root      2037  0.0  0.2  3376 1620 pts/1    D    10:45   0:04 openvpn
|
|and there is no way to kill it, I have to reboot. Other programs (eg.
|wavemon) can handle this situation more sanely.


Regards,

Alberto


[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D278933

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.org

Key fingerprint =3D 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

