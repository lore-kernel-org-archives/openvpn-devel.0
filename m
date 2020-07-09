References: <20200709101603.11941-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <29c05832-9ed7-3871-db1b-df8a679a4728@...2181...>
Date: Thu, 9 Jul 2020 16:07:53 +0200
MIME-Version: 1.0
In-Reply-To: <20200709101603.11941-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/8] Deprecate ncp-disable and add
 improved ncp to Changes.rst
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

On 09/07/2020 12:15, Arne Schwabe wrote:
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  Changes.rst           | 18 ++++++++++++++++++
>  src/openvpn/options.c |  5 ++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Changes.rst b/Changes.rst
> index 00dd6ed8..2752d29b 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -13,6 +13,24 @@ ChaCha20-Poly1305 cipher support
>      Added support for using the ChaCha20-Poly1305 cipher in the OpenVPN data
>      channel.
>  
> +Improved Data channel cipher negotiation
> +    OpenVPN clients will now signal all supported cipher from the
                                                        ^^^ cipherS

> +    ``ncp-ciphers`` option to the server via ``IV_CIPHERS``. OpenVPN
> +    servers will select the first common cipher from the ``ncp-ciphers``
> +    list instead of blindly pushing the first cipher of the list. This
> +    allows to use a configuration like
> +    ``ncp-ciphers ChaCha20-Poly1305:AES-256-GCM`` on the server that
> +    prefers ChaCha20-Poly1305 but uses it only if the client supports it.
> +
> +Deprecated features
> +-------------------
> +For an up-to-date list of all deprecated options, see this wiki page:
> +https://community.openvpn.net/openvpn/wiki/DeprecatedOptions
> +
> +- ``ncp-disable`` has been deprecated
> +    With the improved and matured data channel cipher negioation, the use

                                                         ^^^ negotiation

> +    of ``ncp-disable`` should not be necessary anymore.
> +
>  
>  Overview of changes in 2.4
>  ==========================
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index a72b677a..75871b46 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -545,7 +545,7 @@ static const char usage_message[] =
>      "                  (default=%s).\n"
>      "                  Set alg=none to disable encryption.\n"
>      "--ncp-ciphers list : List of ciphers that are allowed to be negotiated.\n"
> -    "--ncp-disable   : Disable cipher negotiation.\n"
> +    "--ncp-disable   : (DEPRECATED) Disable cipher negotiation.\n"
>      "--prng alg [nsl] : For PRNG, use digest algorithm alg, and\n"
>      "                   nonce_secret_len=nsl.  Set alg=none to disable PRNG.\n"
>  #ifdef HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH
> @@ -7904,6 +7904,9 @@ add_option(struct options *options,
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INSTANCE);
>          options->ncp_enabled = false;
> +        msg(M_WARN, "DEPRECATED OPTION: ncp-disable. Disabling dynamic "
> +                    "cipher negioating is a depracted debug feature that will "
                               ^^^ negotiation    ^^^ deprecated

> +                    "be removed in OpenVPN 2.6");
>      }
>      else if (streq(p[0], "prng") && p[1] && !p[3])
>      {
> 


I only have one doubt about how visible the message is:

2020-07-09 16:05:08 DEPRECATED OPTION: ncp-disable. Disabling dynamic
cipher negioating is a depracted debug feature that will be removed in
OpenVPN 2.6

appears at the top of the log (first line actually) and does not seem
easy to spot.

How about adding some ********* or ######## to make it pop out of the
screen?

I personally did not see it immediately, even though I knew it was
there! (note: it may just be me)

-- 
Antonio Quartulli

