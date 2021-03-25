References: <20210319153129.8734-2-arne@...1227...>
 <20210324220853.31246-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <2222d9d1-864f-ba18-06d6-00dc0ee157b4@...2181...>
Date: Thu, 25 Mar 2021 21:13:13 +0100
MIME-Version: 1.0
In-Reply-To: <20210324220853.31246-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] Implement '--compress migrate' to
 migrate to non-compression setup
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 24/03/2021 23:08, Arne Schwabe wrote:
> This option allow migration to a non compression server config while
> still retraining compatibility with client that have a compression
> setting in their config.
> 
> For existing setups that used to have comp-lzo no or another
> compression setting in their configs it is a difficult to migrate to
> a setup without compression without replacing all client configs at
> once especially if OpenVPN 2.3 or earlier clients are in the mix that
> do not support pushing stub-v2. Even with OpenVPN 2.4 and later clients
> that support pushing this is not a satisfying solution as the clients
> log occ mismatches and the "push stub-v2" needs to be in the server
> config "forever".
> 
> If the new migrate option to compress is set and  a client is detected
> that indicates that compression is used (via OCC), the server will
> automatically add ``--push compress stub-v2`` to the client specific
> configuration if stub-v2 is supported by the client and otherwise
> switch to ``comp-lzo no`` and add ``--push comp-lzo`` to the client
> specific configuration.
> 
> Patch v2: better commit message/man page, add USE_COMP ifdefs, various style
>           fixes
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/man-sections/protocol-options.rst | 13 ++++-
>  src/openvpn/comp.h                    |  1 +
>  src/openvpn/multi.c                   | 42 ++++++++++++++
>  src/openvpn/options.c                 |  6 ++
>  src/openvpn/ssl.c                     | 43 +++++++++++++-
>  src/openvpn/ssl_common.h              |  1 +
>  src/openvpn/ssl_util.c                | 41 +++++++++++++
>  src/openvpn/ssl_util.h                | 15 +++++
>  tests/unit_tests/openvpn/Makefile.am  | 13 ++++-
>  tests/unit_tests/openvpn/test_misc.c  | 83 +++++++++++++++++++++++++++
>  10 files changed, 252 insertions(+), 6 deletions(-)
>  create mode 100644 tests/unit_tests/openvpn/test_misc.c
> 
> diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
> index e9d5d63d..01789e58 100644
> --- a/doc/man-sections/protocol-options.rst
> +++ b/doc/man-sections/protocol-options.rst
> @@ -84,10 +84,10 @@ configured in a compatible way between both the local and remote side.
>  --compress algorithm
>    **DEPRECATED** Enable a compression algorithm.  Compression is generally
>    not recommended.  VPN tunnels which use compression are susceptible to
> -  the VORALCE attack vector.
> +  the VORALCE attack vector. See also the :code:`migrate` parameter below.
>  
>    The ``algorithm`` parameter may be :code:`lzo`, :code:`lz4`,
> -  :code:`lz4-v2`, :code:`stub`, :code:`stub-v2` or empty.
> +  :code:`lz4-v2`, :code:`stub`, :code:`stub-v2`, :code:`migrate` or empty.
>    LZO and LZ4 are different compression algorithms, with LZ4 generally
>    offering the best performance with least CPU usage.
>  
> @@ -106,6 +106,15 @@ configured in a compatible way between both the local and remote side.
>    Note: the :code:`stub` (or empty) option is NOT compatible with the older
>    option ``--comp-lzo no``.
>  
> +  Using :code:`migrate` as compression algorithm enables a special migration mode.
> +  It allows migration away from the ``--compress``/``--comp-lzo`` options to no compression.
> +  This option sets the server to no compression mode and the server behaves identical to
> +  a server without a compression option for all clients without a compression in their
> +  config. However, if a client is detected that indicates that compression is used (via OCC),
> +  the server will automatically add ``--push compress stub-v2`` to the client specific
> +  configuration if supported by the client and otherwise switch to ``comp-lzo no``
> +  and add ``--push comp-lzo`` to the client specific configuration.
> +
>    ***Security Considerations***
>  
>    Compression and encryption is a tricky combination. If an attacker knows
> diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
> index 5c0322ca..a880e198 100644
> --- a/src/openvpn/comp.h
> +++ b/src/openvpn/comp.h
> @@ -58,6 +58,7 @@
>  #define COMP_F_ADVERTISE_STUBS_ONLY (1<<3) /* tell server that we only support compression stubs */
>  #define COMP_F_ALLOW_STUB_ONLY      (1<<4) /* Only accept stub compression, even with COMP_F_ADVERTISE_STUBS_ONLY
>                                              * we still accept other compressions to be pushed */
> +#define COMP_F_MIGRATE              (1<<5) /* push stub-v2 or comp-lzo no when we see a client with comp-lzo in occ */
>  
>  
>  /*
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index f7e0f680..5c495036 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2469,6 +2469,47 @@ multi_client_connect_early_setup(struct multi_context *m,
>      multi_client_connect_setenv(m, mi);
>  }
>  
> +/**
> + *  Do the necessary modification for doing the compress migrate. This is
> + *  implemented as a connect handler as it fits the modify config for a client
> + *  paradigm and also is early enough in the chain to be overwritten by another
> + *  ccd/script to do compression on a special client.
> + */
> +static enum client_connect_return
> +multi_client_connect_compress_migrate(struct multi_context *m,
> +                                      struct multi_instance *mi,
> +                                      bool deferred,
> +                                      unsigned int *option_types_found)
> +{
> +#ifdef USE_COMP
> +    struct options *o = &mi->context.options;
> +    const char *const peer_info = mi->context.c2.tls_multi->peer_info;
> +
> +    if (!peer_info)
> +    {
> +        return CC_RET_SUCCEEDED;
> +    }
> +
> +    if (o->comp.flags & COMP_F_MIGRATE && mi->context.c2.tls_multi->remote_usescomp)
> +    {
> +        if(strstr(peer_info, "IV_COMP_STUBv2=1"))
> +        {
> +            push_option(o, "compress stub-v2", M_USAGE);
> +        }
> +        else
> +        {
> +            /* Client is old and does not support STUBv2 but since it
> +             * announced comp-lzo via OCC we assume it uses comp-lzo, so
> +             * switch to that and push the uncompressed variant. */
> +            push_option(o, "comp-lzo no", M_USAGE);
> +            o->comp.alg = COMP_ALG_STUB;
> +            *option_types_found |= OPT_P_COMP;
> +        }
> +    }
> +#endif
> +    return CC_RET_SUCCEEDED;
> +}
> +
>  /**
>   * Try to source a dynamic config file from the
>   * --client-config-dir directory.
> @@ -2537,6 +2578,7 @@ typedef enum client_connect_return (*multi_client_connect_handler)
>      bool from_deferred, unsigned int *option_types_found);
>  
>  static const multi_client_connect_handler client_connect_handlers[] = {
> +    multi_client_connect_compress_migrate,
>      multi_client_connect_source_ccd,
>      multi_client_connect_call_plugin_v1,
>      multi_client_connect_call_plugin_v2,
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 51bd56c2..e52679f0 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -7783,6 +7783,12 @@ add_option(struct options *options,
>                  options->comp.alg = COMP_ALGV2_UNCOMPRESSED;
>                  options->comp.flags |= COMP_F_ADVERTISE_STUBS_ONLY;
>              }
> +            else if (streq(p[1], "migrate"))
> +            {
> +                options->comp.alg = COMP_ALG_UNDEF;
> +                options->comp.flags = COMP_F_MIGRATE;
> +
> +            }
>              else if (options->comp.flags & COMP_F_ALLOW_STUB_ONLY)
>              {
>                  /* Also printed on a push to hint at configuration problems */
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 893e5753..0daf19ad 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -60,6 +60,7 @@
>  #include "ssl_verify.h"
>  #include "ssl_backend.h"
>  #include "ssl_ncp.h"
> +#include "ssl_util.h"
>  #include "auth_token.h"
>  
>  #include "memdbg.h"
> @@ -2235,12 +2236,24 @@ error:
>      return ret;
>  }
>  
> +#ifdef USE_COMP
> +static bool
> +write_compat_local_options(struct buffer *buf, const char *options)
> +{
> +    struct gc_arena gc = gc_new();
> +    const char *local_options = options_string_compat_lzo(options, &gc);
> +    bool ret = write_string(buf, local_options, TLS_OPTIONS_LEN);
> +    gc_free(&gc);
> +    return ret;
> +}
> +#endif
> +
>  /**
>   * Handle the writing of key data, peer-info, username/password, OCC
>   * to the TLS control channel (cleartext).
>   */
>  static bool
> -key_method_2_write(struct buffer *buf, struct tls_session *session)
> +key_method_2_write(struct buffer *buf, struct tls_multi *multi, struct tls_session *session)
>  {
>      struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
>  
> @@ -2266,7 +2279,19 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
>  
>      /* write options string */
>      {
> +#ifdef USE_COMP
> +        if (multi->remote_usescomp && session->opt->mode == MODE_SERVER
> +           && multi->opt.comp_options.flags & COMP_F_MIGRATE)
> +        {
> +            if (!write_compat_local_options(buf, session->opt->local_options))
> +            {
> +                goto error;
> +            }
> +        }
> +        else
> +#endif
>          if (!write_string(buf, session->opt->local_options, TLS_OPTIONS_LEN))
> +
>          {
>              goto error;
>          }
> @@ -2460,6 +2485,7 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
>      free(multi->remote_ciphername);
>      multi->remote_ciphername =
>          options_string_extract_option(options, "cipher", NULL);
> +    multi->remote_usescomp = strstr(options, ",comp-lzo,");
>  
>      /* In OCC we send '[null-cipher]' instead 'none' */
>      if (multi->remote_ciphername
> @@ -2509,7 +2535,18 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
>      if (!session->opt->disable_occ
>          && !options_cmp_equal(options, session->opt->remote_options))
>      {
> -        options_warning(options, session->opt->remote_options);
> +        const char *remote_options = session->opt->remote_options;
> +#ifdef USE_COMP
> +        if (multi->opt.comp_options.flags & COMP_F_MIGRATE && multi->remote_usescomp)
> +        {
> +            msg(D_SHOW_OCC, "Note: 'compress migrate' detected remote peer "
> +                            "with compression enabled.");
> +            remote_options = options_string_compat_lzo(remote_options, &gc);
> +        }
> +#endif
> +
> +        options_warning(options, remote_options);
> +
>          if (session->opt->ssl_flags & SSLF_OPT_VERIFY)
>          {
>              msg(D_TLS_ERRORS, "Option inconsistency warnings triggering disconnect due to --opt-verify");
> @@ -2826,7 +2863,7 @@ tls_process(struct tls_multi *multi,
>          if (!buf->len && ((ks->state == S_START && !session->opt->server)
>                            || (ks->state == S_GOT_KEY && session->opt->server)))
>          {
> -            if (!key_method_2_write(buf, session))
> +            if (!key_method_2_write(buf, multi, session))
>              {
>                  goto error;
>              }
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index 4e1ff6c8..c96f8ed4 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -576,6 +576,7 @@ struct tls_multi
>      bool use_peer_id;
>  
>      char *remote_ciphername;    /**< cipher specified in peer's config file */
> +    bool remote_usescomp;       /**< remote announced comp-lzo in OCC string */
>  
>      /*
>       * Our session objects.
> diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
> index f6e66be4..ce67907e 100644
> --- a/src/openvpn/ssl_util.c
> +++ b/src/openvpn/ssl_util.c
> @@ -75,3 +75,44 @@ extract_iv_proto(const char *peer_info)
>      }
>      return 0;
>  }
> +
> +const char *
> +options_string_compat_lzo(const char *options, struct gc_arena *gc)
> +{
> +    /* Example string without and with comp-lzo, i.e. input/output of this function */
> +    /* w/o comp: 'V4,dev-type tun,link-mtu 1457,tun-mtu 1400,proto UDPv4,auth SHA1,keysize 128,key-method 2,tls-server' */
> +    /* comp-lzo: 'V4,dev-type tun,link-mtu 1458,tun-mtu 1400,proto UDPv4,comp-lzo,auth SHA1,keysize 128,key-method 2,tls-server' */
> +
> +    /* Note: since this function is used only in a very limited scope it makes
> +     * assumptions how the string looks. Since we locally generated the string
> +     * we can make these assumptions */
> +
> +    /* Check that the link-mtu string is in options */
> +    const char *tmp = strstr(options, ",link-mtu");
> +    if (!tmp)
> +    {
> +        return options;
> +    }
> +
> +    /* Get old link_mtu size */
> +    int link_mtu;
> +    if(sscanf(tmp, ",link-mtu %d,", &link_mtu) != 1 || link_mtu < 100 || link_mtu > 9900)

missing space after if

> +    {
> +        return options;
> +    }
> +
> +    /* 1 byte for the possibility of 999 to 1000 and 1 byte for the null
> +     * terminator */
> +    struct buffer buf = alloc_buf_gc(strlen(options) + strlen(",comp-lzo") + 2, gc);
> +
> +    buf_write(&buf, options, (int)(tmp - options));
> +
> +    /* Increase link-mtu by one for the comp-lzo opcode */
> +    buf_printf(&buf, ",link-mtu %d", link_mtu + 1);
> +
> +    tmp += strlen(",link-mtu ") + (link_mtu < 1000 ? 3 : 4);
> +
> +    buf_printf(&buf, "%s,comp-lzo", tmp);
> +
> +    return BSTR(&buf);
> +}
> diff --git a/src/openvpn/ssl_util.h b/src/openvpn/ssl_util.h
> index 741a7782..472aa591 100644
> --- a/src/openvpn/ssl_util.h
> +++ b/src/openvpn/ssl_util.h
> @@ -54,4 +54,19 @@ extract_var_peer_info(const char *peer_info,
>   */
>  unsigned int
>  extract_iv_proto(const char *peer_info);
> +
> +/**
> + * Takes a locally produced OCC string for TLS server mode and modifies as
> + * if the option comp-lzo was enabled. This is to send a client in
> + * comp-lzo migrate mode the expected OCC string.
> + *
> + * Note: This function excpets the string to be in the locally generated
> + * format and does not accept arbitrary strings.
> + *
> + * @param options   the locally generated OCC string
> + * @param gc        gc_arena to allocate the returned string in
> + * @return          the modified string or options on error
> + */
> +const char *
> +options_string_compat_lzo(const char *options, struct gc_arena *gc);
>  #endif
> diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
> index 50f3a02e..44b77cc5 100644
> --- a/tests/unit_tests/openvpn/Makefile.am
> +++ b/tests/unit_tests/openvpn/Makefile.am
> @@ -6,7 +6,7 @@ if HAVE_LD_WRAP_SUPPORT
>  test_binaries += argv_testdriver buffer_testdriver
>  endif
>  
> -test_binaries += crypto_testdriver packet_id_testdriver auth_token_testdriver ncp_testdriver
> +test_binaries += crypto_testdriver packet_id_testdriver auth_token_testdriver ncp_testdriver misc_testdriver
>  if HAVE_LD_WRAP_SUPPORT
>  test_binaries += tls_crypt_testdriver
>  endif
> @@ -127,3 +127,14 @@ ncp_testdriver_SOURCES = test_ncp.c mock_msg.c \
>  	$(openvpn_srcdir)/packet_id.c \
>  	$(openvpn_srcdir)/platform.c \
>  	$(openvpn_srcdir)/ssl_util.c
> +
> +misc_testdriver_CFLAGS  = @TEST_CFLAGS@ \
> +	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir)
> +
> +misc_testdriver_LDFLAGS = @TEST_LDFLAGS@
> +
> +misc_testdriver_SOURCES = test_misc.c mock_msg.c \
> +    mock_get_random.c \
> +	$(openvpn_srcdir)/buffer.c \
> +	$(openvpn_srcdir)/ssl_util.c \
> +	$(openvpn_srcdir)/platform.c
> \ No newline at end of file
> diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
> new file mode 100644
> index 00000000..15f6cbff
> --- /dev/null
> +++ b/tests/unit_tests/openvpn/test_misc.c
> @@ -0,0 +1,83 @@
> +/*
> + *  OpenVPN -- An application to securely tunnel IP networks
> + *             over a single UDP port, with support for SSL/TLS-based
> + *             session authentication and key exchange,
> + *             packet encryption, packet authentication, and
> + *             packet compression.
> + *
> + *  Copyright (C) 2021 Arne Schwabe <arne@...1227...>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2
> + *  as published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include "config.h"
> +#elif defined(_MSC_VER)
> +#include "config-msvc.h"
> +#endif
> +
> +#include "syshead.h"
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdarg.h>
> +#include <string.h>
> +#include <setjmp.h>
> +#include <cmocka.h>
> +
> +#include "ssl_util.h"
> +
> +static void
> +test_compat_lzo_string(void **state)
> +{
> +    struct gc_arena gc = gc_new();
> +
> +    const char* input = "V4,dev-type tun,link-mtu 1457,tun-mtu 1400,proto UDPv4,auth SHA1,keysize 128,key-method 2,tls-server";
> +
> +    const char* output = options_string_compat_lzo(input, &gc);
> +
> +    assert_string_equal(output, "V4,dev-type tun,link-mtu 1458,tun-mtu 1400,proto UDPv4,auth SHA1,keysize 128,key-method 2,tls-server,comp-lzo");
> +
> +    /* This string is has a much too small link-mtu so we should fail on it" */
> +    input = "V4,dev-type tun,link-mtu 2,tun-mtu 1400,proto UDPv4,auth SHA1,keysize 128,key-method 2,tls-server";
> +
> +    output = options_string_compat_lzo(input, &gc);
> +
> +    assert_string_equal(input, output);
> +
> +    /* not matching at all */
> +    input = "V4,dev-type tun";
> +    output = options_string_compat_lzo(input, &gc);
> +
> +    assert_string_equal(input, output);
> +
> +
> +    input = "V4,dev-type tun,link-mtu 999,tun-mtu 1400,proto UDPv4,auth SHA1,keysize 128,key-method 2,tls-server";
> +    output = options_string_compat_lzo(input, &gc);
> +
> +    /* 999 -> 1000, 3 to 4 chars */
> +    assert_string_equal(output, "V4,dev-type tun,link-mtu 1000,tun-mtu 1400,proto UDPv4,auth SHA1,keysize 128,key-method 2,tls-server,comp-lzo");
> +
> +};
> +
> +const struct CMUnitTest misc_tests[] = {
> +    cmocka_unit_test(test_compat_lzo_string),
> +};
> +
> +int
> +main(void)
> +{
> +    return cmocka_run_group_tests(misc_tests, NULL, NULL);
> +}
> 

Except for the minor style issue (that can be fixed as commit time),
this patch looks good and passes my tests with client announcing various
combinations of compress/comp and IV_COMP_STUBv2.


Acked-by: Antonio Quartulli <antonio@...515...>


-- 
Antonio Quartulli

