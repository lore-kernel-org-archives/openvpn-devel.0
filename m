Date: Thu, 19 May 2022 10:09:26 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <71344563.18026.1652947766056@...2642...>
In-Reply-To: <37447096.1137104.1652870422256@...2642...>
References: <20220518093212.2802495-1-arne@...1227...>
 <20220518093212.2802495-3-arne@...1227...>
 <37447096.1137104.1652870422256@...2642...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 2/4] Cleanup receive_auth_failed and
 simplify method
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net


> Frank Lichtenheld <frank@...2641...> hat am 18.05.2022 12:40 geschrieben:
[...]
> So something like this on top of this patch:

Somehow managed to double paste the patch. They seem to be identical, so simply
ignore either one ;)

> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index be118831..6b8bc0e1 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -104,19 +104,15 @@ receive_auth_failed(struct context *c, const struct buffer *buffer)
>          }
>          management_auth_failure(management, UP_TYPE_AUTH, reason);
>      }
> -#endif
>      /*
>       * Save the dynamic-challenge text even when management is defined
>       */
> +    if (authfail_extended
> +        && buf_string_match_head_str(&buf, "CRV1:") && BLEN(&buf))
>      {
> -#ifdef ENABLE_MANAGEMENT
> -        if (authfail_extended
> -            && buf_string_match_head_str(&buf, "CRV1:") && BLEN(&buf))
> -        {
> -            ssl_put_auth_challenge(BSTR(&buf));
> -        }
> -#endif
> +        ssl_put_auth_challenge(BSTR(&buf));
>      }
> +#endif
>  }
> 
>  /*
> flichtenheld@...2673...:~/openvpn/community/openvpn (master *)$ git --no-pager diff
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index be118831..6b8bc0e1 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -104,19 +104,15 @@ receive_auth_failed(struct context *c, const struct buffer *buffer)
>          }
>          management_auth_failure(management, UP_TYPE_AUTH, reason);
>      }
> -#endif
>      /*
>       * Save the dynamic-challenge text even when management is defined
>       */
> +    if (authfail_extended
> +        && buf_string_match_head_str(&buf, "CRV1:") && BLEN(&buf))
>      {
> -#ifdef ENABLE_MANAGEMENT
> -        if (authfail_extended
> -            && buf_string_match_head_str(&buf, "CRV1:") && BLEN(&buf))
> -        {
> -            ssl_put_auth_challenge(BSTR(&buf));
> -        }
> -#endif
> +        ssl_put_auth_challenge(BSTR(&buf));
>      }
> +#endif
>  }
> 
>  /*

--
Frank Lichtenheld

