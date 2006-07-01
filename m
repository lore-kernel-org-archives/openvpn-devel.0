Message-ID: <44A6B3EF.2060305@...684...>
Date: Sat, 01 Jul 2006 19:42:07 +0200
From: Christian Holler <decoder@...684...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Bugreport: get_default_gateway function fails under
	specific circumstances
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

today I discovered a bug that is not easy to trigger but causes the
"get_default_gateway" function to fail in some cases. This function
is, as you surely know, used for example when "net_gateway" is pushed
by the server as an option to the route command and should return the
default gateway so a route can be set via that default gateway.

(Version: 2.0.7)

Both in the linux and windows code, you assume that this gateway is
non-zero (see lines 1055 and 1295 in route.c). This is normally the
case, but has not necessarily to be always like that. For example,
when you want to use openvpn in an environment, where already other
programs use tun devices to reroute the traffic, then default routes
may appear which look like this:

(route -n output on linux)

Destination     Gateway         Genmask         Flags Metric Ref   
Use Iface
0.0.0.0         0.0.0.0         0.0.0.0         U     0      0       
0 tun0


This is fully valid with tun devices, but because the gateway is
0.0.0.0, the get_default_gateway function fails to find this correct
route and fails.


Solution: Do not rely on gateway to be nonzero, and honor Iface when
setting the default route. This can be fixed easily with small
modifications to the windows and linux version of this function and
how it is used. (Make get_default_gateway return a whole route
structure in side effect instead of only the gateway address. This
route structure should also include the Iface then).


I discovered this bug while I was trying to use openvpn with a server
that uses net_gateway in push instruction from within an environment
that uses vpnc (another VPN client) to connect to a VPN which is
required to get online at all. This other VPN client already reroutes
all traffic through a tun device as described above, and this is fully
valid, but openvpn fails then to find this route, so
get_default_gateway fails.

If this is being fixed, the function should probably be renamed to
"get_default_route", because it does not need to be a gateway
necessarily. Default routes don't need to have any gateway as shown in
the above example.


It would be very helpful for me if this would be fixed as this is what
causes openvpn not work in our environment, and if you wish, then I
can write a patch for it as well.


Thank you very much


Christian Holler
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEprPnJQIKXnJyDxURAohgAJ9RcN4MrhLwRUmJKy/hWtAkLDu5pgCeLHIm
NdEtf0tg342/VhD1z26H7cc=
=lsBP
-----END PGP SIGNATURE-----


