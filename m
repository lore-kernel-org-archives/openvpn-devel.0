From: Juergen Hennerich <juergen.hennerich@...68...>
Reply-To: juergen.hennerich@...68...
Message-Id: <1127694040.5642.125.camel@...460...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Automatically set parameters for a tap device.
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
Date: Sun Sep 25 17:23:33 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi, 

I'm currently building a Windows installer for a debian/coLinux based
embedded toolchain.

For internet access I'm using the slirp daemon which is a zero
configuration solution and is working great. But for local access I have
to use a tap device.

My problem is, while I can install the driver without a problem, I have
no idea how to configure the network interface. I need to find an unused
private subnet and set the IP address of the tap device. Since Windows
enumerates the devices in a way, I haven't seen through yet, I can't do
this with netsh.

Is there an easy way to install the tuntap driver and set up the
interface address with openvpn?

Or is there another way to reliably get a local connection configured?
(XP and Win2k).

Is it also possible to automatically configure bridging?


Thanks in advance

Juergen Hennerich



