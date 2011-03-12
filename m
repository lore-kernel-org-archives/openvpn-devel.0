Date: Sat, 12 Mar 2011 18:44:23 -0300
From: Federico Heinz <fheinz@...277...>
Message-ID: <20110312184423.3fee2f17@...1451...>
In-Reply-To: <20110312153620.8987.qmail@...1287...>
References: <20110308185252.301d0a1d@...1451...>
	<20110309084745.GN9835@...1296...>
	<20110309085656.18e0e796@...1451...> <20110311122309.1292c1dd@...1451...>
	<4D7A7455.4070805@...1114...>
	<20110312003517.3a86c508@...1451...>
	<20110312153620.8987.qmail@...1287...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Bind only to specified interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 12/03/2011, Peter Stuge wrote:
> There are components in your system which *will* know when your
> address is reconfigured. Please just configure them to reconfigure
> OpenVPN. This would seem to be a good use for the management
> interface in OpenVPN.

I'm not worried abut the IP number *changing*, that's a completely
different issue, and I already have stuff in place that will restart
OpenVPN when the interface in question changes configuration.

What I'm trying to solve here is a much simpler (and, in my case,
frequent) use case: I'm starting several instances of OpenVPN, and I
need each of them to listen on specific interfaces, but their dyndns
addresses may not be up-to date yet, so I can specify neither an IP
nor a domain name in the "local" directive.

> It makes no sense trying to work around the requirement of knowing
> your configuration.

I know my configuration I just don't know it at configuration
time. Someone pointed out earlier that the same effect I'm aiming at
can be achieved with a rather involved command-line hack. I'm just
trying to make it more comfortable.

> [...] unless you are prepared to listen on 0.0.0.0, which I would
> guess already works without special OpenVPN options or code.

Only... it doesn't work in all setups. As described in shorewall's
multi-ISP guide[1] (search for "OpenVPN" in that page), sometimes you
need to bind the daemon to a specific interface.

That guide talks about binding to the interface in order to force
traffic through a certain ISP (something I hope you will agree can be
useful under a number of circumstances), but I have found that having
OpenVPN listen on 0.0.0.0 in such a setup does not work properly:
connections are unstable and drop for no apparent reason, and
establishing the tunnel fails intermittently. 

	Fede

[1] http://www.shorewall.net/MultiISP.html

