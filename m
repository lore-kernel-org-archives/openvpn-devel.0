Date: Wed, 18 May 2022 12:40:22 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <37447096.1137104.1652870422256@...2642...>
In-Reply-To: <20220518093212.2802495-3-arne@...1227...>
References: <20220518093212.2802495-1-arne@...1227...>
 <20220518093212.2802495-3-arne@...1227...>
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

Patch looks reasonable when looking at it with -w.

But I have some suggestions to further simplify the function. See below.

> Arne Schwabe <arne@...1227...> hat am 18.05.2022 11:32 geschrieben:
> This simplifies the buffer handling in the method and adds a quick
> return instead of wrapping the whole method in a if (pull) block
> ---
>  src/openvpn/push.c | 96 ++++++++++++++++++++++++----------------------
>  1 file changed, 51 insertions(+), 45 deletions(-)
> 
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 51b8bd521..be118831d 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
[...]
>  #ifdef ENABLE_MANAGEMENT
> -        if (management)
> +    if (management)
> +    {
> +        const char *reason = NULL;
> +        if (authfail_extended && BLEN(&buf))
>          {
> -            const char *reason = NULL;
> -            struct buffer buf = *buffer;
> -            if (buf_string_compare_advance(&buf, "AUTH_FAILED,") && BLEN(&buf))
> -            {
> -                reason = BSTR(&buf);
> -            }
> -            management_auth_failure(management, UP_TYPE_AUTH, reason);
> +            reason = BSTR(&buf);
>          }
> +        management_auth_failure(management, UP_TYPE_AUTH, reason);
> +    }
>  #endif
> -        /*
> -         * Save the dynamic-challenge text even when management is defined
> -         */
> -        {
> +    /*
> +     * Save the dynamic-challenge text even when management is defined
> +     */
> +    {

This additional block has no meaning now that you don't define a variable anymore.

>  #ifdef ENABLE_MANAGEMENT

This ifdef can be merged with the previous ifdef to further simplify the function.

> -            struct buffer buf = *buffer;
> -            if (buf_string_match_head_str(&buf, "AUTH_FAILED,CRV1:") && BLEN(&buf))
> -            {
> -                buf_advance(&buf, 12); /* Length of "AUTH_FAILED," substring */
> -                ssl_put_auth_challenge(BSTR(&buf));
> -            }
> -#endif
> +        if (authfail_extended
> +            && buf_string_match_head_str(&buf, "CRV1:") && BLEN(&buf))
> +        {
> +            ssl_put_auth_challenge(BSTR(&buf));
>          }
> +#endif
>      }
>  }

So something like this on top of this patch:
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index be118831..6b8bc0e1 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -104,19 +104,15 @@ receive_auth_failed(struct context *c, const struct buffer *buffer)
         }
         management_auth_failure(management, UP_TYPE_AUTH, reason);
     }
-#endif
     /*
      * Save the dynamic-challenge text even when management is defined
      */
+    if (authfail_extended
+        && buf_string_match_head_str(&buf, "CRV1:") && BLEN(&buf))
     {
-#ifdef ENABLE_MANAGEMENT
-        if (authfail_extended
-            && buf_string_match_head_str(&buf, "CRV1:") && BLEN(&buf))
-        {
-            ssl_put_auth_challenge(BSTR(&buf));
-        }
-#endif
+        ssl_put_auth_challenge(BSTR(&buf));
     }
+#endif
 }

 /*
flichtenheld@...2673...:~/openvpn/community/openvpn (master *)$ git --no-pager diff
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index be118831..6b8bc0e1 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -104,19 +104,15 @@ receive_auth_failed(struct context *c, const struct buffer *buffer)
         }
         management_auth_failure(management, UP_TYPE_AUTH, reason);
     }
-#endif
     /*
      * Save the dynamic-challenge text even when management is defined
      */
+    if (authfail_extended
+        && buf_string_match_head_str(&buf, "CRV1:") && BLEN(&buf))
     {
-#ifdef ENABLE_MANAGEMENT
-        if (authfail_extended
-            && buf_string_match_head_str(&buf, "CRV1:") && BLEN(&buf))
-        {
-            ssl_put_auth_challenge(BSTR(&buf));
-        }
-#endif
+        ssl_put_auth_challenge(BSTR(&buf));
     }
+#endif
 }

 /*

Regards,
--
Frank Lichtenheld

