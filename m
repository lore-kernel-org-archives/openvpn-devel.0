From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20041117114417.GC1675@...30...>
Mime-Version: 1.0
Subject: [Openvpn-devel] mssfix option changed its behaviour
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
Date: Wed Nov 17 03:45:02 2004
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

Hi,

It seems [1] that specifying mssfix without a value, like the man page
suggests [2], gives a fatal (Options) error now. Is this a new expected
behaviour (that should be updated in the man page), or something not
wanted?

Thanks,

Alberto



[1] http://bugs.debian.org/280893
[2]  --tun-mtu 1500 --fragment 1300 --mssfix

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.org

Key fingerprint =3D 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

