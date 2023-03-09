MIME-Version: 1.0
References: <20230308150704.128797-1-frank@...2641...>
In-Reply-To: <20230308150704.128797-1-frank@...2641...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 8 Mar 2023 22:49:40 -0500
Message-ID: <CAKuzo_hjCm7cahPoEPbiOPrGVDKUfGjKcysVW0kCEPCHP8ezjg@...278...>
Content-Type: multipart/alternative; boundary="000000000000c1477c05f66f89bb"
Subject: Re: [Openvpn-devel] [PATCH] tests/unit_tests: Fix 'make distcheck'
 with subdir-objects enabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000c1477c05f66f89bb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 8, 2023 at 10:08=E2=80=AFAM Frank Lichtenheld <frank@...2641...>
wrote:

> Commit 7f72abcf8a56bb35a510a3409e03a4e2aaba50da enabled subdir-objects
> when using automake 1.16+.
>
> There is an issue with the handling of .deps directories with this option.
> While automake 1.16 fixed subdir-objects to work at all when _SOURCES
> contains "unexpanded references" and it did fix subdir-objects to work
> with out-of-tree build for "source files specified with an explicit
> '$(srcdir)'" those fixes are not transitive. "unexpanded references"
> still break out-of-tree builds when enforcing a read-only source dir
> like 'make distcheck' does. When using *explicit* references to
> srcdir and top_srcdir it works correctly.
>

Thanks for quickly finding a fix for this. Even after re-reading the related
changelog in automake a dozen times, I cannot figure arbitrary variable
expansion won't work as expected for out-of-tree builds with read-only
sources. But testing does show only $(srcdir) and $(top_srcdir) get
correctly handled, and the fix below appears to be a reasonable way out.

Tested "make distcheck" and also compared with a locally generated
search and replace version. LGTM.

Acked-by: Selva Nair <selva.nair@...277...>

<rant>We waited long enough to enable subdir-objects though automake
has been warning about this for almost a decade. Now they have softened
their stand on it from "this behaviour will change ..." and
"unconditionally cause ..." etc.. to "may change" in future. And, the
implementation is still lacking. In retrospect, we (I) could have waited
longer.
</rant>

Selva


> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>  tests/unit_tests/openvpn/Makefile.am          | 220 +++++++++---------
>  tests/unit_tests/plugins/auth-pam/Makefile.am |   6 +-
>  2 files changed, 110 insertions(+), 116 deletions(-)
>
> diff --git a/tests/unit_tests/openvpn/Makefile.am
> b/tests/unit_tests/openvpn/Makefile.am
> index ee0a3d8a..339c7ef3 100644
> --- a/tests/unit_tests/openvpn/Makefile.am
> +++ b/tests/unit_tests/openvpn/Makefile.am
> @@ -30,189 +30,185 @@ if HAVE_SITNL
>  check_PROGRAMS +=3D networking_testdriver
>  endif
>
> -openvpn_includedir =3D $(top_srcdir)/include
> -openvpn_srcdir =3D $(top_srcdir)/src/openvpn
> -compat_srcdir =3D $(top_srcdir)/src/compat
> -
> -argv_testdriver_CFLAGS  =3D @TEST_CFLAGS@ -I$(openvpn_srcdir)
> -I$(compat_srcdir)
> -argv_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(openvpn_srcdir)
> -Wl,--wrap=3Dparse_line
> +argv_testdriver_CFLAGS  =3D @TEST_CFLAGS@ -I$(top_srcdir)/src/openvpn
> -I$(top_srcdir)/src/compat
> +argv_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn
> -Wl,--wrap=3Dparse_line
>  argv_testdriver_SOURCES =3D test_argv.c mock_msg.c mock_msg.h \
>         mock_get_random.c \
> -       $(openvpn_srcdir)/platform.c \
> -       $(openvpn_srcdir)/buffer.c \
> -       $(openvpn_srcdir)/win32-util.c \
> -       $(openvpn_srcdir)/argv.c
> +       $(top_srcdir)/src/openvpn/platform.c \
> +       $(top_srcdir)/src/openvpn/buffer.c \
> +       $(top_srcdir)/src/openvpn/win32-util.c \
> +       $(top_srcdir)/src/openvpn/argv.c
>
> -buffer_testdriver_CFLAGS  =3D @TEST_CFLAGS@ -I$(openvpn_srcdir)
> -I$(compat_srcdir)
> -buffer_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(openvpn_srcdir)
> -Wl,--wrap=3Dparse_line
> +buffer_testdriver_CFLAGS  =3D @TEST_CFLAGS@ -I$(top_srcdir)/src/openvpn
> -I$(top_srcdir)/src/compat
> +buffer_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn
> -Wl,--wrap=3Dparse_line
>  buffer_testdriver_SOURCES =3D test_buffer.c mock_msg.c mock_msg.h \
>         mock_get_random.c \
> -       $(openvpn_srcdir)/win32-util.c \
> -       $(openvpn_srcdir)/platform.c
> +       $(top_srcdir)/src/openvpn/win32-util.c \
> +       $(top_srcdir)/src/openvpn/platform.c
>
>  crypto_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \
> -       -I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir)
> +       -I$(top_srcdir)/include -I$(top_srcdir)/src/compat
> -I$(top_srcdir)/src/openvpn
>  crypto_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
>  crypto_testdriver_SOURCES =3D test_crypto.c mock_msg.c mock_msg.h \
> -       $(openvpn_srcdir)/buffer.c \
> -       $(openvpn_srcdir)/crypto.c \
> -       $(openvpn_srcdir)/crypto_mbedtls.c \
> -       $(openvpn_srcdir)/crypto_openssl.c \
> -       $(openvpn_srcdir)/otime.c \
> -       $(openvpn_srcdir)/packet_id.c \
> -       $(openvpn_srcdir)/platform.c \
> -       $(openvpn_srcdir)/mtu.c \
> -       $(openvpn_srcdir)/win32-util.c \
> -       $(openvpn_srcdir)/mss.c
> +       $(top_srcdir)/src/openvpn/buffer.c \
> +       $(top_srcdir)/src/openvpn/crypto.c \
> +       $(top_srcdir)/src/openvpn/crypto_mbedtls.c \
> +       $(top_srcdir)/src/openvpn/crypto_openssl.c \
> +       $(top_srcdir)/src/openvpn/otime.c \
> +       $(top_srcdir)/src/openvpn/packet_id.c \
> +       $(top_srcdir)/src/openvpn/platform.c \
> +       $(top_srcdir)/src/openvpn/mtu.c \
> +       $(top_srcdir)/src/openvpn/win32-util.c \
> +       $(top_srcdir)/src/openvpn/mss.c
>
>  packet_id_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \
> -       -I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir)
> +       -I$(top_srcdir)/include -I$(top_srcdir)/src/compat
> -I$(top_srcdir)/src/openvpn
>  packet_id_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
>  packet_id_testdriver_SOURCES =3D test_packet_id.c mock_msg.c mock_msg.h \
>         mock_get_random.c \
> -       $(openvpn_srcdir)/buffer.c \
> -       $(openvpn_srcdir)/otime.c \
> -       $(openvpn_srcdir)/packet_id.c \
> -       $(openvpn_srcdir)/platform.c \
> -       $(openvpn_srcdir)/reliable.c \
> -       $(openvpn_srcdir)/win32-util.c \
> -       $(openvpn_srcdir)/session_id.c
> +       $(top_srcdir)/src/openvpn/buffer.c \
> +       $(top_srcdir)/src/openvpn/otime.c \
> +       $(top_srcdir)/src/openvpn/packet_id.c \
> +       $(top_srcdir)/src/openvpn/platform.c \
> +       $(top_srcdir)/src/openvpn/reliable.c \
> +       $(top_srcdir)/src/openvpn/win32-util.c \
> +       $(top_srcdir)/src/openvpn/session_id.c
>
>  pkt_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \
> -       -I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir)
> +       -I$(top_srcdir)/include -I$(top_srcdir)/src/compat
> -I$(top_srcdir)/src/openvpn
>  pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
>  pkt_testdriver_SOURCES =3D test_pkt.c mock_msg.c mock_msg.h \
> -       $(openvpn_srcdir)/argv.c \
> -       $(openvpn_srcdir)/base64.c \
> -       $(openvpn_srcdir)/buffer.c \
> -       $(openvpn_srcdir)/crypto.c \
> -       $(openvpn_srcdir)/crypto_mbedtls.c \
> -       $(openvpn_srcdir)/crypto_openssl.c \
> -       $(openvpn_srcdir)/env_set.c \
> -       $(openvpn_srcdir)/otime.c \
> -       $(openvpn_srcdir)/packet_id.c \
> -       $(openvpn_srcdir)/platform.c \
> -       $(openvpn_srcdir)/reliable.c \
> -       $(openvpn_srcdir)/run_command.c \
> -       $(openvpn_srcdir)/session_id.c \
> -       $(openvpn_srcdir)/ssl_pkt.c \
> -       $(openvpn_srcdir)/win32-util.c \
> -       $(openvpn_srcdir)/tls_crypt.c
> +       $(top_srcdir)/src/openvpn/argv.c \
> +       $(top_srcdir)/src/openvpn/base64.c \
> +       $(top_srcdir)/src/openvpn/buffer.c \
> +       $(top_srcdir)/src/openvpn/crypto.c \
> +       $(top_srcdir)/src/openvpn/crypto_mbedtls.c \
> +       $(top_srcdir)/src/openvpn/crypto_openssl.c \
> +       $(top_srcdir)/src/openvpn/env_set.c \
> +       $(top_srcdir)/src/openvpn/otime.c \
> +       $(top_srcdir)/src/openvpn/packet_id.c \
> +       $(top_srcdir)/src/openvpn/platform.c \
> +       $(top_srcdir)/src/openvpn/reliable.c \
> +       $(top_srcdir)/src/openvpn/run_command.c \
> +       $(top_srcdir)/src/openvpn/session_id.c \
> +       $(top_srcdir)/src/openvpn/ssl_pkt.c \
> +       $(top_srcdir)/src/openvpn/win32-util.c \
> +       $(top_srcdir)/src/openvpn/tls_crypt.c
>
>  if !WIN32
>  tls_crypt_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \
> -       -I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir)
> +       -I$(top_srcdir)/include -I$(top_srcdir)/src/compat
> -I$(top_srcdir)/src/openvpn
>  tls_crypt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \
>         -Wl,--wrap=3Dbuffer_read_from_file \
>         -Wl,--wrap=3Dbuffer_write_file \
>         -Wl,--wrap=3Dparse_line \
>         -Wl,--wrap=3Drand_bytes
>  tls_crypt_testdriver_SOURCES =3D test_tls_crypt.c mock_msg.c mock_msg.h \
> -       $(openvpn_srcdir)/argv.c \
> -       $(openvpn_srcdir)/base64.c \
> -       $(openvpn_srcdir)/buffer.c \
> -       $(openvpn_srcdir)/crypto.c \
> -       $(openvpn_srcdir)/crypto_mbedtls.c \
> -       $(openvpn_srcdir)/crypto_openssl.c \
> -       $(openvpn_srcdir)/env_set.c \
> -       $(openvpn_srcdir)/otime.c \
> -       $(openvpn_srcdir)/packet_id.c \
> -       $(openvpn_srcdir)/platform.c \
> -       $(openvpn_srcdir)/run_command.c
> +       $(top_srcdir)/src/openvpn/argv.c \
> +       $(top_srcdir)/src/openvpn/base64.c \
> +       $(top_srcdir)/src/openvpn/buffer.c \
> +       $(top_srcdir)/src/openvpn/crypto.c \
> +       $(top_srcdir)/src/openvpn/crypto_mbedtls.c \
> +       $(top_srcdir)/src/openvpn/crypto_openssl.c \
> +       $(top_srcdir)/src/openvpn/env_set.c \
> +       $(top_srcdir)/src/openvpn/otime.c \
> +       $(top_srcdir)/src/openvpn/packet_id.c \
> +       $(top_srcdir)/src/openvpn/platform.c \
> +       $(top_srcdir)/src/openvpn/run_command.c
>  endif
>
>  if HAVE_SITNL
>  networking_testdriver_CFLAGS =3D @TEST_CFLAGS@ \
> -       -I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
> +       -I$(top_srcdir)/include -I$(top_srcdir)/src/compat
> -I$(top_srcdir)/src/openvpn \
>         $(OPTIONAL_CRYPTO_CFLAGS)
> -networking_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(openvpn_srcdir) \
> +networking_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
> -L$(top_srcdir)/src/openvpn \
>         $(OPTIONAL_CRYPTO_LIBS)
>  networking_testdriver_SOURCES =3D test_networking.c mock_msg.c \
> -       $(openvpn_srcdir)/networking_sitnl.c \
> -       $(openvpn_srcdir)/buffer.c \
> -       $(openvpn_srcdir)/crypto.c \
> -       $(openvpn_srcdir)/crypto_mbedtls.c \
> -       $(openvpn_srcdir)/crypto_openssl.c \
> -       $(openvpn_srcdir)/otime.c \
> -       $(openvpn_srcdir)/packet_id.c \
> -       $(openvpn_srcdir)/platform.c
> +       $(top_srcdir)/src/openvpn/networking_sitnl.c \
> +       $(top_srcdir)/src/openvpn/buffer.c \
> +       $(top_srcdir)/src/openvpn/crypto.c \
> +       $(top_srcdir)/src/openvpn/crypto_mbedtls.c \
> +       $(top_srcdir)/src/openvpn/crypto_openssl.c \
> +       $(top_srcdir)/src/openvpn/otime.c \
> +       $(top_srcdir)/src/openvpn/packet_id.c \
> +       $(top_srcdir)/src/openvpn/platform.c
>  endif
>
>  provider_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \
> -       -I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
> +       -I$(top_srcdir)/include -I$(top_srcdir)/src/compat
> -I$(top_srcdir)/src/openvpn \
>         $(OPTIONAL_CRYPTO_CFLAGS)
>  provider_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \
>         $(OPTIONAL_CRYPTO_LIBS)
>
>  provider_testdriver_SOURCES =3D test_provider.c mock_msg.c \
> -       $(openvpn_srcdir)/xkey_helper.c \
> -       $(openvpn_srcdir)/xkey_provider.c \
> -       $(openvpn_srcdir)/buffer.c \
> -       $(openvpn_srcdir)/base64.c \
> +       $(top_srcdir)/src/openvpn/xkey_helper.c \
> +       $(top_srcdir)/src/openvpn/xkey_provider.c \
> +       $(top_srcdir)/src/openvpn/buffer.c \
> +       $(top_srcdir)/src/openvpn/base64.c \
>         mock_get_random.c \
> -       $(openvpn_srcdir)/win32-util.c \
> -       $(openvpn_srcdir)/platform.c
> +       $(top_srcdir)/src/openvpn/win32-util.c \
> +       $(top_srcdir)/src/openvpn/platform.c
>
>  if WIN32
>  cryptoapi_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \
> -       -I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
> +       -I$(top_srcdir)/include -I$(top_srcdir)/src/compat
> -I$(top_srcdir)/src/openvpn \
>         $(OPTIONAL_CRYPTO_CFLAGS)
>  cryptoapi_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \
>         $(OPTIONAL_CRYPTO_LIBS) -lcrypt32 -lncrypt
>  cryptoapi_testdriver_SOURCES =3D test_cryptoapi.c mock_msg.c \
> -       $(openvpn_srcdir)/xkey_helper.c \
> -       $(openvpn_srcdir)/buffer.c \
> -       $(openvpn_srcdir)/base64.c \
> -       $(openvpn_srcdir)/platform.c \
> +       $(top_srcdir)/src/openvpn/xkey_helper.c \
> +       $(top_srcdir)/src/openvpn/buffer.c \
> +       $(top_srcdir)/src/openvpn/base64.c \
> +       $(top_srcdir)/src/openvpn/platform.c \
>         mock_get_random.c \
> -       $(openvpn_srcdir)/win32-util.c
> +       $(top_srcdir)/src/openvpn/win32-util.c
>  endif
>
>  auth_token_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \
> -       -I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
> +       -I$(top_srcdir)/include -I$(top_srcdir)/src/compat
> -I$(top_srcdir)/src/openvpn \
>         $(OPTIONAL_CRYPTO_CFLAGS)
>  auth_token_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \
>         $(OPTIONAL_CRYPTO_LIBS)
>
>  auth_token_testdriver_SOURCES =3D test_auth_token.c mock_msg.c \
> -       $(openvpn_srcdir)/buffer.c \
> -       $(openvpn_srcdir)/crypto.c \
> -       $(openvpn_srcdir)/crypto_mbedtls.c \
> -       $(openvpn_srcdir)/crypto_openssl.c \
> -       $(openvpn_srcdir)/otime.c \
> -       $(openvpn_srcdir)/packet_id.c \
> -       $(openvpn_srcdir)/platform.c \
> -       $(openvpn_srcdir)/win32-util.c \
> -       $(openvpn_srcdir)/base64.c
> +       $(top_srcdir)/src/openvpn/buffer.c \
> +       $(top_srcdir)/src/openvpn/crypto.c \
> +       $(top_srcdir)/src/openvpn/crypto_mbedtls.c \
> +       $(top_srcdir)/src/openvpn/crypto_openssl.c \
> +       $(top_srcdir)/src/openvpn/otime.c \
> +       $(top_srcdir)/src/openvpn/packet_id.c \
> +       $(top_srcdir)/src/openvpn/platform.c \
> +       $(top_srcdir)/src/openvpn/win32-util.c \
> +       $(top_srcdir)/src/openvpn/base64.c
>
>
>  ncp_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \
> -       -I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
> +       -I$(top_srcdir)/include -I$(top_srcdir)/src/compat
> -I$(top_srcdir)/src/openvpn \
>         $(OPTIONAL_CRYPTO_CFLAGS)
>  ncp_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \
>         $(OPTIONAL_CRYPTO_LIBS)
>
>  ncp_testdriver_SOURCES =3D test_ncp.c mock_msg.c \
> -       $(openvpn_srcdir)/buffer.c \
> -       $(openvpn_srcdir)/crypto.c \
> -       $(openvpn_srcdir)/crypto_mbedtls.c \
> -       $(openvpn_srcdir)/crypto_openssl.c \
> -       $(openvpn_srcdir)/otime.c \
> -       $(openvpn_srcdir)/packet_id.c \
> -       $(openvpn_srcdir)/platform.c \
> -       $(openvpn_srcdir)/win32-util.c \
> -       $(compat_srcdir)/compat-strsep.c \
> -       $(openvpn_srcdir)/ssl_util.c
> +       $(top_srcdir)/src/openvpn/buffer.c \
> +       $(top_srcdir)/src/openvpn/crypto.c \
> +       $(top_srcdir)/src/openvpn/crypto_mbedtls.c \
> +       $(top_srcdir)/src/openvpn/crypto_openssl.c \
> +       $(top_srcdir)/src/openvpn/otime.c \
> +       $(top_srcdir)/src/openvpn/packet_id.c \
> +       $(top_srcdir)/src/openvpn/platform.c \
> +       $(top_srcdir)/src/openvpn/win32-util.c \
> +       $(top_srcdir)/src/compat/compat-strsep.c \
> +       $(top_srcdir)/src/openvpn/ssl_util.c
>
>  misc_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \
> -       -I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir)
> +       -I$(top_srcdir)/include -I$(top_srcdir)/src/compat
> -I$(top_srcdir)/src/openvpn
>
>  misc_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
>
>  misc_testdriver_SOURCES =3D test_misc.c mock_msg.c \
>         mock_get_random.c \
> -       $(openvpn_srcdir)/buffer.c \
> -       $(openvpn_srcdir)/options_util.c \
> -       $(openvpn_srcdir)/ssl_util.c \
> -       $(openvpn_srcdir)/win32-util.c \
> -       $(openvpn_srcdir)/platform.c
> +       $(top_srcdir)/src/openvpn/buffer.c \
> +       $(top_srcdir)/src/openvpn/options_util.c \
> +       $(top_srcdir)/src/openvpn/ssl_util.c \
> +       $(top_srcdir)/src/openvpn/win32-util.c \
> +       $(top_srcdir)/src/openvpn/platform.c
> diff --git a/tests/unit_tests/plugins/auth-pam/Makefile.am
> b/tests/unit_tests/plugins/auth-pam/Makefile.am
> index 07233eee..de5e96e6 100644
> --- a/tests/unit_tests/plugins/auth-pam/Makefile.am
> +++ b/tests/unit_tests/plugins/auth-pam/Makefile.am
> @@ -5,8 +5,6 @@ check_PROGRAMS =3D auth_pam_testdriver
>  TESTS =3D $(check_PROGRAMS)
>  endif
>
> -sut_sourcedir =3D $(top_srcdir)/src/plugins/auth-pam
> -
> -auth_pam_testdriver_SOURCES =3D test_search_and_replace.c
> $(sut_sourcedir)/utils.h $(sut_sourcedir)/utils.c
> -auth_pam_testdriver_CFLAGS  =3D @TEST_CFLAGS@ -I$(sut_sourcedir)
> +auth_pam_testdriver_SOURCES =3D test_search_and_replace.c
> $(top_srcdir)/src/plugins/auth-pam/utils.h
> $(top_srcdir)/src/plugins/auth-pam/utils.c
> +auth_pam_testdriver_CFLAGS  =3D @TEST_CFLAGS@
> -I$(top_srcdir)/src/plugins/auth-pam
>  auth_pam_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
> --
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000c1477c05f66f89bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Wed, Mar 8, 2023 at 10:08=E2=80=AFAM Frank Lich=
tenheld &lt;<a href=3D"mailto:frank@...2641..." target=3D"_blank">frank@...493...=
2641...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Commit 7f72abcf8a56bb35a510a3409e03a4e2aaba50da enabled subdir-objec=
ts<br>
when using automake 1.16+.<br>
<br>
There is an issue with the handling of .deps directories with this option.<=
br>
While automake 1.16 fixed subdir-objects to work at all when _SOURCES<br>
contains &quot;unexpanded references&quot; and it did fix subdir-objects to=
 work<br>
