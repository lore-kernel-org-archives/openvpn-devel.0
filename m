Message-Id: <ID1003$8ED5A4D33DAACC74B0E5AE6E1A15DABA@...354...>
MIME-Version: 1.0
From: "andi\.c\@libero\.it" <andi.c@...354...>
Subject: [Openvpn-devel] help on win32 tap interface
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
Date: Tue Mar  8 01:08:26 2005
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi to all,
i can't understand why my code (based on openvpn's tun.c file) to
correctly read and write on win32 tap device doesn't work,
All i do is:

1 -- call get_tap_reg and get_panel_reg functions

2 -- call get_unspecified_device_guid function to obtain TAP id

3 -- call CreateFile on the device_path returned. It returns OK

4 -- call TAP_IOCTL_GET_VERSION, TAP_IOCTL_GET_MTU,
IoControls , to obtain TAP device driver and mtu info. All seems
ok.

5 -- call TAP_IOCTL_SET_MEDIA_STATUS IoControl to set the device
as "connected". ok

6 -- Then i call simple ReadFile to read data submitted on the
TAP interface. The problem is that some kind of packet
arrives, but they seems to be corrupted (es. an IPv6 header
format is totally wrong).


Anyone has some suggestion ??? Please !!!



____________________________________________________________
Navighi a 2 MEGA e i primi 3 mesi sono GRATIS.=20
Scegli Libero Adsl Flat senza limiti su http://www.libero.it



