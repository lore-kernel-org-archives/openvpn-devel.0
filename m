References: <1482350454-27280-1-git-send-email-davids@...515...>
	<1482350454-27280-3-git-send-email-davids@...515...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <a73adc70-4f31-2106-f7de-a49a7f4f0afd@...1856...>
Date: Wed, 21 Dec 2016 21:15:23 +0100
MIME-Version: 1.0
In-Reply-To: <1482350454-27280-3-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH release/2.3] Update copyrights
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
>  COPYING                                | 2 +-
>  ChangeLog                              | 2 +-
>  Makefile.am                            | 2 +-
>  PORTS                                  | 2 +-
>  build/Makefile.am                      | 2 +-
>  build/msvc/Makefile.am                 | 2 +-
>  build/msvc/msvc-generate/Makefile.am   | 2 +-
>  configure.ac                           | 2 +-
>  dev-tools/update-copyright.sh          | 2 +-
>  distro/Makefile.am                     | 2 +-
>  distro/rpm/Makefile.am                 | 2 +-
>  doc/Makefile.am                        | 2 +-
>  doc/doxygen/doc_compression.h          | 2 +-
>  doc/doxygen/doc_control_processor.h    | 2 +-
>  doc/doxygen/doc_control_tls.h          | 2 +-
>  doc/doxygen/doc_data_control.h         | 2 +-
>  doc/doxygen/doc_data_crypto.h          | 2 +-
>  doc/doxygen/doc_eventloop.h            | 2 +-
>  doc/doxygen/doc_external_multiplexer.h | 2 +-
>  doc/doxygen/doc_fragmentation.h        | 2 +-
>  doc/doxygen/doc_internal_multiplexer.h | 2 +-
>  doc/doxygen/doc_key_generation.h       | 2 +-
>  doc/doxygen/doc_mainpage.h             | 2 +-
>  doc/doxygen/doc_memory_management.h    | 2 +-
>  doc/doxygen/doc_protocol_overview.h    | 2 +-
>  doc/doxygen/doc_reliable.h             | 2 +-
>  doc/doxygen/doc_tunnel_state.h         | 2 +-
>  doc/openvpn.8                          | 2 +-
>  include/Makefile.am                    | 2 +-
>  include/openvpn-plugin.h               | 2 +-
>  sample/Makefile.am                     | 2 +-
>  sample/sample-plugins/defer/simple.c   | 2 +-
>  sample/sample-plugins/log/log.c        | 2 +-
>  sample/sample-plugins/log/log_v3.c     | 2 +-
>  sample/sample-plugins/simple/simple.c  | 2 +-
>  src/Makefile.am                        | 2 +-
>  src/compat/Makefile.am                 | 2 +-
>  src/compat/compat-gettimeofday.c       | 2 +-
>  src/openvpn/Makefile.am                | 2 +-
>  src/openvpn/basic.h                    | 2 +-
>  src/openvpn/buffer.c                   | 2 +-
>  src/openvpn/buffer.h                   | 2 +-
>  src/openvpn/circ_list.h                | 2 +-
>  src/openvpn/clinat.c                   | 2 +-
>  src/openvpn/clinat.h                   | 2 +-
>  src/openvpn/common.h                   | 2 +-
>  src/openvpn/console.c                  | 2 +-
>  src/openvpn/console.h                  | 2 +-
>  src/openvpn/crypto.c                   | 4 ++--
>  src/openvpn/crypto.h                   | 4 ++--
>  src/openvpn/crypto_backend.h           | 4 ++--
>  src/openvpn/crypto_openssl.c           | 4 ++--
>  src/openvpn/crypto_openssl.h           | 4 ++--
>  src/openvpn/crypto_polarssl.c          | 4 ++--
>  src/openvpn/crypto_polarssl.h          | 4 ++--
>  src/openvpn/dhcp.c                     | 2 +-
>  src/openvpn/dhcp.h                     | 2 +-
>  src/openvpn/errlevel.h                 | 2 +-
>  src/openvpn/error.c                    | 2 +-
>  src/openvpn/error.h                    | 2 +-
>  src/openvpn/event.c                    | 2 +-
>  src/openvpn/event.h                    | 2 +-
>  src/openvpn/fdmisc.c                   | 2 +-
>  src/openvpn/fdmisc.h                   | 2 +-
>  src/openvpn/forward-inline.h           | 2 +-
>  src/openvpn/forward.c                  | 2 +-
>  src/openvpn/forward.h                  | 2 +-
>  src/openvpn/fragment.c                 | 2 +-
>  src/openvpn/fragment.h                 | 2 +-
>  src/openvpn/gremlin.c                  | 2 +-
>  src/openvpn/gremlin.h                  | 2 +-
>  src/openvpn/helper.c                   | 2 +-
>  src/openvpn/helper.h                   | 2 +-
>  src/openvpn/httpdigest.c               | 2 +-
>  src/openvpn/httpdigest.h               | 2 +-
>  src/openvpn/init.c                     | 2 +-
>  src/openvpn/init.h                     | 2 +-
>  src/openvpn/integer.h                  | 2 +-
>  src/openvpn/interval.c                 | 2 +-
>  src/openvpn/interval.h                 | 2 +-
>  src/openvpn/list.c                     | 2 +-
>  src/openvpn/list.h                     | 2 +-
>  src/openvpn/lzo.c                      | 2 +-
>  src/openvpn/lzo.h                      | 2 +-
>  src/openvpn/manage.c                   | 2 +-
>  src/openvpn/manage.h                   | 2 +-
>  src/openvpn/mbuf.c                     | 2 +-
>  src/openvpn/mbuf.h                     | 2 +-
>  src/openvpn/memdbg.h                   | 2 +-
>  src/openvpn/misc.c                     | 2 +-
>  src/openvpn/misc.h                     | 2 +-
>  src/openvpn/mroute.c                   | 2 +-
>  src/openvpn/mroute.h                   | 2 +-
>  src/openvpn/mss.c                      | 2 +-
>  src/openvpn/mss.h                      | 2 +-
>  src/openvpn/mstats.c                   | 2 +-
>  src/openvpn/mstats.h                   | 2 +-
>  src/openvpn/mtcp.c                     | 2 +-
>  src/openvpn/mtcp.h                     | 2 +-
>  src/openvpn/mtu.c                      | 2 +-
>  src/openvpn/mtu.h                      | 2 +-
>  src/openvpn/mudp.c                     | 2 +-
>  src/openvpn/mudp.h                     | 2 +-
>  src/openvpn/multi.c                    | 2 +-
>  src/openvpn/multi.h                    | 2 +-
>  src/openvpn/occ-inline.h               | 2 +-
>  src/openvpn/occ.c                      | 2 +-
>  src/openvpn/occ.h                      | 2 +-
>  src/openvpn/openvpn.c                  | 2 +-
>  src/openvpn/openvpn.h                  | 2 +-
>  src/openvpn/options.c                  | 4 ++--
>  src/openvpn/options.h                  | 2 +-
>  src/openvpn/otime.c                    | 2 +-
>  src/openvpn/otime.h                    | 2 +-
>  src/openvpn/packet_id.c                | 2 +-
>  src/openvpn/packet_id.h                | 2 +-
>  src/openvpn/perf.c                     | 2 +-
>  src/openvpn/perf.h                     | 2 +-
>  src/openvpn/pf-inline.h                | 2 +-
>  src/openvpn/pf.c                       | 2 +-
>  src/openvpn/pf.h                       | 2 +-
>  src/openvpn/ping-inline.h              | 2 +-
>  src/openvpn/ping.c                     | 2 +-
>  src/openvpn/ping.h                     | 2 +-
>  src/openvpn/pkcs11.c                   | 2 +-
>  src/openvpn/pkcs11.h                   | 2 +-
>  src/openvpn/pkcs11_backend.h           | 4 ++--
>  src/openvpn/pkcs11_openssl.c           | 4 ++--
>  src/openvpn/pkcs11_polarssl.c          | 4 ++--
>  src/openvpn/platform.c                 | 2 +-
>  src/openvpn/platform.h                 | 2 +-
>  src/openvpn/plugin.c                   | 2 +-
>  src/openvpn/plugin.h                   | 2 +-
>  src/openvpn/pool.c                     | 2 +-
>  src/openvpn/pool.h                     | 2 +-
>  src/openvpn/proto.c                    | 2 +-
>  src/openvpn/proto.h                    | 2 +-
>  src/openvpn/proxy.c                    | 2 +-
>  src/openvpn/proxy.h                    | 2 +-
>  src/openvpn/ps.c                       | 2 +-
>  src/openvpn/ps.h                       | 2 +-
>  src/openvpn/push.c                     | 2 +-
>  src/openvpn/push.h                     | 2 +-
>  src/openvpn/pushlist.h                 | 2 +-
>  src/openvpn/reliable.c                 | 2 +-
>  src/openvpn/reliable.h                 | 2 +-
>  src/openvpn/route.c                    | 2 +-
>  src/openvpn/route.h                    | 2 +-
>  src/openvpn/schedule.c                 | 2 +-
>  src/openvpn/schedule.h                 | 2 +-
>  src/openvpn/session_id.c               | 2 +-
>  src/openvpn/session_id.h               | 2 +-
>  src/openvpn/shaper.c                   | 2 +-
>  src/openvpn/shaper.h                   | 2 +-
>  src/openvpn/sig.c                      | 2 +-
>  src/openvpn/sig.h                      | 2 +-
>  src/openvpn/socket.c                   | 2 +-
>  src/openvpn/socket.h                   | 2 +-
>  src/openvpn/socks.c                    | 2 +-
>  src/openvpn/socks.h                    | 2 +-
>  src/openvpn/ssl.c                      | 4 ++--
>  src/openvpn/ssl.h                      | 4 ++--
>  src/openvpn/ssl_backend.h              | 4 ++--
>  src/openvpn/ssl_common.h               | 4 ++--
>  src/openvpn/ssl_openssl.c              | 4 ++--
>  src/openvpn/ssl_openssl.h              | 4 ++--
>  src/openvpn/ssl_polarssl.c             | 4 ++--
>  src/openvpn/ssl_polarssl.h             | 4 ++--
>  src/openvpn/ssl_verify.c               | 4 ++--
>  src/openvpn/ssl_verify.h               | 4 ++--
>  src/openvpn/ssl_verify_backend.h       | 4 ++--
>  src/openvpn/ssl_verify_openssl.c       | 4 ++--
>  src/openvpn/ssl_verify_openssl.h       | 4 ++--
>  src/openvpn/ssl_verify_polarssl.c      | 4 ++--
>  src/openvpn/ssl_verify_polarssl.h      | 4 ++--
>  src/openvpn/status.c                   | 2 +-
>  src/openvpn/status.h                   | 2 +-
>  src/openvpn/syshead.h                  | 2 +-
>  src/openvpn/tun.c                      | 2 +-
>  src/openvpn/tun.h                      | 2 +-
>  src/openvpn/win32.c                    | 2 +-
>  src/openvpn/win32.h                    | 2 +-
>  src/openvpnserv/Makefile.am            | 2 +-
>  src/openvpnserv/openvpnserv.c          | 2 +-
>  src/plugins/Makefile.am                | 2 +-
>  src/plugins/auth-pam/auth-pam.c        | 2 +-
>  src/plugins/auth-pam/utils.c           | 2 +-
>  src/plugins/auth-pam/utils.h           | 2 +-
>  src/plugins/down-root/down-root.c      | 2 +-
>  tests/Makefile.am                      | 2 +-
>  190 files changed, 216 insertions(+), 216 deletions(-)
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
> index 1c4d0da..86d2b7a 100644
> --- a/ChangeLog
> +++ b/ChangeLog
> @@ -1,5 +1,5 @@
>  OpenVPN Change Log
> -Copyright (C) 2002-2015 OpenVPN Technologies, Inc. <sales@...515...>
> +Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>  
>  2016.12.06 -- Version 2.3.14
>  Christian Hesse (1):
> diff --git a/Makefile.am b/Makefile.am
> index 5887d4a..3dd3a5c 100644
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
> index 13cf65e..25452a6 100644
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
> index 640203f..8daa47d 100644
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
> index 2140733..7d1a5f8 100644
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
> index 13dee61..7bc9c07 100644
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
> diff --git a/include/openvpn-plugin.h b/include/openvpn-plugin.h
> index 5f2d407..28d10cb 100644
> --- a/include/openvpn-plugin.h
> +++ b/include/openvpn-plugin.h
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
> index 6539865..cab18a5 100644
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
> diff --git a/sample/sample-plugins/log/log.c b/sample/sample-plugins/log/log.c
> index 1cc4650..28fc6fa 100644
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
> index 4d3af91..416b74f 100644
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
> index f26d89f..7f1f4d8 100644
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
> index 273389e..adc0e17 100644
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
> index 0f32d5d..9a9f369 100644
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
> index 6d02fea..b365848 100644
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
> diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h
> index 298cf10..95caf76 100644
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
> diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
> index edbdd66..4d217d1 100644
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
> index 58f0601..c34c4a3 100644
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
> index 583701a..6e0357b 100644
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
> index af75fc9..01c3ae9 100644
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
> index d55a727..1611625 100644
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
> index 2f85bec..b5d024c 100644
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
> diff --git a/src/openvpn/console.c b/src/openvpn/console.c
> index 86331a1..1a3c182 100644
> --- a/src/openvpn/console.c
> +++ b/src/openvpn/console.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/console.h b/src/openvpn/console.h
> index 268f3fe..54a7612 100644
> --- a/src/openvpn/console.h
> +++ b/src/openvpn/console.h
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index ca4af27..206308a 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
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
> diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
> index e489827..5721142 100644
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
> index 4c1ce9f..4001195 100644
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
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 7b1ac6c..e1545f0 100644
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
> index 42c7e9a..2514355 100644
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
> diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
> index bca6a6f..8b39f9f 100644
> --- a/src/openvpn/crypto_polarssl.c
> +++ b/src/openvpn/crypto_polarssl.c
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
> diff --git a/src/openvpn/crypto_polarssl.h b/src/openvpn/crypto_polarssl.h
> index 12b5146..e205bc5 100644
> --- a/src/openvpn/crypto_polarssl.h
> +++ b/src/openvpn/crypto_polarssl.h
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
> index 8d0b18a..0b87909 100644
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
> index e823a4a..f2e6f7e 100644
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
> index 3ee4ebc..b827361 100644
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
> index 6ccdeae..873ebb1 100644
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
> index 4d7fef9..0f3a812 100644
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
> index c642691..e3ab09a 100644
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
> index bd29fdc..a982350 100644
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
> index 7fe449c..47ca263 100644
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
> index 13d6552..7ae366c 100644
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
> index 5853ce2..2e9a30e 100644
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
> index 3294201..658d38c 100644
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
> index 1830a00..72b9aa1 100644
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
> index 7ad1d61..f8ce28d 100644
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
> index 866573b..1610481 100644
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
> index f0aa7f6..dad7e25 100644
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
> index c0aeab1..57201a4 100644
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
> index 3089217..c9b6774 100644
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
> index 444969c..5914c0a 100644
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
> index 99bbda4..9696709 100644
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
> index 8423841..5ecf995 100644
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
> index 593fbf4..dc63475 100644
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
> index a819bd2..8652c19 100644
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
> index f0fc196..b7244a8 100644
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
> index 64494f1..be2d7de 100644
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
> index 4814ec9..31ef843 100644
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
> index ea6bd74..3311327 100644
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
> index adde36b..4742e9d 100644
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
> index 195b819..43918a8 100644
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
> index 472204d..bdd0f39 100644
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
> index 0a4542a..cf6fec1 100644
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
> index 28da69f..a08fe42 100644
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
> index 82f2388..c84c4bd 100644
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
> index 1085adc..94745b9 100644
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
> index 1f6bb67..fa1802f 100644
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
> index 48ca0d5..39aa936 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
> index c1942b6..2fc281d 100644
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
> index 850e336..845550e 100644
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
> index b72b5ff..2ec038b 100644
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
> index 7298c7b..5978e71 100644
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
> index 0d32943..2bc52c1 100644
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
> index 3be493c..d324a8b 100644
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
> index dab05fe..1e9f90e 100644
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
> index dc15f09..4e60298 100644
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
> index b677b48..6b5d6dd 100644
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
> index 13f3f6c..48e49c1 100644
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
> index bccd681..f8222c2 100644
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
> index 2d6d684..862cad6 100644
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
> index 97f961b..89c741c 100644
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
> index 541f8f5..4f781f4 100644
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
> index 7bfbb11..ed8d444 100644
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
> index 516eb4d..16b3660 100644
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
> index d71381d..75b59f6 100644
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
> index 5d88cc9..6d636dc 100644
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
> index 823c3dd..7f8501d 100644
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
> index 36c3100..96dbbc6 100644
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
> index a9419d4..3a6b4f2 100644
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
> @@ -3533,7 +3533,7 @@ usage_version (void)
>    show_windows_version( M_INFO|M_NOPREFIX );
>  #endif
>    msg (M_INFO|M_NOPREFIX, "Originally developed by James Yonan");
> -  msg (M_INFO|M_NOPREFIX, "Copyright (C) 2002-2016 OpenVPN Technologies, Inc. <sales@...515...>");
> +  msg (M_INFO|M_NOPREFIX, "Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>");
>  #ifndef ENABLE_SMALL
>  #ifdef CONFIGURE_DEFINES
>    msg (M_INFO|M_NOPREFIX, "Compile time defines: %s", CONFIGURE_DEFINES);
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 86fa8c2..e4235e9 100644
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
> index 2c1e5b1..ef92bbd 100644
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
> index 4ca1032..cc7943c 100644
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
> index baa4966..a690bbc 100644
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
> index 3ddaab6..b02d6fc 100644
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
> index 910d171..b05e051 100644
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
> index c531d9c..13873bb 100644
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
> index 6b5dcb2..6136ac8 100644
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
> index 461beed..a28ee4a 100644
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
> index 04adf0e..0e3ddba 100644
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
> index c724970..94ffca9 100644
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
> index 6dc0b4e..443ec2f 100644
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
> index 88f5f3a..121adaa 100644
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
> index a1f13c5..ccd22d2 100644
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
> index b49401c..00aab95 100644
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
> index 7b7ec45..3558823 100644
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
> diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
> index 87eb166..c280a7d 100644
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
> diff --git a/src/openvpn/pkcs11_polarssl.c b/src/openvpn/pkcs11_polarssl.c
> index a58beef..1a2ef30 100644
> --- a/src/openvpn/pkcs11_polarssl.c
> +++ b/src/openvpn/pkcs11_polarssl.c
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
> index 16d4dac..7ffaddf 100644
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
> index 7c0a4d7..3b75a20 100644
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
> index 4e5e6ce..2847154 100644
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
> index 2f8416b..5329f15 100644
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
> index 28c26b4..1764733 100644
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
> index fc9d6ab..e1a7198 100644
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
> index 7b58e6a..3730fa7 100644
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
> index 07612c8..22d291d 100644
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
> index 89989d1..0d0bd3c 100644
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
> index 5e476f1..be9020d 100644
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
> index 6495dc7..cd96257 100644
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
> index 4280635..62af8b5 100644
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
> index 402c158..05ad077 100644
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
> index 8c3f157..9928796 100644
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
> index b252676..f84b241 100644
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
> index 763169e..d320f48 100644
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
> index 594ab82..801ec50 100644
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
> index 68857e8..74f0a01 100644
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
> index fe9b461..ff58e9e 100644
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
> index 471330f..430a953 100644
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
> index 71c6d8c..10ad677 100644
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
> index 2e07b54..549853d 100644
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
> index 33909dd..87967ee 100644
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
> index c8a7d38..b4dc123 100644
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
> index afeb9c3..5bbba7f 100644
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
> index 16001fa..439c563 100644
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
> index 987efef..59ce569 100644
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
> index 3474f18..5102a05 100644
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
> index 22eac54..988e60a 100644
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
> index 57dc02a..c710b53 100644
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
> index b55ff6f..4b02321 100644
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
> index bfad291..32d0b6b 100644
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
> index 6a14768..c3d32c7 100644
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
> index 4b35e51..58bbcb8 100644
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
> index 449172d..f780ce8 100644
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
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 055b355..cda0ebb 100644
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
> index 73a6c49..5a7db09 100644
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
> diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
> index 9263698..cf9ef2e 100644
> --- a/src/openvpn/ssl_polarssl.c
> +++ b/src/openvpn/ssl_polarssl.c
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
> diff --git a/src/openvpn/ssl_polarssl.h b/src/openvpn/ssl_polarssl.h
> index b80a509..f31717c 100644
> --- a/src/openvpn/ssl_polarssl.h
> +++ b/src/openvpn/ssl_polarssl.h
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
> index ca69b41..d61a597 100644
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
> index e0bcba4..395a654 100644
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
> index 01e453e..488983f 100644
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
> diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
> index 4750f02..8374783 100644
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
> index 5a7e0a1..2ce0f93 100644
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
> diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
> index cc46b75..ee2a575 100644
> --- a/src/openvpn/ssl_verify_polarssl.c
> +++ b/src/openvpn/ssl_verify_polarssl.c
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
> diff --git a/src/openvpn/ssl_verify_polarssl.h b/src/openvpn/ssl_verify_polarssl.h
> index b5157ed..51effd7 100644
> --- a/src/openvpn/ssl_verify_polarssl.h
> +++ b/src/openvpn/ssl_verify_polarssl.h
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
> index b7ff484..ef59269 100644
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
> index af16fd2..10e9151 100644
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
> index 24926ae..828861a 100644
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
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index ca12180..72ec35c 100644
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
> index 7089f7c..138856d 100644
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
> index e136449..b271597 100644
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
> index 0990182..e2a86d2 100644
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
> index a989c25..591daed 100644
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
> diff --git a/src/openvpnserv/openvpnserv.c b/src/openvpnserv/openvpnserv.c
> index 56f5a02..e6f50a0 100755
> --- a/src/openvpnserv/openvpnserv.c
> +++ b/src/openvpnserv/openvpnserv.c
> @@ -5,7 +5,7 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
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
> index 5ad3ec8..2b48ea9 100644
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
> index e4643cd..dce4b01 100644
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
> index 2f72040..6bfe428 100644
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
> index 6931bec..ee68b94 100644
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
> index 235cd13..b01a233 100644
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

ACK

-Steffan

