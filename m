From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] New feature: --ifconfig for tap devices
Message-ID: <20030903104904.GD27875@...33...>
References: <twig.1062580090.46409@...41...>
Mime-Version: 1.0
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
Date: Thu Sep  4 00:26:06 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wed, 03 Sep 2003, James Yonan wrote:

> One of the nice things about the --ifconfig option is that it lets you set TUN
> adapter endpoint addresses (i.e. the virtual IP addresses for each end of the
> tunnel) in a platform independent manner -- OpenVPN then translates the
> --ifconfig option to the appropriate ifconfig command for your platform.

> What I need right now in order to make the TAP version of --ifconfig work
> correctly, is the correct ifconfig command syntax for setting the IP address
> and netmask of a TAP device, on all the OSes which OpenVPN supports.  I've
> already coded templates for Linux and Windows, but I still need to know the
> appropriate ifconfig syntax for FreeBSD, OpenBSD, NetBSD, Solaris, and Mac OS
> X, with respect to setting the IP/netmask on a TAP device.

## FreeBSD 4.9-PRERELEASE:

ifconfig tap0 inet 10.11.12.42 netmask 255.0.0.0 up

(inet appears to be optional, so the Linux syntax, "ifconfig tap0
10.11.12.42 netmask 255.0.0.0 up", should also work. Untested on FreeBSD
5.x.)

## Solaris:

Does Solaris support "tap"-style ethernet frame tunneling devices at
all? How? Anyone got that to work?

The tun-1.1 driver only installs a "tun" driver and doesn't claim
ethernet bridging on Solaris.

./openvpn --secret /home/ma/openvpn-tap-discardme.key --dev tap0 \
[remote info]

4: Can't open /dev/tap: No such file or directory (errno=2)

Trying  --dev-node /dev/tun and --dev-type tap results in:

4: Can't set multiplexor id: No such device or address (errno=6)

Did I miss anything?

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95

