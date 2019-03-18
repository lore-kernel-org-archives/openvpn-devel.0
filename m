References: <1552943809-6367-1-git-send-email-selva.nair@...277...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <5a54b7c9-d466-c8c2-e468-42c16c88d1dd@...277...>
Date: Mon, 18 Mar 2019 21:30:36 +0000
MIME-Version: 1.0
In-Reply-To: <1552943809-6367-1-git-send-email-selva.nair@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Improve the documentation for
 --dhcp-option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

this situation has been hanging around for so long is this brief note
really enough? Considering that the manual has numerous other URLs why
not include this URL here:
https://community.openvpn.net/openvpn/wiki/Pushing-DNS-to-clients

We already have this:
https://community.openvpn.net/openvpn/wiki/SWEET32

Please consider adding it.
Thanks
tct


On 18/03/2019 21:16, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> Make clear that --dhcp-option is not processed on
> non-Windows clients and the user is expected to handle
> it using an --up script.
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>   doc/openvpn.8 | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index ce44044..993c8bd 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -6026,13 +6026,21 @@ scope IDs. The Scope ID becomes a part of the NetBIOS name, making the name uniq
>   .B DISABLE\-NBT \-\-
>   Disable Netbios\-over\-TCP/IP.
>   
> -Note that if
> +Note that
> +.B \-\-dhcp\-option
> +is processed only on Windows clients. If
>   .B \-\-dhcp\-option
> -is pushed via
> +is used directly on or pushed via
>   .B \-\-push
> -to a non\-windows client, the option will be saved in the client's
> -environment before the up script is called, under
> -the name "foreign_option_{n}".
> +to a non\-windows client, the option is
> +.B only
> +saved in the client's
> +environment before the
> +.B \-\-up
> +script is called, under the name "foreign_option_{n}".
> +The user has to arrange an
> +.B \-\-up
> +script to pick up those parameters and act on them as required.
>   .\"*********************************************************
>   .TP
>   .B \-\-tap\-sleep n
> 

