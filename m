MIME-Version: 1.0
In-Reply-To: <8117ab50-c3d1-2210-6665-9ea86b7110ac@...2181...>
References: <20180608052017.6696-1-a@...2181...>
 <20180613141213.5962-1-a@...2181...>
 <20180620155301.GY57262@...1296...>
 <c416ea67-e4ce-148b-eb19-6d18b35da559@...2181...>
 <20180622094635.GI57262@...1296...>
 <d496bbf5-3c55-f2d9-2ab2-bc89ded80131@...2181...>
 <CAKuzo_jDrcGjQeMaVm3X6yzgKBZecbYHfAAxxCFAuycagTe22Q@...278...>
 <20180622182709.GO57262@...1296...>
 <8117ab50-c3d1-2210-6665-9ea86b7110ac@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 22 Jun 2018 23:09:56 -0400
Message-ID: <CAKuzo_je1ZsOoTeaUdFxnP1JDMM1Op5TP-p=xA85SLn0pPCSGQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/8] windows: properly configure TAP
 driver when no IPv4 is configured
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
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Fri, Jun 22, 2018 at 10:07 PM, Antonio Quartulli <a@...2181...> wrote:
> Hi,
>
> On 23/06/18 02:27, Gert Doering wrote:
>> Hi,
>>
>> On Fri, Jun 22, 2018 at 02:12:24PM -0400, Selva Nair wrote:
>>> My tap adapter has a link local address (169.254.98.86) on it possibly due
>>> to a previous dhcp failure. May be I need to get rid of that (how?) to
>>> activate this code path?
>>
>> I guess this is related - the branch in question is triggered by
>> is_on_link(), so maybe in Antonio's case the tap adapter is set to
>> 0.0.0.0 - or it actually tried to install a route related to
>> redirect-gateway.
>>
>> Are you connecting to your VPN server over IPv6 or IPv4?  You already
>> spotted one weirdness with "redirect-gateway !ipv4" which still seems
>> to setup "something" in the route_list - so maybe it's related to that,
>> but needs "VPN over IPv4" to trigger.
>>
>> In other words, no idea - hoping for a log from Antonio that shows the
>> "route.exe ..." call with "IF <ifindex>" so we can see what openvpn
>> tried to do :-)
>>
>
> attached you have the log, however there is no message containing
> "route.exe ..".

No assert (with argv patch applied?) and no sign of any v4 routes.

>
> Gert, the ASSERT was triggered with your binary: was it simply master +
> 2/8 (this patch)?
>
> What I used for my last test is:
> * master +
> * all the remaining patches from ipv6-only +
> * the fix for argv_printf()

So I guess there wont be any assert with such a build even if the argv patch
is left out. That would match with what I re-tested.

>
> The server side is running master + ipv6-only and there is no --server
> directive in the configuration.
>
> In the log "Ethernet 2" is the TAP interface".
>
> My guts say that the issue might be related to "gateway-redirect",
> because only 8/8 makes sure that no logic is activated for IPv4 and
> without that patch there might be some IPv4 route being installed
> nonetheless.

Very likely. It would be nice to find the on-link route that triggers that code
path to ensure it doesn't cause any other issues.

But not very critical as the assert is fixed and route errors are not FATAL.

Selva

