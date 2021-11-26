Message-ID: <d2c11a34-bb5a-34f5-76a4-cc4be325d17b@...2181...>
Date: Fri, 26 Nov 2021 15:48:20 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20211126144331.2400062-1-tincantech@...2282...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20211126144331.2400062-1-tincantech@...2282...>
Subject: Re: [Openvpn-devel] [PATCH] Doc openvpn.8: Add deprecation notice
 to --compress
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
To: Richard T Bonhomme <stringvest88@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

On 26/11/2021 15:43, Richard T Bonhomme wrote:
> Signed-off-by: Richard T Bonhomme <tincantech@...2282...>
> ---
>   doc/openvpn.8 | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 598d5fce..dfe0ad10 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -2501,6 +2501,7 @@ limit repetitive logging of similar message types.
>   .\"*********************************************************
>   .TP
>   .B \-\-compress [algorithm]
> +.B DEPRECATED
>   Enable a compression algorithm.
>   
>   The

We already have this. Against what branch did you create this patch?

Cheers,

-- 
Antonio Quartulli

