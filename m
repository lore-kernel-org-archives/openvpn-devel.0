Message-ID: <4B7E8326.9050908@...1032...>
Date: Fri, 19 Feb 2010 14:25:10 +0200
From: =?ISO-8859-1?Q?Siim_P=F5der?= <siim@...1032...>
MIME-Version: 1.0
References: <1266518131.7800.7@...1207...>
In-Reply-To: <1266518131.7800.7@...1207...>
Subject: Re: [Openvpn-devel] [PATCH] FQDN for routes should expand to all IPs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi

Karl O. Pinc wrote:
> So, unless you're pulling names out of /etc/hosts it's likely
> that randomization does nothing.  And if the bind administrator
> has gone to the extra work to enable a fixed ordering of
> RR records then randomization destroys his work.

That's entirely dependent on the DNS server. Some DNS servers do not
randomize the order (so I've heard).

Moreover, if you consider that openvpn is mostly used to connect to
central resources from a random location, you can not assume anything
about the nameserver(s) you resolve through. Therefore even if you go
through the trouble of enabling fixed ordering on your DNS, it is
likely that the (caching) nameservers that the clients resolve through
randomize the list sometimes and you will get unpredictable results
anyway.

So IMO it would better to pick at random for load balancing (the case
when ISP local nameserver caches and respons with a static list) as
there is no obvious reason for fixed ordering and even if there were,
it would not work anyway (unless used in a environment entirely under
your control).

Siim

