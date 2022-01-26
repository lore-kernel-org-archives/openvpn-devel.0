Message-ID: <cc81836b-652b-498a-50c8-5541ffcdec9e@...2080...>
Date: Wed, 26 Jan 2022 11:23:18 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220125142456.18176-1-a@...2181...>
From: David Sommerseth <openvpn@...2080...>
In-Reply-To: <20220125142456.18176-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] update copyright year to 2022
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

On 25/01/2022 15:24, Antonio Quartulli wrote:
> Update performed by means of: dev-tools/update-copyright.sh
> 
> Cc: David Sommerseth <davids@...515...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>   COPYING                                                     | 2 +-
>   ChangeLog                                                   | 2 +-
>   Makefile.am                                                 | 4 ++--
>   PORTS                                                       | 2 +-
>   build/Makefile.am                                           | 2 +-
>   build/msvc/Makefile.am                                      | 2 +-
>   build/msvc/msvc-generate/Makefile.am                        | 2 +-
>   configure.ac                                                | 2 +-
>   dev-tools/gen-release-tarballs.sh                           | 2 +-
>   dev-tools/reformat-all.sh                                   | 2 +-
>   dev-tools/update-copyright.sh                               | 4 ++--
>   distro/Makefile.am                                          | 2 +-
>   distro/systemd/Makefile.am                                  | 2 +-
>   doc/Makefile.am                                             | 2 +-
>   include/Makefile.am                                         | 2 +-
>   include/openvpn-msg.h                                       | 2 +-
>   include/openvpn-plugin.h.in                                 | 2 +-
>   sample/Makefile.am                                          | 2 +-
>   sample/sample-keys/gen-sample-keys.sh                       | 2 +-
>   sample/sample-plugins/Makefile.am                           | 2 +-
>   sample/sample-plugins/Makefile.plugins                      | 2 +-
>   .../sample-plugins/client-connect/sample-client-connect.c   | 2 +-
>   sample/sample-plugins/defer/simple.c                        | 2 +-
>   .../keying-material-exporter-demo/keyingmaterialexporter.c  | 2 +-
>   sample/sample-plugins/log/log.c                             | 2 +-
>   sample/sample-plugins/log/log_v3.c                          | 4 ++--
>   sample/sample-plugins/simple/base64.c                       | 2 +-
>   sample/sample-plugins/simple/simple.c                       | 2 +-
>   src/Makefile.am                                             | 2 +-
>   src/compat/Makefile.am                                      | 2 +-
>   src/compat/compat-gettimeofday.c                            | 2 +-
>   src/compat/compat-strsep.c                                  | 2 +-
>   src/openvpn/Makefile.am                                     | 2 +-
>   src/openvpn/argv.c                                          | 2 +-
>   src/openvpn/argv.h                                          | 2 +-
>   src/openvpn/auth_token.h                                    | 2 +-
>   src/openvpn/basic.h                                         | 2 +-
>   src/openvpn/block_dns.c                                     | 2 +-
>   src/openvpn/block_dns.h                                     | 2 +-
>   src/openvpn/buffer.c                                        | 2 +-
>   src/openvpn/buffer.h                                        | 2 +-
>   src/openvpn/circ_list.h                                     | 2 +-
>   src/openvpn/clinat.c                                        | 2 +-
>   src/openvpn/clinat.h                                        | 2 +-
>   src/openvpn/common.h                                        | 2 +-
>   src/openvpn/comp-lz4.c                                      | 4 ++--
>   src/openvpn/comp-lz4.h                                      | 4 ++--
>   src/openvpn/comp.c                                          | 2 +-
>   src/openvpn/comp.h                                          | 2 +-
>   src/openvpn/compstub.c                                      | 2 +-
>   src/openvpn/console.c                                       | 4 ++--
>   src/openvpn/console.h                                       | 4 ++--
>   src/openvpn/console_builtin.c                               | 4 ++--
>   src/openvpn/crypto.c                                        | 2 +-
>   src/openvpn/crypto.h                                        | 2 +-
>   src/openvpn/crypto_backend.h                                | 2 +-
>   src/openvpn/crypto_mbedtls.c                                | 2 +-
>   src/openvpn/crypto_mbedtls.h                                | 2 +-
>   src/openvpn/crypto_openssl.c                                | 2 +-
>   src/openvpn/crypto_openssl.h                                | 2 +-
>   src/openvpn/dhcp.c                                          | 2 +-
>   src/openvpn/dhcp.h                                          | 2 +-
>   src/openvpn/env_set.c                                       | 4 ++--
>   src/openvpn/env_set.h                                       | 2 +-
>   src/openvpn/errlevel.h                                      | 2 +-
>   src/openvpn/error.c                                         | 2 +-
>   src/openvpn/error.h                                         | 2 +-
>   src/openvpn/event.c                                         | 2 +-
>   src/openvpn/event.h                                         | 2 +-
>   src/openvpn/fdmisc.c                                        | 2 +-
>   src/openvpn/fdmisc.h                                        | 2 +-
>   src/openvpn/forward.c                                       | 2 +-
>   src/openvpn/forward.h                                       | 2 +-
>   src/openvpn/fragment.c                                      | 2 +-
>   src/openvpn/fragment.h                                      | 2 +-
>   src/openvpn/gremlin.c                                       | 2 +-
>   src/openvpn/gremlin.h                                       | 2 +-
>   src/openvpn/helper.c                                        | 2 +-
>   src/openvpn/helper.h                                        | 2 +-
>   src/openvpn/httpdigest.c                                    | 2 +-
>   src/openvpn/httpdigest.h                                    | 2 +-
>   src/openvpn/init.c                                          | 2 +-
>   src/openvpn/init.h                                          | 2 +-
>   src/openvpn/integer.h                                       | 2 +-
>   src/openvpn/interval.c                                      | 2 +-
>   src/openvpn/interval.h                                      | 2 +-
>   src/openvpn/list.c                                          | 2 +-
>   src/openvpn/list.h                                          | 2 +-
>   src/openvpn/lzo.c                                           | 2 +-
>   src/openvpn/lzo.h                                           | 2 +-
>   src/openvpn/manage.c                                        | 2 +-
>   src/openvpn/manage.h                                        | 2 +-
>   src/openvpn/mbuf.c                                          | 2 +-
>   src/openvpn/mbuf.h                                          | 2 +-
>   src/openvpn/memdbg.h                                        | 2 +-
>   src/openvpn/misc.c                                          | 4 ++--
>   src/openvpn/misc.h                                          | 2 +-
>   src/openvpn/mroute.c                                        | 2 +-
>   src/openvpn/mroute.h                                        | 2 +-
>   src/openvpn/mss.c                                           | 2 +-
>   src/openvpn/mss.h                                           | 2 +-
>   src/openvpn/mstats.c                                        | 2 +-
>   src/openvpn/mstats.h                                        | 2 +-
>   src/openvpn/mtcp.c                                          | 2 +-
>   src/openvpn/mtcp.h                                          | 2 +-
>   src/openvpn/mtu.c                                           | 2 +-
>   src/openvpn/mtu.h                                           | 2 +-
>   src/openvpn/mudp.c                                          | 2 +-
>   src/openvpn/mudp.h                                          | 2 +-
>   src/openvpn/multi.c                                         | 2 +-
>   src/openvpn/multi.h                                         | 2 +-
>   src/openvpn/networking.h                                    | 2 +-
>   src/openvpn/networking_iproute2.c                           | 2 +-
>   src/openvpn/networking_iproute2.h                           | 2 +-
>   src/openvpn/networking_sitnl.c                              | 2 +-
>   src/openvpn/networking_sitnl.h                              | 2 +-
>   src/openvpn/occ.c                                           | 2 +-
>   src/openvpn/occ.h                                           | 2 +-
>   src/openvpn/openssl_compat.h                                | 2 +-
>   src/openvpn/openvpn.c                                       | 2 +-
>   src/openvpn/openvpn.h                                       | 2 +-
>   src/openvpn/options.c                                       | 6 +++---
>   src/openvpn/options.h                                       | 2 +-
>   src/openvpn/otime.c                                         | 2 +-
>   src/openvpn/otime.h                                         | 2 +-
>   src/openvpn/packet_id.c                                     | 2 +-
>   src/openvpn/packet_id.h                                     | 2 +-
>   src/openvpn/perf.c                                          | 2 +-
>   src/openvpn/perf.h                                          | 2 +-
>   src/openvpn/ping.c                                          | 2 +-
>   src/openvpn/ping.h                                          | 2 +-
>   src/openvpn/pkcs11.c                                        | 2 +-
>   src/openvpn/pkcs11.h                                        | 2 +-
>   src/openvpn/pkcs11_backend.h                                | 2 +-
>   src/openvpn/pkcs11_mbedtls.c                                | 2 +-
>   src/openvpn/pkcs11_openssl.c                                | 2 +-
>   src/openvpn/platform.c                                      | 2 +-
>   src/openvpn/platform.h                                      | 2 +-
>   src/openvpn/plugin.c                                        | 2 +-
>   src/openvpn/plugin.h                                        | 2 +-
>   src/openvpn/pool.c                                          | 2 +-
>   src/openvpn/pool.h                                          | 2 +-
>   src/openvpn/proto.c                                         | 2 +-
>   src/openvpn/proto.h                                         | 2 +-
>   src/openvpn/proxy.c                                         | 2 +-
>   src/openvpn/proxy.h                                         | 2 +-
>   src/openvpn/ps.c                                            | 2 +-
>   src/openvpn/ps.h                                            | 2 +-
>   src/openvpn/push.c                                          | 2 +-
>   src/openvpn/push.h                                          | 2 +-
>   src/openvpn/pushlist.h                                      | 2 +-
>   src/openvpn/reliable.c                                      | 2 +-
>   src/openvpn/reliable.h                                      | 2 +-
>   src/openvpn/ring_buffer.h                                   | 2 +-
>   src/openvpn/route.c                                         | 2 +-
>   src/openvpn/route.h                                         | 2 +-
>   src/openvpn/run_command.c                                   | 2 +-
>   src/openvpn/run_command.h                                   | 2 +-
>   src/openvpn/schedule.c                                      | 2 +-
>   src/openvpn/schedule.h                                      | 2 +-
>   src/openvpn/session_id.c                                    | 2 +-
>   src/openvpn/session_id.h                                    | 2 +-
>   src/openvpn/shaper.c                                        | 2 +-
>   src/openvpn/shaper.h                                        | 2 +-
>   src/openvpn/sig.c                                           | 2 +-
>   src/openvpn/sig.h                                           | 2 +-
>   src/openvpn/sitnl.h                                         | 2 +-
>   src/openvpn/socket.c                                        | 2 +-
>   src/openvpn/socket.h                                        | 2 +-
>   src/openvpn/socks.c                                         | 2 +-
>   src/openvpn/socks.h                                         | 2 +-
>   src/openvpn/ssl.c                                           | 4 ++--
>   src/openvpn/ssl.h                                           | 2 +-
>   src/openvpn/ssl_backend.h                                   | 2 +-
>   src/openvpn/ssl_common.h                                    | 2 +-
>   src/openvpn/ssl_mbedtls.c                                   | 2 +-
>   src/openvpn/ssl_mbedtls.h                                   | 2 +-
>   src/openvpn/ssl_ncp.c                                       | 4 ++--
>   src/openvpn/ssl_ncp.h                                       | 2 +-
>   src/openvpn/ssl_openssl.c                                   | 2 +-
>   src/openvpn/ssl_openssl.h                                   | 2 +-
>   src/openvpn/ssl_util.c                                      | 2 +-
>   src/openvpn/ssl_util.h                                      | 2 +-
>   src/openvpn/ssl_verify.c                                    | 2 +-
>   src/openvpn/ssl_verify.h                                    | 2 +-
>   src/openvpn/ssl_verify_backend.h                            | 2 +-
>   src/openvpn/ssl_verify_mbedtls.c                            | 2 +-
>   src/openvpn/ssl_verify_mbedtls.h                            | 2 +-
>   src/openvpn/ssl_verify_openssl.c                            | 2 +-
>   src/openvpn/ssl_verify_openssl.h                            | 2 +-
>   src/openvpn/status.c                                        | 2 +-
>   src/openvpn/status.h                                        | 2 +-
>   src/openvpn/syshead.h                                       | 2 +-
>   src/openvpn/tun.c                                           | 2 +-
>   src/openvpn/tun.h                                           | 2 +-
>   src/openvpn/vlan.c                                          | 2 +-
>   src/openvpn/vlan.h                                          | 2 +-
>   src/openvpn/win32-util.c                                    | 2 +-
>   src/openvpn/win32-util.h                                    | 2 +-
>   src/openvpn/win32.c                                         | 2 +-
>   src/openvpn/win32.h                                         | 2 +-
>   src/openvpn/xkey_common.h                                   | 2 +-
>   src/openvpn/xkey_helper.c                                   | 2 +-
>   src/openvpn/xkey_provider.c                                 | 2 +-
>   src/openvpnmsica/Makefile.am                                | 4 ++--
>   src/openvpnmsica/dllmain.c                                  | 2 +-
>   src/openvpnmsica/msica_arg.c                                | 2 +-
>   src/openvpnmsica/msica_arg.h                                | 2 +-
>   src/openvpnmsica/msiex.c                                    | 2 +-
>   src/openvpnmsica/msiex.h                                    | 2 +-
>   src/openvpnmsica/openvpnmsica.c                             | 2 +-
>   src/openvpnmsica/openvpnmsica.h                             | 2 +-
>   src/openvpnmsica/openvpnmsica_resources.rc                  | 2 +-
>   src/openvpnserv/Makefile.am                                 | 2 +-
>   src/openvpnserv/common.c                                    | 2 +-
>   src/openvpnserv/interactive.c                               | 2 +-
>   src/openvpnserv/service.h                                   | 2 +-
>   src/openvpnserv/validate.c                                  | 2 +-
>   src/openvpnserv/validate.h                                  | 2 +-
>   src/plugins/Makefile.am                                     | 2 +-
>   src/plugins/auth-pam/auth-pam.c                             | 4 ++--
>   src/plugins/auth-pam/utils.c                                | 2 +-
>   src/plugins/auth-pam/utils.h                                | 2 +-
>   src/plugins/down-root/down-root.c                           | 2 +-
>   src/tapctl/Makefile.am                                      | 4 ++--
>   src/tapctl/basic.h                                          | 4 ++--
>   src/tapctl/error.c                                          | 4 ++--
>   src/tapctl/error.h                                          | 4 ++--
>   src/tapctl/main.c                                           | 4 ++--
>   src/tapctl/tap.c                                            | 2 +-
>   src/tapctl/tap.h                                            | 2 +-
>   src/tapctl/tapctl_resources.rc                              | 2 +-
>   tests/Makefile.am                                           | 2 +-
>   tests/unit_tests/openvpn/test_misc.c                        | 2 +-
>   tests/unit_tests/openvpn/test_ncp.c                         | 2 +-
>   tests/unit_tests/openvpn/test_provider.c                    | 2 +-
>   236 files changed, 257 insertions(+), 257 deletions(-)

Acked-By: David Sommerseth <davids@...515...>

I've only done a quick cursory review, and changes are as expected.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


