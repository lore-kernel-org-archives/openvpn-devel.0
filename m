References: <20210331155508.19423-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <fb104e93-0c52-239f-b80e-020626be116c@...2181...>
Date: Wed, 31 Mar 2021 23:19:27 +0200
MIME-Version: 1.0
In-Reply-To: <20210331155508.19423-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Fix binary and used instead auth-token
 check instead of logical and
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

I would reword the commit subject, because the way it is now fails to
highlight that we are talking about a bitwise-and operator (&).

On 31/03/2021 17:55, Arne Schwabe wrote:
> AUTH_TOKEN_HMAC_OK is 1, so the first term is always 0/1 and the bool
> from the second part is also 0/1, so the & does the same in this instance
> as &&.
> 
> In this specific case & instead && does not change behaviour but using
> && is the intended semantic behaviour.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/auth_token.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
> index cc70c06c3..d571b686e 100644
> --- a/src/openvpn/auth_token.c
> +++ b/src/openvpn/auth_token.c
> @@ -99,7 +99,7 @@ add_session_token_env(struct tls_session *session, struct tls_multi *multi,
>      /* We had a valid session id before */
>      const char *session_id_source;
>      if (multi->auth_token_state_flags & AUTH_TOKEN_HMAC_OK
> -        &!(multi->auth_token_state_flags & AUTH_TOKEN_EXPIRED))
> +        && !(multi->auth_token_state_flags & AUTH_TOKEN_EXPIRED))
>      {
>          session_id_source = up->password;
>      }
> 

Compile-tested and I stared at the change long enough that I can feel
confident it does not change any functional behaviour.

The commit subject did not pass the compile test :) therefore I Will
wait for a new revision before leaving my ACK.

Cheers,

-- 
Antonio Quartulli

