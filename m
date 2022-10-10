Message-ID: <d0c91031-3693-ed91-6e6c-2e52dd8f7d11@...2181...>
Date: Mon, 10 Oct 2022 10:00:37 +0200
MIME-Version: 1.0
References: <20221010071229.7935-1-gert@...1296...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20221010071229.7935-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] TLS: do not lock empty usernames
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

On 10/10/2022 09:12, Gert Doering wrote:
> We do not permit username changes on renegotiation (= username is
> "locked" after successful initial authentication).
> 
> Unfortunately the way this is written this gets in the way of using
> auth-user-pass-optional + pushing "auth-token-user" from client-connect
> (and most likely also "from management") because we'll lock an empty
> username, and on renegotiation, refuse the client with
> 
>     TLS Auth Error: username attempted to change from
>              '' to 'MyTokenUser' -- tunnel disabled
> 
> Fix: extend "is username a valid pointer" to "... and points to a
>       non-empty string" before locking.
> ---
>   src/openvpn/ssl_verify.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index 76cb9f19..4206cf9c 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -166,7 +166,7 @@ tls_lock_username(struct tls_multi *multi, const char *username)
>       }
>       else
>       {
> -        if (username)
> +        if (username && *username)

super uber nitpick (bike shadding level):

I think in other places we perform the very same check using the format: 
username[0] instead of *username.

That's because username is a sequence of chars, therefore it is a bit 
more logical for our brains to "check the first character in the 
sequence" rather than "dereference this pointer".

[or if we want to go the clean way, we should use strlen() == 0, but I 
understand that may be overkill]

my 3 cents.

Cheers,

>           {
>               multi->locked_username = string_alloc(username, NULL);
>           }

-- 
Antonio Quartulli

