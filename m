Message-ID: <4D9433D0.9090508@...1147...>
Date: Thu, 31 Mar 2011 09:57:04 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1301487818-4450-1-git-send-email-davids@...1347...>
In-Reply-To: <1301487818-4450-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Fix the --client-cert-not-required
	feature
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

Hi David,

David Sommerseth wrote:
> Commit 2e8337de248ef0b5b48cbb2964da0d5c3f28b15b introduced a new
> feature for using other SSL certificate fields for authentication
> than then CN field.
>
> This commit introduced a bug, which made the verify_callback()
> function getting called even if --client-cert-not-required was
> enabled in the config.
>
> The reason for this was that an 'else' statement was lacking a
> couple of curly braces.  The offending commit in reality moved
> the setup the verify_callback() function out of the 'else'
> statement.
>
> Report-URL: https://community.openvpn.net/openvpn/ticket/108
> Report-URL: https://forums.openvpn.net/topic7751.html
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
>  ssl.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/ssl.c b/ssl.c
> index ed10714..6d9a9fd 100644
> --- a/ssl.c
> +++ b/ssl.c
> @@ -1874,13 +1874,15 @@ init_ssl (const struct options *options)
>      }
>    else
>  #endif
> +    {
>  #ifdef ENABLE_X509ALTUSERNAME
> -  x509_username_field = (char *) options->x509_username_field;
> +      x509_username_field = (char *) options->x509_username_field;
>  #else
> -  x509_username_field = X509_USERNAME_FIELD_DEFAULT;
> +      x509_username_field = X509_USERNAME_FIELD_DEFAULT;
>  #endif
> -  SSL_CTX_set_verify (ctx, SSL_VERIFY_PEER | SSL_VERIFY_FAIL_IF_NO_PEER_CERT,
> -			verify_callback);
> +      SSL_CTX_set_verify (ctx, SSL_VERIFY_PEER | SSL_VERIFY_FAIL_IF_NO_PEER_CERT,
> +                          verify_callback);
> +    }
>  
>    /* Connection information callback */
>    SSL_CTX_set_info_callback (ctx, info_callback);
>   
weird, but with your patch I get a completely different error:

Thu Mar 31 09:55:01 2011 us=368010 194.171.96.28:44859 Could not create 
temporary file 'openvpn_acf_ab60cdb4d9d6bdf5d3c7812ea9710705.tmp': 
Permission denied
Thu Mar 31 09:55:01 2011 us=368145 194.171.96.28:44859 Exiting


if I run it with '--tmp-dir /tmp' it works again - looks like this patch 
triggers another bug?

cheers,

JJK


