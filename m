Message-ID: <a8d3854b-2b7a-44ba-97b8-cdb250b0d0ff@...2181...>
Date: Mon, 11 Nov 2024 14:31:48 +0100
MIME-Version: 1.0
References: <gerrit.1731290343000.I993e7fc5609955d271e74370affc2eea340a1e2d@...2715...>
 <20241111094033.16073-1-gert@...1296...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20241111094033.16073-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v1] Change --reneg-bytes and
 --reneg-packets to 64 bit counters
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
To: openvpn-devel@lists.sourceforge.net



On 11/11/2024 10:40, Gert Doering wrote:
> From: Arne Schwabe <arne@...1227...>
> 
> reneg-bytes can currently only specify up to a maximum of 2GB.
> This makes it even problematic to use without extended counters.
> 
> Change-Id: I993e7fc5609955d271e74370affc2eea340a1e2d
> Signed-off-by: Arne Schwabe <arne@...1227...>
> Acked-by: Gert Doering <gert@...1296...>
> ---
> 
> This change was reviewed on Gerrit and approved by at least one
> developer. I request to merge it to master.
> 
> Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/795
> This mail reflects revision 1 of this Change.
> 
> Acked-by according to Gerrit (reflected above):
> Gert Doering <gert@...1296...>
> 
>          
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 1beb0ee..10ee9f6 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -2032,8 +2032,8 @@
>   
>       SHOW_INT(tls_timeout);
>   
> -    SHOW_INT(renegotiate_bytes);
> -    SHOW_INT(renegotiate_packets);
> +    SHOW_INT64(renegotiate_bytes);
> +    SHOW_INT64(renegotiate_packets);
>       SHOW_INT(renegotiate_seconds);
>   
>       SHOW_INT(handshake_window);
> @@ -9187,12 +9187,26 @@
>       else if (streq(p[0], "reneg-bytes") && p[1] && !p[2])
>       {
>           VERIFY_PERMISSION(OPT_P_TLS_PARMS);
> -        options->renegotiate_bytes = positive_atoi(p[1]);
> +        char *end;
> +        long long reneg_bytes = strtoll(p[1], &end, 10);

why int64_t in options.h and long long here?
I think they should always match in size, but why not use it consistently?

> +        if (*end != '\0' || reneg_bytes < 0)

Shouldn't also check for "reneg_bytes != LLONG_MAX" ? LLONG_MAX is 
returned in case of overflow.

Regards,

> +        {
> +            msg(msglevel, "--reneg-bytes parameter must be an integer and >= 0");
> +            goto err;
> +        }
> +        options->renegotiate_bytes = reneg_bytes;
>       }
>       else if (streq(p[0], "reneg-pkts") && p[1] && !p[2])
>       {
>           VERIFY_PERMISSION(OPT_P_TLS_PARMS);
> -        options->renegotiate_packets = positive_atoi(p[1]);
> +        char *end;
> +        long long pkt_max = strtoll(p[1], &end, 10);
> +        if (*end != '\0' || pkt_max < 0)

same here.

> +        {
> +            msg(msglevel, "--reneg-pkts parameter must be an integer and >= 0");
> +            goto err;
> +        }
> +        options->renegotiate_packets = pkt_max;
>       }
>       else if (streq(p[0], "reneg-sec") && p[1] && !p[3])
>       {
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index ee39dbb..6ab92e2 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -626,8 +626,8 @@
>       int tls_timeout;
>   
>       /* Data channel key renegotiation parameters */
> -    int renegotiate_bytes;
> -    int renegotiate_packets;
> +    int64_t renegotiate_bytes;
> +    int64_t renegotiate_packets;
>       int renegotiate_seconds;
>       int renegotiate_seconds_min;
>   
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index c48a85c..ab55365 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -118,7 +118,7 @@
>    *                      May *not* be NULL.
>    */
>   static void
> -tls_limit_reneg_bytes(const char *ciphername, int *reneg_bytes)
> +tls_limit_reneg_bytes(const char *ciphername, int64_t *reneg_bytes)
>   {
>       if (cipher_kt_insecure(ciphername))
>       {
> @@ -3028,7 +3028,7 @@
>           && should_trigger_renegotiation(session, ks))
>      {
>           msg(D_TLS_DEBUG_LOW, "TLS: soft reset sec=%d/%d bytes=" counter_format
> -            "/%d pkts=" counter_format "/%d",
> +            "/%" PRIi64 " pkts=" counter_format "/%" PRIi64,
>               (int) (now - ks->established), session->opt->renegotiate_seconds,
>               ks->n_bytes, session->opt->renegotiate_bytes,
>               ks->n_packets, session->opt->renegotiate_packets);
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index 5bc2f2a..5840e2d 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -331,8 +331,8 @@
>       int transition_window;
>       int handshake_window;
>       interval_t packet_timeout;
> -    int renegotiate_bytes;
> -    int renegotiate_packets;
> +    int64_t renegotiate_bytes;
> +    int64_t renegotiate_packets;
>       interval_t renegotiate_seconds;
>   
>       /* cert verification parms */
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-- 
Antonio Quartulli


