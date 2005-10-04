Message-ID: <4342703F.90607@...361...>
From: Rolf Fokkens <r.fokkens@...361...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Patch: TAP usage made non ARP dependent
References: <43404D99.8080309@...361...>  <434189C7.5090304@...361...> <1128369731.6952.59.camel@...399...>
In-Reply-To: <1128369731.6952.59.camel@...399...>
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
Date: Tue Oct  4 05:08:36 2005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Marcelo Toledo <marcelo@...461...>
Cc: openvpn-devel@lists.sourceforge.net

Marcelo Toledo wrote:

>great to read it! We're going to test your patch. Thanks a lot.
>  
>
Wonderful, beware however there's another issue te be resolved: MAC 
aging. Switches require their mac-table te be refreshed regularly, 
otherwise the MAC entries are aged out (on cisco in 300 sec). OpenVPN 
doesn't seem to do aging like that, so a MAC entry learnt won't be 
forgotten.

This is problematic if another client (because of a failover) will be 
routing the traffic. In this case traffic will be sent to the wrong 
client until an ARP request + reply corrects the MAC entry on the server.

So another thing that should be implemented probably is aging.

