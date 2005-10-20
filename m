From: Mathias Sundman <mathias@...454...>
Subject: Re: [Openvpn-devel] Bug report (long) - OpenVPN dropping small frames
In-Reply-To: <dj6pnr$gs4$1@...165...>
Message-ID: <Pine.LNX.4.61.0510200952100.9328@...210...>
References: <dj6pnr$gs4$1@...165...>
MIME-Version: 1.0
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
Date: Thu Oct 20 01:20:56 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: Mike Ireton <mike-openvpn@...479...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 19 Oct 2005, Mike Ireton wrote:

> Suspeciously, I also have been observing an excessive number of ICMP "Frag 
> reassembly time exceeded" messages coming from this openvpn client directed 
> at the server. Putting 2 and 2 together, these excess icmp messages appear to 
> be being generated because the client is not receiving all fragments. And I 
> think it's the encrypted payload that's not being received properly.
>
> I have a good test case right now. If I ping with 1393 bytes or more of
> data, it doesn't work reliably. Whereas if I ping with 1392 bytes, it does 
> work reliably and without loss. Here is an example:

At first glance that seems like a classic MTU/packet fragmentation issue.

I've seen many odd problems due to packet fragmentation. Packet 
fragementation should in teory work just as reliable as with no 
fragmentation, just a little performance lose, but in reality there are 
many problems associated with this. For example I've seen routers routing 
frags perfect for a couple of seconds and then all of suddence only 
forward the first frag of each packet. Very hard to debug as all packets 
not large enough to be fragmented, like smaller pings still pass 
perfectly.

So, the bottom line is to always try avoiding packet fragmentation, or if 
you have the time, get to the bottom with why frags are not getting though 
properly.

--mssfix helps keeping frags away for tcp sessions, but that won't help 
you with pppoe or pings. First use tcpdump to watch the network for the 
openvpn traffic and see if you have any frags occationally while sending 
large pings.

Then try using the --fragment option with a rather low value which will 
cause OpenVPN todo internal fragrentation to avoid IP fragmentation and 
see if the frags goes away, and hopefully the problem as well!

If that solves your problem, it would still be nice to understand if the 
cause were due to a broken router, or if there really is a bug 
somewhere...

Cheers - Mathias

