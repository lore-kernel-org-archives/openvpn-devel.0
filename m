Message-ID: <7f72b422050526073559dd63e3@...278...>
From: Zhenxiao Liu <yingzxliu@...277...>
Reply-To: Zhenxiao Liu <yingzxliu@...277...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Openvpn client on linux cannot get IP for tap
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
Date: Thu May 26 07:37:04 2005
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Openvpn-devel@lists.sourceforge.net

Hi, all,
    I have some problem of running Openvpn bridging.=20
    Below is the senario.
    I have three PCs running linux.
    Linux A runs a dhcp server assigns IP address to pcs connected to
interface eth1.
    Linux B runs a VPN server. eth0 is connected to eth1 of Linux A
and will get a IP assigned by Linux A. VPN server on Linux B uses
tap1. I've set up bridging between tap1 and eth0. Linux B also runs a
dhcp server on its eth1, to which eth0 of Linux C is connected.
    Linux C runs a VPN client with its remote set to be the IP of eth1
of Linux B.
=20=20=20=20
    VPN client on Linux C uses tap2. But tap2 cannot get a IP that
Linux A assignes. But if I use a windows client instead of Linux C,
the tap device will get a IP address.

   Am i doing something wrong?

  thanks a lot,

Liu

