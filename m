Message-ID: <op.s7kva3di285pr5@...606...>
From: Hofi <hofi@...605...>
MIME-Version: 1.0
Subject: [Openvpn-devel] How to use TAP_IOCTL_GET_LOG_LINE
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
Date: Thu Apr  6 01:32:03 2006
Content-Type: text/plain; charset="utf-8"; delsp=yes; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi All!
	I'm trying to use the openvpn tap device on win32 (latest beta11,
selfbuilt) I'm opening with CreateFile and reading from the device with
ReadFile. Everything works fine in tap mode, but in tun mode i have
problems, therefore i wish to see the debug info from the tap-driver. I
found that there is an ioctl TAP_IOCTL_GET_LOG_LINE in the driver. I'm
using DeviceIoControl calls with the TAP_IOCTL_GET_LOG_LINE param and able
to read the debug info, but after a while the normal ReadFile of the tap
device fails with the error: A device attached to the system is not
functioning. (31)
If not using the TAP_IOCTL_GET_LOG_LINE calls the program works fine.
Is there any special rule of using TAP_IOCTL_GET_LOG_LINE ioctl calls?
What is the best method to read the debug info from the device?
Any hints would be greatly welcome!
TIA
	bests
		Hofi

