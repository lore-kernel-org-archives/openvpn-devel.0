From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Automatically set parameters for a tap device.
In-Reply-To: <1127694040.5642.125.camel@...460...>
Message-ID: <Pine.LNX.4.58.0509261752140.25922@...41...>
References: <1127694040.5642.125.camel@...460...>
MIME-Version: 1.0
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
Date: Mon Sep 26 16:54:24 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Juergen Hennerich <juergen.hennerich@...68...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, 26 Sep 2005, Juergen Hennerich wrote:

> Hi, 
> 
> I'm currently building a Windows installer for a debian/coLinux based
> embedded toolchain.
> 
> For internet access I'm using the slirp daemon which is a zero
> configuration solution and is working great. But for local access I have
> to use a tap device.
> 
> My problem is, while I can install the driver without a problem, I have
> no idea how to configure the network interface. I need to find an unused
> private subnet and set the IP address of the tap device. Since Windows
> enumerates the devices in a way, I haven't seen through yet, I can't do
> this with netsh.
> 
> Is there an easy way to install the tuntap driver and set up the
> interface address with openvpn?
> 
> Or is there another way to reliably get a local connection configured?
> (XP and Win2k).
> 
> Is it also possible to automatically configure bridging?

See the tun.c code in OpenVPN, look for the #ifdef WIN32 code  -- it will 
show you how OpenVPN sets up the TUN/TAP interface network settings using 
DeviceIoControl calls to the driver.

James


