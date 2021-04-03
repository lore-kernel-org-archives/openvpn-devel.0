Message-ID: <5f61a142d6c8fc91223af9b89cf2772b.squirrel@...2556...>
In-Reply-To: <20210403095640.GW976@...1296...>
References: <20210402134529.27866-1-gert@...1296...>
 <b92f02afa4d8156edd55c2126ae6352c.squirrel@...2260...>
 <20210402185720.GS976@...1296...>
 <c76250866ae96447a3ec712f04b4b346.squirrel@...2260...>
 <458e1fb5-a725-781b-c048-4f0e07440c7b@...1227...>
 <1cf9fe7a309a622eb0ddd79a34dd3af4.squirrel@...2556...>
 <a0648ba0-41ed-5eef-4f36-d41bcb636823@...2181...>
 <ec1f603d169af78b5fdf0cbc3b6f4e52.squirrel@...2556...>
 <9b3b2029-bb7d-ab1d-a69b-0d910565fad2@...2181...>
 <e477a1210a2efee09ee2eaccb604e164.squirrel@...2556...>
 <20210403095640.GW976@...1296...>
Date: Sat, 3 Apr 2021 12:06:41 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Fix 'compress migrate' for 2.2 clients.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

> Hi,
>
> On Sat, Apr 03, 2021 at 11:52:59AM +0200, Simon Matter wrote:
>> > It sounds like there is no answer to this?
>> > Then why are we even discussing further?
>>
>> It could be at least one feature to prevent people from moving over to
>> WireGuard?
>
> Unless people can come up with real use cases why compression makes
> sense for them, and just move over to wireguard "BECAUSE IT HAS NO
> COMPRESSION EITHER, BUT YOU TOOK IT AWAY FROM ME!! STAMP FOOT!" this
> is hardly a compelling argument.

Our use case is simple, we don't want ANY application in our company to
consume more WAN bandwidth than is absolutely needed. Of course we're
using compression like in rsync where it's possible, but that's not
possible everywhere and with every application. So we also try to catch
those cases by using compression over the VPN links. In case there is no
compressible data, it doesn't hurt much, but it can help a lot with
compressible data.

That's the only reason why OpenVPN was better for us.

Simon


