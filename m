MIME-Version: 1.0
In-Reply-To: <30206ee5-f602-57f3-2ce4-4a7b768200f2@...2181...>
References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...>
 <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
 <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
 <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
 <20180605195935.GU57262@...1296...>
 <CAKuzo_jP1F13rw2pdRx9zF0n-7+N29u3d4FE53tL9SrwxMwk9w@...278...>
 <9a878b99-12ef-47b4-fc85-a16ecc196363@...2181...>
 <CAKuzo_hU64ML71iL7Xdt5_k08QLXwDytXd1W2TVze=7SUhLLSQ@...278...>
 <CAKuzo_gp9jcVocxgf79TNQpgP-ScioC1pM_3oTq9+SHHAhEonw@...278...>
 <665fcdae-dad7-b6c8-14ee-512ff7992963@...2181...>
 <CAKuzo_jLhL=pLrkRoqWXHPRLzBGBiUCgq20Wzxd+DiidoAmOJA@...278...>
 <30206ee5-f602-57f3-2ce4-4a7b768200f2@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 7 Jun 2018 13:00:12 -0400
Message-ID: <CAKuzo_jnTgWve5Mn=R0=bFmGWzr_F90qsAWzw2OrCTkxYiFReg@...278...>
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

Hi,

Failed to respond to some other points in the last reply:

>>
>> Did some quick tests and this seems to work quite well (but see the
>> note at the bottom):
>>
>> - v4 routes via tun just fail with a warning which is good (our route
>> errors not being FATAL pays off here)
>> - v4 routes via net_gateway just works : no idea why we support this,
>> but good to see this patch doesn't break it
>> - redirect-gateway causes warnings as v4 routes fail:
>>   If its not too hard could we check !tt->did_ifconfig_setup before
>> attempting v4 redirect? Saying this because "--redirect-gateway with
>> no options automatically implies ipv4" is just a hangover from the
>> past that we are stuck with. For other routes it may be harder to
>> detect whether its via the tun or not so just letting them error out
>> is fine. And those warnings provide useful feedback to the user.
>>
>
> Don't you think it's still meaningful to print the warning? somebody is
> asking for a redirect that does not make sense because there is no v4
> configured and the config should be adjusted. No?

When you put it that way, yes. But interpreting redirect-gateway with
no arguments to mean redirect ipv4 is something we have to live with
just because of backward compatibility. In that sense its different
from an explicit ipv4 route in the config. Being a bit more helpful
and interpret it as !ipv4 when no v4 address is present looks like a
nice touch? So I would say, a warning saying redirect v4 is skipped is
useful but letting those routes error out is not.

But unlike I may sound, I do not have a strong feeling about this --
works either way for me.

>
>> A minor thing:
>>
>> - The warning
>> "WARNING: OpenVPN was configured to add an IPv4 route. However, no
>> IPv4 has been configured for this interface, therefore the route
>> installation may fail or may not work as expected."
>> is printed without the M_WARN flag  --- so syslog won't see it as a
>> warning nor does the GUI. M_INFO|M_WARN will make it print at verb > 0
>> with the warning tag. If that sounds like a strange combination,
>> invent a warning level like D_GENERIC_WARNING = LOGLEV(1,0,M_WARN). We
>> don't have one.
>>
>
> you are the master of the log levels, therefore I'll just follow your
> suggestion, unless somebody else objects.

Personally I do not like M_WARN|M_INFO but that's the best I can think
of to get the warning tag and print only if verb > 0.

Thanks,

Selva

