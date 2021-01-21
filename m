References: <20200930131317.1299-1-arne@...1227...>
 <20200930131317.1299-12-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <e94aa323-bfe7-85f2-c224-778148dcbf43@...2080...>
Date: Thu, 21 Jan 2021 18:29:54 +0100
MIME-Version: 1.0
In-Reply-To: <20200930131317.1299-12-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 10/11] Implement --client-crresponse
 script options and plugin interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 30/09/2020 15:13, Arne Schwabe wrote:
> This is allows scripts and pluginsto parse/react to a
> CR_RESPONSE message
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   Changes.rst                         |  7 ++++
>   doc/man-sections/script-options.rst | 28 ++++++++++++-
>   include/openvpn-plugin.h.in         |  7 +++-
>   src/openvpn/init.c                  |  1 +
>   src/openvpn/options.c               | 15 +++++++
>   src/openvpn/options.h               |  1 +
>   src/openvpn/push.c                  |  4 ++
>   src/openvpn/ssl_common.h            |  1 +
>   src/openvpn/ssl_verify.c            | 63 +++++++++++++++++++++++++++++
>   src/openvpn/ssl_verify.h            | 23 +++++++++++
>   10 files changed, 147 insertions(+), 3 deletions(-)
> 

Only glared at the code here too.

[...snip...]

> diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
> index e0cc10c2..66bf3662 100644
> --- a/doc/man-sections/script-options.rst
> +++ b/doc/man-sections/script-options.rst
[...snip...]
@@ -123,6 +128,25 @@ SCRIPT HOOKS
    For a sample script that performs PAM authentication, see
    :code:`sample-scripts/auth-pam.pl` in the OpenVPN source distribution.

+--client-crresponse
+    Executed when the client sends a text based challenge response.
+
+    Valid syntax:
+    ::
+
+        client-crresponse cmd method
+

[...snip...]

> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 3df803db..703927da 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
[...snip...]
> @@ -7070,6 +7075,16 @@ add_option(struct options *options,
>           set_user_script(options, &options->client_connect_script,
>                           p[1], "client-connect", true);
>       }
> +    else if (streq(p[0], "client-crresponse") && p[1])
> +    {
> +        VERIFY_PERMISSION(OPT_P_SCRIPT);
> +        if (!no_more_than_n_args(msglevel, p, 2, NM_QUOTE_HINT))
> +        {
> +            goto err;
> +        }
> +        set_user_script(options, &options->client_crresponse_script,
> +                        p[1], "client-crresponse", true);
> +    }

Either the doc is wrong, or the option parser is lacking parsing of 
"method".

[...snip...]

> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 877e9396..a63a1967 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -440,6 +440,7 @@ struct options
>       const char *client_connect_script;
>       const char *client_disconnect_script;
>       const char *learn_address_script;
> +    const char *client_crresponse_script;

Indentation.

[...snip...]
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 58e20baa..e5c92e17 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -227,6 +227,10 @@ receive_cr_response(struct context *c, const struct buffer *buffer)
>   
>   
>       management_notify_client_cr_response(key_id, mda, es, m);
> +#endif
> +#if ENABLE_PLUGIN
> +    verify_crresponse_plugin(c->c2.tls_multi, m);
> +    verify_crresponse_script(c->c2.tls_multi, m);

Any reason the script feature is insdie the ENABLE_PLUGIN fence?

[...snip...]
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index 98afc88c..87877c88 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -314,6 +314,7 @@ struct tls_options
>   
>       /* used for username/password authentication */
>       const char *auth_user_pass_verify_script;
> +    const char *client_crresponse_script;

Indentation.

I've not looked that carefully at the rest of the code, as I would like 
to test those code paths when completing the review.  It looks 
reasonable though at a first glance, but might be I stumble across 
something during testing.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


