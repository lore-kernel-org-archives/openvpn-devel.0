MIME-Version: 1.0
In-Reply-To: <20180301175147.GB69387@...1296...>
References: <1480022363-24222-1-git-send-email-selva.nair@...277...>
 <1480051264-30193-1-git-send-email-selva.nair@...277...>
 <CAKuzo_hThVb9Gozz_T0sn0iZoyfNNzR5JnLEtxSrP8x2xTDy0A@...278...>
 <CAKuzo_gBWiY==v8bjuaOgq8F2R=gq0a5RNN28VvXphj1p2e2vA@...278...>
 <20180301175147.GB69387@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 1 Mar 2018 14:57:29 -0500
Message-ID: <CAKuzo_iKOJDDUyruzP=0f-0neaq6PZV+kJdeCMuuUef4LMBeHg@...278...>
Subject: Re: [Openvpn-devel] Fwd: [PATCH] Delete the IPv6 route to the
 "connected" network on tun close
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Thu, Mar 1, 2018 at 12:51 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Thu, Mar 01, 2018 at 11:09:32AM -0500, Selva Nair wrote:
>> This one is too old to cleanly apply, but still sending again
>> just to get it into patchwork.
>
> Oh, completely fell of my radar.  But now that you mention it, yes,
> there was something about clearing bits :-)
>
>> (For some reason bouncing to patchwork somehow never works for me, else
>> this could have beaten the oldest pending patch record :)
>
> Bouncing my own usually works, bouncing others "sometimes".  Might be
> related to SPF records and/or DKIM/DMARC checks...

One difference is that I'm bouncing @gmail.com mails using mutt. But
its sending through gmail's smtp server, so shouldn't raise any red
flags. And DKIM/SPF failures should be even worse for mails send
through the list. Probably sourceforge.net is whitelisted in
patchwork... Anyway, I can live with it.

>
> [..]
>> This was missing on Windows when interactive service is in use.
>>
>> - Added route_ipv6_clear_host_bits(r6) to delete_route_ipv6: this is
>>   required for Windows IP-helper API. Won't hurt other platforms (?)
>>
>> Signed-off-by: Selva Nair <selva.nair@...277...>
>> ---
>>  src/openvpn/route.c | 2 ++
>>  src/openvpn/tun.c   | 3 +++
>>  2 files changed, 5 insertions(+)
>>
>> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
>> index fec12c1..85f969e 100644
>> --- a/src/openvpn/route.c
>> +++ b/src/openvpn/route.c
>> @@ -2124,6 +2124,8 @@ delete_route_ipv6 (const struct route_ipv6 *r6,
>> const struct tuntap *tt, unsigne
>>
>>    gc_init (&gc);
>>
>> +  route_ipv6_clear_host_bits (r6);
>> +
>
> This is no longer needed, as the clearing is done in
>
>   delete_route_connected_v6_net()
>
> now (2cea72005cb5a825c).
>
>> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
>> index 560b1a8..40ce202 100644
>> --- a/src/openvpn/tun.c
>> +++ b/src/openvpn/tun.c
>> @@ -5663,6 +5663,9 @@ close_tun (struct tuntap *tt)
>>          {
>>            if (tt->options.msg_channel)
>>              {
>> +              /* remove route pointing to interface */
>> +              delete_route_connected_v6_net(tt, NULL);
>> +
>>                do_address_service (false, AF_INET6, tt);
>>               if (tt->options.dns6_len > 0)
>>                   do_dns6_service (false, tt);
>
> So this part remains, but to avoid code duplication I'd move the
> "delete_route_connected_v6_net()" call from the else() branch up
> and before the if (tt->options.msg_channel) clause.

Good point. A new version was unavoidable because of the recent
clear_host_bits fix and uncrustify changes.

Actually there was an old v2 but no longer required. So v3 is coming.

> Looking at the context, this patch is amazingly old... "before the
> code reorganization", so it somehow missed 2.4.0...
> thanks for bringing it back :-)

Trying to delete old local branches. There are two other ones which
need David's attention but it seems he is too busy and no one else
would touch plugins code :)

Selva

