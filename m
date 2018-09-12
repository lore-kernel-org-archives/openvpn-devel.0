References: <20180912110713.31670-1-arne@...1227...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <faa486c3-1b65-972c-27ec-7fd684e2eea2@...277...>
Date: Wed, 12 Sep 2018 13:59:08 +0100
MIME-Version: 1.0
In-Reply-To: <20180912110713.31670-1-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Make compression asymmetric by default
 and add warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Trying to help ;)

10 corrections to openvpn.8

5 possible corrections to options.c



On 12/09/18 12:07, Arne Schwabe wrote:
> This commit introduces the allow-compression option that allow
> changing the new default to the previous default or to a stricter
> version.
> 
> Warning are not generated in the post option check
> (options_postprocess_mutate) since these warnings should also be shown
> on pushed options.
> ---
>   doc/openvpn.8          | 44 +++++++++++++++++----
>   src/openvpn/comp-lz4.c |  3 +-
>   src/openvpn/comp.h     | 16 ++++++--
>   src/openvpn/lzo.c      |  2 +-
>   src/openvpn/options.c  | 86 ++++++++++++++++++++++++++++++++++++------
>   5 files changed, 127 insertions(+), 24 deletions(-)
> 
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index de1a1928..21f42591 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -2508,26 +2508,54 @@ Enable a compression algorithm.
>   
>   The
>   .B algorithm
> -parameter may be "lzo", "lz4", or empty.  LZO and LZ4
> -are different compression algorithms, with LZ4 generally
> +parameter may be "lzo", "lz4", "lz4-v2", "stub", "stub-v2" or empty.

"lz4\-v2" "stub\-v2"

> +LZO and LZ4 are different compression algorithms, with LZ4 generally
>   offering the best performance with least CPU usage.
>   For backwards compatibility with OpenVPN versions before v2.4, use "lzo"
>   (which is identical to the older option "\-\-comp\-lzo yes").
>   
> +The "lz4-v2" and "stub-v2" variants implement a better framing that does not add
> +overhead when packets cannot compressed. All other variants always add one extra
> +compared to no compression framing.

"lz4\-v2" "stub\-v2"

when packets cannot "be" compressed

"add one extra" .. what ? byte

> +
>   If the
>   .B algorithm
> -parameter is empty, compression will be turned off, but the packet
> -framing for compression will still be enabled, allowing a different
> -setting to be pushed later.
> +parameter is "stub", "stubv2", or empty, compression will be turned off, but
> +the packet framing for compression will still be enabled, allowing a different
> +setting to be pushed later. Additionally, "stub" and "stub-v2" will disable
> +announcing lzo and lz4 compression support for via "IV_" variables to the server.

"stub\-v2"

"support for via" -> "support via" (the for is not required)

> +
>   
>   .B Security Considerations
>   
>   Compression and encryption is a tricky combination.  If an attacker knows or is
>   able to control (parts of) the plaintext of packets that contain secrets, the
>   attacker might be able to extract the secret if compression is enabled.  See
> -e.g. the CRIME and BREACH attacks on TLS which also leverage compression to
> -break encryption.  If you are not entirely sure that the above does not apply
> -to your traffic, you are advised to *not* enable compression.
> +e.g. the CRIME and BREACH attacks on TLS and VORACLE on VPNs which also leverage
> +compression to break encryption.  If you are not entirely sure that the above does
> +not apply to your traffic, you are advised to *not* enable compression.
> +
> +.\"*********************************************************
> +.TP
> +.B \-\-allow-compression [mode]
> +As described in
> +\.B \-\-compress
> +option, compression is potentially dangerous option. This option allows
> +control the behaviour of OpenVPN when compression is used and allowed.

"controlling"

> +.B mode
> +may be "yes", "no", or "asym" (default).
> +
> +With allow-compression set to "no", OpenVPN will refuse any non stub

\-\-allow\-compression

> +compression. With "yes" OpenVPN will send and receive compressed packets.
> +With "asym", the default, OpenVPN will only decompress (downlink) packets but
> +not compress (uplink) packets. This also allows migrating to disable compression
> +when changing both server and client configurations to remove compression at the
> +same time options is not feasible.

"options is not feasible." -> "is not a feasible option."

> +
> +The default of asym has been chosen to maximise compatibility with existing
> +configuration while at the same time phasing phasing out compression in existing

phasing phasing (duplicated)


> +deployment by disabling compression on the uplink, effectively completely disabling
> +compression if both client and server are upgraded.
>   
>   .\"*********************************************************
>   .TP


<large snip all looked ok>


> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 61fa9833..8b5c96c8 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -349,6 +349,7 @@ static const char usage_message[] =
>   #endif
>   #if defined(USE_COMP)
>       "--compress alg  : Use compression algorithm alg\n"
> +    "--allow-compression: Specify wether compression should be allowed\n"
>   #if defined(ENABLE_LZO)
>       "--comp-lzo      : Use LZO compression -- may add up to 1 byte per\n"
>       "                  packet for uncompressible data.\n"


*uncompressible should really be *incompressible



