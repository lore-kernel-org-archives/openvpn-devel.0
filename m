Message-ID: <3b2bf322-66d5-5aad-9801-2d56678f0cbb@...2181...>
Date: Fri, 7 Jan 2022 13:46:58 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220107123550.188-1-lstipakov@...277...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220107123550.188-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] auth_token.c: add NULL initialization
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
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>

Hi,

On 07/01/2022 13:35, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
> 
> This fixes
> 
>    error C4703: potentially uninitialized local pointer variable 'b64output' used
> 
> found by arm64 msvc compiler with SDL enabled.
> 
> Not sure why this is not triggered on x86/x64.
> 
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>   src/openvpn/auth_token.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
> index e8875464..ceae68f6 100644
> --- a/src/openvpn/auth_token.c
> +++ b/src/openvpn/auth_token.c
> @@ -259,7 +259,7 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
>       ASSERT(buf_write(&token, &timestamp, sizeof(timestamp)));
>       ASSERT(buf_write(&token, hmac_output, sizeof(hmac_output)));
>   
> -    char *b64output;
> +    char *b64output = NULL;
>       openvpn_base64_encode(BPTR(&token), BLEN(&token), &b64output);

It's impossible to leave b64output uninitialized, but the compiler is 
probably not smart enough to understand it.

On the other hand, passing uninitialized variables by reference to a 
function (without checking its return value) and using them later is 
never a good pattern..

Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

