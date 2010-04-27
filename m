Message-ID: <20100427230723.4696.qmail@...1287...>
Date: Wed, 28 Apr 2010 01:07:23 +0200
From: Peter Stuge <peter@...1287...>
References: <4BC330A0.5000209@...1338...>
MIME-Version: 1.0
In-Reply-To: <4BC330A0.5000209@...1338...>
Subject: Re: [Openvpn-devel] [PULL-REQUEST v3] VLAN-Tagging
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Fabian Knittel wrote:
> I've attached a diff containing all changes introduced by the
> current patch-set.

Thanks for doing this. It makes review so much easier.


> +++ b/configure.ac
> @@ -212,6 +212,12 @@ AC_ARG_ENABLE(selinux,
>     [SELINUX="yes"]
>  )
>  
> +AC_ARG_ENABLE(vlan-tagging,
> +   [  --disable-vlan-tagging  Disable support for VLAN tagging/untagging],
> +   [VLAN_TAGGING="$enableval"],
> +   [VLAN_TAGGING="yes"]
> +)

Maybe explicitly mention that it's 802.1Q ?


> +dnl enable --vlan-tagging
> +if test "$VLAN_TAGGING" = "yes"; then
> +   AC_DEFINE(ENABLE_VLAN_TAGGING, 1, [Enable VLAN tagging/untagging])
> +fi

Maybe also here.


