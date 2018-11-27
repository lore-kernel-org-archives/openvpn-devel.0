References: <20181011184200.22175-1-a@...2181...>
 <20181011184200.22175-3-a@...2181...>
 <083568d5-2591-cdbd-4223-44b5dd46bbd6@...1227...>
 <d963568b-232c-f681-94c7-16e320e244a2@...2181...>
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
Message-ID: <233c6900-3d0b-8004-1b8e-813b0e459285@...2080...>
Date: Tue, 27 Nov 2018 13:13:45 +0100
MIME-Version: 1.0
In-Reply-To: <d963568b-232c-f681-94c7-16e320e244a2@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v2 2/7] implement networking API for
 iproute2
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
To: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 27/11/2018 02:04, Antonio Quartulli wrote:
> 
[...snip...]
>>>  create mode 100644 src/openvpn/networking_ip.h
>>>
>>> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
>>> index 8afc4146..3caad17d 100644
>>> --- a/src/openvpn/Makefile.am
>>> +++ b/src/openvpn/Makefile.am
>>> @@ -80,7 +80,7 @@ openvpn_SOURCES = \
>>>  	mtu.c mtu.h \
>>>  	mudp.c mudp.h \
>>>  	multi.c multi.h \
>>> -	networking.h \
>>> +	networking_ip.c networking_ip.h networking.h \
>>
>> As ip is not really but a linux specific tool, I think naming this
>> networking_linuxip.c is better as networking_ip sounds like something
>> generic.
> 
> I did not want to make any assumption - you never know if iproute will
> later be ported to *BSD as well. But I am fine with either name.

Just adding more paint to the shed :-P  networking_ip.[ch] sounds a bit too
generic, but I'd prefer networking_iproute2.[ch], which I consider more
consistent to what these files implement.

Otherwise, both Arne is right (iproute2 is currently only widely used on
Linux) and Antonio is perhaps right to (iproute2 might be ported in the future).

[...snip...]

>>> +int
>>> +net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *iface,
>>> +                const in_addr_t *addr, int prefixlen,
>>> +                const in_addr_t *broadcast)
>>> +{
>>> +    struct argv argv = argv_new();
>>> +
>>> +    char *addr_str = (char *)print_in_addr_t(*addr, 0, NULL);
>>> +    char *brd_str = (char *)print_in_addr_t(*broadcast, 0, NULL);
>>> +
>>> +    argv_printf(&argv, "%s addr add dev %s %s/%d broadcast %s", iproute_path,
>>> +                iface, addr_str, prefixlen, brd_str);
>>> +    argv_msg(M_INFO, &argv);
>>> +    openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip addr add failed");
>>> +
>>> +    free(addr_str);
>>> +    free(brd_str);
>>> +
>>> +    argv_reset(&argv);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>
>> I initially written a comment that this method removes the ptp variant
>> of the method but later saw that there is also a ptp variant of the
>> method. I would suggest to either ranme this method to
>> net_addr_bcast_v4_add or have a bool ptp paramter and then call out to
>> two different methods.
> 
> To me it feels like the PtP case is a special case, therefore I
> preferred to keep the "standard & simple" name for the non-PtP case and
> then add a special function just for PtP.
> 
> Actually this function may even be called without a broadcast address.
> 
> Mh..dunno to be honest. Maybe somebody else has an opinion?

I agree with Antonio.  It's not just the broadcast which is different, the ptp
variant uses 'peer x.x.x.x' too.  It is a different configuration type, so
this makes it clearer to me when reading:

    net_addr_ptp_v4_addr(ctx, iface, local, remote);

Instead of:

    net_addr_v4_add(ctx, iface, local, 0, remote , true);

Of course, the 'true' could be a variable, but I don't see the real benefit of
making net_addr_v4_add() implemented wit different modes.  Especially when the
"broadcast" and "peer" passing would most likely go via a shared variable.
And it wouldn't make it cleared if peer and remote was separate arguments
either; as only one of them can be present at the same time.

So from code clarity, I like the distinction via the function names instead.
It is more straight to the point for me.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


