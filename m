References: <458e1fb5-a725-781b-c048-4f0e07440c7b@...1227...>
 <1cf9fe7a309a622eb0ddd79a34dd3af4.squirrel@...2556...>
 <a0648ba0-41ed-5eef-4f36-d41bcb636823@...2181...>
 <ec1f603d169af78b5fdf0cbc3b6f4e52.squirrel@...2556...>
 <9b3b2029-bb7d-ab1d-a69b-0d910565fad2@...2181...>
 <e477a1210a2efee09ee2eaccb604e164.squirrel@...2556...>
 <20210403095640.GW976@...1296...>
 <5f61a142d6c8fc91223af9b89cf2772b.squirrel@...2556...>
 <768c58ba-e87b-4e96-0403-61fece8297d0@...2181...>
 <704cc498609f9451a1af5010669452b4.squirrel@...2556...>
 <20210403165313.GY976@...1296...>
 <d4daa5b7f65017700e60369dc5ff1778.squirrel@...2556...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <4d98d62b-1f1c-8753-32b6-c87c935729d3@...1227...>
Date: Mon, 5 Apr 2021 10:39:48 +0200
MIME-Version: 1.0
In-Reply-To: <d4daa5b7f65017700e60369dc5ff1778.squirrel@...2556...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Fix 'compress migrate' for 2.2 clients.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Simon Matter <simon.matter@...2249...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <a@...2181...>

Am 05.04.21 um 09:38 schrieb Simon Matter:
>> Hi,
>>
>> On Sat, Apr 03, 2021 at 03:07:11PM +0200, Simon Matter wrote:
>>> Apr  3 15:00:30 gw-X1 openvpn[1477]: pre-compress bytes,833300152
>>> Apr  3 15:00:30 gw-X1 openvpn[1477]: post-compress bytes,796650159
>>> Apr  3 15:00:30 gw-X1 openvpn[1477]: pre-decompress bytes,343572096
>>> Apr  3 15:00:30 gw-X1 openvpn[1477]: post-decompress bytes,510118472
>>
>> This is indeed fairly significant - and if WAN circuits are full and/or
>> cost money per Gbyte, compression is still a win.
>>
>> I'm more of a compression fan than not :-) - so this will be interesting
>> discussions indeed.
> 
> Hi Gert,
> 
> Based on the answers I got on this list I'm afraid there won't be any
> discussion and compression is gone. That's really sad as it is a useful
> feature for many use cases as I was easily able to show.

Currently compression is not planned to be removed for an upcoming
release. However from our discussion it should be clear that compression
has evolved from a once useful feature for VPN when the security impact
wasn't known and HTTP still was 90% vs 10% HTTPS to a niche feature as
enabling compression by default on a VPN is not reasonable any more.

The future will tell how long compression will stay in OpenVPN. It
depends on how big/small the niche is and how much work it is to
continue supporting this feature.

Arne

