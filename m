From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20041222100009.GE1926@...30...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Fwd: openvpn config parsing
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
Date: Wed Dec 22 02:00:03 2004
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

Hi, yet another report on feature changes not documented.

I thought this may be related to --key-method 2 only, but it seems to be
the same on --key-method 1. Has this changed some where in the 2.x
development? In that case, we should document this for old users.

Thanks.

----- Forwarded message from Ron <ron@...334...> -----

From: Ron <ron@...334...>
To: Alberto Gonzalez Iniesta <agi@...64...>
Subject: openvpn config parsing
Date: Fri, 10 Dec 2004 12:09:42 +1030
X-CRM114-Version: 20040816.BlameClockworkOrange-auto.3 (regex: TRE 0.6.8) M=
F-A10FFB4C=20
X-CRM114-Status: Good  ( pR: 0.9831 )
X-Spam-Status: No, score=3D-2.6 required=3D5.0 tests=3DBAYES_00 autolearn=
=3Dham version=3D3.0.1
X-Spam-Level:=20


Hi Alberto,

Recent updates of openvpn appear to have changed the handling
of whitespace in tls certificate names.

ie. for:

Subject: C=3DOz, ST=3DSecured, L=3DZone, O=3DRiviera tunnel, OU=3Duoa VPN c=
lient,
         CN=3Dtwain.riviera.oz/emailAddress=3Dkeymaster@...335...

I used to need:

tls-remote /C=3DOz/ST=3DSecured/L=3DZone/O=3DRiviera.tunnel/OU=3Duoa.VPN.cl=
ient/CN=3Dtwain.riviera.oz/emailAddress=3Dkeymaster@...335...

Now it needs '_' not '.' for spaces:

tls-remote /C=3DOz/ST=3DSecured/L=3DZone/O=3DRiviera_tunnel/OU=3Duoa_VPN_cl=
ient/CN=3Dtwain.riviera.oz/emailAddress=3Dkeymaster@...335...

This might be worth a mention in the readme, it broke my
existing setup 'silently' -- though it might have been easier
to find if I didn't run off chasing red herrings based on prior
upgrade breakages first :-)

Anyway, thanks for maintaining this one, speaking as an old time
user of cipe, this really is a very nice 'next step' in that
problem space.

best,
Ron


----- End forwarded message -----

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.org

Key fingerprint =3D 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

