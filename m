Subject: Re: [Openvpn-devel] comments on beta12
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1066138374.45509@...41...>
In-Reply-To: <3F8BD572.7080207@...61...>
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
Date: Tue Oct 14 06:34:03 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: julien Touche <julien.touche@...61...>, openvpn-devel@lists.sourceforge.net

julien Touche <julien.touche@...61...> said:

> test between debian linux  2.4.21 <-> openbsd 3.4, beta12 on the 2 sides
> works well
> 
> one comment for openbsd, "dev tun" doesn't work:
> 
> Tue Oct 14 12:14:14 2003 6: /sbin/ifconfig tun delete
> ifconfig: SIOCGIFFLAGS: Device not configured
> Tue Oct 14 12:14:14 2003 7: NOTE: Tried to delete pre-existing tun/tap 
> instance -- No Problem if failure
> Tue Oct 14 12:14:14 2003 8: /sbin/ifconfig tun 10.0.3.3 10.0.3.4 mtu 
> 1255 netmask 255.255.255.255 up
> ifconfig: SIOCGIFFLAGS: Device not configured
> => must precise tunX

Right, but I don't think this behavior has changed since 1.4.x?  You need to
give an explicit unit number (i.e. --dev tun0) because OpenBSD wants the
ifconfig to happen _before_ the tun open, therefore the tun open cannot be
used (as other OSes allow) as a mechanism for cycling through tunX and finding
the first free X.

Take a look at the ifconfig_order function in tun.h.  It tells OpenVPN whether
the ifconfig should come before or after the tun open.

Windows is the only other OS besides OpenBSD which likes the ifconfig before
the tun open.  And if you want --dev tun (without unit number) to work on
OpenBSD, you need to define a special case for OpenBSD in guess_tuntap_dev().

> test openbsd 3.4 <-> win2k, with dev tun (always beta12)
> works well too

> one mistery: on openbsd side, i can't ping itself in the vpn, all other 
> ping work.

Not sure about that -- it would be handled by the tun driver on OpenBSD.
OpenVPN never sees the packet when the local endpoint is pinged.

James


