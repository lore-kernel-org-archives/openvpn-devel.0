References: <20181207142003.73175-1-gert@...1296...>
 <20181207202829.76371-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <95c778fb-857d-521c-a3df-7e84bf690889@...2181...>
Date: Thu, 25 Mar 2021 22:09:59 +0100
MIME-Version: 1.0
In-Reply-To: <20181207202829.76371-1-gert@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3] Stop state-exhaustion attacks from a
 single source address.
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 07/12/2018 21:28, Gert Doering wrote:
> If an attacker sends lots of RESET packets from different source
> ports (but the same source address), every packet will create a
> new multi_instance, leading to resource waste on the server, and
> to lots of reply packets while OpenVPN tries to establish a
> TLS handshake.
> 
> This can be rate-limited with "connect-freq", but if this is set
> too tightly, an attacker can drown out legitimate users of the
> same OpenVPN server.
> 
> So, when deciding whether or not to create a new instance, iterate
> over all existing instances, counting all from the same source IP
> (ignoring source port info) that are "in TLS negotiation" state -
> if more than <n> instances are already active, refuse new instance.
> 
> The cutoff parameter can be configured by a newly introduced 3rd
> argument to "connect-freq".  So something like this might be
> reasonable for a medium-sized server:
> 
>    connect-freq 20 20 3
> 
> ("permit 20 new connections per 20 seconds, but only 3 from the same
> source IP address")
> 
> Drawback: if many users are sitting behind a shared NAT ip address
> and they all reconnect at the same time, session setup will take
> longer for some of the users while the server is still handshaking
> with others.
> 
> v1:
>   this is really a "request for discussion" and needs removal of lots
>   of debugging printout.  Also, it needs to be configurable.
> 
> v2:
>   make it configurable
> 
> v3:
>   Swap order of checks - check "per instance dangling limit" before
>   generic "connect-freq" limiter.  Otherwise a really massive flood of
>   incoming RESET packets from a single host will trigger the global
>   "connect-freq" limiter *first*, and thus drown out other sessions
>   (again).
>   Clarify wording of refusal message.
> 

I am undusting this patch in the attempts of pushing it forward.

Like Steffan already said, this patch looks interesting and offers
another layer of protection against DoS attacks.

Like your descriptions says, this is basically an additional knob to
make connect-freq finer grained. For this reason this change is also
fairly contained and is not expected to create side effects on setups
not using this option.

The case of multiple peers behind the same router needing more time to
reconnect is acceptable, imho.


> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/mudp.c    | 108 +++++++++++++++++++++++++++++++++++++++++-
>  src/openvpn/options.c |   6 ++-
>  src/openvpn/options.h |   1 +
>  3 files changed, 113 insertions(+), 2 deletions(-)
> 
> diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
> index a604d217..be8e0fe7 100644
> --- a/src/openvpn/mudp.c
> +++ b/src/openvpn/mudp.c
> @@ -41,6 +41,111 @@
>  #include <sys/inotify.h>
>  #endif
>  
> +/* compare two mroute_addr, ignoring the port info
> + */
> +static inline bool
> +mroute_addr_equal_no_port(const struct mroute_addr *a1,
> +                          const struct mroute_addr *a2)
> +{
> +    if (a1->type != a2->type)
> +    {
> +        return false;
> +    }
> +    if (a1->netbits != a2->netbits)
> +    {
> +        return false;
> +    }
> +    if (a1->len != a2->len)
> +    {
> +        return false;
> +    }
> +    int len = a1->len;
> +    if ( len == 6 || len == 18 )	/* AF_INET or AF_INET6 + Port */
> +    {
> +	len -= 2;
> +    }
> +    return memcmp(a1->raw_addr, a2->raw_addr, len) == 0;
> +}
> +
> +/*
> + * allow no more than <n> instances for the same source IP
> + * in "key state not active yet" state - this is almost always a
> + * state exhaustion and/or reflection attack
> + *
> + * real use cases might hit "multiple instances for the same source IP"
> + * if there are multiple users behind the same NAT gateway - but those
> + * will not be in "ks->state < S_START" for more than a few seconds
> + * (so we might see a few false positives if many users behind the same
> + * NAT gateway restart their VPNs at the same time, but TLS handshake
> + * will succeed for one after another, eventually for all)
> + */
> +
> +
> +bool
> +dangling_instances_per_source_allowed(struct multi_context *m,
> +				      struct mroute_addr *new_source)
> +{
> +    /* nothing configured -> default = allow all */
> +    if ( m->top.options.cf_max_dangling <= 0 )
> +    {
> +	return true;
> +    }
> +
> +    struct gc_arena gc = gc_new();
> +    msg(M_INFO, "MULTI dipsa: new_source=%s (len=%d)",
> +		mroute_addr_print(new_source, &gc), new_source->len );
> +
> +    struct hash_iterator hi;
> +    struct hash_element *he;
> +    int count = 0;
> +
> +    hash_iterator_init(m->iter, &hi);
> +    while ((he = hash_iterator_next(&hi)))
> +    {
> +	struct multi_instance *mi = (struct multi_instance *) he->value;
> +
> +	msg(M_INFO, "MULTI dipsa: instance: halt=%d real=%s",
> +		mi->halt, mroute_addr_print(&mi->real, &gc));
> +	if (!mi->halt && mroute_addr_equal_no_port(new_source, &mi->real))
> +	{
> +	    msg(M_INFO, "MULTI dipsa: ip match found!");
> +
> +	    struct tls_multi * tls_multi = mi->context.c2.tls_multi;
> +
> +	    for (int i=0; i<TM_SIZE; i++ )
> +	    {
> +	        msg(M_INFO, "MULTI dipsa: session[%d].key[KS_PRIMARY].state=%d",
> +		    i, tls_multi->session[i].key[KS_PRIMARY].state );
> +	    }
> +
> +	    /* session not fully established yet?
> +	     * (TM_ACTIVE seems to be the one that goes from "2" to "6"
> +             * after successful handshake, while TM_UNTRUST sticks to "1")
> +             */
> +	    struct tls_session *session = &tls_multi->session[TM_ACTIVE];
> +	    struct key_state *ks = &session->key[KS_PRIMARY];
> +	    if ( ks->state < S_START )

Why S_START? Shouldn't we rather count all sessions < S_ACTIVE?

I am looking at ssl.c:2072, where the state is moved to S_START, and it
seems we still have to perform the CRL check at this point. It seems to
me a bit early to assume the session is valid.

Maybe Arne can confirm or kill my argument.

> +	    {
> +	        msg(M_INFO, "MULTI dipsa: dangling session (ks->state=%d)",
> +			    ks->state );
> +	        count++;
> +	    }
> +	}
> +    }
> +    hash_iterator_free(&hi);
> +
> +    gc_free(&gc);
> +
> +    msg( M_INFO, "MULTI dipsa: count=%d", count );
> +    if ( count >= m->top.options.cf_max_dangling )
> +    {
> +	msg( M_INFO, "MULTI dipsa: maximum number of instances doing TLS handshake for this source IP reached (%d)", count );
> +	return false;
> +    }
> +
> +    return true;
> +}
> +
>  /*
>   * Get a client instance based on real address.  If
>   * the instance doesn't exist, create it while
> @@ -100,7 +205,8 @@ multi_get_create_instance_udp(struct multi_context *m, bool *floated)
>              if (!m->top.c2.tls_auth_standalone
>                  || tls_pre_decrypt_lite(m->top.c2.tls_auth_standalone, &m->top.c2.from, &m->top.c2.buf))
>              {
> -                if (frequency_limit_event_allowed(m->new_connection_limiter))
> +                if (dangling_instances_per_source_allowed(m, &real)
> +                    && frequency_limit_event_allowed(m->new_connection_limiter))

I agree with Steffan that it would be nice to have a different error
message for DIPSA.


Any specific reason why these checks are UDP only?

>                  {
>                      mi = multi_create_instance(m, &real);
>                      if (mi)
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 26f056fc..b8e28df6 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -6644,7 +6644,7 @@ add_option(struct options *options,
>          options->real_hash_size = real;
>          options->virtual_hash_size = real;
>      }
> -    else if (streq(p[0], "connect-freq") && p[1] && p[2] && !p[3])
> +    else if (streq(p[0], "connect-freq") && p[1] && p[2] && !p[4])
>      {
>          int cf_max, cf_per;
>  
> @@ -6658,6 +6658,10 @@ add_option(struct options *options,
>          }
>          options->cf_max = cf_max;
>          options->cf_per = cf_per;
> +	if ( p[3] )
> +	{
> +	    options->cf_max_dangling = atoi(p[3]);
> +	}
>      }
>      else if (streq(p[0], "max-clients") && p[1] && !p[2])
>      {
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index e2b38939..26a78878 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -451,6 +451,7 @@ struct options
>      bool duplicate_cn;
>      int cf_max;
>      int cf_per;
> +    int cf_max_dangling;
>      int max_clients;
>      int max_routes_per_client;
>      int stale_routes_check_interval;
> 


All in all I think this is a non-invasive patch which introduces a nice
additional barrier against DoS.

[Still requires some style polishing]


Regards,

-- 
Antonio Quartulli

