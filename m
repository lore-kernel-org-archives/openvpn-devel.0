Message-ID: <440E24BE.3040904@...564...>
From: Kosta Welke <kosta@...564...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] float is broken when source port changes
References: <440D05E9.7030203@...564...> <1e6368e80603070813y6d2d144ex3cef3a8a26a02d9@...278...> <440DBD44.5060302@...564...> <440DD137.3060604@...41...>
In-Reply-To: <440DD137.3060604@...41...>
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
Date: Tue Mar  7 16:26:02 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>, openvpn-devel@lists.sourceforge.net

James Yonan wrote:

> No, --float only applies to the IP address, not the port.  

Sadly, yes.

> You can't 
> really float on the port efficiently because a UDP socket needs to bind 
> to some port number (either static or dynamic).  To do port floating, 
> you would need to bind to every possible port that a packet might come 
> in on -- fairly impractical.

No. Using the same logic the openvpn server would need to listen on all 
4,294,967,296 IP addresses.
It is the *client* port that changes, which can be detect just as easily 
as a change in the client IP address. The only problem is that it is not 
checked.
Please re-visit my original post to see under what circumstances the IP 
address can stay the same while the client port number changes *from the 
servers point of view*.

I think I found the potions of the code that would need modification:

- In mroute.h, struct mroute_addr would need an unsigned short port to 
store the port number. Also, mroute_addr_equal() would need to return 
false if the port numbers dont match

- In mroute.c, mroute_extract_addr_from_packet() would need to get the 
port number from the packet. This is the part where I'm not too sure. Is 
it safe to assume that the UDP header starts just after the IP header? 
To be honest, I never understood the concept of IP header options... :)

HTH,
Kosta

