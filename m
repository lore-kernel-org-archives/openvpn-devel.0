From: "Harsha V. Madhyastha" <harsha@...338...>
Message-ID: <Pine.LNX.4.58L.0501161159200.3896@...339...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Problem setting point-to-point mode in 2.0 versions
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
Date: Sun Jan 16 12:24:22 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I'm using OpenVPN on Windows XP and I need to set Point-to-Point mode on 
the device in order to emulate a "tun" interface (as specified in 
http://cvs.sourceforge.net/viewcvs.py/openvpn/openvpn/tap-win32/tapdrvr.c?rev=1.2.2.5)

As specified in 
http://www.tinc-vpn.org/svn/tinc/branches/1.0-gnutls/src/mingw/device.c 
and
http://cvs.sourceforge.net/viewcvs.py/openvpn/openvpn/tun.c?rev=1.46
I used the following code to do this:

#define TAP_CONTROL_CODE(request, method) \
CTL_CODE(FILE_DEVICE_PHYSICAL_NETCARD | 8000, request, method, \
FILE_ANY_ACCESS)
#define TAP_IOCTL_CONFIG_POINT_TO_POINT TAP_CONTROL_CODE(6, METHOD_BUFFERED)

unsigned long ep[2];
HANDLE hTAP32;
long len;

hTAP32 = CreateFile(device_path, GENERIC_READ | GENERIC_WRITE, 0, 0, \
	OPEN_EXISTING, FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED, 0);
ep[0] = inet_addr("10.0.0.1");
ep[1] = ep[0] ^ inet_addr("0.0.0.3");
if (!DeviceIoControl (hTAP32, TAP_IOCTL_CONFIG_POINT_TO_POINT, \
	ep, sizeof (ep), ep, sizeof (ep), &len, NULL))
{
	fprintf (stderr, "ERROR: The TAP-Win32 driver rejected a 
DeviceIoControl call to set Point-to-Point mode\n");
}

The above call to DeviceIoControl works in the 1.6 version of OpenVPN but 
fails in all the 2.0 beta versions. It would be great if any of could let 
me know what the cause for the problem could be.

BTW, thank you very much Charles for replying to my previous post. I guess 
the point you raised there was pertinent. I will look into the JVM source 
to figure out the root of the problem.

Thanks!
Harsha

