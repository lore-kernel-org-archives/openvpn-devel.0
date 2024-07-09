Date: Tue, 9 Jul 2024 14:39:39 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Zo0vi+lxtkZDmk8H@...2685...>
References: <20240708210912.566-1-chipitsine@...277...>
 <20240708210912.566-3-chipitsine@...277...>
MIME-Version: 1.0
In-Reply-To: <20240708210912.566-3-chipitsine@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/5]
 sample/sample-plugins/defer/multi-auth.c: handle strdup errors
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Ilia Shipitsin <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Jul 08, 2024 at 11:08:19PM +0200, Ilia Shipitsin wrote:
> Signed-off-by: Ilia Shipitsin <chipitsine@...277...>
> ---
>  sample/sample-plugins/defer/multi-auth.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/sample/sample-plugins/defer/multi-auth.c b/sample/sample-plugins/defer/multi-auth.c
> index 2c482799..109fa40c 100644
> --- a/sample/sample-plugins/defer/multi-auth.c
> +++ b/sample/sample-plugins/defer/multi-auth.c
> @@ -206,9 +206,24 @@ openvpn_plugin_open_v3(const int v3structver,
>      if ((args->argv[4]) && !args->argv[5])
>      {
>          context->authid = strdup(args->argv[1]);
> +        if (!context->authid)
> +        {
> +            plog(context, PLOG_ERR, "Out of memory");
> +            goto error;
> +        }
>          context->test_deferred_auth = atoi_null0(args->argv[2]);
>          context->test_valid_user = strdup(args->argv[3]);
> +        if (!context->test_valid_user)
> +        {
> +            plog(context, PLOG_ERR, "Out of memory");
> +            goto error;
> +        }
>          context->test_valid_pass = strdup(args->argv[4]);
> +        if (!context->test_valid_pass)
> +        {
> +            plog(context, PLOG_ERR, "Out of memory");
> +            goto error;
> +        }
>      }
>      else
>      {

A bit ugly. Might be nicer to combine the error handling into one if check,
instead of doing separate ones for each call. But OTOH no need to overengineer
sample code. So

Acked-by: Frank Lichtenheld <frank@...2641...>

Regards,
-- 
  Frank Lichtenheld

