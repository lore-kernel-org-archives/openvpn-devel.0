Message-ID: <b3b64bb7-e1b0-9899-433b-c34c5d7de377@...2181...>
Date: Tue, 10 Jan 2023 14:59:27 +0100
MIME-Version: 1.0
References: <20230109200011.2525342-1-gert@...1296...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20230109200011.2525342-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Reduce logspam about 'dco_update_keys:
 peer_id=-1' in p2p server mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 09/01/2023 21:00, Gert Doering wrote:
> p2p --tls-server with no active client/peer logs once per second
> 
>    "dco_update_keys: peer_id=-1"
> 
> which does exactly nothing, except fill the disk.  So skip the call to
> dco_update_keys() if peer_id == -1.
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>   src/openvpn/forward.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index ae0512fc..2ba8b0fa 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -151,6 +151,12 @@ check_dco_key_status(struct context *c)
>           return;
>       }
>   
> +    /* no active peer (p2p tls-server mode) */
> +    if (c->c2.tls_multi->dco_peer_id == -1 )

Please remove the space after -1 (not sure why uncrustify hasn't caught it).

> +    {
> +        return;
> +    }
> +
>       if (!dco_update_keys(&c->c1.tuntap->dco, c->c2.tls_multi))
>       {
>           /* Something bad happened. Kill the connection to


Rest looks good. Thanks!

Acked-by: Antonio Quartulli <a@...2181...>

However, as discussed on IRC: *why* are we running the check_tls code is 
the peer has gone away and we have switched the peer-id to -1?

This is the real question.

-- 
Antonio Quartulli