with out-of-tree build for &quot;source files specified with an explicit<br>
&#39;$(srcdir)&#39;&quot; those fixes are not transitive. &quot;unexpanded =
references&quot;<br>
still break out-of-tree builds when enforcing a read-only source dir<br>
like &#39;make distcheck&#39; does. When using *explicit* references to<br>
srcdir and top_srcdir it works correctly.<br></blockquote><div><br></div><d=
iv>Thanks for quickly finding a fix for this. Even after re-reading the rel=
ated</div><div>changelog in automake a dozen times, I cannot figure arbitra=
ry variable</div><div>expansion won&#39;t work as expected for out-of-tree =
builds with read-only</div><div>sources. But testing=C2=A0does show only $(=
srcdir) and $(top_srcdir) get</div><div>correctly handled, and the fix belo=
w appears to be a=C2=A0reasonable way out.</div><div><br></div><div>Tested =
&quot;make distcheck&quot; and also compared with a locally generated</div>=
<div>search and replace version. LGTM.</div><div><br></div><div>Acked-by: S=
elva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">sel=
va.nair@...277...</a>&gt;</div><div><br></div><div>&lt;rant&gt;We waited lo=
ng enough to enable subdir-objects though automake</div><div>has been warni=
ng about this for almost a decade. Now they have softened</div><div>their s=
tand on it from=C2=A0&quot;this behaviour will change ...&quot; and=C2=A0=
=C2=A0</div><div>&quot;unconditionally=C2=A0cause ...&quot; etc.. to &quot;=
may change&quot; in future. And, the</div><div>implementation is still lack=
ing. In retrospect, we (I) could have waited longer.</div><div>&lt;/rant&gt=
;</div><div><br></div><div>Selva</div><div><br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<br>
Signed-off-by: Frank Lichtenheld &lt;<a href=3D"mailto:frank@...2641..." ta=
rget=3D"_blank">frank@...2641...</a>&gt;<br>
---<br>
=C2=A0tests/unit_tests/openvpn/Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 220 +++++++++---------<br>
=C2=A0tests/unit_tests/plugins/auth-pam/Makefile.am |=C2=A0 =C2=A06 +-<br>
=C2=A02 files changed, 110 insertions(+), 116 deletions(-)<br>
<br>
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am<br>
index ee0a3d8a..339c7ef3 100644<br>
--- a/tests/unit_tests/openvpn/Makefile.am<br>
+++ b/tests/unit_tests/openvpn/Makefile.am<br>
@@ -30,189 +30,185 @@ if HAVE_SITNL<br>
=C2=A0check_PROGRAMS +=3D networking_testdriver<br>
=C2=A0endif<br>
<br>
-openvpn_includedir =3D $(top_srcdir)/include<br>
-openvpn_srcdir =3D $(top_srcdir)/src/openvpn<br>
-compat_srcdir =3D $(top_srcdir)/src/compat<br>
-<br>
-argv_testdriver_CFLAGS=C2=A0 =3D @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(com=
pat_srcdir)<br>
-argv_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(openvpn_srcdir) -Wl,--wrap=
=3Dparse_line<br>
+argv_testdriver_CFLAGS=C2=A0 =3D @TEST_CFLAGS@ -I$(top_srcdir)/src/openvpn=
 -I$(top_srcdir)/src/compat<br>
