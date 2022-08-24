Date: Wed, 24 Aug 2022 12:34:44 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YwX+xFN8eZWKtXaQ@...2685...>
References: <20220824093723.64618-1-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20220824093723.64618-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Improve data key id not found error
 message
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wed, Aug 24, 2022 at 11:37:23AM +0200, Arne Schwabe wrote:
> With delayed data key generation now with deferred auth, NCP and similar
> mechanism the "TLS Error: local/remote TLS keys are out of sync" is shown
> much too frequent and confuses a lot of people.
> 
> This also removes the dead code of printing multi not ready keys and
> replace it with an assert.
> 
> Factor out printing of error messages into an extra function to make
> the code easier to understand and also to only call into that function
> in the case that a key is not found and avoid the overhead.

Okay, I have to say that this patch confuses me. Might be my limited
understanding of the involved structures, though.

> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 33e145b3f..6a3473944 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -3202,11 +3202,61 @@ nohard:
>      return (tas == TLS_AUTHENTICATION_FAILED) ? TLSMP_KILL : active;
>  }
>  
> -/*
> - * Pre and post-process the encryption & decryption buffers in order
> - * to implement a multiplexed TLS channel over the TCP/UDP port.
> +/**
> + * We have not found a matching key to decrypt data channel packet,
> + * try to generate a sensible error message and print it
>   */
> +static void
> +print_key_id_not_found_reason(struct tls_multi *multi,
> +                              const struct link_socket_actual *from, int key_id)
> +{
> +    struct gc_arena gc = gc_new();
> +    const char *source = print_link_socket_actual(from, &gc);
> +
> +
> +    for (int i = 0; i < KEY_SCAN_SIZE; ++i)
> +    {
> +        struct key_state *ks = get_key_scan(multi, i);
> +        /*
> +         * Our key state has been progressed far enough to be part of an valid
> +         * session but has not generated keys. Since there can
> +         * be multiple valid/semi valid key states with key id 0 (especially in
> +         * p2p mode when a client reconnects), we still need
> +         * to loop through all keys and only remember here that there is at
> +         * least one key that is not ready yet*/
> +        if (ks->state >= S_INITIAL && key_id < S_GENERATED_KEYS)

Why are you comparing key_id to a state value? Shouldn't you compare
ks->state to S_GENERATED_KEYS and ks->key_id to the key_id?

> +        {
> +            msg(D_MULTI_DROPPED,
> +                "Key %s [%d] not initialized (yet), dropping packet.",
> +                source, key_id);
> +            gc_free(&gc);
> +            return;
> +        }
> +        if (ks->state >= S_ACTIVE && ks->authenticated == KS_AUTH_FALSE)

While here we do check key_id at all?

> +        {
> +            msg(D_MULTI_DROPPED,
> +                "Key %s [%d] no longer authorized (yet), dropping packet.",
> +                source, key_id);
> +            gc_free(&gc);
> +            return;
> +        }
> +    }


Regards,
-- 
  Frank Lichtenheld

