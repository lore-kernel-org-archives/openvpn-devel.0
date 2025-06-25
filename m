Message-ID: <163dd35d-fee8-4e7f-a6b3-c34bd2c18cb3@...1227...>
Date: Thu, 26 Jun 2025 00:43:41 +0200
MIME-Version: 1.0
References: <1e8ccfd451cbf9e6d090bd6a6886e366.squirrel@...2890...>
 <20250507074438.1326755-1-walter.openvpn@...2889...>
 <eedcf175305a088df0eb7ec146dbe441.squirrel@...2890...>
 <f60dbf91-c2f8-495b-ba14-967e70629d1b@...1227...>
 <ef2598a79cf3efe9d343b514ab6c9e5c.squirrel@...2890...>
 <8ba925a1-85c9-4274-a512-32dcec35b147@...1227...>
 <2bb3487e-6762-40ea-b6ad-2622a879ca21@...2889...>
 <d885df5e-c817-47e8-8d5d-586eb227ead5@...1227...>
 <866e86f674f55d0d39cce796f3f7ed9b.squirrel@...2890...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <866e86f674f55d0d39cce796f3f7ed9b.squirrel@...2890...>
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Walter Doekes <walter.openvpn@...2889...>
Cc: openvpn-devel@lists.sourceforge.net

Am 25.06.25 um 15:30 schrieb Walter Doekes:
> Good. I backported the patch so it ran against the culprit version
> (b3647114).
> 
> I got these mesages:
> 
> 
>    SENT CONTROL [mycommonname]: 'PUSH_REPLY,route ... 255.255.255.255
> net_gateway,route-gateway 10.x.x.1,topology subnet,ping 15,ping-restart
> 55,route 10.x.x.0 255.255.0.0 vpn_gateway,ifconfig 10.x.x.3
> 255.255.255.0,peer-id 4,cipher AES-256-GCM' (status=1)
> 
>    Packet with invalid or missing SID from [AF_INET]HOME_IP:33567
> 
>    Float requested for peer 4 to HOME_IP:33567
> 
>    peer 4 (mycommonname) floated from VPN_IP:33567 to [AF_INET]HOME_IP:33567
> 
> 
> 
> The "Packet with invalid or missing SID" is new to me. But other than
> that, it works.

Thanks for testing and confirming that it works.

> I also tried it against 2.6-latest (0169b4ad). Also works. There the
> message is:
> 
>    Packet (P_ACK_V1) with invalid or missing SID from [AF_INET]HOME_IP:46088
> 
> I can't tell if this new message is problematic or not. It doesn't
> negatively impact my connection setup. And I (now) know when to expect it.
> 
> 
> 
> As for your patch: there's a minor typo in your patch at ssl_pkt.h in the
> signature:
> 
> "bool check_session_id_hmac" should be "bool pkt_is_ack"

Thanks will fix in the  next revision.

> Further, I would prefer if the commit message itself mentioned something
> about "floating IPs and 60 second timeout after connect" instead of "rare
> circumstances" which are not rare in 100% of my use cases. That might be
> beneficial to the next person who runs into this.


You need a connection that

- starts on IP A
- successfully floats to IP B by data packet
- then has a control packet from IP A before any data packet can trigger 
the float back to IP A

In this scenario we would trigger a new connection coming before while 
know we detect that this should not trigger a new connection as it is 
not a new connection attempt. So instead of creating a new connection, 
you see (at verb 4 or higher) the message

    Packet (P_ACK_V1) with invalid or missing SID

instead with the patch.

I will update the commit message when the patch is no longer in draft 
mode. I wanted to confirm that this is actually the problem/scenario we 
are fixing before finishing the patch.

Arne



