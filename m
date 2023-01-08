Date: Sun, 8 Jan 2023 17:11:27 +0100 (CET)
Message-Id: <202301081611.308GBRlw090727@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230105022718.1641751-1-selva.nair@...277...>
References: <20230105022718.1641751-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use IPAPI for setting ipv6
 routes when iservice not available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Stared-at-code ("looks reasonable").  Getting rid of netsh.exe calls is
a good thing.

Actually tested!  MinGW builds, on a Win10 system, running openvpn.exe
from a "cmd.exe run as administrator" window, so no iservice involved -
OpenVPN tells me "IPv6 route added using ipapi", and "route print -6"
looks good.

There is something incorrect in the log, though - I connect via IPv6,
and OpenVPN needs to install a redirect host route due to "gateway and
pushed route overlaps".  It is installed correctly, that is, the /128
route points to the LAN interface and that IPv6 default route (fe80::1),
but the log says

add_route_ipv6(2001:608:8003::200/128 -> fe80::1 metric 1) dev LAN-Verbindung 2
IPv6 route added using ipapi
add_route_ipv6(2001:608:8003::/48 -> 2001:608:8003:f:98::1 metric -1) dev LAN-Verbindung 2
IPv6 route added using ipapi

In "route show -6", the first route ends up on "If 8 ... Intel Pro/100" and
the second route on "If 2 ... TAP-Windows Adapter V9 #2" - which is both 
correct, but only the second is "dev LAN-Verbindung 2".  So it seems to
always print the name of the TAP adapter here - which is misleading at
best.


I have also tested "not run as administrator", and it will correctly
error out with
 
  "ROUTE: route addition failed using ipapi: Zugriff verweigert  [status=5 if_index=2]"

(if it gets there at all :-) - without --ifconfig-noexec, it fails
IPv6 ifconfig/netsh already, and never proceeds to route addition - 
which actually brings up the observation that there's netsh.exe calls
left, "netsh.exe interface ipv6 set address 2 2001:608:..." :-) )


Your patch has been applied to the master and release/2.6 branch.

commit dd66958198f7c4dcf7fca0db82ca72996100b3bd (master)
commit 66a3dc3a007c13e7a8d48ef793e046b09d8e6d30 (release/2.6)
Author: Selva Nair
Date:   Wed Jan 4 21:27:16 2023 -0500

     Use IPAPI for setting ipv6 routes when iservice not available

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20230105022718.1641751-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25886.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


