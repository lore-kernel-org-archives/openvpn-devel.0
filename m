Message-ID: <40A6DDED.60905@...219...>
From: Dzuy Nguyen <dzuy@...219...>
Reply-To: dzuy@...219...
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Openvpn clustering
References: <2A4D228810E123409F4E80AAD2C3D034339140@...218...>
In-Reply-To: <2A4D228810E123409F4E80AAD2C3D034339140@...218...>
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
Date: Sat May 15 20:27:40 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

It can be done.  You'll need a load balancer with persistence.

Chris Timmons wrote:
> I am curious to see if there is any way you can distribute openvpn to a 
> cluster of firewalls?  I am thinking specifically of two or more Soekris 
> 4801+vpn1411 cards, all clustered with Openbsd 3.5+carp+pfsync.
> 
> I have tried it, but I could not get it to work. The vpn connection 
> would continually reset after a minute or so as it would jump from one 
> box to the other and back. I can point clients at specific machines or 
> ports, but that loses all scalability.
> 
> Ideas? Thoughts? Too ambitious? Cluebat?
> 
> Thanks,
> 
> Chris.
> 