+argv_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl=
,--wrap=3Dparse_line<br>
=C2=A0argv_testdriver_SOURCES =3D test_argv.c mock_msg.c mock_msg.h \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mock_get_random.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/platform.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/buffer.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/win32-util.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/argv.c<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/platform.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/buffer.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/win32-util.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/argv.c<br>
<br>
-buffer_testdriver_CFLAGS=C2=A0 =3D @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(c=
ompat_srcdir)<br>
-buffer_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(openvpn_srcdir) -Wl,--wra=
p=3Dparse_line<br>
+buffer_testdriver_CFLAGS=C2=A0 =3D @TEST_CFLAGS@ -I$(top_srcdir)/src/openv=
pn -I$(top_srcdir)/src/compat<br>
+buffer_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -=
Wl,--wrap=3Dparse_line<br>
=C2=A0buffer_testdriver_SOURCES =3D test_buffer.c mock_msg.c mock_msg.h \<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mock_get_random.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/win32-util.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/platform.c<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/win32-util.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/platform.c<br>
<br>
=C2=A0crypto_testdriver_CFLAGS=C2=A0 =3D @TEST_CFLAGS@ \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-I$(openvpn_includedir) -I$(compat_srcdir) -I$(=
openvpn_srcdir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-I$(top_srcdir)/include -I$(top_srcdir)/src/com=
pat -I$(top_srcdir)/src/openvpn<br>
=C2=A0crypto_testdriver_LDFLAGS =3D @TEST_LDFLAGS@<br>
=C2=A0crypto_testdriver_SOURCES =3D test_crypto.c mock_msg.c mock_msg.h \<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/buffer.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/crypto.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/crypto_mbedtls.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/crypto_openssl.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/otime.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/packet_id.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/platform.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/mtu.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/win32-util.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/mss.c<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/buffer.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/crypto.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/crypto_mbedtls.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/crypto_openssl.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/otime.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/packet_id.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/platform.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/mtu.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/win32-util.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/mss.c<br>
<br>
=C2=A0packet_id_testdriver_CFLAGS=C2=A0 =3D @TEST_CFLAGS@ \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-I$(openvpn_includedir) -I$(compat_srcdir) -I$(=
openvpn_srcdir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-I$(top_srcdir)/include -I$(top_srcdir)/src/com=
pat -I$(top_srcdir)/src/openvpn<br>
=C2=A0packet_id_testdriver_LDFLAGS =3D @TEST_LDFLAGS@<br>
=C2=A0packet_id_testdriver_SOURCES =3D test_packet_id.c mock_msg.c mock_msg=
.h \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mock_get_random.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/buffer.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/otime.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/packet_id.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/platform.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/reliable.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/win32-util.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/session_id.c<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/buffer.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/otime.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/packet_id.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/platform.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/reliable.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/win32-util.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/session_id.c<br>
<br>
=C2=A0pkt_testdriver_CFLAGS=C2=A0 =3D @TEST_CFLAGS@ \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-I$(openvpn_includedir) -I$(compat_srcdir) -I$(=
openvpn_srcdir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-I$(top_srcdir)/include -I$(top_srcdir)/src/com=
pat -I$(top_srcdir)/src/openvpn<br>
=C2=A0pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@<br>
=C2=A0pkt_testdriver_SOURCES =3D test_pkt.c mock_msg.c mock_msg.h \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/argv.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/base64.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/buffer.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/crypto.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/crypto_mbedtls.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/crypto_openssl.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/env_set.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/otime.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/packet_id.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/platform.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/reliable.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/run_command.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/session_id.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/ssl_pkt.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/win32-util.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/tls_crypt.c<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/argv.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/base64.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/buffer.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/crypto.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/crypto_mbedtls.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/crypto_openssl.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/env_set.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/otime.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/packet_id.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/platform.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/reliable.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/run_command.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/session_id.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/ssl_pkt.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/win32-util.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/tls_crypt.c<br>
<br>
=C2=A0if !WIN32<br>
=C2=A0tls_crypt_testdriver_CFLAGS=C2=A0 =3D @TEST_CFLAGS@ \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-I$(openvpn_includedir) -I$(compat_srcdir) -I$(=
openvpn_srcdir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-I$(top_srcdir)/include -I$(top_srcdir)/src/com=
pat -I$(top_srcdir)/src/openvpn<br>
=C2=A0tls_crypt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wl,--wrap=3Dbuffer_read_from_file \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wl,--wrap=3Dbuffer_write_file \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wl,--wrap=3Dparse_line \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wl,--wrap=3Drand_bytes<br>
=C2=A0tls_crypt_testdriver_SOURCES =3D test_tls_crypt.c mock_msg.c mock_msg=
.h \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/argv.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/base64.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/buffer.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/crypto.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/crypto_mbedtls.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/crypto_openssl.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/env_set.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/otime.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/packet_id.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/platform.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/run_command.c<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/argv.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/base64.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/buffer.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/crypto.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/crypto_mbedtls.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/crypto_openssl.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/env_set.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/otime.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/packet_id.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/platform.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/run_command.c<br>
=C2=A0endif<br>
<br>
=C2=A0if HAVE_SITNL<br>
=C2=A0networking_testdriver_CFLAGS =3D @TEST_CFLAGS@ \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-I$(openvpn_includedir) -I$(compat_srcdir) -I$(=
openvpn_srcdir) \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-I$(top_srcdir)/include -I$(top_srcdir)/src/com=
pat -I$(top_srcdir)/src/openvpn \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(OPTIONAL_CRYPTO_CFLAGS)<br>
-networking_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(openvpn_srcdir) \<br>
+networking_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openv=
pn \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(OPTIONAL_CRYPTO_LIBS)<br>
=C2=A0networking_testdriver_SOURCES =3D test_networking.c mock_msg.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/networking_sitnl.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/buffer.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/crypto.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/crypto_mbedtls.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/crypto_openssl.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/otime.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/packet_id.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/platform.c<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/networking_sitnl.c \<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/buffer.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/crypto.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/crypto_mbedtls.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/crypto_openssl.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/otime.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/packet_id.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/platform.c<br>
=C2=A0endif<br>
<br>
=C2=A0provider_testdriver_CFLAGS=C2=A0 =3D @TEST_CFLAGS@ \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-I$(openvpn_includedir) -I$(compat_srcdir) -I$(=
openvpn_srcdir) \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-I$(top_srcdir)/include -I$(top_srcdir)/src/com=
pat -I$(top_srcdir)/src/openvpn \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(OPTIONAL_CRYPTO_CFLAGS)<br>
=C2=A0provider_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(OPTIONAL_CRYPTO_LIBS)<br>
<br>
=C2=A0provider_testdriver_SOURCES =3D test_provider.c mock_msg.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/xkey_helper.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/xkey_provider.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/buffer.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/base64.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/xkey_helper.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/xkey_provider.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/buffer.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/base64.c \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mock_get_random.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/win32-util.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/platform.c<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/win32-util.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/platform.c<br>
<br>
=C2=A0if WIN32<br>
=C2=A0cryptoapi_testdriver_CFLAGS=C2=A0 =3D @TEST_CFLAGS@ \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-I$(openvpn_includedir) -I$(compat_srcdir) -I$(=
openvpn_srcdir) \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-I$(top_srcdir)/include -I$(top_srcdir)/src/com=
pat -I$(top_srcdir)/src/openvpn \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(OPTIONAL_CRYPTO_CFLAGS)<br>
=C2=A0cryptoapi_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(OPTIONAL_CRYPTO_LIBS) -lcrypt32 -lncrypt<br>
=C2=A0cryptoapi_testdriver_SOURCES =3D test_cryptoapi.c mock_msg.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/xkey_helper.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/buffer.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/base64.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/platform.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/xkey_helper.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/buffer.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/base64.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/platform.c \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mock_get_random.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/win32-util.c<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/win32-util.c<br>
=C2=A0endif<br>
<br>
=C2=A0auth_token_testdriver_CFLAGS=C2=A0 =3D @TEST_CFLAGS@ \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-I$(openvpn_includedir) -I$(compat_srcdir) -I$(=
openvpn_srcdir) \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-I$(top_srcdir)/include -I$(top_srcdir)/src/com=
pat -I$(top_srcdir)/src/openvpn \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(OPTIONAL_CRYPTO_CFLAGS)<br>
=C2=A0auth_token_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(OPTIONAL_CRYPTO_LIBS)<br>
<br>
=C2=A0auth_token_testdriver_SOURCES =3D test_auth_token.c mock_msg.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/buffer.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/crypto.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/crypto_mbedtls.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/crypto_openssl.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/otime.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/packet_id.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/platform.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/win32-util.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/base64.c<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/buffer.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/crypto.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/crypto_mbedtls.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/crypto_openssl.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/otime.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/packet_id.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/platform.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/win32-util.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/base64.c<br>
<br>
<br>
=C2=A0ncp_testdriver_CFLAGS=C2=A0 =3D @TEST_CFLAGS@ \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-I$(openvpn_includedir) -I$(compat_srcdir) -I$(=
openvpn_srcdir) \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-I$(top_srcdir)/include -I$(top_srcdir)/src/com=
pat -I$(top_srcdir)/src/openvpn \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(OPTIONAL_CRYPTO_CFLAGS)<br>
=C2=A0ncp_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(OPTIONAL_CRYPTO_LIBS)<br>
<br>
=C2=A0ncp_testdriver_SOURCES =3D test_ncp.c mock_msg.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/buffer.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/crypto.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/crypto_mbedtls.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/crypto_openssl.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/otime.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/packet_id.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/platform.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/win32-util.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(compat_srcdir)/compat-strsep.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/ssl_util.c<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/buffer.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/crypto.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/crypto_mbedtls.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/crypto_openssl.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/otime.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/packet_id.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/platform.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/win32-util.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/compat/compat-strsep.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/ssl_util.c<br>
<br>
=C2=A0misc_testdriver_CFLAGS=C2=A0 =3D @TEST_CFLAGS@ \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-I$(openvpn_includedir) -I$(compat_srcdir) -I$(=
openvpn_srcdir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-I$(top_srcdir)/include -I$(top_srcdir)/src/com=
pat -I$(top_srcdir)/src/openvpn<br>
<br>
=C2=A0misc_testdriver_LDFLAGS =3D @TEST_LDFLAGS@<br>
<br>
=C2=A0misc_testdriver_SOURCES =3D test_misc.c mock_msg.c \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mock_get_random.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/buffer.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/options_util.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/ssl_util.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/win32-util.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(openvpn_srcdir)/platform.c<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/buffer.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/options_util.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/ssl_util.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/win32-util.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/src/openvpn/platform.c<br>
diff --git a/tests/unit_tests/plugins/auth-pam/Makefile.am b/tests/unit_tes=
ts/plugins/auth-pam/Makefile.am<br>
index 07233eee..de5e96e6 100644<br>
--- a/tests/unit_tests/plugins/auth-pam/Makefile.am<br>
+++ b/tests/unit_tests/plugins/auth-pam/Makefile.am<br>
@@ -5,8 +5,6 @@ check_PROGRAMS =3D auth_pam_testdriver<br>
=C2=A0TESTS =3D $(check_PROGRAMS)<br>
=C2=A0endif<br>
<br>
-sut_sourcedir =3D $(top_srcdir)/src/plugins/auth-pam<br>
-<br>
-auth_pam_testdriver_SOURCES =3D test_search_and_replace.c=C2=A0 $(sut_sour=
cedir)/utils.h $(sut_sourcedir)/utils.c<br>
-auth_pam_testdriver_CFLAGS=C2=A0 =3D @TEST_CFLAGS@ -I$(sut_sourcedir)<br>
+auth_pam_testdriver_SOURCES =3D test_search_and_replace.c=C2=A0 $(top_srcd=
ir)/src/plugins/auth-pam/utils.h $(top_srcdir)/src/plugins/auth-pam/utils.c=
<br>
+auth_pam_testdriver_CFLAGS=C2=A0 =3D @TEST_CFLAGS@ -I$(top_srcdir)/src/plu=
gins/auth-pam<br>
=C2=A0auth_pam_testdriver_LDFLAGS =3D @TEST_LDFLAGS@<br>
--<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--000000000000c1477c05f66f89bb--

