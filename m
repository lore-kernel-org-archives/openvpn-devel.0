From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] help on win32 tap interface
In-Reply-To: <ID1003$8ED5A4D33DAACC74B0E5AE6E1A15DABA@...354...>
Message-ID: <Pine.LNX.4.58.0503080334281.1122@...41...>
References: <ID1003$8ED5A4D33DAACC74B0E5AE6E1A15DABA@...354...>
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
Date: Tue Mar  8 02:40:30 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: "andi.c@...354..." <andi.c@...354...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>


On Tue, 8 Mar 2005, andi.c@...354... wrote:

> Hi to all,
> i can't understand why my code (based on openvpn's tun.c file) to
> correctly read and write on win32 tap device doesn't work,
> All i do is:
> 
> 1 -- call get_tap_reg and get_panel_reg functions
> 
> 2 -- call get_unspecified_device_guid function to obtain TAP id
> 
> 3 -- call CreateFile on the device_path returned. It returns OK
> 
> 4 -- call TAP_IOCTL_GET_VERSION, TAP_IOCTL_GET_MTU,
> IoControls , to obtain TAP device driver and mtu info. All seems
> ok.
> 
> 5 -- call TAP_IOCTL_SET_MEDIA_STATUS IoControl to set the device
> as "connected". ok
> 
> 6 -- Then i call simple ReadFile to read data submitted on the
> TAP interface. The problem is that some kind of packet
> arrives, but they seems to be corrupted (es. an IPv6 header
> format is totally wrong).

Does IPv4 work?

Are you correctly extracting the IPv6 packet from the ethernet frame?

Have you tried running OpenVPN in a debugger, and break on the TAP-Win32 
calls, to get an idea of how OpenVPN is interacting with the driver?

James

