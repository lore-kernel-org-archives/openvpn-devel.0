References: <20210319142001.2201-1-arne@...1227...>
 <20210321142538.1656-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <68db2ef8-5751-80c0-b9be-79045d906fd9@...2181...>
Date: Sun, 21 Mar 2021 17:09:29 +0100
MIME-Version: 1.0
In-Reply-To: <20210321142538.1656-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3] Extend verify-hash to allow multiple
 hashes
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

Hi,

This patch looks good to me.
There is just one minor note below:

On 21/03/2021 15:25, Arne Schwabe wrote:
> This patch introduces support for verify-hash inlining.
> When inlined, this options now allows to specify multiple fingerprints,
> one per line.
> 
> Since this is a new syntax, there is no backwards compatibility to take
> care of, therefore we can drop support for SHA1. Inlined fingerprints
> are assumed be to SHA-256 only.
> 
> Also print a warning about SHA1 hash being deprecated to verify
> certificates as it is not "industry standard" anymore.
> 
> Patch v2: fix/clarify various comments, fix a few minor problems, allow
>           the option to be specified multiple times and have that
>           added to the list.
> 
> Patch v3: Remove leftover variable, always call
>           parse_hash_fingerprint_multiline, add comments clarifying list
>           appending
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/man-sections/inline-files.rst |   4 +-
>  doc/man-sections/tls-options.rst  |  10 +++
>  src/openvpn/options.c             | 102 ++++++++++++++++++++++++++----
>  src/openvpn/options.h             |  10 ++-
>  src/openvpn/ssl_common.h          |   2 +-
>  src/openvpn/ssl_verify.c          |  16 ++++-
>  6 files changed, 127 insertions(+), 17 deletions(-)
> 
> diff --git a/doc/man-sections/inline-files.rst b/doc/man-sections/inline-files.rst
> index 819bd3c8..303bb3c8 100644
> --- a/doc/man-sections/inline-files.rst
> +++ b/doc/man-sections/inline-files.rst
> @@ -4,8 +4,8 @@ INLINE FILE SUPPORT
>  OpenVPN allows including files in the main configuration for the ``--ca``,
>  ``--cert``, ``--dh``, ``--extra-certs``, ``--key``, ``--pkcs12``,
>  ``--secret``, ``--crl-verify``, ``--http-proxy-user-pass``, ``--tls-auth``,
> -``--auth-gen-token-secret``, ``--tls-crypt`` and ``--tls-crypt-v2``
> -options.
> +``--auth-gen-token-secret``, ``--tls-crypt``, ``--tls-crypt-v2`` and
> +``--verify-hash`` options.
>  
>  Each inline file started by the line ``<option>`` and ended by the line
>  ``</option>``
> diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
> index e13fb3c8..d8f9800e 100644
> --- a/doc/man-sections/tls-options.rst
> +++ b/doc/man-sections/tls-options.rst
> @@ -582,6 +582,16 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
>    The ``algo`` flag can be either :code:`SHA1` or :code:`SHA256`. If not
>    provided, it defaults to :code:`SHA1`.
>  
> +  This option can also be inlined
> +  ::
> +
> +    <verify-hash>
> +    00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff
> +    11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:00
> +    </verify-hash>
> +
> +If the option is inlined, ``algo`` is always :code:`SHA256`.
> +
>  --verify-x509-name args
>    Accept connections only if a host's X.509 name is equal to **name.** The
>    remote host must also pass all other tests of verification.
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 86e78b05..3b1c69ba 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -1078,12 +1078,24 @@ string_substitute(const char *src, int from, int to, struct gc_arena *gc)
>      return ret;
>  }
>  
> -static uint8_t *
> +/**
> + * Parses a hexstring and checks if the string has the correct length. Return
> + * a verify_hash_list containing the parsed hash string.
> + *
> + * @param   str         String to check/parse
> + * @param   nbytes      Number of bytes expected in the hexstr (e.g. 20 for SHA1)
> + * @param   msglevel    message level to use when printing warnings/errors
> + * @param   gc          The returned object will be allocated in this gc
> + */
> +static struct verify_hash_list *
>  parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_arena *gc)
>  {
>      int i;
>      const char *cp = str;
> -    uint8_t *ret = (uint8_t *) gc_malloc(nbytes, true, gc);
> +
> +    struct verify_hash_list *ret;
> +    ALLOC_OBJ_CLEAR_GC(ret, struct verify_hash_list, gc);
> +
>      char term = 1;
>      int byte;
>      char bs[3];
> @@ -1102,7 +1114,7 @@ parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_aren
>          {
>              msg(msglevel, "format error in hash fingerprint hex byte: %s", str);
>          }
> -        ret[i] = (uint8_t)byte;
> +        ret->hash[i] = (uint8_t)byte;
>          term = *cp++;
>          if (term != ':' && term != 0)
>          {
> @@ -1116,10 +1128,55 @@ parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_aren
>      if (term != 0 || i != nbytes-1)
>      {
>          msg(msglevel, "hash fingerprint is different length than expected (%d bytes): %s", nbytes, str);
> +        return NULL;

The rest of this function assumes that msglevel is set to a FATAL level.

As you can also see in the hunk above, if blocks handling other errors
have no return statement, because they assume the program will exit there.

Personally I find this style very counter intuitive.
Also we should consider that the msglevel is a variable here, so this
very function CANNOT assume that the msglevel contains the FATAL bit.

Imagine using this function in a another context in the future, while
forgetting about this hidden assumption: disaster.

Now, this problem is mostly unrelated to this patch.

We just have to make a decision here:
1) remove the "return NULL" (it's just above my text), in order to
follow the current function's style - because the return will never be
hit; or
2) accept the patch as is and move on.

In both cases, this patch gets my ACK.

Acked-by: Antonio Quartulli <antonio@...515...>


The error handling in the option parser is a topic we could discuss in a
meeting.


Cheers,


-- 
Antonio Quartulli

