References: <1482350454-27280-1-git-send-email-davids@...515...>
	<1482350454-27280-4-git-send-email-davids@...515...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <c406ca8d-5bb1-f53c-241c-253354f03ff6@...1856...>
Date: Wed, 21 Dec 2016 21:09:25 +0100
MIME-Version: 1.0
In-Reply-To: <1482350454-27280-4-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH release/2.4] Update copyrights
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 21-12-16 21:00, David Sommerseth wrote:
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  COPYING                                                               | 2 +-
>  ChangeLog                                                             | 2 +-
>  Makefile.am                                                           | 2 +-
>  PORTS                                                                 | 2 +-
>  build/Makefile.am                                                     | 2 +-
>  build/msvc/Makefile.am                                                | 2 +-
>  build/msvc/msvc-generate/Makefile.am                                  | 2 +-
>  configure.ac                                                          | 2 +-
>  dev-tools/reformat-all.sh                                             | 2 +-
>  dev-tools/update-copyright.sh                                         | 2 +-
>  distro/Makefile.am                                                    | 2 +-
>  distro/rpm/Makefile.am                                                | 2 +-
>  doc/Makefile.am                                                       | 2 +-
>  doc/doxygen/doc_compression.h                                         | 2 +-
>  doc/doxygen/doc_control_processor.h                                   | 2 +-
>  doc/doxygen/doc_control_tls.h                                         | 2 +-
>  doc/doxygen/doc_data_control.h                                        | 2 +-
>  doc/doxygen/doc_data_crypto.h                                         | 2 +-
>  doc/doxygen/doc_eventloop.h                                           | 2 +-
>  doc/doxygen/doc_external_multiplexer.h                                | 2 +-
>  doc/doxygen/doc_fragmentation.h                                       | 2 +-
>  doc/doxygen/doc_internal_multiplexer.h                                | 2 +-
>  doc/doxygen/doc_key_generation.h                                      | 2 +-
>  doc/doxygen/doc_mainpage.h                                            | 2 +-
>  doc/doxygen/doc_memory_management.h                                   | 2 +-
>  doc/doxygen/doc_protocol_overview.h                                   | 2 +-
>  doc/doxygen/doc_reliable.h                                            | 2 +-
>  doc/doxygen/doc_tunnel_state.h                                        | 2 +-
>  doc/openvpn.8                                                         | 2 +-
>  include/Makefile.am                                                   | 2 +-
>  include/openvpn-msg.h                                                 | 2 +-
>  include/openvpn-plugin.h.in                                           | 2 +-
>  sample/Makefile.am                                                    | 2 +-
>  sample/sample-plugins/defer/simple.c                                  | 2 +-
>  .../keying-material-exporter-demo/keyingmaterialexporter.c            | 2 +-
>  sample/sample-plugins/log/log.c                                       | 2 +-
>  sample/sample-plugins/log/log_v3.c                                    | 2 +-
>  sample/sample-plugins/simple/simple.c                                 | 2 +-
>  src/Makefile.am                                                       | 2 +-
>  src/compat/Makefile.am                                                | 2 +-
>  src/compat/compat-gettimeofday.c                                      | 2 +-
>  src/openvpn/Makefile.am                                               | 2 +-
>  src/openvpn/argv.c                                                    | 2 +-
>  src/openvpn/argv.h                                                    | 2 +-
>  src/openvpn/basic.h                                                   | 2 +-
>  src/openvpn/block_dns.c                                               | 2 +-
>  src/openvpn/buffer.c                                                  | 2 +-
>  src/openvpn/buffer.h                                                  | 2 +-
>  src/openvpn/circ_list.h                                               | 2 +-
>  src/openvpn/clinat.c                                                  | 2 +-
>  src/openvpn/clinat.h                                                  | 2 +-
>  src/openvpn/common.h                                                  | 2 +-
>  src/openvpn/comp-lz4.c                                                | 4 ++--
>  src/openvpn/comp-lz4.h                                                | 4 ++--
>  src/openvpn/comp.c                                                    | 2 +-
>  src/openvpn/comp.h                                                    | 2 +-
>  src/openvpn/compstub.c                                                | 2 +-
>  src/openvpn/console.c                                                 | 4 ++--
>  src/openvpn/console.h                                                 | 4 ++--
>  src/openvpn/console_builtin.c                                         | 4 ++--
>  src/openvpn/crypto.c                                                  | 4 ++--
>  src/openvpn/crypto.h                                                  | 4 ++--
>  src/openvpn/crypto_backend.h                                          | 4 ++--
>  src/openvpn/crypto_mbedtls.c                                          | 4 ++--
>  src/openvpn/crypto_mbedtls.h                                          | 4 ++--
>  src/openvpn/crypto_openssl.c                                          | 4 ++--
>  src/openvpn/crypto_openssl.h                                          | 4 ++--
>  src/openvpn/dhcp.c                                                    | 2 +-
>  src/openvpn/dhcp.h                                                    | 2 +-
>  src/openvpn/errlevel.h                                                | 2 +-
>  src/openvpn/error.c                                                   | 2 +-
>  src/openvpn/error.h                                                   | 2 +-
>  src/openvpn/event.c                                                   | 2 +-
>  src/openvpn/event.h                                                   | 2 +-
>  src/openvpn/fdmisc.c                                                  | 2 +-
>  src/openvpn/fdmisc.h                                                  | 2 +-
>  src/openvpn/forward-inline.h                                          | 2 +-
>  src/openvpn/forward.c                                                 | 2 +-
>  src/openvpn/forward.h                                                 | 2 +-
>  src/openvpn/fragment.c                                                | 2 +-
>  src/openvpn/fragment.h                                                | 2 +-
>  src/openvpn/gremlin.c                                                 | 2 +-
>  src/openvpn/gremlin.h                                                 | 2 +-
>  src/openvpn/helper.c                                                  | 2 +-
>  src/openvpn/helper.h                                                  | 2 +-
>  src/openvpn/httpdigest.c                                              | 2 +-
>  src/openvpn/httpdigest.h                                              | 2 +-
>  src/openvpn/init.c                                                    | 2 +-
>  src/openvpn/init.h                                                    | 2 +-
>  src/openvpn/integer.h                                                 | 2 +-
>  src/openvpn/interval.c                                                | 2 +-
>  src/openvpn/interval.h                                                | 2 +-
>  src/openvpn/list.c                                                    | 2 +-
>  src/openvpn/list.h                                                    | 2 +-
>  src/openvpn/lzo.c                                                     | 2 +-
>  src/openvpn/lzo.h                                                     | 2 +-
>  src/openvpn/manage.c                                                  | 2 +-
>  src/openvpn/manage.h                                                  | 2 +-
>  src/openvpn/mbuf.c                                                    | 2 +-
>  src/openvpn/mbuf.h                                                    | 2 +-
>  src/openvpn/memdbg.h                                                  | 2 +-
>  src/openvpn/misc.c                                                    | 4 ++--
>  src/openvpn/misc.h                                                    | 2 +-
>  src/openvpn/mroute.c                                                  | 2 +-
>  src/openvpn/mroute.h                                                  | 2 +-
>  src/openvpn/mss.c                                                     | 2 +-
>  src/openvpn/mss.h                                                     | 2 +-
>  src/openvpn/mstats.c                                                  | 2 +-
>  src/openvpn/mstats.h                                                  | 2 +-
>  src/openvpn/mtcp.c                                                    | 2 +-
>  src/openvpn/mtcp.h                                                    | 2 +-
>  src/openvpn/mtu.c                                                     | 2 +-
>  src/openvpn/mtu.h                                                     | 2 +-
>  src/openvpn/mudp.c                                                    | 2 +-
>  src/openvpn/mudp.h                                                    | 2 +-
>  src/openvpn/multi.c                                                   | 2 +-
>  src/openvpn/multi.h                                                   | 2 +-
>  src/openvpn/occ-inline.h                                              | 2 +-
>  src/openvpn/occ.c                                                     | 2 +-
>  src/openvpn/occ.h                                                     | 2 +-
>  src/openvpn/openvpn.c                                                 | 2 +-
>  src/openvpn/openvpn.h                                                 | 2 +-
>  src/openvpn/options.c                                                 | 4 ++--
>  src/openvpn/options.h                                                 | 2 +-
>  src/openvpn/otime.c                                                   | 2 +-
>  src/openvpn/otime.h                                                   | 2 +-
>  src/openvpn/packet_id.c                                               | 2 +-
>  src/openvpn/packet_id.h                                               | 2 +-
>  src/openvpn/perf.c                                                    | 2 +-
>  src/openvpn/perf.h                                                    | 2 +-
>  src/openvpn/pf-inline.h                                               | 2 +-
>  src/openvpn/pf.c                                                      | 2 +-
>  src/openvpn/pf.h                                                      | 2 +-
>  src/openvpn/ping-inline.h                                             | 2 +-
>  src/openvpn/ping.c                                                    | 2 +-
>  src/openvpn/ping.h                                                    | 2 +-
>  src/openvpn/pkcs11.c                                                  | 2 +-
>  src/openvpn/pkcs11.h                                                  | 2 +-
>  src/openvpn/pkcs11_backend.h                                          | 4 ++--
>  src/openvpn/pkcs11_mbedtls.c                                          | 4 ++--
>  src/openvpn/pkcs11_openssl.c                                          | 4 ++--
>  src/openvpn/platform.c                                                | 2 +-
>  src/openvpn/platform.h                                                | 2 +-
>  src/openvpn/plugin.c                                                  | 2 +-
>  src/openvpn/plugin.h                                                  | 2 +-
>  src/openvpn/pool.c                                                    | 2 +-
>  src/openvpn/pool.h                                                    | 2 +-
>  src/openvpn/proto.c                                                   | 2 +-
>  src/openvpn/proto.h                                                   | 2 +-
>  src/openvpn/proxy.c                                                   | 2 +-
>  src/openvpn/proxy.h                                                   | 2 +-
>  src/openvpn/ps.c                                                      | 2 +-
>  src/openvpn/ps.h                                                      | 2 +-
>  src/openvpn/push.c                                                    | 2 +-
>  src/openvpn/push.h                                                    | 2 +-
>  src/openvpn/pushlist.h                                                | 2 +-
>  src/openvpn/reliable.c                                                | 2 +-
>  src/openvpn/reliable.h                                                | 2 +-
>  src/openvpn/route.c                                                   | 2 +-
>  src/openvpn/route.h                                                   | 2 +-
>  src/openvpn/schedule.c                                                | 2 +-
>  src/openvpn/schedule.h                                                | 2 +-
>  src/openvpn/session_id.c                                              | 2 +-
>  src/openvpn/session_id.h                                              | 2 +-
>  src/openvpn/shaper.c                                                  | 2 +-
>  src/openvpn/shaper.h                                                  | 2 +-
>  src/openvpn/sig.c                                                     | 2 +-
>  src/openvpn/sig.h                                                     | 2 +-
>  src/openvpn/socket.c                                                  | 2 +-
>  src/openvpn/socket.h                                                  | 2 +-
>  src/openvpn/socks.c                                                   | 2 +-
>  src/openvpn/socks.h                                                   | 2 +-
>  src/openvpn/ssl.c                                                     | 4 ++--
>  src/openvpn/ssl.h                                                     | 4 ++--
>  src/openvpn/ssl_backend.h                                             | 4 ++--
>  src/openvpn/ssl_common.h                                              | 4 ++--
>  src/openvpn/ssl_mbedtls.c                                             | 4 ++--
>  src/openvpn/ssl_mbedtls.h                                             | 4 ++--
>  src/openvpn/ssl_openssl.c                                             | 4 ++--
>  src/openvpn/ssl_openssl.h                                             | 4 ++--
>  src/openvpn/ssl_verify.c                                              | 4 ++--
>  src/openvpn/ssl_verify.h                                              | 4 ++--
>  src/openvpn/ssl_verify_backend.h                                      | 4 ++--
>  src/openvpn/ssl_verify_mbedtls.c                                      | 4 ++--
>  src/openvpn/ssl_verify_mbedtls.h                                      | 4 ++--
>  src/openvpn/ssl_verify_openssl.c                                      | 4 ++--
>  src/openvpn/ssl_verify_openssl.h                                      | 4 ++--
>  src/openvpn/status.c                                                  | 2 +-
>  src/openvpn/status.h                                                  | 2 +-
>  src/openvpn/syshead.h                                                 | 2 +-
>  src/openvpn/tls_crypt.c                                               | 2 +-
>  src/openvpn/tls_crypt.h                                               | 2 +-
>  src/openvpn/tun.c                                                     | 2 +-
>  src/openvpn/tun.h                                                     | 2 +-
>  src/openvpn/win32.c                                                   | 2 +-
>  src/openvpn/win32.h                                                   | 2 +-
>  src/openvpnserv/Makefile.am                                           | 2 +-
>  src/openvpnserv/automatic.c                                           | 2 +-
>  src/openvpnserv/common.c                                              | 2 +-
>  src/openvpnserv/interactive.c                                         | 2 +-
>  src/openvpnserv/service.h                                             | 2 +-
>  src/plugins/Makefile.am                                               | 2 +-
>  src/plugins/auth-pam/auth-pam.c                                       | 2 +-
>  src/plugins/auth-pam/utils.c                                          | 2 +-
>  src/plugins/auth-pam/utils.h                                          | 2 +-
>  src/plugins/down-root/down-root.c                                     | 2 +-
>  tests/Makefile.am                                                     | 2 +-
>  tests/unit_tests/openvpn/mock_msg.c                                   | 2 +-
>  tests/unit_tests/openvpn/mock_msg.h                                   | 2 +-
>  tests/unit_tests/openvpn/test_buffer.c                                | 2 +-
>  tests/unit_tests/openvpn/test_tls_crypt.c                             | 2 +-
>  211 files changed, 243 insertions(+), 243 deletions(-)
> 
> diff --git a/COPYING b/COPYING
> index f6e5c43..f88ad79 100644
> --- a/COPYING
> +++ b/COPYING
> @@ -1,6 +1,6 @@
>  OpenVPN (TM) -- An Open Source VPN daemon
>  
> -Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> +Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>  
>  This distribution contains multiple components, some
>  of which fall under different licenses.  By using OpenVPN
> diff --git a/ChangeLog b/ChangeLog
> index 8ff692d..8ae0863 100644
> --- a/ChangeLog
> +++ b/ChangeLog
> @@ -1,5 +1,5 @@
>  OpenVPN Change Log
> -Copyright (C) 2002-2016 OpenVPN Technologies, Inc. <sales@...515...>
> +Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>  
>  2016.12.16 -- Version 2.4_rc2
>  David Sommerseth (9):
> diff --git a/Makefile.am b/Makefile.am
> index 8e9581b..d1a72da 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -5,7 +5,7 @@
>  #             packet encryption, packet authentication, and
>  #             packet compression.
>  #
> -#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> +#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>  #  Copyright (C) 2010      David Sommerseth <dazo@...384...>
>  #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
>  #
> diff --git a/PORTS b/PORTS
> index 735493c..5a9de66 100644
> --- a/PORTS
> +++ b/PORTS
> @@ -1,5 +1,5 @@
>  OpenVPN
> -Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> +Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>  
>    OpenVPN has been written to try to avoid features
>    that are not standardized well across different
> diff --git a/build/Makefile.am b/build/Makefile.am
> index b53ff52..4191a99 100644
> --- a/build/Makefile.am
> +++ b/build/Makefile.am
> @@ -5,7 +5,7 @@
>  #             packet encryption, packet authentication, and
>  #             packet compression.
>  #
> -#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> +#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>  #
>  
>  MAINTAINERCLEANFILES = \
> diff --git a/build/msvc/Makefile.am b/build/msvc/Makefile.am
> index 7dc3def..85a613b 100644
> --- a/build/msvc/Makefile.am
> +++ b/build/msvc/Makefile.am
> @@ -5,7 +5,7 @@
>  #             packet encryption, packet authentication, and
>  #             packet compression.
>  #
> -#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> +#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>  #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
>  #
>  
> diff --git a/build/msvc/msvc-generate/Makefile.am b/build/msvc/msvc-generate/Makefile.am
> index 539fb6c..2151b42 100644
> --- a/build/msvc/msvc-generate/Makefile.am
> +++ b/build/msvc/msvc-generate/Makefile.am
> @@ -5,7 +5,7 @@
>  #             packet encryption, packet authentication, and
>  #             packet compression.
>  #
> -#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> +#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>  #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
>  #
>  
> diff --git a/configure.ac b/configure.ac
> index 4f086ea..43487b0 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -4,7 +4,7 @@ dnl             session authentication and key exchange,
>  dnl             packet encryption, packet authentication, and
>  dnl             packet compression.
>  dnl
> -dnl  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> +dnl  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>  dnl  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
>  dnl
>  dnl  This program is free software; you can redistribute it and/or modify
> diff --git a/dev-tools/reformat-all.sh b/dev-tools/reformat-all.sh
> index cf42bd0..e253ab2 100755
> --- a/dev-tools/reformat-all.sh
> +++ b/dev-tools/reformat-all.sh
> @@ -2,7 +2,7 @@
>  # reformat-all.sh - Reformat all git files in the checked out
>  #                   git branch using uncrustify.
>  #
> -# Copyright (C) 2016 - David Sommerseth <davids@...515...>
> +# Copyright (C) 2016-2017 - David Sommerseth <davids@...515...>
>  #
>  # This program is free software; you can redistribute it and/or
>  # modify it under the terms of the GNU General Public License
> diff --git a/dev-tools/update-copyright.sh b/dev-tools/update-copyright.sh
> index 10f2235..755d1e0 100755
> --- a/dev-tools/update-copyright.sh
> +++ b/dev-tools/update-copyright.sh
> @@ -2,7 +2,7 @@
>  # update-copyright-sh - Simple tool to update the Copyright lines
>  #                       in all files checked into git
>  #
> -# Copyright (C) 2016 David Sommerseth <davids@...515...>
> +# Copyright (C) 2016-2017 David Sommerseth <davids@...515...>
>  #
>  # This program is free software; you can redistribute it and/or
>  # modify it under the terms of the GNU General Public License
> diff --git a/distro/Makefile.am b/distro/Makefile.am
> index bd65b79..7a9ffd0 100644
> --- a/distro/Makefile.am
> +++ b/distro/Makefile.am
> @@ -5,7 +5,7 @@
>  #             packet encryption, packet authentication, and
>  #             packet compression.
>  #
> -#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> +#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>  #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
>  #
>  
> diff --git a/distro/rpm/Makefile.am b/distro/rpm/Makefile.am
> index 536061d..37ee099 100644
> --- a/distro/rpm/Makefile.am
> +++ b/distro/rpm/Makefile.am
> @@ -5,7 +5,7 @@
>  #             packet encryption, packet authentication, and
>  #             packet compression.
>  #
> -#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> +#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>  #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
>  #
>  
> diff --git a/doc/Makefile.am b/doc/Makefile.am
> index d33e1ed..dedd1fa 100644
> --- a/doc/Makefile.am
> +++ b/doc/Makefile.am
> @@ -5,7 +5,7 @@
>  #             packet encryption, packet authentication, and
>  #             packet compression.
>  #
> -#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> +#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>  #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
>  #
>  
> diff --git a/doc/doxygen/doc_compression.h b/doc/doxygen/doc_compression.h
> index bdc4a7e..3213164 100644
> --- a/doc/doxygen/doc_compression.h
> +++ b/doc/doxygen/doc_compression.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *
>   *  This program is free software; you can redistribute it and/or modify
> diff --git a/doc/doxygen/doc_control_processor.h b/doc/doxygen/doc_control_processor.h
> index 072dc37..797bf0f 100644
> --- a/doc/doxygen/doc_control_processor.h
> +++ b/doc/doxygen/doc_control_processor.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *
>   *  This program is free software; you can redistribute it and/or modify
> diff --git a/doc/doxygen/doc_control_tls.h b/doc/doxygen/doc_control_tls.h
> index aba55f7..fc5c96a 100644
> --- a/doc/doxygen/doc_control_tls.h
> +++ b/doc/doxygen/doc_control_tls.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *
>   *  This program is free software; you can redistribute it and/or modify
> diff --git a/doc/doxygen/doc_data_control.h b/doc/doxygen/doc_data_control.h
> index d0f65ba..c527f70 100644
> --- a/doc/doxygen/doc_data_control.h
> +++ b/doc/doxygen/doc_data_control.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *
>   *  This program is free software; you can redistribute it and/or modify
> diff --git a/doc/doxygen/doc_data_crypto.h b/doc/doxygen/doc_data_crypto.h
> index 1172672..571171e 100644
> --- a/doc/doxygen/doc_data_crypto.h
> +++ b/doc/doxygen/doc_data_crypto.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *
>   *  This program is free software; you can redistribute it and/or modify
> diff --git a/doc/doxygen/doc_eventloop.h b/doc/doxygen/doc_eventloop.h
> index a860db6..10d41c4 100644
> --- a/doc/doxygen/doc_eventloop.h
> +++ b/doc/doxygen/doc_eventloop.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *
>   *  This program is free software; you can redistribute it and/or modify
> diff --git a/doc/doxygen/doc_external_multiplexer.h b/doc/doxygen/doc_external_multiplexer.h
> index 7653255..bc64c33 100644
> --- a/doc/doxygen/doc_external_multiplexer.h
> +++ b/doc/doxygen/doc_external_multiplexer.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *
>   *  This program is free software; you can redistribute it and/or modify
> diff --git a/doc/doxygen/doc_fragmentation.h b/doc/doxygen/doc_fragmentation.h
> index ef34cdb..34d73d6 100644
> --- a/doc/doxygen/doc_fragmentation.h
> +++ b/doc/doxygen/doc_fragmentation.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *
>   *  This program is free software; you can redistribute it and/or modify
> diff --git a/doc/doxygen/doc_internal_multiplexer.h b/doc/doxygen/doc_internal_multiplexer.h
> index 5142dd0..d38231b 100644
> --- a/doc/doxygen/doc_internal_multiplexer.h
> +++ b/doc/doxygen/doc_internal_multiplexer.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *
>   *  This program is free software; you can redistribute it and/or modify
> diff --git a/doc/doxygen/doc_key_generation.h b/doc/doxygen/doc_key_generation.h
> index 903a465..43ca150 100644
> --- a/doc/doxygen/doc_key_generation.h
> +++ b/doc/doxygen/doc_key_generation.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *
>   *  This program is free software; you can redistribute it and/or modify
> diff --git a/doc/doxygen/doc_mainpage.h b/doc/doxygen/doc_mainpage.h
> index ed8e324..685e0b9 100644
> --- a/doc/doxygen/doc_mainpage.h
> +++ b/doc/doxygen/doc_mainpage.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *
>   *  This program is free software; you can redistribute it and/or modify
> diff --git a/doc/doxygen/doc_memory_management.h b/doc/doxygen/doc_memory_management.h
> index f948783..0e85d93 100644
> --- a/doc/doxygen/doc_memory_management.h
> +++ b/doc/doxygen/doc_memory_management.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *
>   *  This program is free software; you can redistribute it and/or modify
> diff --git a/doc/doxygen/doc_protocol_overview.h b/doc/doxygen/doc_protocol_overview.h
> index 9edafcf..46d2e12 100644
> --- a/doc/doxygen/doc_protocol_overview.h
> +++ b/doc/doxygen/doc_protocol_overview.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2010-2014 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *
>   *  This program is free software; you can redistribute it and/or modify
> diff --git a/doc/doxygen/doc_reliable.h b/doc/doxygen/doc_reliable.h
> index 5264906..a6d8f2f 100644
> --- a/doc/doxygen/doc_reliable.h
> +++ b/doc/doxygen/doc_reliable.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *
>   *  This program is free software; you can redistribute it and/or modify
> diff --git a/doc/doxygen/doc_tunnel_state.h b/doc/doxygen/doc_tunnel_state.h
> index 6c93e71..4433dbe 100644
> --- a/doc/doxygen/doc_tunnel_state.h
> +++ b/doc/doxygen/doc_tunnel_state.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *
>   *  This program is free software; you can redistribute it and/or modify
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index f079799..b1ca9ed 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -4,7 +4,7 @@
>  .\"             packet encryption, packet authentication, and
>  .\"             packet compression.
>  .\"
> -.\"  Copyright (C) 2002-2016 OpenVPN Technologies, Inc. <sales@...515...>
> +.\"  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>  .\"
>  .\"  This program is free software; you can redistribute it and/or modify
>  .\"  it under the terms of the GNU General Public License version 2
> diff --git a/include/Makefile.am b/include/Makefile.am
> index 498b3b5..a52c427 100644
> --- a/include/Makefile.am
> +++ b/include/Makefile.am
> @@ -5,7 +5,7 @@
>  #             packet encryption, packet authentication, and
>  #             packet compression.
>  #
> -#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> +#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>  #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
>  #
>  
> diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
> index 4c9e63c..5f3c96c 100644
> --- a/include/openvpn-msg.h
> +++ b/include/openvpn-msg.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2013 Heiko Hund <heiko.hund@...1489...>
> + *  Copyright (C) 2013-2017 Heiko Hund <heiko.hund@...1489...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
> index f17b753..0b30352 100644
> --- a/include/openvpn-plugin.h.in
> +++ b/include/openvpn-plugin.h.in
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/sample/Makefile.am b/sample/Makefile.am
> index be30c88..58ae965 100644
> --- a/sample/Makefile.am
> +++ b/sample/Makefile.am
> @@ -5,7 +5,7 @@
>  #             packet encryption, packet authentication, and
>  #             packet compression.
>  #
> -#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> +#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>  #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
>  #
>  
> diff --git a/sample/sample-plugins/defer/simple.c b/sample/sample-plugins/defer/simple.c
> index 1d70ad1..ad1bbb0 100644
> --- a/sample/sample-plugins/defer/simple.c
> +++ b/sample/sample-plugins/defer/simple.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
> index 9827ed1..177977d 100644
> --- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
> +++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/sample/sample-plugins/log/log.c b/sample/sample-plugins/log/log.c
> index 390c37f..0201628 100644
> --- a/sample/sample-plugins/log/log.c
> +++ b/sample/sample-plugins/log/log.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
> index 317604d..9037225 100644
> --- a/sample/sample-plugins/log/log_v3.c
> +++ b/sample/sample-plugins/log/log_v3.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2009 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *  Copyright (C) 2010 David Sommerseth <dazo@...384...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
> diff --git a/sample/sample-plugins/simple/simple.c b/sample/sample-plugins/simple/simple.c
> index 4beab48..f595333 100644
> --- a/sample/sample-plugins/simple/simple.c
> +++ b/sample/sample-plugins/simple/simple.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/Makefile.am b/src/Makefile.am
> index c04468a..eb5b007 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -5,7 +5,7 @@
>  #             packet encryption, packet authentication, and
>  #             packet compression.
>  #
> -#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> +#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>  #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
>  #
>  
> diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
> index 0a9d1c2..444a8f8 100644
> --- a/src/compat/Makefile.am
> +++ b/src/compat/Makefile.am
> @@ -5,7 +5,7 @@
>  #             packet encryption, packet authentication, and
>  #             packet compression.
>  #
> -#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> +#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>  #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
>  #
>  
> diff --git a/src/compat/compat-gettimeofday.c b/src/compat/compat-gettimeofday.c
> index 027bc4a..d53e360 100644
> --- a/src/compat/compat-gettimeofday.c
> +++ b/src/compat/compat-gettimeofday.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index 4c18449..bea294b 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -5,7 +5,7 @@
>  #             packet encryption, packet authentication, and
>  #             packet compression.
>  #
> -#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> +#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>  #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
>  #
>  
> diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
> index 27cda0c..cc813ed 100644
> --- a/src/openvpn/argv.c
> +++ b/src/openvpn/argv.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
> index 8e263e1..1dd6dd7 100644
> --- a/src/openvpn/argv.h
> +++ b/src/openvpn/argv.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h
> index 48d4d9b..dac6f01 100644
> --- a/src/openvpn/basic.h
> +++ b/src/openvpn/basic.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c
> index 81c2929..e31765e 100644
> --- a/src/openvpn/block_dns.c
> +++ b/src/openvpn/block_dns.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *                2015-2016  <iam@...2070...>
>   *                2016 Selva Nair <selva.nair@...277...>
>   *
> diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
> index b1d2fbf..2defd18 100644
> --- a/src/openvpn/buffer.c
> +++ b/src/openvpn/buffer.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
> index a1a130c..28b224e 100644
> --- a/src/openvpn/buffer.h
> +++ b/src/openvpn/buffer.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/circ_list.h b/src/openvpn/circ_list.h
> index b4324d8..ecf2a7f 100644
> --- a/src/openvpn/circ_list.h
> +++ b/src/openvpn/circ_list.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
> index 08d7acf..9158437 100644
> --- a/src/openvpn/clinat.c
> +++ b/src/openvpn/clinat.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
> index e0c8ec5..cdaf2a8 100644
> --- a/src/openvpn/clinat.h
> +++ b/src/openvpn/clinat.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/common.h b/src/openvpn/common.h
> index 6352b01..cd988d4 100644
> --- a/src/openvpn/common.h
> +++ b/src/openvpn/common.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
> index 6b7c49b..fa65f87 100644
> --- a/src/openvpn/comp-lz4.c
> +++ b/src/openvpn/comp-lz4.c
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2012 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2013      Gert Doering <gert@...1296...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2013-2017 Gert Doering <gert@...1296...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/comp-lz4.h b/src/openvpn/comp-lz4.h
> index 65f4f8e..8621e93 100644
> --- a/src/openvpn/comp-lz4.h
> +++ b/src/openvpn/comp-lz4.h
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2012 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2013      Gert Doering <gert@...1296...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2013-2017 Gert Doering <gert@...1296...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
> index 5f563ae..0182a7c 100644
> --- a/src/openvpn/comp.c
> +++ b/src/openvpn/comp.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2012 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
> index 7410c92..3c0b18e 100644
> --- a/src/openvpn/comp.h
> +++ b/src/openvpn/comp.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2012 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/compstub.c b/src/openvpn/compstub.c
> index 7082b99..5070c82 100644
> --- a/src/openvpn/compstub.c
> +++ b/src/openvpn/compstub.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2012 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/console.c b/src/openvpn/console.c
> index ec64d42..90c8a94 100644
> --- a/src/openvpn/console.c
> +++ b/src/openvpn/console.c
> @@ -5,9 +5,9 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
> - *  Copyright (C) 2016      David Sommerseth <davids@...515...>
> + *  Copyright (C) 2016-2017 David Sommerseth <davids@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/console.h b/src/openvpn/console.h
> index 495414a..2c7f3e9 100644
> --- a/src/openvpn/console.h
> +++ b/src/openvpn/console.h
> @@ -5,9 +5,9 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
> - *  Copyright (C) 2016      David Sommerseth <davids@...515...>
> + *  Copyright (C) 2016-2017 David Sommerseth <davids@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
> index 2d0c15f..13b9d7e 100644
> --- a/src/openvpn/console_builtin.c
> +++ b/src/openvpn/console_builtin.c
> @@ -5,9 +5,9 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2016  OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *  Copyright (C) 2014-2015  David Sommerseth <davids@...1347...>
> - *  Copyright (C) 2016       David Sommerseth <davids@...515...>
> + *  Copyright (C) 2016-2017 David Sommerseth <davids@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index b28eb9d..7119abc 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010-2016 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
> index 56761ba..61e9b59 100644
> --- a/src/openvpn/crypto.h
> +++ b/src/openvpn/crypto.h
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010-2014 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
> index a4b2b43..2c79baa 100644
> --- a/src/openvpn/crypto_backend.h
> +++ b/src/openvpn/crypto_backend.h
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
> index 89915bc..942684c 100644
> --- a/src/openvpn/crypto_mbedtls.c
> +++ b/src/openvpn/crypto_mbedtls.c
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
> index 16f9007..d9b1446 100644
> --- a/src/openvpn/crypto_mbedtls.h
> +++ b/src/openvpn/crypto_mbedtls.h
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 4e78316..b016d98 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
> index 6cf009e..56ec6e1 100644
> --- a/src/openvpn/crypto_openssl.h
> +++ b/src/openvpn/crypto_openssl.h
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
> index 9c706ed..c17a22e 100644
> --- a/src/openvpn/dhcp.c
> +++ b/src/openvpn/dhcp.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/dhcp.h b/src/openvpn/dhcp.h
> index ee0f438..d406870 100644
> --- a/src/openvpn/dhcp.h
> +++ b/src/openvpn/dhcp.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
> index b3a9f81..c4dd518 100644
> --- a/src/openvpn/errlevel.h
> +++ b/src/openvpn/errlevel.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/error.c b/src/openvpn/error.c
> index 6c07cde..e78f272 100644
> --- a/src/openvpn/error.c
> +++ b/src/openvpn/error.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/error.h b/src/openvpn/error.h
> index eb9f8c0..df4eee7 100644
> --- a/src/openvpn/error.h
> +++ b/src/openvpn/error.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/event.c b/src/openvpn/event.c
> index a13e0dc..f4922e0 100644
> --- a/src/openvpn/event.c
> +++ b/src/openvpn/event.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/event.h b/src/openvpn/event.h
> index 5e66d48..6a6e029 100644
> --- a/src/openvpn/event.h
> +++ b/src/openvpn/event.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/fdmisc.c b/src/openvpn/fdmisc.c
> index 3851c43..401069d 100644
> --- a/src/openvpn/fdmisc.c
> +++ b/src/openvpn/fdmisc.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/fdmisc.h b/src/openvpn/fdmisc.h
> index bd9b47c..1e84a08 100644
> --- a/src/openvpn/fdmisc.h
> +++ b/src/openvpn/fdmisc.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/forward-inline.h b/src/openvpn/forward-inline.h
> index 6bce755..97e1cd6 100644
> --- a/src/openvpn/forward-inline.h
> +++ b/src/openvpn/forward-inline.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index ab56056..8102e94 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
> index 82f7bbf..ae86e7a 100644
> --- a/src/openvpn/forward.h
> +++ b/src/openvpn/forward.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
> index 87b9380..6fbfe08 100644
> --- a/src/openvpn/fragment.c
> +++ b/src/openvpn/fragment.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/fragment.h b/src/openvpn/fragment.h
> index 4073212..a24b524 100644
> --- a/src/openvpn/fragment.h
> +++ b/src/openvpn/fragment.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin.c
> index e8b10a7..5bff5e8 100644
> --- a/src/openvpn/gremlin.c
> +++ b/src/openvpn/gremlin.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/gremlin.h b/src/openvpn/gremlin.h
> index c60048c..8f41864 100644
> --- a/src/openvpn/gremlin.h
> +++ b/src/openvpn/gremlin.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
> index 1fc4c86..adcc4f8 100644
> --- a/src/openvpn/helper.c
> +++ b/src/openvpn/helper.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/helper.h b/src/openvpn/helper.h
> index d78c02f..593d1ed 100644
> --- a/src/openvpn/helper.h
> +++ b/src/openvpn/helper.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
> index c5f0d92..01301c0 100644
> --- a/src/openvpn/httpdigest.c
> +++ b/src/openvpn/httpdigest.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/httpdigest.h b/src/openvpn/httpdigest.h
> index fff7d46..b074fb2 100644
> --- a/src/openvpn/httpdigest.h
> +++ b/src/openvpn/httpdigest.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index f6a5ac7..9a3e29d 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/init.h b/src/openvpn/init.h
> index d742bc7..3b97d84 100644
> --- a/src/openvpn/init.h
> +++ b/src/openvpn/init.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
> index ee9a43e..bae8f16 100644
> --- a/src/openvpn/integer.h
> +++ b/src/openvpn/integer.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/interval.c b/src/openvpn/interval.c
> index 108b778..99e72a0 100644
> --- a/src/openvpn/interval.c
> +++ b/src/openvpn/interval.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/interval.h b/src/openvpn/interval.h
> index 0507ed2..5ed64a9 100644
> --- a/src/openvpn/interval.h
> +++ b/src/openvpn/interval.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/list.c b/src/openvpn/list.c
> index 4d64b4c..fb9f664 100644
> --- a/src/openvpn/list.c
> +++ b/src/openvpn/list.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/list.h b/src/openvpn/list.h
> index 72fb2c9..6270f88 100644
> --- a/src/openvpn/list.h
> +++ b/src/openvpn/list.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
> index e587268..3d6891e 100644
> --- a/src/openvpn/lzo.c
> +++ b/src/openvpn/lzo.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h
> index f9eddcc..85937b2 100644
> --- a/src/openvpn/lzo.h
> +++ b/src/openvpn/lzo.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
> index b6520c0..763f6c6 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
> index 7e022f0..6e5cb9b 100644
> --- a/src/openvpn/manage.h
> +++ b/src/openvpn/manage.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
> index a8388c4..7a23e59 100644
> --- a/src/openvpn/mbuf.c
> +++ b/src/openvpn/mbuf.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/mbuf.h b/src/openvpn/mbuf.h
> index c6375e3..cfaef58 100644
> --- a/src/openvpn/mbuf.h
> +++ b/src/openvpn/mbuf.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/memdbg.h b/src/openvpn/memdbg.h
> index 4906f88..ee30b15 100644
> --- a/src/openvpn/memdbg.h
> +++ b/src/openvpn/memdbg.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index 7c769a8..87f03be 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -5,9 +5,9 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
> - *  Copyright (C) 2016      David Sommerseth <davids@...515...>
> + *  Copyright (C) 2016-2017 David Sommerseth <davids@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
> index 606c465..16be621 100644
> --- a/src/openvpn/misc.h
> +++ b/src/openvpn/misc.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
> index cdcd061..8b466b6 100644
> --- a/src/openvpn/mroute.c
> +++ b/src/openvpn/mroute.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
> index 9da41ee..0698348 100644
> --- a/src/openvpn/mroute.h
> +++ b/src/openvpn/mroute.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
> index af3457b..5b110d2 100644
> --- a/src/openvpn/mss.c
> +++ b/src/openvpn/mss.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h
> index 6d18fb9..afe7a32 100644
> --- a/src/openvpn/mss.h
> +++ b/src/openvpn/mss.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/mstats.c b/src/openvpn/mstats.c
> index 3dad866..8ab1d02 100644
> --- a/src/openvpn/mstats.c
> +++ b/src/openvpn/mstats.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2011 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/mstats.h b/src/openvpn/mstats.h
> index 7a5cc68..f87a858 100644
> --- a/src/openvpn/mstats.h
> +++ b/src/openvpn/mstats.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2011 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
> index 4fab23f..b5471b1 100644
> --- a/src/openvpn/mtcp.c
> +++ b/src/openvpn/mtcp.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
> index a11e56e..835b8fd 100644
> --- a/src/openvpn/mtcp.h
> +++ b/src/openvpn/mtcp.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
> index 416a11e..73eab21 100644
> --- a/src/openvpn/mtu.c
> +++ b/src/openvpn/mtu.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
> index 0d5402d..471e51e 100644
> --- a/src/openvpn/mtu.h
> +++ b/src/openvpn/mtu.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
> index 35a8d3c..64ce4d7 100644
> --- a/src/openvpn/mudp.c
> +++ b/src/openvpn/mudp.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
> index 89ec78c..a98d64d 100644
> --- a/src/openvpn/mudp.h
> +++ b/src/openvpn/mudp.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 3480579..f6f3f5d 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
> index 7508fe2..b4ffd69 100644
> --- a/src/openvpn/multi.h
> +++ b/src/openvpn/multi.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/occ-inline.h b/src/openvpn/occ-inline.h
> index 5b656d4..84fe1ac 100644
> --- a/src/openvpn/occ-inline.h
> +++ b/src/openvpn/occ-inline.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
> index 046d03b..b4ccc4d 100644
> --- a/src/openvpn/occ.c
> +++ b/src/openvpn/occ.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
> index cb5d957..843ceb2 100644
> --- a/src/openvpn/occ.h
> +++ b/src/openvpn/occ.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
> index 9a1ff9c..888acda 100644
> --- a/src/openvpn/openvpn.c
> +++ b/src/openvpn/openvpn.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
> index 36c53e8..37edec4 100644
> --- a/src/openvpn/openvpn.h
> +++ b/src/openvpn/openvpn.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index b343502..bfedb6a 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2013 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *  Copyright (C) 2008-2013 David Sommerseth <dazo@...384...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
> @@ -4137,7 +4137,7 @@ usage_version(void)
>      show_windows_version( M_INFO|M_NOPREFIX );
>  #endif
>      msg(M_INFO|M_NOPREFIX, "Originally developed by James Yonan");
> -    msg(M_INFO|M_NOPREFIX, "Copyright (C) 2002-2016 OpenVPN Technologies, Inc. <sales@...515...>");
> +    msg(M_INFO|M_NOPREFIX, "Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>");
>  #ifndef ENABLE_SMALL
>  #ifdef CONFIGURE_DEFINES
>      msg(M_INFO|M_NOPREFIX, "Compile time defines: %s", CONFIGURE_DEFINES);
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 3fd0f23..b3ab029 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
> index cc487e5..22abda0 100644
> --- a/src/openvpn/otime.c
> +++ b/src/openvpn/otime.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
> index 2b596ff..eede63d 100644
> --- a/src/openvpn/otime.h
> +++ b/src/openvpn/otime.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
> index 64d19c5..fe13e1d 100644
> --- a/src/openvpn/packet_id.c
> +++ b/src/openvpn/packet_id.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
> index d4019ff..ecc25a6 100644
> --- a/src/openvpn/packet_id.h
> +++ b/src/openvpn/packet_id.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/perf.c b/src/openvpn/perf.c
> index e012eb4..51e051a 100644
> --- a/src/openvpn/perf.c
> +++ b/src/openvpn/perf.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/perf.h b/src/openvpn/perf.h
> index f277b1e..f0430a1 100644
> --- a/src/openvpn/perf.h
> +++ b/src/openvpn/perf.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/pf-inline.h b/src/openvpn/pf-inline.h
> index beaae5c..a0f5cc7 100644
> --- a/src/openvpn/pf-inline.h
> +++ b/src/openvpn/pf-inline.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
> index 7db4ba9..56b6858 100644
> --- a/src/openvpn/pf.c
> +++ b/src/openvpn/pf.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/pf.h b/src/openvpn/pf.h
> index e5c951f..3832683 100644
> --- a/src/openvpn/pf.h
> +++ b/src/openvpn/pf.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/ping-inline.h b/src/openvpn/ping-inline.h
> index 1029100..2fa1d5c 100644
> --- a/src/openvpn/ping-inline.h
> +++ b/src/openvpn/ping-inline.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/ping.c b/src/openvpn/ping.c
> index 1af31cc..0496b72 100644
> --- a/src/openvpn/ping.c
> +++ b/src/openvpn/ping.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/ping.h b/src/openvpn/ping.h
> index 6f060c6..e839ce7 100644
> --- a/src/openvpn/ping.h
> +++ b/src/openvpn/ping.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
> index f77d4cd..6858846 100644
> --- a/src/openvpn/pkcs11.c
> +++ b/src/openvpn/pkcs11.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/pkcs11.h b/src/openvpn/pkcs11.h
> index 621796d..3747d3a 100644
> --- a/src/openvpn/pkcs11.h
> +++ b/src/openvpn/pkcs11.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/pkcs11_backend.h b/src/openvpn/pkcs11_backend.h
> index e883d0c..9606899 100644
> --- a/src/openvpn/pkcs11_backend.h
> +++ b/src/openvpn/pkcs11_backend.h
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c
> index 874618c..bdca893 100644
> --- a/src/openvpn/pkcs11_mbedtls.c
> +++ b/src/openvpn/pkcs11_mbedtls.c
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
> index bab4c90..6244cc7 100644
> --- a/src/openvpn/pkcs11_openssl.c
> +++ b/src/openvpn/pkcs11_openssl.c
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
> index 3deed32..952d633 100644
> --- a/src/openvpn/platform.c
> +++ b/src/openvpn/platform.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
> index a43ee13..62396a9 100644
> --- a/src/openvpn/platform.h
> +++ b/src/openvpn/platform.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
> index dab9c93..17eb2d8 100644
> --- a/src/openvpn/plugin.c
> +++ b/src/openvpn/plugin.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
> index 7f0cbd4..4ded529 100644
> --- a/src/openvpn/plugin.h
> +++ b/src/openvpn/plugin.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
> index 8d5dc1b..aa0bc2b 100644
> --- a/src/openvpn/pool.c
> +++ b/src/openvpn/pool.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/pool.h b/src/openvpn/pool.h
> index 5638b9f..c3e1190 100644
> --- a/src/openvpn/pool.h
> +++ b/src/openvpn/pool.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
> index acf35f5..40e0714 100644
> --- a/src/openvpn/proto.c
> +++ b/src/openvpn/proto.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
> index 1b560a3..bfcb36d 100644
> --- a/src/openvpn/proto.h
> +++ b/src/openvpn/proto.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
> index 7a06038..dd327a2 100644
> --- a/src/openvpn/proxy.c
> +++ b/src/openvpn/proxy.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
> index 892277b..c20a676 100644
> --- a/src/openvpn/proxy.h
> +++ b/src/openvpn/proxy.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
> index bca670c..21b12ca 100644
> --- a/src/openvpn/ps.c
> +++ b/src/openvpn/ps.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/ps.h b/src/openvpn/ps.h
> index cbfe9b8..0fc1ee4 100644
> --- a/src/openvpn/ps.h
> +++ b/src/openvpn/ps.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index b6e12e1..f515475 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/push.h b/src/openvpn/push.h
> index 38cf5c1..86900c8 100644
> --- a/src/openvpn/push.h
> +++ b/src/openvpn/push.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/pushlist.h b/src/openvpn/pushlist.h
> index 5471b1b..58fc870 100644
> --- a/src/openvpn/pushlist.h
> +++ b/src/openvpn/pushlist.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
> index 3671916..57cdd78 100644
> --- a/src/openvpn/reliable.c
> +++ b/src/openvpn/reliable.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
> index 84cd1e2..455168a 100644
> --- a/src/openvpn/reliable.h
> +++ b/src/openvpn/reliable.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index 01c3787..0c93dcd 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/route.h b/src/openvpn/route.h
> index dcc7ded..03ee8cd 100644
> --- a/src/openvpn/route.h
> +++ b/src/openvpn/route.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
> index 4495b1e..610bfa4 100644
> --- a/src/openvpn/schedule.c
> +++ b/src/openvpn/schedule.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/schedule.h b/src/openvpn/schedule.h
> index bdd443f..f2a6813 100644
> --- a/src/openvpn/schedule.h
> +++ b/src/openvpn/schedule.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/session_id.c b/src/openvpn/session_id.c
> index 029608e..b23f0f4 100644
> --- a/src/openvpn/session_id.c
> +++ b/src/openvpn/session_id.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/session_id.h b/src/openvpn/session_id.h
> index 0fb8f6e..2b0ceb8 100644
> --- a/src/openvpn/session_id.h
> +++ b/src/openvpn/session_id.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/shaper.c b/src/openvpn/shaper.c
> index 05c179e..eb459ef 100644
> --- a/src/openvpn/shaper.c
> +++ b/src/openvpn/shaper.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/shaper.h b/src/openvpn/shaper.h
> index 21b4fb6..d97221a 100644
> --- a/src/openvpn/shaper.h
> +++ b/src/openvpn/shaper.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
> index bd473e3..9f4841a 100644
> --- a/src/openvpn/sig.c
> +++ b/src/openvpn/sig.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
> index 9536a6e..5783731 100644
> --- a/src/openvpn/sig.h
> +++ b/src/openvpn/sig.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index 516a8f6..ae12832 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
> index 2f70eca..63e601e 100644
> --- a/src/openvpn/socket.h
> +++ b/src/openvpn/socket.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
> index da4c824..b50cac3 100644
> --- a/src/openvpn/socks.c
> +++ b/src/openvpn/socks.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
> index d0b18f1..17e75e1 100644
> --- a/src/openvpn/socks.h
> +++ b/src/openvpn/socks.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 1022fb6..15f62f2 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *  Copyright (C) 2008-2013 David Sommerseth <dazo@...384...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
> diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
> index a78d462..ed1344e 100644
> --- a/src/openvpn/ssl.h
> +++ b/src/openvpn/ssl.h
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
> index b364512..206400f 100644
> --- a/src/openvpn/ssl_backend.h
> +++ b/src/openvpn/ssl_backend.h
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index 018da27..9a16d77 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index b6b600d..5c84e30 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *  Copyright (C) 2006-2010, Brainspark B.V.
>   *
>   *  This program is free software; you can redistribute it and/or modify
> diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
> index dfd2ec9..1bc53ce 100644
> --- a/src/openvpn/ssl_mbedtls.h
> +++ b/src/openvpn/ssl_mbedtls.h
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 1f156d6..eae1e22 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
> index 5f77713..c64c65f 100644
> --- a/src/openvpn/ssl_openssl.h
> +++ b/src/openvpn/ssl_openssl.h
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index e901202..334eb29 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
> index 45ce3b0..ffab218 100644
> --- a/src/openvpn/ssl_verify.h
> +++ b/src/openvpn/ssl_verify.h
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
> index 34edffb..c4330ba 100644
> --- a/src/openvpn/ssl_verify_backend.h
> +++ b/src/openvpn/ssl_verify_backend.h
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
> index b8fbee8..f01569f 100644
> --- a/src/openvpn/ssl_verify_mbedtls.c
> +++ b/src/openvpn/ssl_verify_mbedtls.c
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/ssl_verify_mbedtls.h b/src/openvpn/ssl_verify_mbedtls.h
> index a5252ff..3c71073 100644
> --- a/src/openvpn/ssl_verify_mbedtls.h
> +++ b/src/openvpn/ssl_verify_mbedtls.h
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
> index 04880d7..e9692a0 100644
> --- a/src/openvpn/ssl_verify_openssl.c
> +++ b/src/openvpn/ssl_verify_openssl.c
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/ssl_verify_openssl.h b/src/openvpn/ssl_verify_openssl.h
> index 934c1e9..1db6fe6 100644
> --- a/src/openvpn/ssl_verify_openssl.h
> +++ b/src/openvpn/ssl_verify_openssl.h
> @@ -5,8 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> - *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/status.c b/src/openvpn/status.c
> index cca623f..e47f35c 100644
> --- a/src/openvpn/status.c
> +++ b/src/openvpn/status.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/status.h b/src/openvpn/status.h
> index 01fe33e..590ae41 100644
> --- a/src/openvpn/status.h
> +++ b/src/openvpn/status.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
> index 2f04896..a1b6047 100644
> --- a/src/openvpn/syshead.h
> +++ b/src/openvpn/syshead.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
> index 8173467..c227b09 100644
> --- a/src/openvpn/tls_crypt.c
> +++ b/src/openvpn/tls_crypt.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2016 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2016-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
> index 2c7831f..47f75d0 100644
> --- a/src/openvpn/tls_crypt.h
> +++ b/src/openvpn/tls_crypt.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2016 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2016-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 8dbdd4f..f812844 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
> index bc499bf..f4b600c 100644
> --- a/src/openvpn/tun.h
> +++ b/src/openvpn/tun.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
> index 88fa3ec..e26f54d 100644
> --- a/src/openvpn/win32.c
> +++ b/src/openvpn/win32.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
> index 5d2e1fb..4ee44fd 100644
> --- a/src/openvpn/win32.h
> +++ b/src/openvpn/win32.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
> index 58ecd91..21efc7c 100644
> --- a/src/openvpnserv/Makefile.am
> +++ b/src/openvpnserv/Makefile.am
> @@ -5,7 +5,7 @@
>  #             packet encryption, packet authentication, and
>  #             packet compression.
>  #
> -#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> +#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>  #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
>  #
>  
> diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
> index dc57cad..6be6c6d 100644
> --- a/src/openvpnserv/automatic.c
> +++ b/src/openvpnserv/automatic.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
> index c7abe0d..3b9b396 100644
> --- a/src/openvpnserv/common.c
> +++ b/src/openvpnserv/common.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2011 Heiko Hund <heiko.hund@...1489...>
> + *  Copyright (C) 2011-2017 Heiko Hund <heiko.hund@...1489...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index 9cbe25c..dbe2b9b 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2012 Heiko Hund <heiko.hund@...1489...>
> + *  Copyright (C) 2012-2017 Heiko Hund <heiko.hund@...1489...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
> index f907e69..b1130c9 100644
> --- a/src/openvpnserv/service.h
> +++ b/src/openvpnserv/service.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2013 Heiko Hund <heiko.hund@...1489...>
> + *  Copyright (C) 2013-2017 Heiko Hund <heiko.hund@...1489...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/plugins/Makefile.am b/src/plugins/Makefile.am
> index 17b72b9..ca90496 100644
> --- a/src/plugins/Makefile.am
> +++ b/src/plugins/Makefile.am
> @@ -5,7 +5,7 @@
>  #             packet encryption, packet authentication, and
>  #             packet compression.
>  #
> -#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> +#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>  #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
>  #
>  
> diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
> index 4581411..d3e2c89 100644
> --- a/src/plugins/auth-pam/auth-pam.c
> +++ b/src/plugins/auth-pam/auth-pam.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c
> index e4f4d19..4f8fb0a 100644
> --- a/src/plugins/auth-pam/utils.c
> +++ b/src/plugins/auth-pam/utils.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/plugins/auth-pam/utils.h b/src/plugins/auth-pam/utils.h
> index 810f7b9..fbc9705 100644
> --- a/src/plugins/auth-pam/utils.h
> +++ b/src/plugins/auth-pam/utils.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
> index c940d61..ae85ecb 100644
> --- a/src/plugins/down-root/down-root.c
> +++ b/src/plugins/down-root/down-root.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2013 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *  Copyright (C) 2013      David Sommerseth <davids@...1347...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
> diff --git a/tests/Makefile.am b/tests/Makefile.am
> index e55928b..0795680 100644
> --- a/tests/Makefile.am
> +++ b/tests/Makefile.am
> @@ -5,7 +5,7 @@
>  #             packet encryption, packet authentication, and
>  #             packet compression.
>  #
> -#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> +#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>  #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
>  #
>  
> diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c
> index b6f1a46..eb0d5e9 100644
> --- a/tests/unit_tests/openvpn/mock_msg.c
> +++ b/tests/unit_tests/openvpn/mock_msg.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2016 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2016-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/tests/unit_tests/openvpn/mock_msg.h b/tests/unit_tests/openvpn/mock_msg.h
> index 5d93a1a..e0933c6 100644
> --- a/tests/unit_tests/openvpn/mock_msg.h
> +++ b/tests/unit_tests/openvpn/mock_msg.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2016 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2016-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
> index 5d25437..5158eb8 100644
> --- a/tests/unit_tests/openvpn/test_buffer.c
> +++ b/tests/unit_tests/openvpn/test_buffer.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2016 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2016-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
> index 3650aa8..7b014e0 100644
> --- a/tests/unit_tests/openvpn/test_tls_crypt.c
> +++ b/tests/unit_tests/openvpn/test_tls_crypt.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2016 Fox Crypto B.V. <openvpn@...1435...>
> + *  Copyright (C) 2016-2017 Fox Crypto B.V. <openvpn@...1435...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> 

ACK

-Steffan

