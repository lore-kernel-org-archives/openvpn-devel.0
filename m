Message-ID: <4BD84E6F.10409@...1338...>
Date: Wed, 28 Apr 2010 17:04:15 +0200
From: Fabian Knittel <fabian.knittel@...1338...>
MIME-Version: 1.0
References: <4BC330A0.5000209@...1338...> <20100427230723.4696.qmail@...1287...>
In-Reply-To: <20100427230723.4696.qmail@...1287...>
Subject: Re: [Openvpn-devel] [PULL-REQUEST v3] VLAN-Tagging
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi Peter,

Peter Stuge wrote:
> Fabian Knittel wrote:
>> +++ b/configure.ac
>> @@ -212,6 +212,12 @@ AC_ARG_ENABLE(selinux,
>>     [SELINUX="yes"]
>>  )
>>  
>> +AC_ARG_ENABLE(vlan-tagging,
>> +   [  --disable-vlan-tagging  Disable support for VLAN tagging/untagging],
>> +   [VLAN_TAGGING="$enableval"],
>> +   [VLAN_TAGGING="yes"]
>> +)
> 
> Maybe explicitly mention that it's 802.1Q ?

Changed to "Disable support for 802.1Q-based VLAN tagging".

>> +dnl enable --vlan-tagging
>> +if test "$VLAN_TAGGING" = "yes"; then
>> +   AC_DEFINE(ENABLE_VLAN_TAGGING, 1, [Enable VLAN tagging/untagging])
>> +fi
> 
> Maybe also here.

Changed to "Enable 802.1Q-based VLAN tagging/untagging".

Also changed openvpn --help to output "Enable 802.1Q-based VLAN
tagging." instead of "Enable VLAN tagging."

>> +++ b/mroute.c
>> @@ -164,12 +164,28 @@ mroute_extract_addr_ipv4 (struct mroute_addr *src,
>>    return ret;
>>  }
>>  
>> +static void mroute_copy_ether_to_addr(struct mroute_addr *maddr,
>> +				      const uint8_t *eth_addr,
>> +				      int16_t vid)
>> +{
>> +  maddr->type = MR_ADDR_ETHER;
>> +  maddr->netbits = 0;
>> +  memcpy (maddr->addr, eth_addr, 6);
>> +#ifdef ENABLE_VLAN_TAGGING
>> +  maddr->len = 8;
>> +  memcpy (maddr->addr + 6, &vid, 2);
> 
> Does this need to consider htons() ?

As far as I understand it, struct mroute_addr is only used internally in
OpenVPN and never copied to the wire anywhere.  So my use of
host-byte-order _should_ only influence the hashing order and not
correctness.

(Further down I noticed that you might have meant ntohns() ... so you
might want to see my clarification below.)

> Also, I have a weak preference for uint16_t, just to indicate that
> negative values are never correct.

Good idea.  I've changed all storage to uint16_t.  (The only exception
is the return value of remove_vlan_tag() as it indicates error by
returning -1.)  The signed integer is an artefact of early iterations of
the patch-set.

