Message-ID: <db3d305c-ed53-0ca7-a165-85d99619dd5a@...2181...>
Date: Mon, 19 Sep 2022 10:17:29 +0200
MIME-Version: 1.0
References: <20220917231030.22565-1-a@...2181...>
 <Yyb07u4pG0Ii9vQf@...1296...>
 <dca91e77-175c-9540-7993-112ca7a4661b@...2181...>
 <YygN5ZRAAMA1xdrj@...1296...> <YygWLIqh1MIdiZ0m@...1296...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <YygWLIqh1MIdiZ0m@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] implement --session-timeout
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 19/09/2022 09:11, Gert Doering wrote:
> Hi,
> 
> On Mon, Sep 19, 2022 at 08:36:21AM +0200, Gert Doering wrote:
>>> we don't get here at all, if we have no event object that is timing out.
>>
>> process_coarse_timers() is run once per second, and does not need
>> additional timers to be called.
>>
>> This new check is added to process_coarse_timers().
>>
>> Why do we need an extra event object, again?
> 
> Mmmmh.  I think we actually might need one, to ensure that this fires
> only *once*, and we can then do what is needed (like, explicit-exit-notify,
> reliable TLS processing, etc.) without raising more SIGTERM on every
> future visit here.
> 
> (Of course we could avoid this by resetting the session end time, but
> then it might be easier to understand if we use the existing mechanisms,
> even if a bit heavyweight)

I went down the multi-rabbit-hole and managed to get back alive.

The coarse timer is set to the lowest needed value across all the active 
timers (through event_timer_trigger()) or required TLS action. However 
we don't have specific code to handle a bunch of "one-shot" events.

For this reason the simplest approach is to set an event object and 
simply not rearm it after it is triggered. The rearm happens via 
_reset(), which we don't call. So this patch looks good to me as is.

Cheers,

> 
> gert
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-- 
Antonio Quartulli

