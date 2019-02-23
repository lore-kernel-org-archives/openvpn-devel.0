References: <20190201204348.22326-1-openvpn-devel=lists.sourceforge.net@...2493...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <d9d1209d-3689-108f-e406-6f97eb63fa9c@...1856...>
Date: Sat, 23 Feb 2019 14:14:52 +0100
MIME-Version: 1.0
In-Reply-To: <20190201204348.22326-1-openvpn-devel=lists.sourceforge.net@...2493...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Fix documentation of tls-verify script
 argument
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On 01-02-19 21:43, openvpn-devel=lists.sourceforge.net@...2493...
wrote:
> From: Thomas Quinot <quinot@...2492...>
> 
> The second argument is the entire subject DN, not just the CN.
> ---
>  doc/openvpn.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 7abcaf1e..f80393ee 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -5448,7 +5448,7 @@ is executed two arguments are appended after any arguments specified in
>  .B cmd certificate_depth subject
>  
>  These arguments are, respectively, the current certificate depth and
> -the X509 common name (cn) of the peer.
> +the X509 subject distinguished name (dn) of the peer.
>  
>  This feature is useful if the peer you want to trust has a certificate
>  which was signed by a certificate authority who also signed many
> 

This is indeed what we do. Thanks for the fix.

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

