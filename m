References: <20190122150333.1061-1-arne@...1227...>
 <20190122150333.1061-3-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c3186992-a85d-5934-f6ab-0e8512952e3c@...2080...>
Date: Fri, 15 Feb 2019 22:19:18 +0100
MIME-Version: 1.0
In-Reply-To: <20190122150333.1061-3-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v2 3/6] Rewrite auth-token-gen to be
 based on HMAC based tokens
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 22/01/2019 16:03, Arne Schwabe wrote:
> The previous auth-token implementation had a serious problem, especially when
> paired with an unpatched OpenVPN client that keeps trying the auth-token
> (commit e61b401a).
> 
> The auth-token-gen implementation forgot the auth-token on reconnect, this
> lead to reconnect with auth-token never working.
> 
> This new implementation implements the auth-token in a stateles variant. By
> using HMAC to sign the auth-token the server can verify if a token has been
> authenticated and by checking the embedded timestamp in the token it can
> also verify that the auth-token is still valid.
> 
> Patch V2: cleaned up code, use refactored read_pem_key_file function
> ---
>  doc/openvpn.8            |  27 ++++
>  src/openvpn/Makefile.am  |   1 +
>  src/openvpn/auth_token.c | 260 +++++++++++++++++++++++++++++++++++++++
>  src/openvpn/auth_token.h | 116 +++++++++++++++++
>  src/openvpn/init.c       |  34 ++++-
>  src/openvpn/openvpn.h    |   1 +
>  src/openvpn/options.c    |  24 +++-
>  src/openvpn/options.h    |   4 +
>  src/openvpn/push.c       |  70 +++++++++--
>  src/openvpn/push.h       |   8 ++
>  src/openvpn/ssl.c        |   7 +-
>  src/openvpn/ssl_common.h |  36 +++---
>  src/openvpn/ssl_verify.c | 182 ++++++++++++---------------
>  13 files changed, 635 insertions(+), 135 deletions(-)
>  create mode 100644 src/openvpn/auth_token.c
>  create mode 100644 src/openvpn/auth_token.h
> 
[...snip...]

This review cannot be complete, due to my remarks to the previous commit
suggesting not touching read_pem_key_file() at all.


> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 0cf8db76..87632551 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -6769,6 +6774,23 @@ add_option(struct options *options,
>          options->auth_token_generate = true;
>          options->auth_token_lifetime = p[1] ? positive_atoi(p[1]) : 0;
>      }
> +    else if (streq(p[0], "auth-gen-token-secret") && p[1] && (!p[2]
> +                                                              || (p[2] && streq(p[1], INLINE_FILE_TAG))))
> +    {
> +        VERIFY_PERMISSION(OPT_P_GENERAL);
> +        options->auth_token_secret_file = p[1];
> +
> +        if (streq(p[1], INLINE_FILE_TAG) && p[2])
> +        {
> +            options->auth_token_secret_file_inline = p[2];
> +        }
> +    }
> +    else if (streq(p[0], "auth-gen-token-secret-genkey") && !p[1])
> +    {
> +        VERIFY_PERMISSION(OPT_P_GENERAL);
> +        options->auth_token_gen_secret_file = true;
> +    }
> +

I see you add --auth-gen-token-secret and --auth-gen-token-secret-genkey ... I
find this a bit confusing ... gen-token-secret-genkey ...

Why not extend --auth-gen-token to take an additional file argument.  Today it
is defined as:

     --auth-gen-token [lifetime]

I suggest:

     --auth-gen-token [lifetime] [secret-key]

If you want non-expiring tokens using a secret key, you can set the lifetime
value to 0.

Then instead of the --auth-gen-token-secret-genkey .... I suggest renaming
that to: --genkey-auth-token-secret

I see that your initial suggetion maps nicely to the same structure we have in
--tls-crypt-v2-genkey.  But I find auth-gen-token-secret-genkey too long and
repetetive without being that explicit on what it does.  I think
--genkey-auth-token-secret is a bit clearer in what that option does.


Another segment (I'm shuffling things around a bit, sorry about that)

> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 560d87db..983b49e4 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1098,6 +1099,17 @@ do_genkey(const struct options *options)
>  
>          msg(M_USAGE, "--tls-crypt-v2-genkey type should be \"client\" or \"server\"");
>      }
> +
> +    if (options->auth_token_gen_secret_file)
> +    {
> +        if (!options->auth_token_secret_file)
> +        {
> +            msg(M_USAGE, "--auth-gen-token-secret-genkey requires a server key "
> +                "to be set via --auth-gen-token-secret to create a shared secret");
> +        }
> +        auth_token_write_server_key_file(options->auth_token_secret_file);

Any reason we can't just skip this wrapper function and call the line below
directly?

   write_pem_key_file(filename, auth_token_pem_name);

Otherwise, the rest looks reasonable.  But I've only glared at the code for
now.  I will dig deeper when starting to test the code.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


