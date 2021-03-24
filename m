References: <20210319153129.8734-1-arne@...1227...>
 <20210319153129.8734-2-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <e90f000e-17b7-39e6-686a-2fdf72f2aa4e@...2181...>
Date: Wed, 24 Mar 2021 18:10:16 +0100
MIME-Version: 1.0
In-Reply-To: <20210319153129.8734-2-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/2] Implement '--compress migrate' to
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
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 19/03/2021 16:31, Arne Schwabe wrote:
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

As discussed on other channels, I think it would be beneficial to report
in the commit message also the "what is this patch doing to achieve this
goal?".
Basically a shorter version of what you are already putting in the manpage.

> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/man-sections/protocol-options.rst | 12 +++-
>  src/openvpn/comp.h                    |  1 +
>  src/openvpn/multi.c                   | 41 +++++++++++++
>  src/openvpn/options.c                 |  6 ++
>  src/openvpn/ssl.c                     | 34 ++++++++++-
>  src/openvpn/ssl_common.h              |  1 +
>  src/openvpn/ssl_util.c                | 43 ++++++++++++++
>  src/openvpn/ssl_util.h                | 15 +++++
>  tests/unit_tests/openvpn/Makefile.am  | 14 ++++-
>  tests/unit_tests/openvpn/test_misc.c  | 83 +++++++++++++++++++++++++++
>  10 files changed, 245 insertions(+), 5 deletions(-)
>  create mode 100644 tests/unit_tests/openvpn/test_misc.c
> 
> diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
> index e9d5d63d..c5cd76dd 100644
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
> @@ -106,6 +106,14 @@ configured in a compatible way between both the local and remote side.
>    Note: the :code:`stub` (or empty) option is NOT compatible with the older
>    option ``--comp-lzo no``.
>  
> +  The :code:`migrate` algorithm is a special and is intended to allow
> +  migration away from ``--compress``/``--comp-lzo`` options to no compression.
> +  This options set the server to no compression mode. If a client
> +  is detected that indicates that compression is used the will automatically

typ0 - missing $something after 'the'

> +  add ``--push compress stub-v2`` to the client specific configuration
> +  if supported by the client and otherwise  switch to ``comp-lzo no``
> +  and also ``--push comp-lzo`` to the client specific configuration.
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
> index f7e0f680..3060410d 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2469,6 +2469,46 @@ multi_client_connect_early_setup(struct multi_context *m,
>      multi_client_connect_setenv(m, mi);
>  }
>  
> +/**
> + *  Do the necessary modification for doing the compress mitigrate. This is

typ0: mitigrate

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
> +    struct options *o = &mi->context.options;
> +    const char *const peer_info =mi->context.c2.tls_multi->peer_info;

space after =

> +
> +    if (!peer_info)
> +    {
> +        return CC_RET_SUCCEEDED;
> +    }
> +
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
> +             * switch to that and pushed the uncompressed variant. */

pushed -> push ?

