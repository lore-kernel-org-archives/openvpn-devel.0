Subject: Re: [Openvpn-devel] Automatically set parameters for a tap device.
From: Juergen Hennerich <juergen.hennerich@...68...>
Reply-To: juergen.hennerich@...68...
In-Reply-To: <Pine.LNX.4.58.0509261752140.25922@...41...>
References: <1127694040.5642.125.camel@...460...>
	 <Pine.LNX.4.58.0509261752140.25922@...41...>
Message-Id: <1128381436.5656.112.camel@...460...>
Mime-Version: 1.0
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
Date: Mon Oct  3 16:18:28 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

Am Di, den 27.09.2005 schrieb James Yonan um 1:53:
> On Mon, 26 Sep 2005, Juergen Hennerich wrote:
> 
> > Hi, 
> > 
> > I'm currently building a Windows installer for a debian/coLinux based
> > embedded toolchain.
> > 
> > For internet access I'm using the slirp daemon which is a zero
> > configuration solution and is working great. But for local access I have
> > to use a tap device.
> > 
> > My problem is, while I can install the driver without a problem, I have
> > no idea how to configure the network interface. I need to find an unused
> > private subnet and set the IP address of the tap device. Since Windows
> > enumerates the devices in a way, I haven't seen through yet, I can't do
> > this with netsh.
> > 
> > Is there an easy way to install the tuntap driver and set up the
> > interface address with openvpn?
> > 
> > Or is there another way to reliably get a local connection configured?
> > (XP and Win2k).
> > 
> > Is it also possible to automatically configure bridging?
> 
> See the tun.c code in OpenVPN, look for the #ifdef WIN32 code  -- it will 
> show you how OpenVPN sets up the TUN/TAP interface network settings using 
> DeviceIoControl calls to the driver.
> 
Thank you. Maybe the coLinux conet-daemon can be modified to set the
appropriate options automatically.

But I thought more about a solution I could use in a installer, without
modifying the conet sources.

While I can easily set the network address of the TAP device with "netsh
interface ip set address "LAN-Verbindun 9" static 10.12.12.1
255.255.255.0" for example, I have still the problem to map the network
connection name to the TAP driver. 

I can combine the Information I get from: 
HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}"

and 

HKLM\SYSTEM\CurrentControlSet\Control\Network\{4D36E972-E325-11CE-BFC1-08002BE10318}"

to find out the connection name, but I thing this is a little bit
complicate and crazy. Is there a simpler way? 

Also I think the best way would be to give the connection a custom name,
like coLinux-TAP01 for example. Is this possible at installation time?
Could this be set somewhere in the OemWin2k.inf file?

Also since I normally do not use Windows (I'm Windows abstinent since
'94), is there a way tho make the connection static and provide a single
IP address to the Linux guest via dhcp. (Tell Windows somehow to set a
static IP address like 10.12.12.1 for the TAP connection and give the
Linux guest 10.12.12.2 via dhcp ?)

Is there some good free lecture on this topic available?

Also is there a simple way to add something like a "local" DNS  entry,
so that I not have to use the IP address all the time to connect to the
Linux guest?


Juergen
   
> James
> 


