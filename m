Date: Sat, 03 May 2008 16:19:56 -0600
MIME-Version: 1.0
Message-ID: <1209853267.11766.TMDA@...1092...>
From: Stephen Warren <s-t-openvpn@...1091...>
Subject: [Openvpn-devel] /etc/resolv.conf caching fix,
	for long-running clients that move	between networks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I run OpenVPN on my laptop, and move between different physical
locations/networks without rebooting my laptop or restarting OpenVPN.
All I do is hibernate/unhibernate.

After unhibernate, OpenVPN correctly detects that its "connection" has
dropped, and attempts to re-initiate the connection. My config file uses
a DNS name for the "remote" option (since the server uses DHCP for its
IP, and the hostname is a dyndns hostname).

However, the DNS lookup never works if I've moved network locations,
since glibc caches the content of /etc/resolv.conf forever, and hence
OpenVPN (via glibc) continues to attempt to query the DNS servers from
the old physical location/network, which refuse to answer clients at the
new location/network, and connectivity may not even be available to such
an IP.

I believe the fix for this is for OpenVPN to call the "res_init()"
function whenever it attempts to restart a broken connection (or at
least periodically when doing this) or when DNS lookups fail. This
should flush the /etc/resolv.conf cache, pick up the new entries that
are relevant to the laptops' new location/network, and everything will
be happy.

For more (brief) details, see the following bug report:

http://sourceware.org/bugzilla/show_bug.cgi?id=3675

