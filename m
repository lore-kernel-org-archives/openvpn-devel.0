Message-ID: <866e86f674f55d0d39cce796f3f7ed9b.squirrel@...2890...>
In-Reply-To: <d885df5e-c817-47e8-8d5d-586eb227ead5@...1227...>
References: <1e8ccfd451cbf9e6d090bd6a6886e366.squirrel@...2890...>
 <20250507074438.1326755-1-walter.openvpn@...2889...>
 <eedcf175305a088df0eb7ec146dbe441.squirrel@...2890...>
 <f60dbf91-c2f8-495b-ba14-967e70629d1b@...1227...>
 <ef2598a79cf3efe9d343b514ab6c9e5c.squirrel@...2890...>
 <8ba925a1-85c9-4274-a512-32dcec35b147@...1227...>
 <2bb3487e-6762-40ea-b6ad-2622a879ca21@...2889...>
 <d885df5e-c817-47e8-8d5d-586eb227ead5@...1227...>
Date: Wed, 25 Jun 2025 13:30:19 -0000
From: "Walter Doekes" <walter.openvpn@...2889...>
MIME-Version: 1.0
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
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Good. I backported the patch so it ran against the culprit version
(b3647114).

I got these mesages:


  SENT CONTROL [mycommonname]: 'PUSH_REPLY,route ... 255.255.255.255
net_gateway,route-gateway 10.x.x.1,topology subnet,ping 15,ping-restart
55,route 10.x.x.0 255.255.0.0 vpn_gateway,ifconfig 10.x.x.3
255.255.255.0,peer-id 4,cipher AES-256-GCM' (status=1)

  Packet with invalid or missing SID from [AF_INET]HOME_IP:33567

  Float requested for peer 4 to HOME_IP:33567

  peer 4 (mycommonname) floated from VPN_IP:33567 to [AF_INET]HOME_IP:33567



The "Packet with invalid or missing SID" is new to me. But other than
that, it works.

I also tried it against 2.6-latest (0169b4ad). Also works. There the
message is:

  Packet (P_ACK_V1) with invalid or missing SID from [AF_INET]HOME_IP:46088

I can't tell if this new message is problematic or not. It doesn't
negatively impact my connection setup. And I (now) know when to expect it.



As for your patch: there's a minor typo in your patch at ssl_pkt.h in the
signature:

"bool check_session_id_hmac" should be "bool pkt_is_ack"


Further, I would prefer if the commit message itself mentioned something
about "floating IPs and 60 second timeout after connect" instead of "rare
circumstances" which are not rare in 100% of my use cases. That might be
beneficial to the next person who runs into this.


Thanks for the fixes!

Walter


> Am 25.05.25 um 22:27 schrieb Walter Doekes:
>> Good. Your understanding of the situation is the same.
>>
>> I did not yet make a reproducer config -- mostly because I don't think
>> we're doing anything non-standard. But I did double check that latest
>> 2.6 is affected, tested both client and server.
>
> With pcap dumps I think I got an understanding what is happening. Can
> you see if this patch on the server fixes the problem for you? It is
> marked as WIP since I want to have more unit tests but the code
> shouldn't change.
>
> https://gerrit.openvpn.net/c/openvpn/+/1067
>
> Arne
>


