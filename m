References: <20210426174436.26210-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <f08a95a9-1b87-ab19-6e9d-cac9c63c862a@...2181...>
Date: Mon, 26 Apr 2021 21:58:38 +0200
MIME-Version: 1.0
In-Reply-To: <20210426174436.26210-1-gert@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] rewrite parse_hash_fingerprint()
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 26/04/2021 19:44, Gert Doering wrote:
> The existing code was doing far too much work for too little
> gain - copying the string segment for scanf(), checking extra
> for spaces, making the result quite unreadable.
> 
> Verify each segment with (short-circuited) isxdigit() checks,
> then feed directly to scanf(), which will stop parsing on ':'
> or end-of-string.
> 
> Rewrite error message to differenciate "hash too short" (including

differenciate -> differenTiate

> number of bytes read) and "hash too long" (it did not terminate when
> we had enough bytes).
> 
> While at it, add an option printer for the resulting o->verify_hash
> list to show_settings().
> 

Thanks for this patch!
Simplifying existing code is as important as introducing new features
and this proves that the project is still well maintained. (Feature-ACK)


> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/options.c | 64 +++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 2a5b1393..15472878 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -1082,56 +1082,43 @@ string_substitute(const char *src, int from, int to, struct gc_arena *gc)
>  static struct verify_hash_list *
>  parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_arena *gc)
>  {
> -    int i;
> +    int i=0;

spaces around the '='

>      const char *cp = str;
>  
>      struct verify_hash_list *ret;
>      ALLOC_OBJ_CLEAR_GC(ret, struct verify_hash_list, gc);
>  
> -    char term = 1;
> +    char term = 0;
>      int byte;
> -    char bs[3];
>  
> -    for (i = 0; i < nbytes; ++i)
> +    while (*cp && i < nbytes)
>      {
> -        if (strlen(cp) < 2)
> +        /* valid segments consist of exactly two hex digits, then ':' or EOS */
> +        if (!isxdigit(cp[0])
> +            || !isxdigit(cp[1])

since we have a limit of 80 chars per line, how about putting the two
conditions above on the same line?

> +            || (cp[2] != ':' && cp[2] != '\0')
> +            || sscanf(cp, "%x", &byte) != 1)

same for this two, but less important as they are not really related.

Regarding the format string, we concluded on IRC that %hhx is part of
C99 - why not using it here then?

>          {
>              msg(msglevel, "format error in hash fingerprint: %s", str);
> +            break;

We had no break here because this function is always invoked with the
FATAL bit set in the msglevel, therefore the msg() call will terminate
the program.

This said, I prefer moving away from this assumption, so I personally
welcome the break.

>          }
> -        bs[0] = *cp++;
> -        bs[1] = *cp++;
> -        bs[2] = 0;
>  
> -        /* the format string "%x" passed to sscanf will ignore any space and
> -         * will still try to parse the other character. However, this is not
> -         * expected format for a fingerprint, therefore explictly check for
> -         * blanks in the string and error out if any is found
> -         */
> -        if (bs[0] == ' ' || bs[1] == ' ')
> -        {
> -            msg(msglevel, "format error in hash fingerprint unexpected blank: %s",
> -                str);
> -        }
> +        ret->hash[i++] = (uint8_t)byte;

This cast would go away if byte is declared as uint8_t and we use %hhx
in the sscanf().

>  
> -        byte = 0;
> -        if (sscanf(bs, "%x", &byte) != 1)
> -        {
> -            msg(msglevel, "format error in hash fingerprint hex byte: %s", str);
> -        }
> -        ret->hash[i] = (uint8_t)byte;
> -        term = *cp++;
> -        if (term != ':' && term != 0)
> -        {
> -            msg(msglevel, "format error in hash fingerprint delimiter: %s", str);
> -        }
> -        if (term == 0)
> +        term = cp[2];
> +        if (term == '\0')

do we really need "term" at al at this point?
we could directly use cp[2] in the if condition.

>          {
>              break;
>          }
> +        cp += 3;
>      }
> -    if (term != 0 || i != nbytes-1)
> +    if (i < nbytes)
>      {
> -        msg(msglevel, "hash fingerprint is different length than expected (%d bytes): %s", nbytes, str);
> +        msg(msglevel, "hash fingerprint is wrong length - expected %d bytes, got %d: %s", nbytes, i, str);
> +    }
> +    else if (term != '\0')

same here: if we hit the else branch, it means that cp[0,1,2] are all
defined so we can again compare cp[2] to '\0'.

> +    {
> +        msg(msglevel, "hash fingerprint too long - expected only %d bytes: %s", nbytes, str);
>      }
>      return ret;
>  }
> @@ -1791,6 +1778,19 @@ show_settings(const struct options *o)
>          }
>      }
>      SHOW_STR(remote_cert_eku);
> +    if (o->verify_hash)
> +    {
> +        struct gc_arena gc = gc_new();
> +        struct verify_hash_list *hl = o->verify_hash;
> +        while (hl)
> +        {
> +            char *s = format_hex_ex(hl->hash, sizeof(hl->hash), 0,
> +                                    1, ":", &gc);
> +            SHOW_PARM(verify_hash, s, "%s");
> +            hl = hl->next;
> +        }
> +        gc_free(&gc);
> +    }

Should we also print options->verify_hash_depth while at it?

>      SHOW_INT(ssl_flags);
>  
>      SHOW_INT(tls_timeout);
> 

Rest looks good!

I performed a bunch of tests with various strings and they all passed as
expected.

Regards,

-- 
Antonio Quartulli

