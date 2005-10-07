Message-ID: <4346ED46.4040204@...361...>
From: Rolf Fokkens <r.fokkens@...361...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Patch: TAP usage made non ARP dependent
References: <43404D99.8080309@...361...>  <434189C7.5090304@...361...>	 <1128369731.6952.59.camel@...399...> <4342703F.90607@...361...>	 <1128428582.7061.18.camel@...399...>	 <4342D092.4050502@...361...>	 <1128619301.7000.58.camel@...399...>	 <4346A01F.4030106@...361...> <1128702738.7000.97.camel@...399...>
In-Reply-To: <1128702738.7000.97.camel@...399...>
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
Date: Fri Oct  7 14:49:35 2005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Marcelo Toledo <marcelo@...461...>
Cc: openvpn-devel@lists.sourceforge.net

Marcelo Toledo wrote:

>In the main server we installed the patch. We have ~400 clients
>connected to it, 3 of them we also installed the patch, here is the
>result.
>
>All these 3 clients couldn't see each other but they could see the
>remaining 397 clients. The 397 couldn't see the 3 clients.
>
>I think that's it, any idea?
>  
>
Oh dear, I'm starting to get a notion what's happening: the broadcast 
that happens when an unknow client is addressed, is handled by the patch 
in multi_process_incoming_tun. The same thing should happen in 
multi_process_incoming_link as well, which is not the case. This may be 
related to your problem.

So I tried to fix that. But here comes the catch: OpenVPN only keeps 
track of MAC addresses on remote clients, not of the ones behind the TAP 
interface. Now suppose some machine behind the TAP interface of the 
server sends an ICMP echo request to a machine behind one of the 
clients, the following happens:
* The ICMP echo request will be unicast to the right client once the MAC 
address is in de MAC table of the server.
* The ICMP echo reply will be unicast back to the server.
* The server looks up the destination MAC address of the destination of 
the ICMP echo reply, but this fails because the mac address is behind 
the TAP interface.
* Because the server can't find the MAC address the ICMP echo reply is 
broadcast to all clients. Ouch! Marcelo, this is no option for you as 
you have 400 clients!!

The problem is caused by the fact that the MAC table only keeps track of 
MAC's behind clients, no MAC's behind the TAP interface are registered. 
This can easily be fixed by registering them as well. I'll get back on 
that as well.

And once I have this working "kinda prototypically" I guess I need James 
help to finish it.

Rolf

