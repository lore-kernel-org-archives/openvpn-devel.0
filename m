From: "James Yonan" <jim@...41...>
Message-ID: <twig.1062580090.46409@...41...>
Subject: [Openvpn-devel] New feature: --ifconfig for tap devices
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
Date: Wed Sep  3 02:09:18 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

One of the nice things about the --ifconfig option is that it lets you set TUN
adapter endpoint addresses (i.e. the virtual IP addresses for each end of the
tunnel) in a platform independent manner -- OpenVPN then translates the
--ifconfig option to the appropriate ifconfig command for your platform.

Up until now, the --ifconfig option has only worked for TUN adapters, but with
the increasing use of TAP adapters for ethernet bridging, and the fact that
the new Windows port only supports a TAP adapter, I've decided to extend
--ifconfig so that it works for TAP devices as well (this feature will be
included in 1.5-beta8).

--ifconfig is really a convenience function -- you can call ifconfig yourself
in an --up script, but letting OpenVPN run the ifconfig command for you makes
the configuration simpler and more portable.

The new --ifconfig will still work as always with --dev tun.  However if --dev
tap is specified, then the --ifconfig option will be interpreted as --ifconfig
ip-addr netmask.

What I need right now in order to make the TAP version of --ifconfig work
correctly, is the correct ifconfig command syntax for setting the IP address
and netmask of a TAP device, on all the OSes which OpenVPN supports.  I've
already coded templates for Linux and Windows, but I still need to know the
appropriate ifconfig syntax for FreeBSD, OpenBSD, NetBSD, Solaris, and Mac OS
X, with respect to setting the IP/netmask on a TAP device.

So if you are using one of these OSes with OpenVPN + TAP adapter, please let
us know what kind of ifconfig syntax you use in your --up script to set the
adapter parameters.

James




