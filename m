MIME-Version: 1.0
In-Reply-To: <c107aa30-32d4-dfb6-96d9-9f7610399796@...2181...>
References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...>
 <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
 <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
 <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
 <c107aa30-32d4-dfb6-96d9-9f7610399796@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 6 Jun 2018 00:26:44 -0400
Message-ID: <CAKuzo_jPBZS42OndiU_k04072JUFFGveRjmP-ZwzLjNb8Hw4Mg@...278...>
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi

On Tue, Jun 5, 2018 at 10:30 PM, Antonio Quartulli <a@...2181...> wrote:
> Hi,
>
> On 06/06/18 03:38, Selva Nair wrote:
>> Here is the diff of what I did for the Windows build run:
>>
>> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
>> index 2e33880..75336a9 100644
>> --- a/src/openvpn/tun.c
>> +++ b/src/openvpn/tun.c
>> @@ -5824,9 +5824,9 @@ open_tun(const char *dev, const char *dev_type,
>> const char *dev_node, struct tun
>>
>>      if (tt->type == DEV_TYPE_TUN)
>>      {
>> -        if (!tt->did_ifconfig_setup)
>> +        if (!tt->did_ifconfig_setup && !tt->did_ifconfig_ipv6_setup)
>>          {
>> -            msg(M_FATAL, "ERROR: --dev tun also requires --ifconfig");
>> +            msg(M_WARN|M_INFO, "WARNING: neither ifconfig nor
>> ifconfig-ipv6 specified");
>
> Why converting this FAtTAL to M_WARN|M_INFO?
> Isn't just better to quit the client if we receive no IPv* settings?

That was just to show why Windows needs some special handling here,
not a patch :)

Well, the reason why this used to be FATAL is because Windows is
special: tun mode requires --ifconfig. Whereas on other platforms its
not FATAL to run without any ifconfig: say the user sets a static IP
on the tun and somehow gets it to work.

At the same time, v4 address will work only if also present as an
ifconfig line (even if a manual method of assigning the IP is in use).
So some FATAL check is still required to catch that. But making this
combination check FATAL is not the same thing.  I'm not entirely sure
of the best approach, but, anyway, its your patch :)

Selva

