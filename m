References: <8a2c220c-e169-0cb1-c8b4-3c8af5fab82a@...515...>
 <c573880b-af3b-0876-d00f-70e7a06c69fa@...515...>
 <003a7779-3f07-5335-4fd4-8f62aadf6134@...1918...>
 <20180412082603.GT69387@...1296...>
 <CAKuzo_g9Pabn1JSCXJxTse2u9-Laj+Ejc3mG94xQk=UOT4GUNw@...278...>
 <20180412145052.GC69387@...1296...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <e06e75c5-06fb-000f-f5c6-4d1949cf1b45@...1147...>
Date: Thu, 12 Apr 2018 22:22:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180412145052.GC69387@...1296...>
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] Viscosity patch to TAP driver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 12/04/18 16:50, Gert Doering wrote:
> Hi,
>
> On Thu, Apr 12, 2018 at 10:27:08AM -0400, Selva Nair wrote:
>>>> This change was made not because of any actual performance gains, but
>>>> because of user reports that certain firewall or AV software tries to
>>>> QoS the adapter based on its reported adapter speed, which is of course
>>>> a problem if the VPN connection is capable of more than 100 Mbit.
> [..]
>> Or am I mistaken -- does this setting really affect the max throughput?
> Not normally, but when certain 'helpful' software is around...
>
>
as a side note: there is one thing to keep in mind when changing this:
Windows calculates its automatic routing metrics based on the adapter 
speed. So if we increase the speed then there are scenarios possible 
where the tun adapter route will take precedence over a lan route : in 
most cases that is what a user would want, but there are (rare) 
scenarios where that could have nasty side effects (including the 
"biting your own tail" problem)

JM2CW,

JJK