> +            push_option(o, "comp-lzo no", M_USAGE);
> +            o->comp.alg = COMP_ALG_STUB;
> +            *option_types_found |= OPT_P_COMP;
> +        }
> +    }
> +    return CC_RET_SUCCEEDED;
> +}
> +
>  /**
>   * Try to source a dynamic config file from the
>   * --client-config-dir directory.
> @@ -2537,6 +2577,7 @@ typedef enum client_connect_return (*multi_client_connect_handler)
>      bool from_deferred, unsigned int *option_types_found);
>  
>  static const multi_client_connect_handler client_connect_handlers[] = {
> +    multi_client_connect_compress_migrate,
>      multi_client_connect_source_ccd,
>      multi_client_connect_call_plugin_v1,
>      multi_client_connect_call_plugin_v2,
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 86e78b05..f0d1e128 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -7692,6 +7692,12 @@ add_option(struct options *options,
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
> index 893e5753..7ab8d585 100644
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
> @@ -2235,6 +2236,16 @@ error:
>      return ret;
>  }
>  
> +static bool
> +write_compat_local_options(struct buffer *buf, const char *options)
> +{
> +    struct gc_arena gc = gc_new();
> +    const char* local_options = options_string_compat_lzo(options, &gc);

space should go before * and not after.

> +    bool ret = write_string(buf, local_options, TLS_OPTIONS_LEN);
> +    gc_free(&gc);
> +    return ret;
> +}
> +
>  /**
>   * Handle the writing of key data, peer-info, username/password, OCC
>   * to the TLS control channel (cleartext).
> @@ -2266,7 +2277,15 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
>  
>      /* write options string */
>      {
> -        if (!write_string(buf, session->opt->local_options, TLS_OPTIONS_LEN))
> +        if (multi->remote_usescomp && session->opt->mode == MODE_SERVER
> +           && multi->opt.comp_options.flags & COMP_F_MIGRATE)
> +        {
> +            if (!write_compat_local_options(buf, session->opt->local_options))
> +            {
> +                goto error;
> +            }
> +        }
> +        else if (!write_string(buf, session->opt->local_options, TLS_OPTIONS_LEN))
>          {
>              goto error;
>          }
> @@ -2460,6 +2479,7 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
>      free(multi->remote_ciphername);
>      multi->remote_ciphername =
>          options_string_extract_option(options, "cipher", NULL);
> +    multi->remote_usescomp = strstr(options, ",comp-lzo,") != NULL;

remote_usescomp is bool - we never do "strstr() != NULL" when we need a
boolean result.

>  
>      /* In OCC we send '[null-cipher]' instead 'none' */
>      if (multi->remote_ciphername
> @@ -2509,7 +2529,17 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
>      if (!session->opt->disable_occ
>          && !options_cmp_equal(options, session->opt->remote_options))
>      {
> -        options_warning(options, session->opt->remote_options);
> +        const char *remote_options = session->opt->remote_options;
> +        if (multi->opt.comp_options.flags & COMP_F_MIGRATE && multi->remote_usescomp)
> +        {
> +            msg(D_SHOW_OCC, "Note: --comp-lzo migrate is enabled and remote "
> +                            "announces comp-lzo, consider removing "
> +                            "compress/comp-lzo options from remote config.");

should we explain a bit more what is happening? i.e. compression is
being forcefully disabled?

> +            remote_options = options_string_compat_lzo(remote_options, &gc);
> +        }
> +
> +        options_warning(options, remote_options);
> +
>          if (session->opt->ssl_flags & SSLF_OPT_VERIFY)
>          {
>              msg(D_TLS_ERRORS, "Option inconsistency warnings triggering disconnect due to --opt-verify");
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index 2e3c98db..5791b014 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -574,6 +574,7 @@ struct tls_multi
>      bool use_peer_id;
>  
>      char *remote_ciphername;    /**< cipher specified in peer's config file */
> +    bool remote_usescomp;       /**< remote announced comp-lzo in OCC string */
>  
>      /*
>       * Our session objects.
> diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
> index f6e66be4..38b371f1 100644
> --- a/src/openvpn/ssl_util.c
> +++ b/src/openvpn/ssl_util.c
> @@ -75,3 +75,46 @@ extract_iv_proto(const char *peer_info)
>      }
>      return 0;
>  }
> +
> +const char *
> +options_string_compat_lzo(const char *options, struct gc_arena *gc> +{
> +

no need for this empty line?

> +    /* comp-lzo: 'V4,dev-type tun,link-mtu 1458,tun-mtu 1400,proto UDPv4,comp-lzo,auth SHA1,keysize 128,key-method 2,tls-server' */
> +    /* w/o comp: 'V4,dev-type tun,link-mtu 1457,tun-mtu 1400,proto UDPv4,auth SHA1,keysize 128,key-method 2,tls-server' */
> +

maybe this comment could be articulated a bit more? just to explain that
this is also a sample input/output for this function.

> +
> +    /* Note: since this function is used only in a very limited scope it makes
> +     * assumptions how the string looks. Since we locally generated the string
> +     * we can make these assumptions */
> +
> +
> +    /* Check that the link-mtu string is in options */
> +    const char* tmp = strstr(options, ",link-mtu");

space before the * and not after.

> +    if (!tmp)
> +    {
> +        return options;
> +    }
> +
> +    /* Get old link_mtu size */
> +    int link_mtu;
> +    if(sscanf(tmp, ",link-mtu %d,", &link_mtu) !=1 || link_mtu < 100 || link_mtu > 9000)

- 9000 is sometimes used in some setups. How about having 9900 as upper
bound?

- space after if

- space after !=

> +    {
> +        return options;
> +    }
> +
> +    struct buffer buf = alloc_buf_gc(strlen(options) + strlen(",comp-lzo") + 2, gc);

as suggested, please add a comment to explain why +2 is needed

> +
> +

no need for double empty line?

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
> +

no need for this empty line

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
> index 50f3a02e..524ef50d 100644
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
> @@ -127,3 +127,15 @@ ncp_testdriver_SOURCES = test_ncp.c mock_msg.c \
>  	$(openvpn_srcdir)/packet_id.c \
>  	$(openvpn_srcdir)/platform.c \
>  	$(openvpn_srcdir)/ssl_util.c
> +
> +

no need for double empty line

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
> index 00000000..4fcf82c1
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
> + *  Copyright (C) 2019 Arne Schwabe <arne@...1227...>

since the file is being introduced now, maybe it should carry a more
recent copyright year?

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


My comments are all basically about style only, because there is nothing
else to report.

The patch was discussed with Arne in a meeting and it represent a an
important milestone that will allow people to migrate away from having
compression enabled.

This is very important, especially after it was realized that
compression on the outer side of a VPN link can be dangerous.

I tested this patch (after manually applying the fix as per Arne's
suggestion) in the following scenarios:
* server with --compress migrate

1) client without any compression enabled -> data flows;
2) client with --compress lzo/lz4 -> server pushes compress stub-v2 ->
data flows;
3) client with --comp-lzo -> server pushes compress stub-v2 -> data flows;
4) client does not announce IV_COMP_STUBv2=1 and with --comp-lzo ->
server pushes comp-lzo no -> data flows;
5) client does not announce IV_COMP_STUBv2=1 and with --compress lzo/lz4
(I don't think any client can do this) -> server pushes comp-lzo no ->
data flows;


Cheers,

-- 
Antonio Quartulli

