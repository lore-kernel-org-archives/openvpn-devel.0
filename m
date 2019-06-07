References: <20190510121114.30468-1-arne@...1227...>
 <20190510121114.30468-4-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <2c0be0c4-1f3b-1761-6708-e0397642bcfd@...2080...>
Date: Fri, 7 Jun 2019 22:46:04 +0200
MIME-Version: 1.0
In-Reply-To: <20190510121114.30468-4-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v3 3/7] Add pem_read_key_file variant
 that allows a random key
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

On 10/05/2019 14:11, Arne Schwabe wrote:
> From: Arne Schwabe <arne@...515...>
> 
> This is useful for features that can use enither a persistent
> or an ephemeral key.
> 
> Patch V2: Move the functionality of generating a random key into a
>           separate function that acts as wrapper for pem_read_key_file
> ---
>  src/openvpn/crypto.c | 22 ++++++++++++++++++++++
>  src/openvpn/crypto.h | 15 +++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index eb56421b..0e17c351 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -1892,6 +1892,28 @@ cleanup:
>      return;
>  }
>  
> +bool
> +load_pem_file_or_ephemeral_key(struct buffer *key, const char *pem_name,
> +                               const char *key_file, const char *key_inline)
> +{
> +    if (key_file == NULL)

I don't like this approach.  Why can't we have generate_ephemeral_key()
basically doing the keyfile == NULL part below and put the "which key to use"
logic in the only caller I could see in auth_token_init_secret() [added in a
later patch] ?  This makes the code clearer:

-----------------------------------------------------------------

void
auth_token_init_secret(struct key_ctx *key_ctx, const char *key_file,
                       const char *key_inline)
{
   /* .... */
   bool key_loaded = false;
   if (key_file)
   {
	key_loaded = read_pem_key(...);
   }
   else
   {
        key_loaded = generate_ephemeral_key(...);
   }
   if (!key_loaded)
   {
        msg(M_FATAL, ....);
   }
   /* .... */
-----------------------------------------------------------------

You could also make it more compact, but not sure it's worth it here, as these
functions requires a few longer argument lists:

   bool key_loaded = (key_file ? read_pem_key(...)
                               : generate_ephemeral_key(...));


The point is: This makes read_pem_key() and generate_ephemeral_key() do only
one simple and predictable task.  The load_pem_file_or_ephemeral_key() does
one of two things, depending on the argument.  And since I only see we have
only a single caller to the load_pem_file_or_ephemeral_key(), there's nothing
to save on code reuse by wrapping it up like this.


> +    {
> +        msg(M_INFO, "Using random %s.", pem_name);
> +        uint8_t rand[BCAP(key)];
> +        if (!rand_bytes(rand, BCAP(key)))
> +        {
> +            msg(M_WARN, "ERROR: could not generate random key");
> +            return false;
> +        }
> +        buf_write(key, rand, BCAP(key));
> +        return true;
> +    }
> +    else
> +    {
> +        return read_pem_key_file(key, pem_name, key_file, key_inline);
> +    }
> +}
> +

-- 
kind regards,

David Sommerseth
OpenVPN Inc


