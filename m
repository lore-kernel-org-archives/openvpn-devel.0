MIME-Version: 1.0
In-Reply-To: <1481804534-26913-1-git-send-email-davids@...515...>
References: <1481728374-7196-1-git-send-email-davids@...515...>
	<1481804534-26913-1-git-send-email-davids@...515...>
From: Steffan Karger <steffan@...1856...>
Date: Thu, 15 Dec 2016 22:52:51 +0100
Message-ID: <CAA1Abx+LM1Z5O3wVwZ=i1cRqdbHr_KL8Hpg4GmAbdjgyfUs8bw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] auth-gen-token: Hardening memory
 cleanup on auth-token failuers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 15 December 2016 at 13:22, David Sommerseth <davids@...515...> wrote:
> Further improve the memory management when a clients --auth-token
> fails the server side token authentication enabled via --auth-gen-token.
>
> v2 - Add ASSERT() if base64 encoding of token fails

This will need rebasing because of the reformatting.

> @@ -1255,24 +1269,11 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
>           /* The token should be longer than the input when
>             * being base64 encoded
>             */
> -         if( openvpn_base64_encode(tok, AUTH_TOKEN_SIZE,
> -                                    &multi->auth_token) < AUTH_TOKEN_SIZE)
> -           {
> -             msg(D_TLS_ERRORS, "BASE64 encoding of token failed. "
> -                  "No auth-token will be activated now");
> [...]
> +          ASSERT(openvpn_base64_encode(tok, AUTH_TOKEN_SIZE,
> +                                       &multi->auth_token) < AUTH_TOKEN_SIZE);

Uhm, I think the < should be a > now?

-Steffan

