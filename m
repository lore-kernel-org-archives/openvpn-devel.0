Message-ID: <3F5B206F.5070402@...61...>
From: julien Touche <julien.touche@...61...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] New feature: --ifconfig for tap devices
References: <twig.1062580090.46409@...41...>
In-Reply-To: <twig.1062580090.46409@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Sep  7 05:11:02 2003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net


James Yonan wrote:

> What I need right now in order to make the TAP version of --ifconfig work
> correctly, is the correct ifconfig command syntax for setting the IP address
> and netmask of a TAP device, on all the OSes which OpenVPN supports.  I've
> already coded templates for Linux and Windows, but I still need to know the
> appropriate ifconfig syntax for FreeBSD, OpenBSD, NetBSD, Solaris, and Mac OS
> X, with respect to setting the IP/netmask on a TAP device.
> 
> So if you are using one of these OSes with OpenVPN + TAP adapter, please let
> us know what kind of ifconfig syntax you use in your --up script to set the
> adapter parameters.

not sure if tap is available on openbsd (have post it previously to james)

some googling drives me to this thread
http://www.monkey.org/openbsd/archive/tech/0111/msg00098.html
and
find /sys -iname '*tap*' returns nothing

so i'm not sure openbsd stock-kernel has tap ...
if someone has more information (i will ask about it on misc@)


Regards

		Julien



