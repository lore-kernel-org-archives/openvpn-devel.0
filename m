From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20060403102922.GB2617@...30...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Possible security bug
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
Date: Mon Apr  3 03:31:02 2006
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

Hi all,

I have just received the following bug report from the Debian Bug Track
System:

--
From: Hendrik Weimer <hendrik@...595...>

As described in http://www.osreviews.net/reviews/security/openvpn
OpenVPN contains a security hole that allows a malicious VPN server to
take over connected clients.

OpenVPN allows to push environment variables to a client via 'push
setenv ...'. Using LD_PRELOAD it is possible to run arbitrary code as
root. The only prerequisite is that the attacker needs to control a
file on the victim's computer, e.g. by returning a specially crafted
document upon web access.

A possible solution would be to prefix all pushed environment
variables with something like 'OPENVPN_'.
--

What's your opinion on this?

Thanks,

Alberto

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

