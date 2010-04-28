Message-ID: <4BD80438.4070603@...1114...>
Date: Wed, 28 Apr 2010 11:47:36 +0200
From: David Sommerseth <openvpn.list@...1114...>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Thank you Peter, for going so thoroughly through these patches!

More comments below ...

On 28/04/10 01:07, Peter Stuge wrote:
> Fabian Knittel wrote:
[...snip...]
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

Agreed!  It made me even think if we should have a macro helping doing
this other places as well, if such need exists - as this seems to be a
good practice.  If this is the only places in the whole code needing it,
it makes no sense - but if there are a handful places, then yes.

[...snip...]

>> +multi_prepend_vlan_tag (const struct context *c, struct buffer *buf)
>> +{
> ..
>> +  /* Frame too small? */
>> +  if (BLEN (buf) < (int) sizeof (struct openvpn_ethhdr))
>> +    goto drop;
> 
> I like forward goto for error handling very much too!

Goto is not necessarily a bad thing, as long as they go in one direction
only.

In general I prefer when goto's go downwards only, as that is how the
code gets executed.  Going backwards should really be solved in other
ways.  And this seems to be the coding style in the rest of the OpenVPN
code base as well.

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
> 
> 
>> @@ -2158,6 +2363,16 @@ multi_process_incoming_tun (struct multi_context *m, const unsigned int mpp_flag
>>         * the appropriate multi_instance object.
>>         */
>>  
>> +#ifdef ENABLE_VLAN_TAGGING
>> +      if (dev_type == DEV_TYPE_TAP && m->top.options.vlan_tagging)
>> +        {
>> +	  if ((vid = remove_vlan_tag (&m->top, &m->top.c2.buf)) == -1)
>> +	    {
>> +	      return false;
>> +	    }
>> +        }
>> +#endif
> 
> This indent also looks off - but it may just be me not knowing the
> coding style. (I hope not though, this is horrible.)
> 
> 
>> @@ -415,6 +418,26 @@ multi_process_outgoing_tun (struct multi_context *m, const unsigned int mpp_flag
> ..
>> +      if (m->top.options.vlan_pvid != mi->context.options.vlan_pvid)
>> +	{
> 
> Again with the weird indenting.
> 

[...snip...]

>> +++ b/options.c
>> @@ -1742,6 +1774,17 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
>>  
>>  	if ((options->ssl_flags & SSLF_NO_NAME_REMAPPING) && script_method == SM_SYSTEM)
>>  	  msg (M_USAGE, "--script-security method='system' cannot be combined with --no-name-remapping");
>> +#ifdef ENABLE_VLAN_TAGGING
>> +      if (options->vlan_tagging && dev != DEV_TYPE_TAP)
>> +	msg (M_USAGE, "--vlan-tagging must be used with --dev tap");
>> +      if (!options->vlan_tagging)
>> +	{
>> +	  if (options->vlan_accept != defaults.vlan_accept)
>> +	    msg (M_USAGE, "--vlan-accept requires --vlan-tagging");
>> +	  if (options->vlan_pvid != defaults.vlan_pvid)
>> +	    msg (M_USAGE, "--vlan-pvid requires --vlan-tagging");
>> +	}
>> +#endif
> 
> Funky indent again.
> 
> 
>> @@ -1788,7 +1831,10 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
>>        if (options->port_share_host || options->port_share_port)
>>  	msg (M_USAGE, "--port-share requires TCP server mode (--mode server --proto tcp-server)");
>>  #endif
>> -
>> +#ifdef ENABLE_VLAN_TAGGING
>> +      if (options->vlan_tagging)
>> +	msg (M_USAGE, "--vlan-tagging requires --mode server");
>> +#endif
> 
> Here too.
> 
> 
>> @@ -5730,6 +5776,45 @@ add_option (struct options *options,
> ..
>> +  else if (streq (p[0], "vlan-accept") && p[1])
>> +    {
>> +      VERIFY_PERMISSION (OPT_P_GENERAL);
>> +      if (streq (p[1], "tagged"))
>> +	{
>> +	  options->vlan_accept = VAF_ONLY_VLAN_TAGGED;
>> +	}
>> +      else if (streq (p[1], "untagged"))
>> +	{
>> +	  options->vlan_accept = VAF_ONLY_UNTAGGED_OR_PRIORITY;
>> +	}
>> +      else if (streq (p[1], "all"))
>> +	{
>> +	  options->vlan_accept = VAF_ALL;
>> +	}
>> +      else
>> +	{
>> +	  msg (msglevel, "--vlan-accept must be 'tagged', 'untagged' or 'all'");
>> +	  goto err;
>> +	}
>> +    }
>> +  else if (streq (p[0], "vlan-pvid") && p[1])
>> +    {
>> +      VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_INSTANCE);
>> +      options->vlan_pvid = positive_atoi (p[1]);
>> +      if (options->vlan_pvid < OPENVPN_8021Q_MIN_VID ||
>> +	  options->vlan_pvid > OPENVPN_8021Q_MAX_VID)
>> +	{
>> +	  msg (msglevel, "the parameter of --vlan-pvid parameters must be >= %d and <= %d", OPENVPN_8021Q_MIN_VID, OPENVPN_8021Q_MAX_VID);
>> +	  goto err;
>> +	}
>> +    }
> 
> This indent stuff is really killing me. I find it extremely hard to
> read. :)
> 
> 
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
> 

All these indenting issues seems to be result of mixing tabs and spaces.
 I am not quite sure what is the proper coding standard in regards to
tabs vs spaces.  But I'd lean towards spaces, just to avoid such
discussions like this.

I'll make sure the coding style standard will arrive on a developer meeting!

[...snip...]


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvYBDYACgkQDC186MBRfrrtwgCgp+x1irVY6HqrJwwKW6yOyKF6
xKYAnjZNUMjIagVl7vdNtsvpWg5bS63r
=UtwM
-----END PGP SIGNATURE-----

