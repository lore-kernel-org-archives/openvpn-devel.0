References: <20210417100544.5497-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <dd2f4249-6980-f4f7-ecdb-2b412131a9ea@...2181...>
Date: Sat, 17 Apr 2021 14:00:57 +0200
MIME-Version: 1.0
In-Reply-To: <20210417100544.5497-1-gert@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Repair --secret depreciation warning.
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 17/04/2021 12:05, Gert Doering wrote:
> commit 60f5889ae formally depreciated use of configs without either

depreciated -> deprecated (no?)

> "tls-client" or "tls-server" - but got the booleans wrong.
> 
> Fix.
> 
> Signed-off-by: Gert Doering <gert@...1296...>

Makes sense.
The warning should be displayed when both options are not specified.

With the current logic the warning pops up all the time, except when
both options are specified (not sure this is even allowed..). And
clearly not what we wanted :-)


Acked-by: Antonio Quartulli <antonio@...2609...>

> ---
>  src/openvpn/options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 3dd22d52..ef854c76 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -2541,7 +2541,7 @@ options_postprocess_verify_ce(const struct options *options,
>          msg(M_USAGE, "specify only one of --tls-server, --tls-client, or --secret");
>      }
>  
> -    if (!options->tls_server || !options->tls_client)
> +    if (!options->tls_server && !options->tls_client)
>      {
>          msg(M_INFO, "DEPRECATION: No tls-client or tls-server option in "
>                      "configuration detected. OpenVPN 2.7 will remove the "
> 

-- 
Antonio Quartulli

