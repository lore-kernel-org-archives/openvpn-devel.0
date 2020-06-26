References: <20200626142947.12776-1-tincanteksup@...277...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <edef7a28-bbd5-3db5-3229-0d3a525bb577@...277...>
Date: Fri, 26 Jun 2020 15:34:55 +0100
MIME-Version: 1.0
In-Reply-To: <20200626142947.12776-1-tincanteksup@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] New man page corrections -
 encryption-options.rst
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Comment inline:

On 26/06/2020 15:29, Richard Bonhomme wrote:
> Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
> ---
>   doc/man-sections/encryption-options.rst | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/man-sections/encryption-options.rst b/doc/man-sections/encryption-options.rst
> index 42c80eb8..076b5fd3 100644
> --- a/doc/man-sections/encryption-options.rst
> +++ b/doc/man-sections/encryption-options.rst
> @@ -86,5 +86,5 @@ Generating key material
>   
>     * Generating *TLS Crypt v2 Server key*
> -    Generate a ``--tls-crypt-v2`` key tp be used by an OpenVPN server.
> +    Generate a ``--tls-crypt-v2`` key to be used by an OpenVPN server.
>       The key is stored in ``keyfile``.
>   
> @@ -127,7 +127,7 @@ Generating key material
>   
>       *Note:*
> -       This file should be kept secret to the server as anyone that
> -       access to this file will be to generate auth tokens that the OpenVPN
> -       server will accept as valid.
> +       This file should be kept secret to the server as anyone that has

I don't know if this is correct or if it should read:
        This file should be kept secret from the server ..

> +       access to this file will be able to generate auth tokens that the
> +       OpenVPN server will accept as valid.
>   
>   .. include:: renegotiation.rst
> 

