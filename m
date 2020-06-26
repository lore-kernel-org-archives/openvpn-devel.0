MIME-Version: 1.0
References: <20180917134001.11666-1-arne@...1227...>
 <20200626110554.3690-1-arne@...1227...>
In-Reply-To: <20200626110554.3690-1-arne@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 26 Jun 2020 14:40:23 +0300
Message-ID: <CAGyAFMVN_CMCmaCHKfGfua1rZpT9d=hfKvCWD890_RGU_qA2bA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v5] Make compression asymmetric by
 default and add warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Checked that only diffs are warning messages (as agreed)
and different indentation in #define VERIFY_PERMISSION
(probably caused by uncrustify).

Acked-by: Lev Stipakov <lstipakov@...277...>

pe 26. kes=C3=A4k. 2020 klo 14.06 Arne Schwabe (arne@...1227...) kirjoitti:
>
> This commit introduces the allow-compression option that allow
> changing the new default to the previous default or to a stricter
> version.
>
> Warning for comp-lzo/compress are not generated in the post option check
> (options_postprocess_mutate) since these warnings should also be shown
> on pushed options. Moving the showing the warning showing for
> allow-compression to options_postprocess_mutate will complicate the
> option handling without giving any other benefit.
>
> Patch V2: fix spelling and grammer (thanks tincantech), also fix
>    uncompressiable to incompressible in three other instances in the
>    source code
>
> Patch V3: fix overlong lines. Do not allow compression to be pushed
>
> Patch V4: rename COMP_F_NO_ASYM to COMP_F_ALLOW_COMPRESS, fix style.
>           The logic of warnings etc in options.c has not been changed
>           since adding all the code to mutate_options would a lot more
>           and more complicated code and after discussion we decided that
>           it is okay as is.
>
> Patch V5: Reword warnings, rebase on master
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/openvpn.8          |  44 +++++++++++++---
>  src/openvpn/comp-lz4.c |   3 +-
>  src/openvpn/comp.c     |   2 +-
>  src/openvpn/comp.h     |  16 ++++--
>  src/openvpn/lzo.c      |   2 +-
>  src/openvpn/mtu.h      |   2 +-
>  src/openvpn/options.c  | 115 +++++++++++++++++++++++++++++++++++------
>  7 files changed, 153 insertions(+), 31 deletions(-)
>
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index dcc72abe..03ae5ac5 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -2545,26 +2545,54 @@ Enable a compression algorithm.
>
>  The
>  .B algorithm
> -parameter may be "lzo", "lz4", or empty.  LZO and LZ4
> -are different compression algorithms, with LZ4 generally
> +parameter may be "lzo", "lz4", "lz4\-v2", "stub", "stub\-v2" or empty.
> +LZO and LZ4 are different compression algorithms, with LZ4 generally
>  offering the best performance with least CPU usage.
>  For backwards compatibility with OpenVPN versions before v2.4, use "lzo"
>  (which is identical to the older option "\-\-comp\-lzo yes").
>
> +The "lz4\-v2" and "stub\-v2" variants implement a better framing that do=
es not add
> +overhead when packets cannot be compressed. All other variants always ad=
d one extra
> +framing byte compared to no compression framing.
> +
>  If the
>  .B algorithm
> -parameter is empty, compression will be turned off, but the packet
> -framing for compression will still be enabled, allowing a different
> -setting to be pushed later.
> +parameter is "stub", "stub\-v2", or empty, compression will be turned of=
f, but
> +the packet framing for compression will still be enabled, allowing a dif=
ferent
> +setting to be pushed later. Additionally, "stub" and "stub\-v2" will dis=
able
> +announcing lzo and lz4 compression support via "IV_" variables to the se=
rver.
> +
>
>  .B Security Considerations
>
>  Compression and encryption is a tricky combination.  If an attacker know=
s or is
>  able to control (parts of) the plaintext of packets that contain secrets=
, the
>  attacker might be able to extract the secret if compression is enabled. =
 See
> -e.g. the CRIME and BREACH attacks on TLS which also leverage compression=
 to
