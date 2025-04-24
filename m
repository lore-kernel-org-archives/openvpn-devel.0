Message-ID: <c58984b2-e637-42d7-917c-130d282da34c@...2889...>
Date: Thu, 24 Apr 2025 11:08:12 +0200
MIME-Version: 1.0
References: <20250423175843.104553-1-walter.openvpn@...2889...>
 <55dfca69-67f1-4afa-8b05-a0bfddb94929@...1227...>
Content-Language: en-US, sv-SE, nl
From: Walter Doekes <walter.openvpn@...2889...>
In-Reply-To: <55dfca69-67f1-4afa-8b05-a0bfddb94929@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] multi.c: Allow floating to a new IP
 right after connection setup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 24-04-2025 10:26, Arne Schwabe wrote:
> I still do not really understanding what network setup you have to 
> trigger this kind of bizzare behaviour of having a VPN connection.
> It would really be helpful if you can describe that more. Since the 
> current explainations do not really explain for me why there is already 
> an existing half-established connection.
> 
> The scenario you are fixing seem like:
> 
>   * somehow a connection attempt is done from IP A
>   * a connection is fully established for IP B
>   * connection for IP B tries to move to IP A

If you take into account that 2.5 works just fine with this scenario, I 
don't see why you would call this bizarre.

But I'll break it down some more:

- I have internet, exit IP: 1.1.1.10.

- I have a VPN, CorporateVPN at 2.2.2.1. I use it as my default route. 
CorporateVPN has one exit IP: 2.2.2.10.

- There is a second VPN server, SecondVPN, at 3.3.3.1, which I'd like to 
connect to.


 From the perspective of SecondVPN, CorporateVPN is connecting to it:

- 2.2.2.10 -> 3.3.3.1 - openvpn UDP stuff, all works


But, in fact, this is tunneled traffic. There is also:

- 1.1.1.10 -> 2.2.2.1 - here traffic is doubly encrypted


So, I'd like the traffic to go directly instead, to lose the double 
encryption and the extra latency:

- 1.1.1.10 -> 3.3.3.1


To do that, I tell SecondVPN to push this route:

   push "route 3.3.3.1 255.255.255.255 net_gateway"


This causes my machine to create a direct route, bypassing the CorporateVPN.

- 1.1.1.10 -> 3.3.3.1 - now goes directly without the double tunnel


This seems to me like a legit use of net_gateway.

What happens is that SecondVPN sees traffic that previously came from 
2.2.2.10 now suddenly comes from 1.1.1.10. And this IP change is 
detected by openvpn as a "floating IP".

- In OpenVPN 2.5 this worked like a charm.

- In OpenVPN 2.6 it doesn't, as mentioned in the Github ticket.

I've reliably reproduced this several times, as there are a bunch of 
OpenVPN 2.5's that I've connected to that do not exhibit the problematic 
behaviour, while the OpenVPN 2.6's do (both 2.6.3 bookworm and 2.6.12 
noble).

Is this a sufficiently clear explanation?


> You are also saying that there is a difference in OpenVPN 2.5 vs OPneVPN 
> 2.6. If that is indeed the case, a git bisect would be helpful to point 
> to the commit that is breaking this.

This is a fair request. But bisecting will take me considerably more 
time, so this wasn't my first priority.

I did look into all the changes, and it indeed looked like the "floating 
IP detection" was untouched, while there are some connection setup 
speedup (shortcut?) changes. My suspicion is that the quicker connection 
setup has something to do with the changed behaviour.

In due time, I can get to bisecting. But if the information in this 
ticket and workaround is sufficient for someone else to say "A-HA", then 
that would be my preferred option.


>  > msg(M_INFO, "peer %" PRIu32 " (%s) floating from %s to %s (m2 still 
> setting up) state=%d/%d",
> 
> A user has no idea what m2 is. This message more confusing than helpful.

I'll look into rephrasing when making a new patch.


>> +    /* if the new connection is fresh and the old one is already 
>> connected, this
>> +     * might be a legitimate move to a new IP by the original client;
>> +     * for example when the server IP is pushed as net_gateway to 
>> escape from
>> +     * a double VPN. */
>> +    if (m1->multi_state == CAS_CONNECT_DONE && m2->multi_state == 
>> CAS_NOT_CONNECTED
>> +        && m1->locked_cert_hash_set && !m2->locked_cert_hash_set)
> 
> The code doesn't really do what the comment does. If you were trying to 
> actually figure out if it is the same client you should rather compare 
> the session ID of the tls state.
> 
> Also I think this code looks on the first glance to be broken in the way 
> that an authorized client could just send a bunch of data packets with 
> faked sender ip and then kill of other connections that are in the 
> progress of connection.

Given your experience with openvpn, I betting you're right on these points.

I don't know where the "tls state session ID" is and if it's there. I'm 
dealing with OpenVPN 2.5 clients (no older ones, I hope).

If you can point me in the right direction, I'd be grateful. This is my 
first venture into openvpn code.


Cheers,
Walter Doekes
OSSO B.V.


