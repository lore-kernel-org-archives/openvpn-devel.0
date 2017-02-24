References: <20170224135222.44640-1-gert@...1296...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <6097ac79-1fbf-9b0d-edcf-9057aceb88f4@...1435...>
Date: Fri, 24 Feb 2017 15:42:19 +0100
MIME-Version: 1.0
In-Reply-To: <20170224135222.44640-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix "--dev null"
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

Hi,

On 24-02-17 14:52, Gert Doering wrote:
> To test whether a server is reachable and all the key handling is
> right, openvpn can connect with "--dev null --ifconfig-noexec" to
> avoid needing to the client with elevated privileges.
> 
> This was erroring out for no good reason (because the "set environment
> variables appropriately" code didn't know if this is a tun or tap
> device...) - treat --dev null as "tap", done.
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/tun.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 31585b32..12ce99d5 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -560,7 +560,9 @@ is_tun_p2p(const struct tuntap *tt)
>  {
>      bool tun = false;
>  
> -    if (tt->type == DEV_TYPE_TAP || (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET))
> +    if (tt->type == DEV_TYPE_TAP ||
> +        (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET) ||
> +	tt->type == DEV_TYPE_NULL )
>      {
>          tun = false;
>      }
> 

Code makes sense.  Code-ACK.

Style-wise, we went for pos_arith=lead (Knuth style), so

x = first_condition
      && second_condition
      && third_condition

and this patch is trying to sneak a tab into the code! ;)

I'd be fine with you fixing the style on the fly when applying.

-Steffan

