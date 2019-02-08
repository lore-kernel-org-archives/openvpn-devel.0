References: <20190122150333.1061-1-arne@...1227...>
 <20190122150333.1061-2-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <38ffdb09-276d-8f5a-ce81-f3d36a1e685b@...2080...>
Date: Fri, 8 Feb 2019 13:30:10 +0100
MIME-Version: 1.0
In-Reply-To: <20190122150333.1061-2-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v2 2/6] Allow pem_read_key_file to
 generate a random key
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
Cc: Arne Schwabe <arne@...515...>

On 22/01/2019 16:03, Arne Schwabe wrote:
> From: Arne Schwabe <arne@...515...>
> 
> This is useful for features that can use either a persistent
> or an ephemeral key.

Agreed, this is valuable.  But I generally don't like "hiding" this feature
behind an argument to {read,write}_pem_key_file().  I prefer having functions
doing explicit things, not "I can do this, or this, or this" depending on the
arguments given.

Rather add a generate_random_pem_key() which does just that.

> ---
>  src/openvpn/crypto.c    | 23 ++++++++++++++++++++---
>  src/openvpn/crypto.h    |  4 +++-
>  src/openvpn/tls_crypt.c |  5 +++--
>  3 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index ff9dbfdc..68a28dee 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -1885,13 +1885,30 @@ cleanup:
>  
>  bool
>  read_pem_key_file(struct buffer *key, const char *pem_name,
> -                  const char *key_file, const char *key_inline)
> +                  const char *key_file, const char *key_inline,
> +                  bool allow_random)
>  {
>      bool ret = false;
>      struct buffer key_pem = { 0 };
>      struct gc_arena gc = gc_new();
>  
> -    if (strcmp(key_file, INLINE_FILE_TAG))
> +
> +    if (allow_random && key_file == NULL)
> +    {
> +        msg(M_INFO, "Using random %s.", pem_name);
> +        uint8_t rand[BCAP(key)];
> +        if (!rand_bytes(rand, BCAP(key)))
> +        {
> +            msg(M_WARN, "ERROR: could not generate random key");
> +        }
> +        else
> +        {
> +            buf_write(key, rand, BCAP(key));
> +            ret = true;
> +        }

The if (rand_bytes(rand, BCAP(key))) logic could be improved when splitting it
into a separate function.

    if (!rand_bytes(rand, BCAP(key)))
    {
         msg(...);
	return false;
    }
    buf_write(...);
    return true;


[...]

> -    if (strcmp(key_file, INLINE_FILE_TAG))
> +    if (key_file && strcmp(key_file, INLINE_FILE_TAG))

Is this fixing a bug?  I'd recommend putting such fixes in a separate commit.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


