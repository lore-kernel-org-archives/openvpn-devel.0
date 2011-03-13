Date: Sat, 12 Mar 2011 21:33:45 -0300
From: Federico Heinz <fheinz@...277...>
Message-ID: <20110312213345.694340df@...1451...>
In-Reply-To: <20110312232602.10422.qmail@...1287...>
References: <20110308185252.301d0a1d@...1451...>
	<20110309084745.GN9835@...1296...>
	<20110309085656.18e0e796@...1451...> <20110311122309.1292c1dd@...1451...>
	<4D7A7455.4070805@...1114...>
	<20110312003517.3a86c508@...1451...>
	<20110312153620.8987.qmail@...1287...>
	<20110312184423.3fee2f17@...1451...>
	<20110312215420.31033.qmail@...1287...>
	<20110312195923.55eaa915@...1451...>
	<20110312232602.10422.qmail@...1287...>
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

On 13/03/2011, Peter Stuge wrote:
> Federico Heinz wrote:
> > Because I don't know it at configuration time.
> You said that you already have a solution in place for dealing with
> interface reconfiguration.

I said I have a solution in place to restart OpenVPN when the
configuration changes. The solution is part of my distro of choice
(Debian), and works pretty well for that purspose.
 
> Simply use the same mechanism for initial configuration.

That's an odd way of unsing the word "simply".

Sure, I could change a few system scripts, and include something like
Alon suggested (/sbin/ip addr show dev ppp0 | grep inet | sed
's#.*inet \(.*\)/.*#\1#'), to figure out the IP address, change the
configuration files and only then restart OpenVPN.

What I fail to see is how that is "simpler" or easier to understand
or maintain than writing "local if:ppp0" in the daemon's config file.

> Until OpenVPN has multilisten there's no point in OpenVPN trying to
> do this, because it will only do a poor job.

This is simply not true. It will do a good job in most cases, and a
well-specified, if incomplete, job in the rather unlikely case that
someone deliberately attempts to use this feature together with
multiple IP addresses on a single interface, and even then it will
emit a warning.

You are arguing that because it cannot do the job perfectly in an
unlikely edge case, it shouldn't even attempt to solve a
different, well-defined use case.

I'm sorry, that doesn't make sense to me.

> > or a domain name.
> The domain name is irrelevant. Go closer to the authoritative
> source, not further away.

Agreed. I'm going as close to it as I can: the interface itself, from
the viewpoint of the program that is using it.

> > which in some cases involves messing around with the way
> > your distro usually does things,
> Why would it?

It means modifying the distro's startup scripts for OpenVPN, to get
them to figure out the IP address of the interface for *some*
instances of the server but not necessarily for all.

Sure, modifying those scripts isn't taboo, but it's not as usual and
clean as it is to modify the subsystem's own configuration files (in
Debian, /etc/openvpn/*.conf and /etc/default/openvpn), because they
simply assume the program will be able to gather all the info it
needs to run from those configuration files.

The change I'm proposing simply aims at meeting that assumption.

	Fede

