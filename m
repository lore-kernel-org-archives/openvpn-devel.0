Message-ID: <OF16152585.163DBB30-ON41256EC4.0055E643@...246...>
From: Juerg.VonBueren@...245...
MIME-Version: 1.0
Subject: [Openvpn-devel] Urgent: Limitation to 100  virtual tunnel devices??
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
Date: Thu Jul  1 08:19:04 2004
Content-type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

We are running into trouble with more than 100 virtual tunnel devices .
The reported problem is as follows:

Reported Failure in /var/log/syslog
Jul  1 06:30:19 1100PRVC001 openvpn[15520]: OpenVPN 1.5.0 i386-rpm-linux
[SSL] [LZO] [PTHREAD] built on Mar  4 2004
Jul  1 06:30:19 1100PRVC001 openvpn[15520]: Note: Cannot ioctl TUNSETIFF
tun: Too many open files in system (errno=3D23)
Jul  1 06:30:19 1100PRVC001 openvpn[15520]: Note: Attempting fallback to
kernel 2.2 TUN/TAP interface
Jul  1 06:30:19 1100PRVC001 openvpn[15520]: Cannot allocate TUN/TAP dev
dynamically
Jul  1 06:30:19 1100PRVC001 openvpn[15520]: Exiting

max file-handles ist set to 16384


You can reproduce the failure by starting openvpn with:
openvpn --dev-node /dev/net/tun --port 5000&
openvpn --dev-node /dev/net/tun --port 5001&
openvpn --dev-node /dev/net/tun --port 5002&
....
....
openvpn --dev-node /dev/net/tun --port 5099&
openvpn --dev-node /dev/net/tun --port 5100&



Distribution ist Debian Woody 3.0 r2      (Kernel 2.4.18)
openvpn 1.5.0-2                     (rpm-Package, converted via alien to
deb-package)

Is there any known Limitation to 100 TUN-Devices or how can we break that
limitation?

Thanks
J=FCrg von B=FCren
IT Systeme

AMAG Automobil- und Motoren AG, Informatik, D=E4llikerstr. 34, CH-8107 Buchs
Juerg.vonBueren@...245...




