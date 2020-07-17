References: <20200716134315.17742-1-arne@...1227...>
 <20200716134315.17742-2-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <d944d13a-3464-aee4-ceaf-5f03a59f6400@...2181...>
Date: Fri, 17 Jul 2020 16:00:21 +0200
MIME-Version: 1.0
In-Reply-To: <20200716134315.17742-2-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v7 2/6] client-connect: Add deferred
 support to the client-connect script handler
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



On 16/07/2020 15:43, Arne Schwabe wrote:
> From: Fabian Knittel <fabian.knittel@...1547...>
> 
> This patch introduces the concept of a return value file for the client-connect
> handlers. (This is very similar to the auth value file used during deferred
> authentication.)  The file name is stored in the client_connect_state struct.
> 
> In addition, the patch also allows the storage of the client config file name
> in struct client_connect_state.
> 
> Both changes are used by the client-connect script handler to support deferred
> client-connection handling.  The deferred return value file (deferred_ret_file)
> is passed to the actual script via the environment.  If the script succeeds and
> writes the value for deferral into the deferred_ret_file, the handler knows to
> indicate deferral.  Later on, the deferred handler checks whether the value of
> the deferred_ret_file has been updated to success or failure.
> 
> Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/multi.c | 226 +++++++++++++++++++++++++++++++++++++++++---
>  src/openvpn/multi.h |  12 +++
>  2 files changed, 225 insertions(+), 13 deletions(-)
> 
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 9128798d..e26daeea 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -1854,6 +1854,168 @@ multi_client_set_protocol_options(struct context *c)
>      }
>  }
>  
> +/**
> + * Delete the temporary file for the return value of client connect
> + * It also removes it from it from client_connect_defer_state and
> + * environment
> + */
> +static void
> +ccs_delete_deferred_ret_file(struct multi_instance *mi)
> +{
> +    struct client_connect_defer_state *ccs = &(mi->client_connect_defer_state);
> +    if (ccs->deferred_ret_file)
> +    {
> +        setenv_del(mi->context.c2.es, "client_connect_deferred_file");
> +        if (!platform_unlink(ccs->deferred_ret_file))
> +        {
> +            msg(D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
> +                ccs->deferred_ret_file);
> +        }
> +        free(ccs->deferred_ret_file);
> +        ccs->deferred_ret_file = NULL;
> +    }

As discussed on IRC, previous patches (already applied) changed the
style of many of our functions from:


if (x)
{
 do something
}



to:



if (!x)
{
  return
}


Now this patch is unfortunately introducing a set of functions all
implemented using the old pattern.

I suggest them to be converted before we merge this patch.

I don't really have other comments about this patch, therefore it may go
in once we get the code style right.


Regards,

-- 
Antonio Quartulli

