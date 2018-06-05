MIME-Version: 1.0
In-Reply-To: <20180605195935.GU57262@...1296...>
References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...>
 <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
 <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
 <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
 <20180605195935.GU57262@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 5 Jun 2018 16:30:46 -0400
Message-ID: <CAKuzo_jP1F13rw2pdRx9zF0n-7+N29u3d4FE53tL9SrwxMwk9w@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Tue, Jun 5, 2018 at 3:59 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Tue, Jun 05, 2018 at 03:38:44PM -0400, Selva Nair wrote:
>> FWIW, I did a quick test --- looking into tap-windows sources it seems
>> the address is used only for ARP so passing some random address to the
>> ioctl looks ok (?).
>
> Not sure about that.  For ARP spoofing, it should use the route-gateway
> address - the "ifconfig" address is likely to end up in the DHCP-server
> code.  Haven't checked yet (busy repairing my own test right which
> deteriorated a bit...).

I should have said TAP is given the address/network/netmask combination.
In ProcessARP() it checks both the source and destination using those. This
is for subnet topology, so it spoofs all addresses in the subnet I suppose.

For DHCP we have another ioctl which sets the dhcp_address (same as the
v4 ip),  dhcp server address and mask of ~0 but we wont be using it if
v4 address is not set. There is also a sanity check on the netmask
and network addresses which 0.0.0.0/0.0.0.0 will pass.

That said, I have only got it to connect and ping the server.

>
> [..]
>> There is a less than ideal log message which could be improved:
>>
>> "Set TAP-Windows TUN subnet mode network/local/netmask =
>> 0.0.0.0/0.0.0.0/0.0.0.0 [SUCCEEDED]"
>
> Indeed :-)
>
>> However, even with !ipv4, redirect-gateway ipv6 appears to error out
>> -- it fails with
>>
>> "TEST ROUTES: 0/2 succeeded len=1 ret=0 a=0 u/d=up
>> Route: Waiting for TUN/TAP interface to come up..."
>
> Interesting.  This is route.c, test_routes(), using test_route_helper()
> -> test_route(), which basically tries to find the adapter index where
> a given (route)->gateway is configured on.  Since it cannot find anything,
> it assumes "tun interface is stuck in DHCP" and is unhappy.
>
> This shouldn't actually try to do anything in the first place - it
> looks at "struct route_list *rl", which should not be populated if
> we have no v4 address to point the routes to.  (Or maybe it should,
> but only for "non-tun/tap routes").

Yeah, we cant ignore v4 routes completely. So the logic for checking the
tun is ready has to change?

>
>
>> A couple of other random things I noticed
>>
>> If a v4 address is not being set:
>>
>> - some management messages could be bypassed as Gert had guessed --
>> eg., ASSIGN_IP which includes the v4 and v6 address.
>> The GUI takes the address from the final CONNECTED,SUCCESS message but
>> other clients may parse this message.
>
> What does our GUI display here?  "0.0.0.0" or "<blank>"?

Just a "comma" but no segfaults :) We can fix that.

Selva