>> @@ -303,6 +322,9 @@ mroute_addr_print_ex (const struct mroute_addr *ma,
>>  	{
>>  	case MR_ADDR_ETHER:
>>  	  buf_printf (&out, "%s", format_hex_ex (ma->addr, 6, 0, 1, ":", gc)); 
>> +#ifdef ENABLE_VLAN_TAGGING
>> +	  buf_printf (&out, "@%d", *(int16_t*)(ma->addr + 6));
>> +#endif
> 
> Also here, ntohs() ?

Maybe you meant htons()?  The value is stored in host-byte-order (by
mroute_copy_ether_to_addr() which you commented on above) and
mroute_addr_print_ex() attempts to display it to the user.  So no
conversion is necessary.

To clarify: The VID is sent over the wire in network-byte-order and
converted to host-byte-order at the untagging stage.  So all vid
variables you see in the code should hold the VID in host-byte-order.

>> +++ b/multi.c
> ..
>> @@ -1918,6 +1924,28 @@ multi_process_post (struct multi_context *m, struct multi_instance *mi, const un
>>    return ret;
>>  }
>>  
>> +#ifdef ENABLE_VLAN_TAGGING
>> +bool
>> +buf_filter_incoming_vlan_tags (const struct buffer *buf)
>> +{
>> +  if (BLEN (buf) >= (int) sizeof (struct openvpn_8021qhdr))
>> +    {
>> +      const struct openvpn_8021qhdr *vlanhdr = (const struct openvpn_8021qhdr *) BPTR (buf);
>> +
>> +      if (ntohs (vlanhdr->tpid) == OPENVPN_ETH_P_8021Q)
>> +        {
>> +	  const int16_t vid = vlanhdr_get_vid(vlanhdr);
>> +	  if (vid != 0)
>> +	    {
>> +	      msg (D_VLAN_DEBUG, "dropping tagged incoming frame, vid: %d", vid);
>> +	      return true;
>> +	    }
>> +	}
>> +    }
>> +  return false;
>> +}
>> +#endif
> 
> What a horrible coding style this is!! But oh well, that's certainly
> not your fault. :)

And the mix of tabs and spaces apparently gets more horrible the more
mail readers mangle it... :)

> However, I really like code that checks for "break" conditions first,
> and returns early, over code that nests multiple levels of
> conditions, something like:
> 
> {
>   struct openvpn_8021qhdr *vlanhdr;
>   int16_t vid;
>   if (BLEN (buf) < (int) sizeof (struct openvpn_8021qhdr))
>     return false;
>   vlanhdr = (const struct openvpn_8021qhdr *) BPTR (buf);
>   if (ntohs (vlanhdr->tpid) != OPENVPN_ETH_P_8021Q)
>     return false;
>   vid = vlanhdr_get_vid(vlanhdr);
>   if (0 == vid)
>     return false;
>   msg (D_VLAN_DEBUG, "dropping .. ");
>   return true;
> }
> 
> But don't let this start some kind of argument about coding style. I
> have no technical complaints about the hunk above.

I prefer your style too, but as OpenVPN often appears to prefer the
nested style, I probably get carried away sometimes. ;-)

I've prepared a patch to use your style.

>> @@ -2033,10 +2062,27 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
>>  	    }
>>  	  else if (TUNNEL_TYPE (m->top.c1.tuntap) == DEV_TYPE_TAP)
>>  	    {
>> +#ifdef ENABLE_VLAN_TAGGING
>> +	      int16_t vid = 0;
>> +#else
>> +	      const int16_t vid = 0;
>> +#endif
> 
> I like how you use const here.

Thanks :)

>> @@ -2116,6 +2163,159 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
>>    return ret;
>>  }
>>  
>> +#ifdef ENABLE_VLAN_TAGGING
>> +/*
>> + * For vlan_accept == VAF_ONLY_UNTAGGED_OR_PRIORITY:
>> + *   If a frame is VLAN-tagged, it is dropped.  Otherwise, the global
>> + *   vlan_pvid is returned as VID.
> 
> This is just a comment in the code, but maybe mention that vid=0 in a
> tag does not mean that it's VLAN-tagged. Yes, _OR_PRIORITY indicates
> this, but it might be nice to be super consistent also in the text.

OK.

>> +remove_vlan_tag (const struct context *c, struct buffer *buf)
>> +{
> ..
>> +  /* Tagged packet. */
>> +
>> +  vid = ntohs (vlanhdr_get_vid (&vlanhdr));
> 
> Hmm - does ntohs() here mean that it shouldn't be done in mroute.c?

Depends on what you were hinting at before.  As mentioned above, the vid
is currently always in host-byte-order within OpenVPN's data structures.

>> +      /* Frame too small for header type? */
>> +      if (BLEN (buf) < (int) (sizeof (struct openvpn_8021qhdr)))
>> +	goto drop;
> 
> This looks like a whitespace oops?
> 
> 
>> +      /* Not enough head room for VLAN tag? */
>> +      if (buf_reverse_capacity (buf) < SIZE_ETH_TO_8021Q_HDR)
>> +	goto drop;
> 
> Here too? Hmm. Am I missing something?

