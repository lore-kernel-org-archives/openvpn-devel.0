Message-ID: <4823DEDB.9030700@...41...>
Date: Thu, 08 May 2008 23:19:23 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <1209853267.11766.TMDA@...1092...>
In-Reply-To: <1209853267.11766.TMDA@...1092...>
Subject: Re: [Openvpn-devel] /etc/resolv.conf caching fix,
 for long-running clients that move	between networks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Stephen Warren <s-t-openvpn@...1091...>
Cc: openvpn-devel@lists.sourceforge.net

Stephen Warren wrote:
> I run OpenVPN on my laptop, and move between different physical
> locations/networks without rebooting my laptop or restarting OpenVPN.
> All I do is hibernate/unhibernate.
>
> After unhibernate, OpenVPN correctly detects that its "connection" has
> dropped, and attempts to re-initiate the connection. My config file uses
> a DNS name for the "remote" option (since the server uses DHCP for its
> IP, and the hostname is a dyndns hostname).
>
> However, the DNS lookup never works if I've moved network locations,
> since glibc caches the content of /etc/resolv.conf forever, and hence
> OpenVPN (via glibc) continues to attempt to query the DNS servers from
> the old physical location/network, which refuse to answer clients at the
> new location/network, and connectivity may not even be available to such
> an IP.
>
> I believe the fix for this is for OpenVPN to call the "res_init()"
> function whenever it attempts to restart a broken connection (or at
> least periodically when doing this) or when DNS lookups fail. This
> should flush the /etc/resolv.conf cache, pick up the new entries that
> are relevant to the laptops' new location/network, and everything will
> be happy.
>
> For more (brief) details, see the following bug report:
>
> http://sourceware.org/bugzilla/show_bug.cgi?id=3675
>
>   


I've merged a patch to deal with this into the subversion directory for 
the 2.1 series:

http://svn.openvpn.net/projects/openvpn/branches/BETA21/openvpn/

It will be included in 2.1-rc8.

------------------------------------------------------------------------
r2928 | james | 2008-05-08 22:21:53 -0600 (Thu, 08 May 2008) | 4 lines
Changed paths:
   M /branches/BETA21/openvpn/configure.ac
   M /branches/BETA21/openvpn/socket.c
   M /branches/BETA21/openvpn/syshead.h

On systems that support res_init, always call it
before calling gethostbyname to ensure that
resolver configuration state is current.

------------------------------------------------------------------------

James