> +++ b/mroute.c
> @@ -164,12 +164,28 @@ mroute_extract_addr_ipv4 (struct mroute_addr *src,
>    return ret;
>  }
>  
> +static void mroute_copy_ether_to_addr(struct mroute_addr *maddr,
> +				      const uint8_t *eth_addr,
> +				      int16_t vid)
> +{
> +  maddr->type = MR_ADDR_ETHER;
> +  maddr->netbits = 0;
> +  memcpy (maddr->addr, eth_addr, 6);
> +#ifdef ENABLE_VLAN_TAGGING
> +  maddr->len = 8;
> +  memcpy (maddr->addr + 6, &vid, 2);

Does this need to consider htons() ?

Also, I have a weak preference for uint16_t, just to indicate that
negative values are never correct.


> @@ -303,6 +322,9 @@ mroute_addr_print_ex (const struct mroute_addr *ma,
>  	{
>  	case MR_ADDR_ETHER:
>  	  buf_printf (&out, "%s", format_hex_ex (ma->addr, 6, 0, 1, ":", gc)); 
> +#ifdef ENABLE_VLAN_TAGGING
> +	  buf_printf (&out, "@%d", *(int16_t*)(ma->addr + 6));
> +#endif

Also here, ntohs() ?


> +++ b/multi.c
..
> @@ -1918,6 +1924,28 @@ multi_process_post (struct multi_context *m, struct multi_instance *mi, const un
>    return ret;
>  }
>  
> +#ifdef ENABLE_VLAN_TAGGING
> +bool
> +buf_filter_incoming_vlan_tags (const struct buffer *buf)
> +{
> +  if (BLEN (buf) >= (int) sizeof (struct openvpn_8021qhdr))
> +    {
> +      const struct openvpn_8021qhdr *vlanhdr = (const struct openvpn_8021qhdr *) BPTR (buf);
> +
> +      if (ntohs (vlanhdr->tpid) == OPENVPN_ETH_P_8021Q)
> +        {
> +	  const int16_t vid = vlanhdr_get_vid(vlanhdr);
> +	  if (vid != 0)
> +	    {
> +	      msg (D_VLAN_DEBUG, "dropping tagged incoming frame, vid: %d", vid);
> +	      return true;
> +	    }
> +	}
> +    }
> +  return false;
> +}
> +#endif

What a horrible coding style this is!! But oh well, that's certainly
not your fault. :)

However, I really like code that checks for "break" conditions first,
and returns early, over code that nests multiple levels of
conditions, something like:

{
  struct openvpn_8021qhdr *vlanhdr;
  int16_t vid;
  if (BLEN (buf) < (int) sizeof (struct openvpn_8021qhdr))
    return false;
  vlanhdr = (const struct openvpn_8021qhdr *) BPTR (buf);
  if (ntohs (vlanhdr->tpid) != OPENVPN_ETH_P_8021Q)
    return false;
  vid = vlanhdr_get_vid(vlanhdr);
  if (0 == vid)
    return false;
  msg (D_VLAN_DEBUG, "dropping .. ");
  return true;
}

But don't let this start some kind of argument about coding style. I
have no technical complaints about the hunk above.


> @@ -2033,10 +2062,27 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
>  	    }
>  	  else if (TUNNEL_TYPE (m->top.c1.tuntap) == DEV_TYPE_TAP)
>  	    {
> +#ifdef ENABLE_VLAN_TAGGING
> +	      int16_t vid = 0;
> +#else
> +	      const int16_t vid = 0;
> +#endif

I like how you use const here.


> @@ -2116,6 +2163,159 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
>    return ret;
>  }
>  
> +#ifdef ENABLE_VLAN_TAGGING
> +/*
> + * For vlan_accept == VAF_ONLY_UNTAGGED_OR_PRIORITY:
> + *   If a frame is VLAN-tagged, it is dropped.  Otherwise, the global
> + *   vlan_pvid is returned as VID.

This is just a comment in the code, but maybe mention that vid=0 in a
tag does not mean that it's VLAN-tagged. Yes, _OR_PRIORITY indicates
this, but it might be nice to be super consistent also in the text.


> +remove_vlan_tag (const struct context *c, struct buffer *buf)
> +{
..
> +  /* Tagged packet. */
> +
> +  vid = ntohs (vlanhdr_get_vid (&vlanhdr));

Hmm - does ntohs() here mean that it shouldn't be done in mroute.c?


> +multi_prepend_vlan_tag (const struct context *c, struct buffer *buf)
> +{
..
> +  /* Frame too small? */
> +  if (BLEN (buf) < (int) sizeof (struct openvpn_ethhdr))
> +    goto drop;

I like forward goto for error handling very much too!


> +      /* Frame too small for header type? */
> +      if (BLEN (buf) < (int) (sizeof (struct openvpn_8021qhdr)))
> +	goto drop;

This looks like a whitespace oops?


> +      /* Not enough head room for VLAN tag? */
> +      if (buf_reverse_capacity (buf) < SIZE_ETH_TO_8021Q_HDR)
> +	goto drop;

Here too? Hmm. Am I missing something?


> @@ -2158,6 +2363,16 @@ multi_process_incoming_tun (struct multi_context *m, const unsigned int mpp_flag
>         * the appropriate multi_instance object.
>         */
>  
> +#ifdef ENABLE_VLAN_TAGGING
> +      if (dev_type == DEV_TYPE_TAP && m->top.options.vlan_tagging)
> +        {
> +	  if ((vid = remove_vlan_tag (&m->top, &m->top.c2.buf)) == -1)
> +	    {
> +	      return false;
> +	    }
> +        }
> +#endif

This indent also looks off - but it may just be me not knowing the
coding style. (I hope not though, this is horrible.)


> @@ -415,6 +418,26 @@ multi_process_outgoing_tun (struct multi_context *m, const unsigned int mpp_flag
..
> +      if (m->top.options.vlan_pvid != mi->context.options.vlan_pvid)
> +	{

Again with the weird indenting.


> +++ b/openvpn.8
..
> +Incoming untagged packets from clients are assigned with the client's Port
> +VLAN Identifier (PVID) as their VID. In
> +.B untagged
> +mode, incoming untagged packets on the tap device are associated with the
> +global
> +.B \-\-vlan\-pvid
> +setting. In
> +.B tagged
> +mode, any incoming untagged packets are dropped.

Would it be desirable to support both tagged and untagged at once?

On Linux maybe there could be a workaround involving a bridge or so.


> +++ b/options.c
> @@ -1742,6 +1774,17 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
>  
>  	if ((options->ssl_flags & SSLF_NO_NAME_REMAPPING) && script_method == SM_SYSTEM)
>  	  msg (M_USAGE, "--script-security method='system' cannot be combined with --no-name-remapping");
> +#ifdef ENABLE_VLAN_TAGGING
> +      if (options->vlan_tagging && dev != DEV_TYPE_TAP)
> +	msg (M_USAGE, "--vlan-tagging must be used with --dev tap");
> +      if (!options->vlan_tagging)
> +	{
> +	  if (options->vlan_accept != defaults.vlan_accept)
> +	    msg (M_USAGE, "--vlan-accept requires --vlan-tagging");
> +	  if (options->vlan_pvid != defaults.vlan_pvid)
> +	    msg (M_USAGE, "--vlan-pvid requires --vlan-tagging");
> +	}
> +#endif

Funky indent again.


> @@ -1788,7 +1831,10 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
>        if (options->port_share_host || options->port_share_port)
>  	msg (M_USAGE, "--port-share requires TCP server mode (--mode server --proto tcp-server)");
>  #endif
> -
> +#ifdef ENABLE_VLAN_TAGGING
> +      if (options->vlan_tagging)
> +	msg (M_USAGE, "--vlan-tagging requires --mode server");
> +#endif

Here too.


> @@ -5730,6 +5776,45 @@ add_option (struct options *options,
..
> +  else if (streq (p[0], "vlan-accept") && p[1])
> +    {
> +      VERIFY_PERMISSION (OPT_P_GENERAL);
> +      if (streq (p[1], "tagged"))
> +	{
> +	  options->vlan_accept = VAF_ONLY_VLAN_TAGGED;
> +	}
> +      else if (streq (p[1], "untagged"))
> +	{
> +	  options->vlan_accept = VAF_ONLY_UNTAGGED_OR_PRIORITY;
> +	}
> +      else if (streq (p[1], "all"))
> +	{
> +	  options->vlan_accept = VAF_ALL;
> +	}
> +      else
> +	{
> +	  msg (msglevel, "--vlan-accept must be 'tagged', 'untagged' or 'all'");
> +	  goto err;
> +	}
> +    }
> +  else if (streq (p[0], "vlan-pvid") && p[1])
> +    {
> +      VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_INSTANCE);
> +      options->vlan_pvid = positive_atoi (p[1]);
> +      if (options->vlan_pvid < OPENVPN_8021Q_MIN_VID ||
> +	  options->vlan_pvid > OPENVPN_8021Q_MAX_VID)
> +	{
> +	  msg (msglevel, "the parameter of --vlan-pvid parameters must be >= %d and <= %d", OPENVPN_8021Q_MIN_VID, OPENVPN_8021Q_MAX_VID);
> +	  goto err;
> +	}
> +    }

This indent stuff is really killing me. I find it extremely hard to
read. :)


> +++ b/proto.c
> @@ -54,6 +54,9 @@ is_ipv4 (int tunnel_type, struct buffer *buf)
>  	return false;
>        eh = (const struct openvpn_ethhdr *) BPTR (buf);
>        if (ntohs (eh->proto) == OPENVPN_ETH_P_8021Q) {
> +        if (BLEN (buf) < (int)(sizeof (struct openvpn_8021qhdr)
> +	    + sizeof (struct openvpn_iphdr)))
> +	  return false;
>          const struct openvpn_8021qhdr *evh;
>          evh = (const struct openvpn_8021qhdr *) BPTR (buf);
>          if (ntohs (evh->proto) != OPENVPN_ETH_P_IPV4)

Indenting here too. And I think the if needs to go after the struct
to compile very broadly, even if C99 permits variables like this.


> +++ b/proto.h
..
> +/*
> + * Retrieve the Priority Code Point (PCP) from the IEEE 802.1Q header.
> + */
> +static inline int
> +vlanhdr_get_pcp (const struct openvpn_8021qhdr *hdr)
> +{
> +  return hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_PCP;
> +}

What about byte order for these guys? Is it OK to use host byte
order?


Thank you so much for your work on this!


//Peter

