Subject: Re: [Openvpn-devel] Openvpn clustering
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1084739871.8892@...41...>
In-Reply-To: <40A6DDED.60905@...219...>
References: <2A4D228810E123409F4E80AAD2C3D034339140@...218...>, <2A4D228810E123409F4E80AAD2C3D034339140@...218...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun May 16 13:38:02 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dzuy@...219..., openvpn-devel@lists.sourceforge.net

Beta2 has a new feature where you can run the OpenVPN server on multiple
machines, and then give clients a DNS name which maps to multiple IP
addresses.  The client will choose one of the IPs randomly.  If there's a
ping-restart event, the client will restart and use a different IP from the
list.  Using ping/ping-restart one can then establish a kind of failover sequence.

This can be done in two ways: (1) via DNS, i.e. giving multiple addresses to a
single DNS name or (2) using multiple "remote" options in the client config
file, and possibly using the "remote-random" flag.

James

Dzuy Nguyen <dzuy@...219...> said:

> It can be done.  You'll need a load balancer with persistence.
> 
> Chris Timmons wrote:
> > I am curious to see if there is any way you can distribute openvpn to a 
> > cluster of firewalls?  I am thinking specifically of two or more Soekris 
> > 4801+vpn1411 cards, all clustered with Openbsd 3.5+carp+pfsync.
> > 
> > I have tried it, but I could not get it to work. The vpn connection 
> > would continually reset after a minute or so as it would jump from one 
> > box to the other and back. I can point clients at specific machines or 
> > ports, but that loses all scalability.
> > 
> > Ideas? Thoughts? Too ambitious? Cluebat?
> > 
> > Thanks,
> > 
> > Chris.
> > 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: SourceForge.net Broadband
> Sign-up now for SourceForge Broadband and get the fastest
> 6.0/768 connection for only $19.95/mo for the first 3 months!
> http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 



-- 