> -break encryption.  If you are not entirely sure that the above does not =
apply
> -to your traffic, you are advised to *not* enable compression.
> +e.g. the CRIME and BREACH attacks on TLS and VORACLE on VPNs which also =
leverage
> +compression to break encryption.  If you are not entirely sure that the =
above does
> +not apply to your traffic, you are advised to *not* enable compression.
> +
> +.\"*********************************************************
> +.TP
> +.B \-\-allow\-compression [mode]
> +As described in
> +\.B \-\-compress
> +option, compression is potentially dangerous option. This option allows
> +controlling the behaviour of OpenVPN when compression is used and allowe=
d.
> +.B mode
> +may be "yes", "no", or "asym" (default).
> +
> +With allow\-compression set to "no", OpenVPN will refuse any non stub
> +compression. With "yes" OpenVPN will send and receive compressed packets.
> +With "asym", the default, OpenVPN will only decompress (downlink) packet=
s but
> +not compress (uplink) packets. This also allows migrating to disable com=
pression
> +when changing both server and client configurations to remove compressio=
n at the
> +same time is not a feasible option.
> +
> +The default of asym has been chosen to maximise compatibility with exist=
ing
> +configuration while at the same time phasing out compression in existing
> +deployment by disabling compression on the uplink, effectively completel=
y disabling
> +compression if both client and server are upgraded.
>
>  .\"*********************************************************
>  .TP
> diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
> index f52fdbfb..30e6da95 100644
> --- a/src/openvpn/comp-lz4.c
> +++ b/src/openvpn/comp-lz4.c
> @@ -70,8 +70,9 @@ do_lz4_compress(struct buffer *buf,
>  {
>      /*
>       * In order to attempt compression, length must be at least COMPRESS=
_THRESHOLD.
> +     * and asymmetric compression must be disabled
>       */
> -    if (buf->len >=3D COMPRESS_THRESHOLD)
> +    if (buf->len >=3D COMPRESS_THRESHOLD && (compctx->flags & COMP_F_ALL=
OW_COMPRESS))
>      {
>          const size_t ps =3D PAYLOAD_SIZE(frame);
>          int zlen_max =3D ps + COMP_EXTRA_BUFFER(ps);
> diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
> index a9459133..9b131137 100644
> --- a/src/openvpn/comp.c
> +++ b/src/openvpn/comp.c
> @@ -127,7 +127,7 @@ void
>  comp_add_to_extra_buffer(struct frame *frame)
>  {
>      /* Leave room for compression buffer to expand in worst case scenario
> -     * where data is totally uncompressible */
> +     * where data is totally incompressible */
>      frame_add_to_extra_buffer(frame, COMP_EXTRA_BUFFER(EXPANDED_SIZE(fra=
me)));
>  }
>
> diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
> index 0dadd1e6..5c0322ca 100644
> --- a/src/openvpn/comp.h
> +++ b/src/openvpn/comp.h
> @@ -52,10 +52,12 @@
>   */
>
>  /* Compression flags */
> -#define COMP_F_ADAPTIVE   (1<<0) /* COMP_ALG_LZO only */
> -#define COMP_F_ASYM       (1<<1) /* only downlink is compressed, not upl=
ink */
> -#define COMP_F_SWAP       (1<<2) /* initial command byte is swapped with=
 last byte in buffer to preserve payload alignment */
> +#define COMP_F_ADAPTIVE             (1<<0) /* COMP_ALG_LZO only */
> +#define COMP_F_ALLOW_COMPRESS       (1<<1) /* not only downlink is compr=
essed but also uplink */
> +#define COMP_F_SWAP                 (1<<2) /* initial command byte is sw=
apped with last byte in buffer to preserve payload alignment */
>  #define COMP_F_ADVERTISE_STUBS_ONLY (1<<3) /* tell server that we only s=
upport compression stubs */
> +#define COMP_F_ALLOW_STUB_ONLY      (1<<4) /* Only accept stub compressi=
on, even with COMP_F_ADVERTISE_STUBS_ONLY
> +                                            * we still accept other comp=
ressions to be pushed */
>
>
>  /*
> @@ -188,6 +190,14 @@ comp_enabled(const struct compress_options *info)
>      return info->alg !=3D COMP_ALG_UNDEF;
>  }
>
> +static inline bool
> +comp_non_stub_enabled(const struct compress_options *info)
> +{
> +    return info->alg !=3D COMP_ALGV2_UNCOMPRESSED
> +           && info->alg !=3D COMP_ALG_STUB
> +           && info->alg !=3D COMP_ALG_UNDEF;
> +}
> +
>  static inline bool
>  comp_unswapped_prefix(const struct compress_options *info)
>  {
> diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
> index e3be6adf..d053fedf 100644
> --- a/src/openvpn/lzo.c
> +++ b/src/openvpn/lzo.c
> @@ -123,7 +123,7 @@ lzo_compress_uninit(struct compress_context *compctx)
>  static inline bool
>  lzo_compression_enabled(struct compress_context *compctx)
>  {
> -    if (compctx->flags & COMP_F_ASYM)
> +    if (!(compctx->flags & COMP_F_ALLOW_COMPRESS))
>      {
>          return false;
>      }
> diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
> index cfa8d2f7..549c319b 100644
> --- a/src/openvpn/mtu.h
> +++ b/src/openvpn/mtu.h
> @@ -45,7 +45,7 @@
>   *      ifconfig $1 10.1.0.2 pointopoint 10.1.0.1 mtu 1450
>   *
>   *    Compression overflow bytes is the worst-case size expansion that w=
ould be
> - *    expected if we tried to compress mtu + extra_frame bytes of uncomp=
ressible data.
> + *    expected if we tried to compress mtu + extra_frame bytes of incomp=
ressible data.
>   */
>
>  /*
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 3484f7d4..9580d1d2 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -357,9 +357,10 @@ static const char usage_message[] =3D
>  #endif
>  #if defined(USE_COMP)
>      "--compress alg  : Use compression algorithm alg\n"
> +    "--allow-compression: Specify whether compression should be allowed\=
n"
>  #if defined(ENABLE_LZO)
>      "--comp-lzo      : Use LZO compression -- may add up to 1 byte per\n"
> -    "                  packet for uncompressible data.\n"
> +    "                  packet for incompressible data.\n"
>      "--comp-noadapt  : Don't use adaptive compression when --comp-lzo\n"
>      "                  is specified.\n"
>  #endif
> @@ -4978,11 +4979,11 @@ options_string_import(struct options *options,
>  #if P2MP
>
>  #define VERIFY_PERMISSION(mask) {                                       =
     \
> -    if (!verify_permission(p[0], file, line, (mask), permission_mask,   =
     \
> -                           option_types_found, msglevel, options, is_inl=
ine))\
> -    {                                                                   =
     \
> -        goto err;                                                       =
     \
> -    }                                                                   =
     \
> +        if (!verify_permission(p[0], file, line, (mask), permission_mask=
,        \
> +                               option_types_found, msglevel, options, is=
_inline)) \
> +        {                                                               =
         \
> +            goto err;                                                   =
         \
> +        }                                                               =
         \
>  }
>
>  static bool
> @@ -5115,6 +5116,25 @@ set_user_script(struct options *options,
>  #endif
>  }
>
> +static void
> +show_compression_warning(struct compress_options *info)
> +{
> +    if (comp_non_stub_enabled(info))
> +    {
> +        /*
> +         * Check if already displayed the strong warning and enabled full
> +         * compression
> +         */
> +        if (!(info->flags & COMP_F_ALLOW_COMPRESS))
> +        {
> +            msg(M_WARN, "WARNING: Compression for receiving enabled. "
> +                "Compression has been used in the past to break encrypti=
on. "
> +                "Sent packets are not compressed unless \"allow-compress=
ion yes\" "
> +                "is also set.");
> +        }
> +    }
> +}
> +
>  static void
>  add_option(struct options *options,
>             char *p[],
> @@ -7606,29 +7626,80 @@ add_option(struct options *options,
>      }
>  #endif
>  #if defined(USE_COMP)
> +    else if (streq(p[0], "allow-compression") && p[1] && !p[2])
> +    {
> +        VERIFY_PERMISSION(OPT_P_GENERAL);
> +
> +        if (streq(p[1], "no"))
> +        {
> +            options->comp.flags =3D
> +                COMP_F_ALLOW_STUB_ONLY|COMP_F_ADVERTISE_STUBS_ONLY;
> +            if (comp_non_stub_enabled(&options->comp))
> +            {
> +                msg(msglevel, "'--allow-compression no' conflicts with "
> +                    " enabling compression");
> +            }
> +        }
> +        else if (options->comp.flags & COMP_F_ALLOW_STUB_ONLY)
> +        {
> +            /* Also printed on a push to hint at configuration problems =
*/
> +            msg(msglevel, "Cannot set allow-compression to '%s' "
> +                "after set to 'no'", p[1]);
> +            goto err;
> +        }
> +        else if (streq(p[1], "asym"))
> +        {
> +            options->comp.flags &=3D ~COMP_F_ALLOW_COMPRESS;
> +        }
> +        else if (streq(p[1], "yes"))
> +        {
> +            msg(M_WARN, "WARNING: Compression for sending and receiving =
enabled. Compression has "
> +                "been used in the past to break encryption. Allowing com=
pression allows "
> +                "attacks that break encryption. Using \"--allow-compress=
ion yes\" is "
> +                "strongly discouraged for common usage. See --compress i=
n the manual "
> +                "page for more information ");
> +
> +            options->comp.flags |=3D COMP_F_ALLOW_COMPRESS;
> +        }
> +        else
> +        {
> +            msg(msglevel, "bad allow-compression option: %s -- "
> +                "must be 'yes', 'no', or 'asym'", p[1]);
> +            goto err;
> +        }
> +    }
>      else if (streq(p[0], "comp-lzo") && !p[2])
>      {
>          VERIFY_PERMISSION(OPT_P_COMP);
>
> +        /* All lzo variants do not use swap */
> +        options->comp.flags &=3D ~COMP_F_SWAP;
>  #if defined(ENABLE_LZO)
>          if (p[1] && streq(p[1], "no"))
>  #endif
>          {
>              options->comp.alg =3D COMP_ALG_STUB;
> -            options->comp.flags =3D 0;
> +            options->comp.flags &=3D ~COMP_F_ADAPTIVE;
>          }
>  #if defined(ENABLE_LZO)
> +        else if (options->comp.flags & COMP_F_ALLOW_STUB_ONLY)
> +        {
> +            /* Also printed on a push to hint at configuration problems =
*/
> +            msg(msglevel, "Cannot set comp-lzo to '%s', "
> +                "allow-compression is set to 'no'", p[1]);
> +            goto err;
> +        }
>          else if (p[1])
>          {
>              if (streq(p[1], "yes"))
>              {
>                  options->comp.alg =3D COMP_ALG_LZO;
> -                options->comp.flags =3D 0;
> +                options->comp.flags &=3D ~COMP_F_ADAPTIVE;
>              }
>              else if (streq(p[1], "adaptive"))
>              {
>                  options->comp.alg =3D COMP_ALG_LZO;
> -                options->comp.flags =3D COMP_F_ADAPTIVE;
> +                options->comp.flags |=3D COMP_F_ADAPTIVE;
>              }
>              else
>              {
> @@ -7639,12 +7710,17 @@ add_option(struct options *options,
>          else
>          {
>              options->comp.alg =3D COMP_ALG_LZO;
> -            options->comp.flags =3D COMP_F_ADAPTIVE;
> +            options->comp.flags |=3D COMP_F_ADAPTIVE;
>          }
> +        show_compression_warning(&options->comp);
>  #endif /* if defined(ENABLE_LZO) */
>      }
>      else if (streq(p[0], "comp-noadapt") && !p[1])
>      {
> +        /*
> +         * We do not need to check here if we allow compression since
> +         * it only modifies a flag if compression is enabled
> +         */
>          VERIFY_PERMISSION(OPT_P_COMP);
>          options->comp.flags &=3D ~COMP_F_ADAPTIVE;
>      }
> @@ -7656,30 +7732,36 @@ add_option(struct options *options,
>              if (streq(p[1], "stub"))
>              {
>                  options->comp.alg =3D COMP_ALG_STUB;
> -                options->comp.flags =3D (COMP_F_SWAP|COMP_F_ADVERTISE_ST=
UBS_ONLY);
> +                options->comp.flags |=3D (COMP_F_SWAP|COMP_F_ADVERTISE_S=
TUBS_ONLY);
>              }
>              else if (streq(p[1], "stub-v2"))
>              {
>                  options->comp.alg =3D COMP_ALGV2_UNCOMPRESSED;
> -                options->comp.flags =3D COMP_F_ADVERTISE_STUBS_ONLY;
> +                options->comp.flags |=3D COMP_F_ADVERTISE_STUBS_ONLY;
> +            }
> +            else if (options->comp.flags & COMP_F_ALLOW_STUB_ONLY)
> +            {
> +                /* Also printed on a push to hint at configuration probl=
ems */
> +                msg(msglevel, "Cannot set compress to '%s', "
> +                    "allow-compression is set to 'no'", p[1]);
> +                goto err;
>              }
>  #if defined(ENABLE_LZO)
>              else if (streq(p[1], "lzo"))
>              {
>                  options->comp.alg =3D COMP_ALG_LZO;
> -                options->comp.flags =3D 0;
> +                options->comp.flags &=3D ~(COMP_F_ADAPTIVE | COMP_F_SWAP=
);
>              }
>  #endif
>  #if defined(ENABLE_LZ4)
>              else if (streq(p[1], "lz4"))
>              {
>                  options->comp.alg =3D COMP_ALG_LZ4;
> -                options->comp.flags =3D COMP_F_SWAP;
> +                options->comp.flags |=3D COMP_F_SWAP;
>              }
>              else if (streq(p[1], "lz4-v2"))
>              {
>                  options->comp.alg =3D COMP_ALGV2_LZ4;
> -                options->comp.flags =3D 0;
>              }
>  #endif
>              else
> @@ -7691,8 +7773,9 @@ add_option(struct options *options,
>          else
>          {
>              options->comp.alg =3D COMP_ALG_STUB;
> -            options->comp.flags =3D COMP_F_SWAP;
> +            options->comp.flags |=3D COMP_F_SWAP;
>          }
> +        show_compression_warning(&options->comp);
>      }
>  #endif /* USE_COMP */
>      else if (streq(p[0], "show-ciphers") && !p[1])
> --
> 2.26.2
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



--=20
-Lev

