Date: Sat, 12 Mar 2011 19:59:23 -0300
From: Federico Heinz <fheinz@...277...>
Message-ID: <20110312195923.55eaa915@...1451...>
In-Reply-To: <20110312215420.31033.qmail@...1287...>
References: <20110308185252.301d0a1d@...1451...>
	<20110309084745.GN9835@...1296...>
	<20110309085656.18e0e796@...1451...> <20110311122309.1292c1dd@...1451...>
	<4D7A7455.4070805@...1114...>
	<20110312003517.3a86c508@...1451...>
	<20110312153620.8987.qmail@...1287...>
	<20110312184423.3fee2f17@...1451...>
	<20110312215420.31033.qmail@...1287...>
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
To: Peter Stuge <peter@...1287...>
Cc: openvpn-devel@lists.sourceforge.net

On 12/03/2011, Peter Stuge wrote:
> Federico Heinz wrote:
> > What I'm trying to solve here is a much simpler (and, in my case,
> > frequent) use case: I'm starting several instances of OpenVPN,
> > and I need each of them to listen on specific interfaces, but
> > their dyndns addresses may not be up-to date yet, so I can
> > specify neither an IP nor a domain name in the "local" directive.
> Why can't you specify the IP address?

Because I don't know it at configuration time.

The "local" directive will currently accept either a fixed IP address
(which I don't know, because it will be assigned in the future, and
may change every time that particular interface is brought up) or a
domain name.

Using the domain name together with a dyndns service works sometimes,
but fails when the interface has just been brought up, and the dyndns
update hasn't yet propagated through the DNS system.

Alon mentioned earlier that this could be dealt with at run-time by
modifying the startup scripts to determine the IP address and specify
it through the command-line, but it's an unnecessarily complex
solution, which in some cases involves messing around with the way
your distro usually does things, something I prefer to avoid.

	Fede

