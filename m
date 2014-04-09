Date: Thu, 10 Apr 2014 01:25:27 +0200
From: Cedric <cedric+openvpn@...1891...>
Message-ID: <20140409232527.GA3061@...1890...>
MIME-Version: 1.0
Subject: [Openvpn-devel] BUG: Windows netsh interface ipv6 delete address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

I get an error on latest release 2.3.3 (and previous ones), on windows 8.1.

NETSH: C:\WINDOWS\system32\netsh.exe interface ipv6 delete address OPENVPN =
2a02:xxxx:xxxx:ffff::1000
ERROR: netsh command failed: returned error code 1
MANAGEMENT: Client disconnected
NETSH: command failed
Exiting due to fatal error

When I type on commande line (administrator):
netsh interface ipv6 delete address OPENVPN 2a02:xxxx:xxxx:ffff::1000
it fails with : "The system cannot find the file specified"

When I type on commande line (administrator):
"netsh interface ipv6 delete address OPENVPN 2a02:xxxx:xxxx:ffff::1000 stor=
e=3Dactive"
windows removes the ipv6 address successfully from the interface.

I think address is set with store=3Dactive by openvpn therefore it must be
deleted with store=3Dactive also which is not the default according to
netsh usage :

 [[store=3D]active|persistent]
    One of the following values:
        active: Address will disappear on next boot.
        Persistent (default): Address will be persistent.

Consequences :
- Openvpn never reconnects automatically (fatal error due to ipv6 delete
  failure)
- On (manual) reconnect openvpn adds a new ipv6 address but the old one
  is still prefered and ipv6 is not working any more.
- Ipv6 address is never removed from tun/tap interface and disappears
  only on reboot

Regards

C=E9dric


