References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-7-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <b664c8cc-7126-48eb-fcc8-55097eab4ae1@...2181...>
Date: Tue, 14 Jul 2020 13:58:37 +0200
MIME-Version: 1.0
In-Reply-To: <20200711093655.23686-7-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v5 07/14] client-connect: Change
 cas_context from int to enum
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 11/07/2020 11:36, Arne Schwabe wrote:
> This deviates from Fabian's original patch that relied on the now
> removed connection_established bool as pointer being NULL or non NULL as
> implicit third state and makeing connection_established as a substate of
> (cas_context == CAS_PENDING)
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> 
> Patch V5: extend cas_context with two new states instead adding an
>           extra mini state machine.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/multi.c   |  2 +-
>  src/openvpn/multi.h   |  1 +
>  src/openvpn/openvpn.h | 24 +++++++++++++++++-------
>  3 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 83848fdc..f9b8af80 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2163,7 +2163,7 @@ multi_client_connect_early_setup(struct multi_context *m,
>   * Try to source a dynamic config file from the
>   * --client-config-dir directory.
>   */
> -enum client_connect_return
> +static enum client_connect_return

I don't think this change belongs to this patch .... ?

>  multi_client_connect_source_ccd(struct multi_context *m,
>                                  struct multi_instance *mi,
>                                  unsigned int *option_types_found)
> diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
> index 4fb4d0b6..1d30dcc6 100644
> --- a/src/openvpn/multi.h
> +++ b/src/openvpn/multi.h
> @@ -62,6 +62,7 @@ struct deferred_signal_schedule_entry
>      struct timeval wakeup;
>  };
>  
> +
>  /**
>   * Server-mode state structure for one single VPN tunnel.
>   *
> diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
> index a1308852..7c469b01 100644
> --- a/src/openvpn/openvpn.h
> +++ b/src/openvpn/openvpn.h
> @@ -210,6 +210,21 @@ struct context_1
>  #endif
>  };
>  
> +
> +/* client authentication state, CAS_SUCCEEDED must be 0 since
> + * non multi code path still checks this variable but does not initialise it
> + * so the code depends on zero initialisation */
> +enum client_connect_status {
> +    CAS_SUCCEEDED=0,

Please add spaces around '='

> +    CAS_PENDING,
> +    CAS_FAILED,
> +    CAS_PARTIAL,        /**< Variant of CAS_FAILED: at least one
> +                         * client-connect script/plugin succeeded
> +                         * while a later one in the chain failed
> +                         * (we still need cleanup compared to FAILED)
> +                         */
> +};
> +
>  /**
>   * Level 2 %context containing state that is reset on both \c SIGHUP and
>   * \c SIGUSR1 restarts.
> @@ -444,13 +459,8 @@ struct context_2
>      int push_ifconfig_ipv6_netbits;
>      struct in6_addr push_ifconfig_ipv6_remote;
>  
> -    /* client authentication state, CAS_SUCCEEDED must be 0 */
> -#define CAS_SUCCEEDED 0
> -#define CAS_PENDING   1
> -#define CAS_FAILED    2
> -#define CAS_PARTIAL   3  /* at least one client-connect script/plugin
> -                          * succeeded while a later one in the chain failed */
> -    int context_auth;
> +
> +    enum client_connect_status context_auth;
>  
>      struct event_timeout push_request_interval;
>      int n_sent_push_requests;
> 


The rest looks good and makes sense. Using enum is always better as the
compiler (and the reader) has extra information about how a variable can
be used.

I believe the first chunk with the +static should be moved somewhere
else...but other than that and the missing-spaces comment:

Acked-by: Antonio Quartulli <antonio@...515...>

-- 
Antonio Quartulli

