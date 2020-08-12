References: <20200812140120.21287-1-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <acdbc6b7-d9ef-7824-6511-d7bec7713b1d@...1856...>
Date: Wed, 12 Aug 2020 21:43:05 +0200
MIME-Version: 1.0
In-Reply-To: <20200812140120.21287-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 1/3] Refactor
 key_state_export_keying_material functions
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On 12-08-2020 16:01, Arne Schwabe wrote:
> This refactors the common code between mbed SSL and OpenSSL into
> export_user_keying_material and also prepares the backend functions
> to export more than one key.
> 
> Also fix checking the return value of SSL_export_keying_material
> only 1 is a sucess, -1 is also an error.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> 
> Patch V2: Cache secrets for mbed TLS instead generating all ekms
>           in the call back function
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>
>  [...]
> 
> --- a/src/openvpn/ssl_backend.h
> +++ b/src/openvpn/ssl_backend.h
> @@ -394,13 +394,23 @@ void backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx,
>   * derived from existing TLS channel. This exported keying material can then be
>   * used for a variety of purposes.
>   *
> + *

This extra newline seems unneeded.

>   * @param ks_ssl       The SSL channel's state info
>   * @param session      The session associated with the given key_state
> + * @param label        The label to use when exporting the key
> + * @param label_size   The size of the label to use when exporting the key
> + *
> + * @param gc           gc_arena that might be used to allocate the string
> + *                     returned
> + * @returns            The exported key material, the caller may zero the
> + *                     string but should not free it
>   */
>  
> -void
> -key_state_export_keying_material(struct key_state_ssl *ks_ssl,
> -                                 struct tls_session *session) __attribute__((nonnull));
> +unsigned char*
> +key_state_export_keying_material(struct tls_session *session,
> +                                 const char* label, size_t label_size,
> +                                 size_t ekm_size,
> +                                 struct gc_arena *gc) __attribute__((nonnull));

(Quoting a former colleague:) comment is a lie! It does not match the
actual function prototype.

All the code itself looks good to me. I *think* it could be made
slightly better even, but these changes make sense for the intended
goal, and look correct.

Tested both openssl and mbedtls builds (with -fsanitize=address), and
verified that this indeed produces the same exported values for both
builds and a build without this patch.

-Steffan

