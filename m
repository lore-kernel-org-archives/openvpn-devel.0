Message-ID: <7327aea6-5cd7-7b67-b92d-30d3da50a53f@...1227...>
Date: Tue, 22 Feb 2022 13:21:29 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20220221111933.1314-1-frank@...2641...>
 <20220222121439.1260-1-frank@...2641...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220222121439.1260-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH v2] doc: cleanup for --data-ciphers and
 related
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
To: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

>   
>     The ``algorithm`` parameter may be :code:`lzo`, :code:`lz4`,
> @@ -193,6 +193,10 @@ configured in a compatible way between both the local and remote side.
>     supported by the client will be pushed to clients that support cipher
>     negotiation.
>   
> +  For more details see the chapter on `Data channel cipher negotiation`_.
> +  *Especially* if you need to support clients with OpenVPN versions older
> +  than 2.5!
> +

Why 2.5? 2.4 client and server will just default to AES-256-GCM and that 
should be fine?

> -
> -  Note for using NCP with an OpenVPN 2.4 peer: This list must include the
> -  :code:`AES-256-GCM` and :code:`AES-128-GCM` ciphers.
> +  If ``--compat-mode`` is set to a version older than 2.5.0 ``--cipher``
> +  will be appended to ``--data-ciphers`` if not already present.

Nitpick, not ``--cipher`` but the cipher specified by ``--cipher``


>   /**
> - * The option --compat-mode is used to set up default settings to values
> + * The option --compat-mode is used to set up default settings to values
>    * used on the specified openvpn version and earlier.
>    *
>    * This function is used in various "default option" paths to test if the
>    * user requested compatibility with a version before the one specified
> - * as argument. This way some default settings can be automatically
> - * altered to guarantee compatibility with the version specified by the
> + * as argument. This way some default settings can be automatically
> + * altered to guarantee compatibility with the version specified by the
>    * user via --compat-mode.
>    *
>    * @param version   need compatibility with openvpn versions before the
> @@ -3219,11 +3219,11 @@ options_set_backwards_compatible_options(struct options *o)
>       }
>   
>       /* Versions < 2.5.0 do need --cipher in the list of accepted ciphers.
> -     * Version 2.4 might probably does not need it but NCP was not so
> +     * Version 2.4 probably does not need it but NCP was not so
>        * good with 2.4 and ncp-disable might be more common on 2.4 peers.
> -     * Only do this iif --cipher is not explicitly (BF-CBC). This is not
> -     * 100% correct backwards compatible behaviour but 2.5 already behaved like
> -     * this */
> +     * Only do this if --cipher is set explicitly (or compat mode is

iif should have been iff (=if and only if). So probably either correct 
to that or write it out if you think that math idiom is not understood 
by normal programmers.

> +     * < 2.4.0, see above). This is not 100% correct backwards compatible
> +     * behaviour but 2.5 already behaved like this */
>       if (o->ciphername && need_compatibility_before(o, 20500)
>           && !tls_item_in_cipher_list(o->ciphername, o->ncp_ciphers))
>       {


