Message-ID: <93a42f95-e8a7-0134-e33f-c9d3ec479abb@...1227...>
Date: Fri, 13 May 2022 10:55:32 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220511121038.1002898-1-heiko@...2662...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220511121038.1002898-1-heiko@...2662...>
Subject: Re: [Openvpn-devel] [PATCH] doc: fix literal block in
 tls-options.rst
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
To: Heiko Hund <heiko@...2662...>, openvpn-devel@lists.sourceforge.net

Am 11.05.22 um 14:10 schrieb Heiko Hund:
> Signed-off-by: Heiko Hund <heiko@...2662...>
> ---
>   doc/man-sections/tls-options.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
> index c06ee335..d51aff77 100644
> --- a/doc/man-sections/tls-options.rst
> +++ b/doc/man-sections/tls-options.rst
> @@ -487,8 +487,8 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
>   
>   --tls-crypt-v2 keyfile
>   
> -  Valid syntax:
> -  ::
> +  Valid syntax::
> +
>        tls-crypt-v2 keyfile
>        tls-crypt-v2 keyfile force-cookie
>        tls-crypt-v2 keyfile allow-noncookie


I don't understand this to be honest. I don't have a good about rst but 
all other instances of Valid syntax use the form like what was before 
the patch, e.g.


   Valid syntax:
   ::

     peer-fingerprint AD:B0:95:D8:09:...


So why exactly does this one need to be different?

Arne


