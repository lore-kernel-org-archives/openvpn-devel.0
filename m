Message-ID: <61752087-04ba-c571-9ee6-b366adb54c68@...2181...>
Date: Tue, 25 Jan 2022 17:27:14 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220121185752.14138-1-selva.nair@...277...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220121185752.14138-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Do not error when md_kt_size() is
 called with mdname="none"
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
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Hi,

On 21/01/2022 19:57, selva.nair@...277... wrote:
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 35fb0052..b93c680a 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -1073,6 +1073,10 @@ md_kt_name(const char *mdname)
>   unsigned char
>   md_kt_size(const char *mdname)
>   {
> +    if (!strcmp("none", mdname))

Since we have it implemented, can we use streq() here?

Cheers,

-- 
Antonio Quartulli

