References: <20170827161515.2424-1-gert@...2298...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <221c483d-ee17-9da0-bcc8-684fb5e2fb89@...1435...>
Date: Mon, 28 Aug 2017 13:06:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170827161515.2424-1-gert@...2298...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Warn that DH config option is only
 meaningful in a tls-server context
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 27-08-17 18:15, Gert van Dijk wrote:
> If specified in a tls-client context, don't try to open the file as it's
> not used. Worse even, if 'none' was specified to disable explicitly, it
> complained that the file 'none' could not be found.
> ---
>  src/openvpn/options.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 1bbda027..536d6f3f 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3011,6 +3011,13 @@ options_postprocess_mutate(struct options *o)
>              o->dh_file = NULL;
>          }
>      }
> +    else if (o->dh_file)
> +    {
> +        /* DH file is only meaningful in a tls-server context. */
> +        msg(M_WARN, "ignoring option 'dh' in tls-client mode, please only "
> +                    "include this in your server configuration");
> +        o->dh_file = NULL;
> +    }
>  
>      /* cipher negotiation (NCP) currently assumes --pull or --mode server */
>      if (o->ncp_enabled
> 

ACK.  Ideally, we would have never excepted the --dh option for clients.
 But since we for some reason did, I agree that warning and explicitly
ignoring the option is the best approach (because it will not break
existing client configs that do have the --dh option in there).

But: Gert is a colleague of mine at Fox-IT, so it would be good to have
some non-fox eyes look at this patch too.

-Steffan

