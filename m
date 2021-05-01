References: <20210422151724.2132573-1-arne@...1227...>
 <20210422151724.2132573-4-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <8f27d116-d286-c593-0ea5-3a837145eab1@...2181...>
Date: Sat, 1 May 2021 16:21:25 +0200
MIME-Version: 1.0
In-Reply-To: <20210422151724.2132573-4-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 4/7] Make waiting on auth an explicit
 state in the context state machine
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

I am not sure what I Am missing, but this patch does not apply on top of
master + 3/7.

Is there another patch that I need to apply first?

Regards,

On 22/04/2021 17:17, Arne Schwabe wrote:
> Previously we relied on checking tls_authentication_status to check
> wether to determine if the context auth state is actually valid or not.
> This patch eliminates that check by introducing waiting on the
> authentication as extra state in the context auth, state machine.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/multi.c      | 6 ------
>  src/openvpn/ssl.c        | 9 ++++++++-
>  src/openvpn/ssl_common.h | 1 +
>  3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index ab2270a58..7cb9e86aa 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2596,12 +2596,6 @@ static const multi_client_connect_handler client_connect_handlers[] = {
>  static void
>  multi_connection_established(struct multi_context *m, struct multi_instance *mi)
>  {
> -    if (tls_authentication_status(mi->context.c2.tls_multi, TLS_MULTI_AUTH_STATUS_INTERVAL)
> -        != TLS_AUTHENTICATION_SUCCEEDED)
> -    {
> -        return;
> -    }
> -
>      /* We are only called for the CAS_PENDING_x states, so we
>       * can ignore other states here */
>      bool from_deferred = (mi->context.c2.tls_multi->multi_state != CAS_PENDING);
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 7d66cf565..4bb395039 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -2809,7 +2809,7 @@ tls_process(struct tls_multi *multi,
>                      if (session->opt->mode == MODE_SERVER)
>                      {
>                          /* On a server we continue with running connect scripts next */
> -                        multi->multi_state = CAS_PENDING;
> +                        multi->multi_state = CAS_WAITING_AUTH;
>                      }
>                      else
>                      {
> @@ -3135,6 +3135,13 @@ tls_multi_process(struct tls_multi *multi,
>  
>      enum tls_auth_status tas = tls_authentication_status(multi, TLS_MULTI_AUTH_STATUS_INTERVAL);
>  
> +    /* If we have successfully authenticated and are still waiting for the authentication to finish
> +     * move the state machine for the multi context forward */
> +    if (multi->multi_state == CAS_WAITING_AUTH && tas == TLS_AUTHENTICATION_SUCCEEDED)
> +    {
> +        multi->multi_state = CAS_PENDING;
> +    }
> +
>      /*
>       * If lame duck session expires, kill it.
>       */
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index 026da3578..01f00950e 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -512,6 +512,7 @@ struct tls_session
>   * connect scripts/plugins */
>  enum multi_status {
>      CAS_NOT_CONNECTED,
> +    CAS_WAITING_AUTH,               /**< TLS connection established but deferred auth not finished */
>      CAS_PENDING,
>      CAS_PENDING_DEFERRED,
>      CAS_PENDING_DEFERRED_PARTIAL,   /**< at least handler succeeded, no result yet*/
> 

-- 
Antonio Quartulli