Yeah ... it's the tabs + spaces mixing.  As soon as we hit 8 spaces, the
indentation is switched to a full tab.  That's why it looks silly in
places where a tab is not expanded to 8 spaces.  It also breaks in
patches, because of the prepended '+'/'-'/' ' character, which moves the
spaces but doesn't move the tab.

So maaaybe the OpenVPN project might want to consider switching from 
tabs + spaces to only tabs or only spaces.

[...]
> This indent also looks off - but it may just be me not knowing the
> coding style. (I hope not though, this is horrible.)

It's not nice to look at for patches, agreed.


>> +++ b/openvpn.8
> ..
>> +Incoming untagged packets from clients are assigned with the client's Port
>> +VLAN Identifier (PVID) as their VID. In
>> +.B untagged
>> +mode, incoming untagged packets on the tap device are associated with the
>> +global
>> +.B \-\-vlan\-pvid
>> +setting. In
>> +.B tagged
>> +mode, any incoming untagged packets are dropped.
> 
> Would it be desirable to support both tagged and untagged at once?
> 
> On Linux maybe there could be a workaround involving a bridge or so.

I'm not sure whether we're talking about the same thing here.  So maybe 
that man page paragraph needs clarification. :)

The paragraph talks about two things:
a) Packets coming in from clients must not be VLAN-tagged.  The packets
    implicitly get the client's VID assigned (the --vlan-pvid that was
    set for the connected client).
b) Packets coming in from the tap device: In untagged mode they get
    assigned the VID of the global --vlan-pvid setting and any
    VLAN-tagged packets are dropped. In tagged mode the VID is explicit
    within the packet and any not-VLAN-tagged packets are dropped.
    Further down (not quoted above), the "all" mode is explained, which
    handles the case where untagged and tagged packets should be accepted
    on the tap device.

But maybe you were talking about allowing clients to send tagged packets 
in addition to untagged packets?

I considered implementing that, but it would be quite in invasive 
change.  Basically, the --vlan-accept option would then be valid per 
client and would indicate what type of packets the client may send or 
receive.  This would make it necessary to pass around the frames in 
tagged form internally (i.e. all untagged frames would be tagged with 
the PVID) and handle untagging separately for each port during sending.
In addition, we would probably want to introduce a VID filter per port, 
so that ports can only introduce frames for a set of permitted VLANs 
(something like "--vlan-valid-vids" or simply "--vlan-vids" per port).

As the current set of configuration options should be flexible enough 
for the above mentioned "full feature set", I hope them to be relatively 
future-proof and consider the implementation of the "full feature set" 
out of scope for my current efforts.


[ Skipped further comments on indentation. ]

>> +++ b/proto.c
>> @@ -54,6 +54,9 @@ is_ipv4 (int tunnel_type, struct buffer *buf)
>>  	return false;
>>        eh = (const struct openvpn_ethhdr *) BPTR (buf);
>>        if (ntohs (eh->proto) == OPENVPN_ETH_P_8021Q) {
>> +        if (BLEN (buf) < (int)(sizeof (struct openvpn_8021qhdr)
>> +	    + sizeof (struct openvpn_iphdr)))
>> +	  return false;
>>          const struct openvpn_8021qhdr *evh;
>>          evh = (const struct openvpn_8021qhdr *) BPTR (buf);
>>          if (ntohs (evh->proto) != OPENVPN_ETH_P_IPV4)
> 
> Indenting here too. And I think the if needs to go after the struct
> to compile very broadly, even if C99 permits variables like this.

Ah, good catch!  Fixed.

>> +++ b/proto.h
> ..
>> +/*
>> + * Retrieve the Priority Code Point (PCP) from the IEEE 802.1Q header.
>> + */
>> +static inline int
>> +vlanhdr_get_pcp (const struct openvpn_8021qhdr *hdr)
>> +{
>> +  return hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_PCP;
>> +}
> 
> What about byte order for these guys? Is it OK to use host byte
> order?

They expected and returned the values in network byte order and all 
invocations did the matching conversions.  I've moved the conversions 
into vlanhdr_get_*/_set_*.

Cheers
Fabian

