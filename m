References: <CAEsd45TcQP9BDxyV+k+UXJUoZ7ZNoLGZuAq03C=6=gTBv-=Dfg@...278...>
 <1510511581-12120-1-git-send-email-arne@...1227...>
 <2202ec29-6107-e34f-4317-ace40e4ccbac@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <160f6a11-0b86-c2c1-15ee-4fd47bcde754@...1227...>
Date: Tue, 3 Jul 2018 16:46:09 +0200
MIME-Version: 1.0
In-Reply-To: <2202ec29-6107-e34f-4317-ace40e4ccbac@...2181...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH v3] Implement block-ipv6
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net


>> +    }
>> +    if (c->c2.buf.len > 0)
>> +    {
> 
> is this related to the ipv6 change? If so, how?


To drop packet OpenVPN generally sets the buf len to zero. Since we now
also drop packets that would normally go from client to server, I added
the check here so these packets can be dropped.



>> +{
>> +#define ICMPV6LEN  1280
> 
> isn't this available in any header? If not, I'd put MAX somewhere, to
> let people immediately understand what it is used for.

No and that constant is specific to the icmpv6 code so I kept in this
function.



> 
>> +
>> +    struct openvpn_ipv6hdr pip6out;
> 
> I know that we can declare variables basically everywhere, but don't you
> think this can quickly get out of control? Personally I'd just declare
> all of them at the top.
> 
> But I am not sure what the others think about it.

I inlined that declaration to make it more C99 style and look a bit better..


> 
>> +
>> +    /* IPv6 Header */
>> +    ASSERT(buf_write_prepend(outbuf, &pip6out, sizeof(struct openvpn_ipv6hdr)));
>> +
>> +    /*
>> +     * Working IPv6 block for TAP will also need the client to respond to IPv6 nd with
>> +     * its own (fake) adress
>> +     */
> 
> maybe I am missing something, but in the comment above you talk about
> answering to ND, but below you are just filling the Ethernet header. How
> are the two related?
> 
>> +    if (TUNNEL_TYPE(c->c1.tuntap) == DEV_TYPE_TAP)
>> +    {
>> +        if (BLEN(buf) < (int) sizeof (struct openvpn_ethhdr))
> 
> spaces..
> 
>> +            return;
>> +
>> +        const struct openvpn_ethhdr* orig_ethhdr = (struct openvpn_ethhdr *) BPTR(buf);
>> +
>> +        /* Copy frametype and reverse source/destination for the response */
>> +        struct openvpn_ethhdr ethhdr;
>> +        memcpy(ethhdr.source, orig_ethhdr->dest, OPENVPN_ETH_ALEN);
>> +        memcpy(ethhdr.dest, orig_ethhdr->source, OPENVPN_ETH_ALEN);
>> +        ethhdr.proto = htons(OPENVPN_ETH_P_IPV6);
>> +        ASSERT(buf_write_prepend(outbuf, &ethhdr, sizeof(struct openvpn_ethhdr)));
>> +    }
>> +}
> 
> Overall I was thinking: instead of creating many little objects (one per
> header) here and there and then copying them one by one in the allocated
> buffer, why not allocating the buffer first and writing directly into
> it? I believe that this is normal practice and might make the code a bit
> slimmer too. What do you think?
> 
> This is just a suggestion - I haven't tried to change the code myself.

I don't think that it would make the code much easier to to read.
Allocating the whole len in the buffer at the start and then defining
the structs as pointers at certain offsets in the buffer, is probably
not easier to understand. And since this is not a critical code path I
think the speed argument also does not count here. I would prefer to
keep it like it currently is.


>>      {
>>          /*
>> @@ -1275,7 +1392,7 @@ process_ip_header(struct contexICMPV6LENt *c, unsigned int flags, struct buffer *buf)
>>                  /* possibly do NAT on packet */
>>                  if ((flags & PIPV4_CLIENT_NAT) && c->options.client_nat)
>>                  {
>> -                    const int direction = (flags & PIPV4_OUTGOING) ? CN_INCOMING : CN_OUTGOING;
>> +                    const int direction = (flags & PIP_OUTGOING) ? CN_INCOMING : CN_OUTGOING;
> 
> how is this change related to this patch?

Since PIP_OUTGOING is not ipv4 specific anymore thanks to this patch, I
renamed the constant to PIP_OUTGOING.


For all the other comments I that I did not answer, I integrated them in
the V4 patch.

Arne

