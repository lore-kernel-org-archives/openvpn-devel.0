From: Juan Rodriguez Hervella <jrh@...176...>
Subject: Re: [Openvpn-devel] Question regarding ....mmm...TAP and a ping that doesn't work
References: <200403180948.33165.jrh@...176...>
In-Reply-To: <200403180948.33165.jrh@...176...>
MIME-Version: 1.0
Message-Id: <200403251734.27272.jrh@...176...>
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
Date: Thu Mar 25 08:35:19 2004
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net
Cc: openvpn-users@lists.sourceforge.net

I dont know if the topology that I've described is clear enough,
what I've really got is this:

Server:
======
external interface: X.X.X.X
internal interface: 163.117.140.177
virtual TAP interface: 163.117.140.80

Client:
=====
virtual TAP interface: 163.117.140.55

I can ping to 163.117.140.80, but I can _not_
ping to 163.117.140.177

I guess it is a specific FreeBSD problem related to the
bridge implementation. AFAIK, something that is received
on the server is written to the TAP socket, which makes
the TAP interface act as if it had received an ethernet
frame. If the TAP and innner interface are bridged, FreeBSD
will forward the ethernet frame out of the innner interface.
The thing that it's happening here is that the ethernet frame
should also be read by the inner interface, not only be forwarded
outside.

Do you agree with this ? Is out there somebody else using
FreeBSD who can either test or find out whether what I'm saying is 
true ? (^-^)

Thanks!


On Thursday 18 March 2004 09:48, Juan Rodriguez Hervella wrote:
> Hellooo...,
>
> I'm testing openVPN using 2 FreeBSD machines, I use
> TAP interfaces to relay ethernet frames from the LAN where
> the openVPN server sits down to my client at home.
>
> The server has 2 interfaces, the outer which I use in --remote,
> and the inner which is the LAN I want to access at home.
>
> The problem that I'm experiencing is that I'm not able to ping
> the inner interface of the server from home.
>
> Is this something I should expect ? I mean,
> Linux has the same problem ?
>
> I'm wondering how this kind of encapsulation works, I think
> (please correct me if I'm wrong) it should be like this:
>
> 1. The client's routing table decides that a packet must be sent
> through its TAP interface.
> 2. The TAP interface is read by openVPN (read() from TAP?),
> which encapsulates the ethernet frame in TCP/UDP
> and sends it to the server.
> 3. The server desencapsulates the packet, and then inserts
> the ethernet frame in the corresponding TAP device
> (write() to TAP?)
>
> Supposing the TAP and real-ethernet interface are bridged
> on the server, what can be the reason I can not ping the
> real-interface leg ?
>
> I think that it might be caused because the ARP request is sent off
> through the inner interface and the server doesn't realize
> that he's got the answer, or in other words, the server doesn't listen
> to its own ethernet broadcast packets ???
> Does all this make sense ? Im quite lost :)
>
> --
> Sex without love is an empty experience, but, as empty experiences go,
> it's one of the best.
> 		-- Woody Allen
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-- 
******
JFRH
******

All syllogisms have three parts, therefore this is not a syllogism.

