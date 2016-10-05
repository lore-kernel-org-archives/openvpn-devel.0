References: <2ad2231f-9e17-7709-b488-5ee201200f68@...1856...>
	<1475610786-25781-1-git-send-email-lstipakov@...277...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <9b16d76d-1a90-403a-146a-cea93dcb38ce@...1435...>
Date: Wed, 5 Oct 2016 14:27:18 +0200
MIME-Version: 1.0
In-Reply-To: <1475610786-25781-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2 2.3] Exclude peer-id from pulled
 options digest
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 04-10-16 21:53, Lev Stipakov wrote:
> v2:
>  - Use md5_* methods
>  - Move digest update to separate method
> 
> Peer-id might change on restart and this should not trigger reopening
> tun.
> 
> Trac #649
> ---
>  src/openvpn/push.c | 43 +++++++++++++++++++++++++++++--------------
>  1 file changed, 29 insertions(+), 14 deletions(-)
> 
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 71f39c1..402c158 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -407,6 +407,20 @@ push_reset (struct options *o)
>  }
>  #endif
>  
> +static void
> +push_update_digest(struct md5_state *ctx, struct buffer *buf)
> +{
> +  char line[OPTION_PARM_SIZE];
> +  while (buf_parse (buf, ',', line, sizeof (line)))
> +    {
> +      /* peer-id might change on restart and this should not trigger reopening tun */
> +      if (strstr (line, "peer-id ") != line)
> +	{
> +	  md5_state_update (ctx, line, strlen(line));
> +	}
> +    }
> +}
> +
>  int
>  process_incoming_push_msg (struct context *c,
>  			   const struct buffer *buffer,
> @@ -473,20 +487,21 @@ process_incoming_push_msg (struct context *c,
>  				  permission_mask,
>  				  option_types_found,
>  				  c->c2.es))
> -	    switch (c->options.push_continuation)
> -	      {
> -	      case 0:
> -	      case 1:
> -		md5_state_update (&c->c2.pulled_options_state, BPTR(&buf_orig), BLEN(&buf_orig));
> -		md5_state_final (&c->c2.pulled_options_state, &c->c2.pulled_options_digest);
> -	        c->c2.pulled_options_md5_init_done = false;
> -		ret = PUSH_MSG_REPLY;
> -		break;
> -	      case 2:
> -		md5_state_update (&c->c2.pulled_options_state, BPTR(&buf_orig), BLEN(&buf_orig));
> -		ret = PUSH_MSG_CONTINUATION;
> -		break;
> -	      }
> +	    {
> +	      push_update_digest (&c->c2.pulled_options_state, &buf_orig);
> +	      switch (c->options.push_continuation)
> +		{
> +		  case 0:
> +		  case 1:
> +		    md5_state_final (&c->c2.pulled_options_state, &c->c2.pulled_options_digest);
> +		    c->c2.pulled_options_md5_init_done = false;
> +		    ret = PUSH_MSG_REPLY;
> +		    break;
> +		  case 2:
> +		    ret = PUSH_MSG_CONTINUATION;
> +		    break;
> +		}
> +	    }
>  	}
>        else if (ch == '\0')
>  	{
> 

Looks good now.  ACK.

-Steffan