> @@ -4952,6 +4953,18 @@ set_user_script(struct options *options,
>   #endif
>   }
>   
> +static void show_compression_warning(struct compress_options *info)
> +{
> +    if (comp_non_stub_enabled(info))
> +    {
> +        /* Check if already displayed the strong warning and enabled full compression */
> +        if (!(info->flags & COMP_F_NO_ASYM))
> +        {
> +            msg(M_WARN, "WARNING: compression allows attacks that break encryption. "
> +                        "Enabling decompression of received packet only. Sent packets are not compressed.");
> +        }
> +    }
> +}
>   
>   static void
>   add_option(struct options *options,
> @@ -7368,29 +7381,72 @@ add_option(struct options *options,
>       }
>   #endif
>   #if defined(USE_COMP)
> +    else if (streq(p[0], "allow-compression") && p[1] && !p[2])
> +    {
> +        VERIFY_PERMISSION(OPT_P_COMP);
> +
> +        if (streq(p[1], "no"))
> +        {
> +            options->comp.flags = COMP_F_ALLOW_STUB_ONLY;
> +            if (comp_non_stub_enabled(&options->comp)) {
> +                msg(msglevel, "allow-compression no conflicts with enabling compression");


Mixing your message formats:

--allow-compression


> +                /* we could manipulate the algorithm to a stub/no variant but the only scenario
> +                 * that the previous message does not abort the program is when pushed from a server
> +                 * and the server probably has a very confused configuration, so keep whatever we have */
> +            }
> +        }
> +        else if (options->comp.flags & COMP_F_ALLOW_STUB_ONLY)
> +        {
> +            msg(msglevel, "Cannot set allow-compression to '%s' after set to 'no'", p[1]);
> +            goto err;
> +        }
> +        else if (streq(p[1], "asym"))
> +        {
> +            options->comp.flags &= ~COMP_F_NO_ASYM;
> +        }
> +        else if (streq(p[1], "yes"))
> +        {
> +            msg(M_WARN, "WARNING: Allowing compression allows attacks that break encryption. "
> +                "Using allow-compression yes is strongly discouraged for common usage. "
> +                "See --compress in the manual page for more information");


Mixing your message formats:

--allow-compression

For example, you have used "See --compress"
this is why I highlight where you have omitted "--"


> +            options->comp.flags |= COMP_F_NO_ASYM;
> +        }
> +        else
> +        {
> +          msg(msglevel, "bad allow-compression option: %s -- must be 'yes', 'no', or 'asym'", p[1]);
> +          goto err;
> +        }
> +    }
>       else if (streq(p[0], "comp-lzo") && !p[2])
>       {
>           VERIFY_PERMISSION(OPT_P_COMP);
>   
> +        /* All lzo variants do not use swap */
> +        options->comp.flags &= ~COMP_F_SWAP;
>   #if defined(ENABLE_LZO)
>           if (p[1] && streq(p[1], "no"))
>   #endif
>           {
>               options->comp.alg = COMP_ALG_STUB;
> -            options->comp.flags = 0;
> +            options->comp.flags &= ~COMP_F_ADAPTIVE;
>           }
>   #if defined(ENABLE_LZO)
> +        else if (options->comp.flags & COMP_F_ALLOW_STUB_ONLY)
> +        {
> +            msg(msglevel, "Cannot set comp-lzo to '%s', allow-compression is set to  'no'", p[1]);


"--" again or not ?



> +            goto err;
> +        }
>           else if (p[1])
>           {
>               if (streq(p[1], "yes"))
>               {
>                   options->comp.alg = COMP_ALG_LZO;
> -                options->comp.flags = 0;
> +                options->comp.flags &= ~COMP_F_ADAPTIVE;
>               }
>               else if (streq(p[1], "adaptive"))
>               {
>                   options->comp.alg = COMP_ALG_LZO;
> -                options->comp.flags = COMP_F_ADAPTIVE;
> +                options->comp.flags |= COMP_F_ADAPTIVE;
>               }
>               else
>               {
> @@ -7401,12 +7457,15 @@ add_option(struct options *options,
>           else
>           {
>               options->comp.alg = COMP_ALG_LZO;
> -            options->comp.flags = COMP_F_ADAPTIVE;
> +            options->comp.flags |= COMP_F_ADAPTIVE;
>           }
> +        show_compression_warning(&options->comp);
>   #endif /* if defined(ENABLE_LZO) */
>       }
>       else if (streq(p[0], "comp-noadapt") && !p[1])
>       {
> +        /* We do not need to check here if we allow compression since
> +         * it only modifies a flag if compression is enabled */
>           VERIFY_PERMISSION(OPT_P_COMP);
>           options->comp.flags &= ~COMP_F_ADAPTIVE;
>       }
> @@ -7418,30 +7477,34 @@ add_option(struct options *options,
>               if (streq(p[1], "stub"))
>               {
>                   options->comp.alg = COMP_ALG_STUB;
> -                options->comp.flags = (COMP_F_SWAP|COMP_F_ADVERTISE_STUBS_ONLY);
> +                options->comp.flags |= (COMP_F_SWAP|COMP_F_ADVERTISE_STUBS_ONLY);
>               }
>               else if (streq(p[1], "stub-v2"))
>               {
>                   options->comp.alg = COMP_ALGV2_UNCOMPRESSED;
> -                options->comp.flags = COMP_F_ADVERTISE_STUBS_ONLY;
> +                options->comp.flags |= COMP_F_ADVERTISE_STUBS_ONLY;
> +            }
> +            else if (options->comp.flags & COMP_F_ALLOW_STUB_ONLY)
> +            {
> +              msg(msglevel, "Cannot set compress to '%s', allow-compression is set to  'no'", p[1]);


"--" again or not ?


EOF

