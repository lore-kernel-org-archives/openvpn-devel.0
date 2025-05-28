From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 28 May 2025 11:39:23 +0000
In-Reply-To: <gerrit.1748268615000.I80a14b77fcc2fabf51af9f2d5ea0c36362cccb91@...2715...>
References: <gerrit.1748268615000.I80a14b77fcc2fabf51af9f2d5ea0c36362cccb91@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <1bf9eb50b20a934207f492ac79f367b69fc094ed-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Caonh2dBo5A="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: OpenVPN Release
 2.7_alpha1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, selvanair <selva.nair@...277...>, stipa <lstipakov@...277...>

--Caonh2dBo5A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos, selvanair, stipa.

cron2 has uploaded a new patch set (#6) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1032?usp=3Demail )


Change subject: OpenVPN Release 2.7_alpha1
......................................................................

OpenVPN Release 2.7_alpha1

version.m4, ChangeLog, Changes.rst

(ChangeLog in "master" will revert to its normal state of "empty"
after release/2.7 is forked off into its own branch)

Additionally, add test_common.h to tests/unit_tests/openvpn/Makefile.am
(..._SOURCES) so it's packed into the "make dist" tarball

Change-Id: I80a14b77fcc2fabf51af9f2d5ea0c36362cccb91
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M ChangeLog
M Changes.rst
M tests/unit_tests/openvpn/Makefile.am
M version.m4
4 files changed, 894 insertions(+), 46 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/32/1032/6

diff --git a/ChangeLog b/ChangeLog
index c26dd2e..c6e626b 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,7 +1,759 @@
 OpenVPN ChangeLog
-Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>

-This file is not maintained in this branch of the OpenVPN git repository.
+2025.05.28 -- Version 2.7_alpha1

-Release branches (release/2.5, release/2.4, etc) have individual ChangeLog
-files with all changes relevant for these releases.
+5andr0 (1):
+      Implement server_poll_timeout for socks
+
+Alexander von Gluck (4):
+      Haiku: Introduce basic platform / tun support
+      Haiku: Add calls to manage routing table
+      Haiku: change del to delete in route command. del is undocumented
+      Haiku: Fix short interface path length
+
+Antonio Quartulli (32):
+      disable DCO if --secret is specified
+      dco: properly re-initialize dco_del_peer_reason
+      dco: bail out when no peer-specific message is delivered
+      dco: improve comment about hidden debug message
+      dco: print proper message in case of transport disconnection
+      dco_linux: update license for ovpn_dco_linux.h
+      Update issue templates
+      Avoid warning about missing braces when initialising key struct
+      dco: don't use NetLink to exchange control packets
+      dco: print version to log if available
+      dco-linux: remove M_ERRNO flag when printing netlink error message
+      multi: don't call DCO APIs if DCO is disabled
+      dco-freebsd: use m->instances[] instead of m->hash
+      dco-linux: implement dco_get_peer_stats{, multi} API
+      configure.ac: fix typ0 in LIBCAPNG_CFALGS
+      dco: fix crash when --multihome is used with --proto tcp
+      dco: mark peer as deleted from kernel after receiving CMD_DEL_PEER n=
otification
+      event/multi: add event_arg object to make event handling more generic
+      pass link_socket object to i/o functions
+      io_work: convert shift argument to uintptr_t
+      io_work: pass event_arg object to event handler in case of socket ev=
ent
+      sitnl: replace NLMSG_TAIL macro with noinline function
+      override ai_family if 'local' numeric address was specified
+      Adapt socket handling to support listening on multiple sockets
+      allow user to specify 'local' multiple times in config files
+      dco_linux: extend netlink error cb with extra info
+      man: extend --persist-tun section
+      dco: pass remoteaddr only for UDP peers
+      socket: use remote proto when creating client sockets
+      dco_linux: fix peer stats parsing with new ovpn kernel module
+      socket: don't transfer bind family to socket in case of ANY address
+      dco_linux: avoid bogus text when netlink message is not parsed
+
+Aquila Macedo (1):
+      doc: Correct typos in multiple documentation files
+
+Arne Schwabe (190):
+      Fix connection cookie not including address and fix endianness in te=
st
+      Fix unit test of test_pkt on little endian Linux
+      Disable DCO when TLS mode is not used
+      Ignore connection attempts while server is shutting down
+      Improve debug logging of DCO swap key message and Linux dco_new_peer
+      Trigger a USR1 if dco_update_keys fails
+      Set DCO_NOT_INSTALLED also for keys not in the get_key_scan range
+      Ensure that argument to parse_line has always space for final sentin=
el
+      Improve documentation on user/password requirement and unicodize fun=
ction
+      Eliminate or comment empty blocks and switch fallthrough
+      Remove unused gc_arena
+      Fix corner case that might lead to leaked file descriptor
+      Deprecate NTLMv1 proxy auth method.
+      Use include "buffer.h" instead of include <buffer.h>
+      Ensure that dco keepalive and mssfix options are also set in pure p2=
p mode
+      Make management password check constant time
+      Rename TM_UNTRUSTED to TM_INITIAL, always start session in TM_INITIA=
L rather than TM_ACTIVE or TM_INITIAL
+      Move dco_installed back to link_socket from link_socket.info.actual
+      Do not set nl socket buffer size
+      Also drop incoming dco packet content when dropping the packet
+      Improve logging when seeing a message for an unkown peer
+      Ignore OVPN_DEL_PEER_REASON_USERSPACE to avoid race conditions
+      Replace custom min macro and use more C99 style in man_remote_entry_=
get
+      Replace realloc with new gc_realloc function
+      Add connect-freq-initial option to limit initial connection responses
+      Log peer-id if loglevel is D_DCO_DEBUG and dco is enabled
+      Deprecate OCC checking
+      Workaround: make ovpn-dco more reliable
+      Fix unaligned access in auth-token
+      Update LibreSSL to 3.7.0 in Github actions
+      Add printing USAN stack trace on github actions
+      Fix LibreSSL not building in Github Actions
+      Add missing stdint.h includes in unit tests files
+      Combine extra_tun/frame parameter of frame_calculate_payload_overhead
+      Update the last sections in the man page to a be a bit less outdated
+      Add building unit tests with mingw to github actions
+      Revise the cipher negotiation info about OpenVPN3 in the man page
+      Exit if a proper message instead of segfault on Android without mana=
gement
+      Use proper print format/casting when converting msg_channel handle
+      Reduce initialisation spam from verb <=3D 3 and print summary instead
+      Dynamic tls-crypt for secure soft_reset/session renegotiation
+      Set netlink socket to be non-blocking
+      Ensure n =3D 2 is set in key2 struct in tls_crypt_v2_unwrap_client_k=
ey
+      Fix memory leaks in open_tun_dco()
+      Fix memory leaks in HMAC initial packet generation
+      Use key_state instead of multi for tls_send_payload parameter
+      Make sending plain text control message session aware
+      Only update frame calculation if we have a valid link sockets
+      Improve description of compat-mode
+      Simplify --compress parsing in options.c
+      Refuse connection if server pushes an option contradicting allow-com=
press
+      Add 'allow-compression stub-only' internally for DCO
+      Parse compression options and bail out when compression is disabled
+      Remove unused variable line
+      Add Apache2 linking with for new commits
+      Fix compile error on TARGET_ANDROID
+      Fix use-after-free with EVP_CIPHER_free
+      Remove key_type argument from generate_key_random
+      add basic CMake based build
+      Avoid unused function warning/error on FreeBSD (and potientially oth=
ers)
+      Do not blindly assume python3 is also the interpreter that runs rst2=
html
+      Only add -Wno-stringop-truncation on supported compilers
+      fix warning with gcc 12.2.0 (compiler bug?)
+      Fix CR_RESPONSE mangaement message using wrong key_id
+      Print a more user-friendly error when tls-crypt-v2 client auth fails
+      Ignore Ipv6 route delete request on Android and set ipv4 verbosity t=
o 7
+      Mock openvpn_exece on win32 also for test_tls_crypt
+      Check if the -wrap argument is actually supported by the platform's =
ld
+      Revert commit 423ced962d
+      Implement using --peer-fingerprint without CA certificates
+      show extra info for OpenSSL errors
+      Remove ability to use configurations without TLS by default
+      Add warning for the --show-groups command that some groups are missi=
ng
+      Print peer temporary key details
+      Add warning if a p2p NCP client connects to a p2mp server
+      Remove openssl engine method for loading the key
+      Add undefined and abort on error to clang sanitize builds
+      Add --enable-werror to all platforms in Github Actions
+      Remove saving initial frame code
+      Double check that we do not use a freed buffer when freeing a session
+      Fix using to_link buffer after freed
+      Remove CMake custom compiler flags for RELEASE and DEBUG build
+      Do not check key_state buffers that are in S_UNDEF state
+      Remove unused function prototype crypto_adjust_frame_parameters
+      Introduce report_command_status helper function
+      Log SSL alerts more prominently
+      Remove unused/unneeded/add missing defines from configure/cmake
+      Document tls-exit option mainly as test option
+      Remove dead remains of extract_x509_field_test
+      Replace character_class_debug with proper unit test
+      Remove TEST_GET_DEFAULT_GATEWAY as it duplicates --show-gateway
+      Fix check_session_buf_not_used using wrong index
+      Add missing check for nl_socket_alloc failure
+      Add check for nice in cmake config
+      Minimal Solaris/OpenIndiana support to Cmake and clean up -Werror
+      Remove compat versionhelpers.h and remove cmake/configure check for =
it
+      Rename state_change to continue_tls_process
+      Move tls_get_cipher_name_pair and get_num_elements to ssl_utils.c
+      Fix building mbed TLS with CMake and allow specifying custom directo=
ries
+      Extend the error message when TLS 1.0 PRF fails
+      Fix unaligned access in macOS, FreeBSD, Solaris hwaddr
+      Check PRF availability on initialisation and add --force-tls-key-mat=
erial-export
+      Make it more explicit and visible when pkg-config is not found
+      Clarify that the tls-crypt-v2-verify has a very limited env set
+      Move get_tmp_dir to win32-util.c and error out on failure
+      Implement the --tls-export-cert feature
+      Use mingw compile definition also to unit tests
+      Add test_ssl unit test and test export of PEM to file
+      Remove conditional text for Apache2 linking exception
+      Fix ssl unit tests on OpenSSL 1.0.2
+      Ensure that all unit tests use unbuffered stdout and stderr
+      Allow unit tests to fall back to hard coded location
+      Add unit test for encrypting/decrypting data channel
+      Print SSL peer signature information in handshake debug details
+      Implement generating TLS 1.0 PRF using new OpenSSL 3.0 APIs
+      Turn dead list test code into unit test
+      Use snprintf instead of sprintf for get_ssl_library_version
+      Fix snprintf/swnprintf related compiler warnings
+      Add bracket in fingerprint message and do not warn about missing ver=
ification
+      Match ifdef for get_sigtype function with if ifdef of caller
+      Remove/combine redundant call of EVP_CipherInit before EVP_CipherIni=
t_Ex
+      Add missing EVP_KDF_CTX_free in ssl_tls1_PRF
+      Replace macos11 with macos14 in github runners
+      Remove openvpn_snprintf and similar functions
+      Repeat the unknown command in errors from management interface
+      Only run coverity scan in OpenVPN/OpenVPN repository
+      Support OpenBSD with cmake
+      Workaround issue in LibreSSL crashing when enumerating digests/ciphe=
rs
+      Remove OpenSSL 1.0.2 support
+      Remove custom TLS 1.0 PRF implementation only used by LibreSSL/wolfS=
SL
+      Allow the TLS session to send out TLS alerts
+      Properly handle null bytes and invalid characters in control messages
+      Allow trailing \r and \n in control channel message
+      Add Ubuntu 24.04 runner to Github Actions
+      Implement support for AEAD tag at the end
+      Remove check for anonymous unions from configure and cmake config
+      Make read/write_tun_header static
+      Avoid SIGUSR1 to SIGHUP remapping when the configuration is read fro=
m stdin
+      Move to common backend_driver type in struct tuntap
+      Introduce DRIVER_AFUNIX backend for use with lwipovpn
+      Change dev null to be a driver type instead of a special mode of tun=
/tap
+      Use print_tun_backend_driver instead of custom code to print type
+      Automatically enable ifconfig-exec/route-exec behaviour for afunix t=
un/tap
+      Ensure that the AF_UNIX socket pair has at least 65k of buffer space
+      Fix check for CMake not detecting struct cmsg
+      Remove null check after checking for checking for did_open_tun
+      Remove a large number of unused structs and functions
+      Remove unused methods write_key/read_key
+      Refuse clients if username or password is longer than USER_PASS_LEN
+      Move should_trigger_renegotiation into its own function
+      Change --reneg-bytes and --reneg-packets to 64 bit counters
+      Use XOR instead of concatenation for calculation of IV from implicit=
 IV
+      Trigger renegotiation of data key if getting close to the AEAD usage=
 limit
+      Implement HKDF expand function based on RFC 8446
+      Split init_key_ctx_bi into send/recv init
+      Move initialisation of implicit IVs to init_key_ctx_bi methods
+      Change internal id of packet id to uint64
+      Add small unit test for buf_chomp
+      Add building/testing with msbuild and the clang compiler
+      Ensure that Python3 is available
+      Change API of init_key_ctx to use struct key_parameters
+      Allow DEFAULT in data-ciphers and report both expanded and user set =
option
+      Do not attempt to decrypt packets anymore after 2**36 failed decrypt=
ions
+      Add methods to read/write packet ids for epoch data
+      Implement methods to generate and manage OpenVPN Epoch keys
+      Rename aead-tag-at-end to aead-epoch
+      Improve peer fingerprint documentation
+      Remove comparing username to NULL in tls_lock_username
+      Print warnings/errors when numerical parameters cannot be parsed
+      Add unit tests for atoi parsing options helper
+      Improve error reporting from AF_UNIX tun/tap support
+      Fix typo in positive_atoi
+      Fix oversight of link socket code change in Android code path
+      Implement epoch key data format
+      Extend the unit test for data channel packets with aead limit tests
+      Add (fake) Android cmake building
+      Add android build to Github Actions
+      Reconnect when TCP is on use on network-change management command
+      Implement override-username
+      Fix incorrect condition for checking password related check
+      Directly use _countof in array initialisation
+      Improve documentation for override-username
+      Mention address if not unspecific on DNS failure
+      Do not leave half-initialised key wrap struct when dynamic tls-crypt=
 fails
+      Allow tls-crypt-v2 to be setup only on initial packet of a session
+      Use SSL_get0_peer_signature_name instead of SSL_get_peer_signature_n=
id
+      Use USER_PASS_LEN instead of TLS_USERNAME_LEN for override-username
+      Also print key agreement when printing negotiated details
+      Fix mbed TLS key exporter functionality in 3.6.x and cmake
+      Make --dh none behaviour default if not specified
+
+Ben Boeckel (1):
+      console_systemd: remove the timeout when using 'systemd-ask-password'
+
+Christoph Schug (1):
+      Update documentation references in systemd unit files
+
+Corubba Smith (3):
+      Support IPv6 towards port-share proxy receiver
+      Document x509-username-fields oid usage
+      Remove x509-username-fields uppercasing
+
+David Sommerseth (4):
+      ssl_verify: Fix memleak if creating deferred auth control files fails
+      ntlm: Clarify details on NTLM phase 3 decoding
+      Remove --tls-export-cert
+      Remove superfluous x509_write_pem()
+
+Franco Fichtner (1):
+      Allow to set ifmode for existing DCO interfaces in FreeBSD
+
+Frank Lichtenheld (174):
+      options.c: fix format security error when compiling without optimiza=
tion
+      options.c: update usage description of --cipher
+      Update copyright year to 2023
+      xkey_pkcs11h_sign: fix dangling pointer
+      options: Always define options->management_flags
+      check_engine_keys: make pass with OpenSSL 3
+      documentation: update 'unsupported options' section
+      Changes.rst: document removal of --keysize
+      Windows: fix unused function setenv_foreign_option
+      Windows: fix unused variables in delete_route_ipv6
+      Windows: fix wrong printf format in x_check_status
+      Windows: fix unused variable in win32_get_arch
+      configure: enable DCO by default on FreeBSD/Linux
+      Windows: fix signedness errors with recv/send
+      configure: fix formatting of --disable-lz4 and --enable-comp-stub
+      tests/unit_tests: Fix 'make distcheck' with subdir-objects enabled
+      GHA: remove Ubuntu 18.04 builds
+      vcpkg: request "tools" feature of openssl for MSVC build
+      Do not include net/in_systm.h
+      version.sh: remove
+      doc: run rst2* with --strict to catch warnings
+      man page: Remove cruft from --topology documentation
+      tests: do not include t_client.sh in dist
+      vcpkg-ports/pkcs11-helper: Make compatible with mingw build
+      vcpkg-ports/pkcs11-helper: Convert CONTROL to vcpkg.json
+      vcpkg-ports/pkcs11-helper: reference upstream PRs in patches
+      dco_linux: properly close dco version file
+      DCO: fix memory leak in dco_get_peer_stats_multi for Linux
+      Fix two unused assignments
+      sample-plugins: Fix memleak in client-connect example plugin
+      tests: Allow to override openvpn binary used
+      test_buffer: add tests for buf_catrunc and its caller format_hex_ex
+      buffer: use memcpy in buf_catrunc
+      options: remove --key-method from usage message
+      msvc-generate: include version.m4.in in tarball
+      dist: add more missing files only used in the MSVC build
+      vcpkg-ports/pkcs11-helper: rename patches to make file names shorter
+      unit_tests: Add missing cert_data.h to source list for unit tests
+      dist: Include all documentation in distribution
+      CMake: Add complete MinGW and MSVC build
+      Remove all traces of the previous MSVC build system
+      CMake: Add /Brepro to MSVC link options
+      GHA: update to run-vcpkg@...2735...
+      test_tls_crypt: Improve mock() usage to be more portable
+      CMake: Throw a clear error when config.h in top-level source directo=
ry
+      CMake: Support doc builds on Windows machines that do not have .py f=
ile association
+      Remove old Travis CI related files
+      README.cmake.md: Add new documentation for CMake buildsystem
+      GHA: refactor mingw UTs and add missing tls_crypt
+      GHA: Add macos-13
+      options: Do not hide variables from parent scope
+      pkcs11_openssl: Disable unused code
+      route: Fix overriding return value of add_route3
+      CMake: various small non-functional improvements
+      GHA: do not trigger builds in openvpn-build anymore
+      Remove --no-replay option
+      GHA: new workflow to submit scan to Coverity Scan service
+      doc: fix argument name in --route-delay documentation
+      Change type of frame.mss_fix to uint16_t
+      Remove last uses of inet_ntoa
+      mss/mtu: make all size calculations use size_t
+      dev-tools/gerrit-send-mail.py: tool to send Gerrit patchsets to Patc=
hwork
+      gerrit-send-mail.py: Add patch version to subject
+      Add mbedtls3 GHA build
+      platform.c: Do not depend Windows build on HAVE_CHDIR
+      sample-keys: renew for the next 10 years
+      GHA: clean up libressl builds with newer libressl
+      configure.ac: Remove unused AC_TYPE_SIGNAL macro
+      documentation: remove reference to removed option --show-proxy-setti=
ngs
+      unit_tests: remove includes for mock_msg.h
+      buffer: add documentation for string_mod and extend related UT
+      tests: disable automake serial_tests
+      documentation: improve documentation of --x509-track
+      configure: allow to disable NTLM
+      configure: enable silent rules by default
+      misc: make get_auth_challenge static
+      Remove support for NTLM v1 proxy authentication
+      GHA: increase verbosity for make check
+      NTLM: add length check to add_security_buffer
+      NTLM: increase size of phase 2 response we can handle
+      Fix various 'Uninitialized scalar variable' warnings from Coverity
+      proxy-options.rst: Add proper documentation for --http-proxy-user-pa=
ss
+      NTLM: when NTLMv1 is requested, try NTLMv2 instead
+      buf_string_match_head_str: Fix Coverity issue 'Unsigned compared aga=
inst 0'
+      --http-proxy-user-pass: allow to specify in either order with --http=
-proxy
+      test_user_pass: new UT for get_user_pass
+      test_user_pass: Add UTs for character filtering
+      gerrit-send-mail: Make output consistent across systems
+      README.cmake.md: Document minimum required CMake version for --preset
+      documentation: Update and fix documentation for --push-peer-info
+      documentation: Fixes for previous fixes to --push-peer-info
+      test_user_pass: add basic tests for static/dynamic challenges
+      Fix typo --data-cipher-fallback
+      samples: Remove tls-*.conf
+      check_compression_settings_valid: Do not test for LZ4 in LZO check
+      t_client.sh: Allow to skip tests
+      gerrit-send-mail: add missing Signed-off-by
+      Update Copyright statements to 2024
+      GHA: general update March 2024
+      samples: Update sample configurations
+      documentation: make section levels consistent
+      phase2_tcp_server: fix Coverity issue 'Dereference after null check'
+      script-options.rst: Update ifconfig_* variables
+      crypto_backend: fix type of enc parameter
+      tests: fork default automake test-driver
+      forked-test-driver: Show test output always
+      Change default of "topology" to "subnet"
+      Use topology default of "subnet" only for server mode
+      Fix 'binary or' vs 'boolean or' related to server_bridge_proxy_dhcp
+      configure: update old copy of pkg.m4
+      LZO: do not use lzoutils.h macros
+      test_user_pass: Fix building with --enable-systemd
+      Remove "experimental" denotation for --fast-io
+      t_server_null.sh: Fix failure case
+      configure: Add -Wstrict-prototypes and -Wold-style-definition
+      configure: Try to detect LZO with pkg-config
+      configure: Switch to C11 by default
+      Fix missing spaces in various messages
+      console_systemd: rename query_user_exec to query_user_systemd
+      configure: Allow to detect git checkout if .git is not a directory
+      GHA: Configure Renovate
+      configure: Try to use pkg-config to detect mbedTLS
+      tun: use is_tun_p2p more consistently
+      Various fixes for -Wconversion errors
+      generate_auth_token: simplify code
+      GHA: Update dependency Mbed-TLS/mbedtls to v3.6.1
+      GHA: Enable t_server_null tests
+      configure: Handle libnl-genl and libcap-ng consistent with other libs
+      configure: Review use of standard AC macros
+      socket: Change return types of link_socket_write* to ssize_t
+      GHA: Pin dependencies
+      GHA: Update macOS runners
+      GHA: Simplify macOS builds
+      Remove support for compression on send
+      Fix wrong doxygen comments
+      Various typo fixes
+      macOS: Assume that net/if_utun.h is always present
+      Fix some formatting related to if/else and macros
+      Fix memory leak in ntlm_support
+      forward: Fix potential unaligned access in drop_if_recursive_routing
+      GHA: General update December 2024
+      Review doxygen warnings
+      Regenerate doxygen config file with doxygen -u
+      Fix 'uninitialized pointer read' in openvpn_decrypt_aead
+      ssl_openssl: Clean up unused functions and add missing "static"
+      Fix some trivial sign-compare compiler warnings
+      tls_crypt_v2_write_client_key_file: Fix missing-field-initializers c=
ompiler warning
+      openvpnserv: Fix some inconsistent usages of TEXT()
+      Fix doxygen warnings in crypto_epoch.h
+      GHA: Drop Ubuntu 20.04 and other maintenance
+      GHA: Publish Doxygen documentation to Github Pages
+      Add more 'intentional fallthrough' comments
+      Remove various unused function parameters
+      Remove unused function check_subnet_conflict
+      options: Cleanup and simplify options_postprocess_verify_ce
+      Apply text-removal.sh script to Windows codebase
+      openvpnserv: Clean up use of TEXT() from DNS patches
+      Post tchar.h removal cleanup
+      Fix compatibility with mbedTLS 2.28.10+ and 3.6.3+
+      t_server_null_default.rc: Add some tests with --data-ciphers
+      GHA: Pin version of CMake for all builds
+      GHA: Dependency and Actions update April 2025
+      GHA: Make sure renovate notifies us about AWS LC releases
+      Doxygen: Fix obsolete links to OpenSSL documentation
+      GHA: Use CMake 4.0 and apply required fixes
+      Doxygen: Clean up tls-crypt documentation
+      Doxygen: Remove useless Python information
+      Manually reformat some long trailing comments
+      CMake: Make sure to treat UNIT_TEST_SOURCEDIR as path
+      CMake: Sync list of compiler flags with configure.ac
+      CMake: Reorganize header and symbol tests
+      GHA: Dependency and Actions update May 2025
+      Doxygen: Fix missing parameter warnings
+      Changes.rst: Collect, fix, and improve entries for 2.7 release
+
+George Pchelkin (1):
+      fix typo: dhcp-options to dhcp-option in vpn-network-options.rst
+
+Gert Doering (21):
+      Change version.m4 to 2.7_git
+      bandaid fix for TCP multipoint server crash with Linux-DCO
+      Undo FreeBSD 12.x workaround on IPv6 ifconfig for 12.4 and up
+      Reduce logspam about 'dco_update_keys: peer_id=3D-1' in p2p server m=
ode
+      Fix OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT breakage on FreeBSD+DCO
+      Repair special-casing of EEXIST for Linux/SITNL route install
+      Get rid of unused 'bool tuntap_buffer' arguments.
+      FreeBSD 12.x workaround for IPv6 ifconfig is needed on 12.4 as well
+      Make received OCC exit messages more visible in log.
+      OpenBSD: repair --show-gateway
+      get_default_gateway() HWADDR overhaul
+      make t_server_null 'server alive?' check more robust
+      t_client.sh: conditionally skip ifconfig+route check
+      send uname() release as IV_PLAT_VER=3D on non-windows versions
+      options: add IPv4 support to '--show-gateway <arg>'
+      get_default_gateway(): implement platform support for Linux/SITNL
+      get_default_gateway(): implement platform support for Linux/IPROUTE2
+      add missing (void) to win32 function declarations
+      add more (void) to windows specific function prototypes and declarat=
ions
+      Make 'lport 0' no longer sufficient to do '--bind'.
+      Add information-gathering about DNS resolvers configured to t_client=
.sh(.in)
+
+Gianmarco De Gregori (17):
+      Persist-key: enable persist-key option by default
+      Minor fix to process_ip_header
+      Http-proxy: fix bug preventing proxy credentials caching
+      Ensures all params are ready before invoking dco_set_peer()
+      Route: remove incorrect routes on exit
+      Fix for msbuild/mingw GHA failures
+      multiproto: move generic event handling code in dedicated files
+      Fix PASS_BY_VALUE issue in options_postprocess_mutate_le()
+      mroute: adapt to new protocol handling and hashing improvements
+      mroute/management: repair mgmt client-kill for mroute with proto
+      Add support for simultaneous use of UDP and TCP sockets
+      Rename occurences of 'struct link_socket' from 'ls' to 'sock'
+      Fix FreeBSD-DCO and Multisocket interaction
+      manpage: fix HTML format for --local
+      Fix dco_win and multisocket interaction
+      dco_linux: Introduce new uAPIs
+      Explicit-exit-notify and multisocket interaction
+
+Heiko Hund (21):
+      dns option: allow up to eight addresses per server
+      work around false positive warning with mingw 12
+      dns option: remove support for exclude-domains
+      cmake: create and link compile_commands.json file
+      cmake: symlink whole build dir not just .json file
+      Windows: enforce 'block-local' with WFP filters
+      add and send IV_PROTO_DNS_OPTION_V2 flag
+      dns: store IPv4 addresses in network byte order
+      dns: clone options via pointer instead of copy
+      service: add utf8to16 function that takes a size
+      dns: support multiple domains without DHCP
+      dns: do not use netsh to set name server addresses
+      win: calculate address string buffer size
+      win: implement --dns option support with NRPT
+      dns: apply settings via script on unixoid systems
+      fix typo in haikuos dns-updown script
+      dns: support running up/down command with privsep
+      dns: don't publish env vars to non-dns scripts
+      dns: fix potential NULL pointer dereference
+      win: match search domains when creating exclude rules
+      win: fix collecting DNS exclude data
+
+Heiko Wundram (1):
+      Implement Windows CA template match for Crypto-API selector
+
+Ilia Shipitsin (3):
+      src/openvpn/init.c: handle strdup failures
+      sample/sample-plugins/defer/multi-auth.c: handle strdup errors
+      tests/unit_tests/openvpn/test_auth_token.c: handle strdup errors
+
+Ilya Shipitsin (1):
+      src/openvpn/dco_freebsd.c: handle malloc failure
+
+Juliusz Sosinowicz (1):
+      Change include order for tests
+
+Klemens Nanni (1):
+      Fix tmp-dir documentation
+
+Kristof Provost (10):
+      Read DCO traffic stats from the kernel
+      dco: Update counters when a client disconnects
+      Read the peer deletion reason from the kernel
+      dco: cleanup FreeBSD dco_do_read()
+      options.c: enforce a minimal fragment size
+      configure: improve FreeBSD DCO check
+      dco: define OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT on FreeBSD
+      dco: print FreeBSD version
+      DCO: support key rotation notifications
+      dco-freebsd: dynamically re-allocate buffer if it's too small
+
+Lev Stipakov (63):
+      Rename dco_get_peer_stats to dco_get_peer_stats_multi
+      management: add timer to output BYTECOUNT
+      Introduce dco_get_peer_stats API and Windows implementation
+      git-version.py: proper support for tags
+      msvc: upgrade to Visual Studio 2022
+      tun: move print_windows_driver() out of tun.h
+      openvpnmsica: remove dco installer custom actions
+      openvpnmsica: remove unused declarations
+      openvpnmsica: fix adapters discovery logic for DCO
+      Allow certain DHCP options to be used without DHCP server
+      dco-win: use proper calling convention on x86
+      Improve format specifier for socket handle in Windows
+      Disable DCO if proxy is set via management
+      Add logging for windows driver selection process
+      Avoid management log loop with verb >=3D 6
+      Support --inactive option for DCO
+      Fix '--inactive <time> 0' behavior for DCO
+      Print DCO client stats on SIGUSR2
+      Don't overwrite socket flags when using DCO on Windows
+      Support of DNS domain for DHCP-less drivers
+      dco-win: support for --dev-node
+      tapctl: generate driver-specific adapter names
+      openvpnmsica: link C runtime statically
+      tun.c: enclose DNS domain in single quotes in WMIC call
+      manage.c: document missing KID parameter
+      Set WINS servers via interactice service
+      CMake: fix broken daemonization and syslog functionality
+      Warn user if INFO control command is too long
+      CMake: fix HAVE_DAEMON detection on Linux
+      dco-win: get driver version
+      dco: warn if DATA_V1 packets are sent to userspace
+      config.h: fix incorrect defines for _wopen()
+      Make --dns options apply for tap-windows6 driver
+      Warn if pushed options require DHCP
+      tun.c: don't attempt to delete DNS and WINS servers if they're not s=
et
+      win32: Enforce loading of plugins from a trusted directory
+      interactive.c: disable remote access to the service pipe
+      interactive.c: Fix potential stack overflow issue
+      Disable DCO if proxy is set via management
+      misc.c: remove unused code
+      interactive.c: Improve access control for gui<->service pipe
+      Use a more robust way to get dco-win version
+      dco: better naming for function parameters
+      repair DNS address option
+      dco-win: factor out getting dco version
+      dco-win: enable mode server on supported configuration
+      dco-win: simplify do_close_link_socket()
+      route.c: change the signature of get_default_gateway()
+      route.c: improve get_default_gateway() logic on Windows
+      mudp.c: keep offset value when resetting buffer
+      multi.c: add iroutes after dco peer is added
+      dco-win: disable dco in server mode if multiple --local options defi=
ned
+      dco-win: multipeer support
+      dco-win: simplify control packets prepend code
+      dco-win: kernel notifications
+      dco-win: support for iroutes
+      dco-win: Fix crash when cancelling pending operation
+      Remove UINT8_MAX definition
+      win: allow OpenVPN service account to use any command-line options
+      ssl_openssl.c: Prevent potential double-free
+      win: refactor get_windows_version()
+      win: create adapter on demand
+      win: remove Wintun support
+
+Marc Becker (5):
+      unify code path for adding PKCS#11 providers
+      use new pkcs11-helper interface to add providers
+      special handling for PKCS11 providers on win32
+      vcpkg-ports/pkcs11-helper: support loader flags
+      vcpkg-ports/pkcs11-helper: bump to version 1.30
+
+Marco Baffo (3):
+      tun: removed unnecessary route installations
+      IPv6 MADDR LOG: Wrap IPv6 addresses in square brackets and print por=
t when the port is specified
+      get_default_gateway(): Prevent passing IPV4_INVALID_ADDR as a destin=
ation
+
+Martin Rys (1):
+      openvpn-[client|server].service: Remove syslog.target
+
+Matthias Andree (1):
+      make dist: Ship ovpn_dco_freebsd.h, too
+
+Max Fillinger (10):
+      Correct tls-crypt-v2 metadata length in man page
+      Fix message for too long tls-crypt-v2 metadata
+      Add support for mbedtls 3.X.Y
+      Update README.mbedtls
+      Disable TLS 1.3 support with mbed TLS
+      Enable key export with mbed TLS 3.x.y
+      Remove license warning from README.mbedtls
+      mbedtls: Remove support for old TLS versions
+      mbedtls: Warn if --tls-version-min is too low
+      Remove HAVE_EXPORT_KEYING_MATERIAL macro
+
+Michael Baentsch (1):
+      using OpenSSL3 API for EVP PKEY type name reporting
+
+Michael Nix (1):
+      fix typo in help text: --ignore-unknown-option
+
+Qingfang Deng (1):
+      dco: fix source IP selection when multihome
+
+Ralf Lici (3):
+      Fix check_addr_clash argument order
+      Handle missing DCO peer by restarting the session
+      Implement ovpn version detection
+
+Reynir Bj=C3=B6rnsson (2):
+      protocol_dump: tls-crypt support
+      Only schedule_exit() once
+
+R=C3=A9mi Farault (1):
+      Add calls to nvlist_destroy to avoid leaks
+
+Samuli Sepp=C3=A4nen (6):
+      Add t_server_null test suite
+      t_server_null: multiple improvements and fixes
+      t_server_null: persist test log files
+      t_server_null: forcibly kill misbehaving servers
+      t_server_null: use wait instead of marker files
+      Add lwip support to t_server_null
+
+Selva Nair (63):
+      Reduce default restart pause to 1 second
+      Do not include auth-token in pulled option digest
+      Persist DCO client data channel traffic stats on restart
+      Add remote-count and remote-entry query via management
+      Permit unlimited connection entries and remotes
+      Use a template for 'unsupported management commands' error
+      Allow skipping multple remotes via management interface
+      Properly unmap ring buffer file-map in interactive service
+      Use undo_lists for saving ring-buffer handles in interactive service
+      Cleanup: Close duplicated handles in interactive service
+      Preparing for better signal handling: some code refactoring
+      Refactor signal handling in openvpn_getaddrinfo
+      Use IPAPI for setting ipv6 routes when iservice not available
+      Fix signal handling on Windows
+      Assign and honour signal priority order
+      Distinguish route addition errors from route already exists
+      Propagate route error to initialization_completed()
+      Include CE_DISABLED status of remote in "remote-entry-get" response
+      Define and use macros for route addition status code
+      Warn when pkcs11-id or pkcs11-id-management options are ignored
+      Cleanup route error and debug logging on Windows
+      Fix one more 'existing route may get deleted' case
+      block-dns using iservice: fix a potential double free
+      Conditionally add subdir-objects option to automake
+      Build unit tests in mingw Windows build
+      cyryptapi.c: log the selected certificate's name
+      cryptoapi.c: remove pre OpenSSL-3.01 support
+      cryptoapi.c: simplify parsing of thumbprint hex string
+      Option --cryptoapicert: support issuer name as a selector
+      Add a unit test for functions in cryptoapi.c
+      Do not save pointer to 'struct passwd' returned by getpwnam etc.
+      Bugfix: Convert ECDSA signature form pkcs11-helper to DER encoded fo=
rm
+      Import some sample certificates into Windows store for testing
+      Add tests for finding certificates in Windows cert store
+      Refactor SSL_CTX_use_CryptoAPI_certificate()
+      Add a test for signing with certificates in Windows store
+      Unit tests: add test for SSL_CTX_use_Cryptoapi_certificate()
+      Improve error message on short read from socks proxy
+      Make error in setting metric for IPv6 interface non-fatal
+      Bug-fix: segfault in dco_get_peer_stats()
+      Move digest_sign_verify out of test_cryptoapi.c
+      Unit tests: Test for PKCS#11 using a softhsm2 token
+      Enable pkcs11 an dtest_pkcs11 in github actions
+      Make cert_data.h and test_cryptoapi/pkcs11.c MSVC compliant
+      Format Windows error message in Unicode
+      Bugfix: dangling pointer passed to pkcs11-helper
+      Correctly handle Unicode names for exit event
+      Interactive service: do not force a target desktop for openvpn.exe
+      Improve signal handling using POSIX sigaction
+      signal_reset(): combine check and reset operations
+      Log OpenSSL errors on failure to set certificate
+      Document that auth-user-pass may be inlined
+      test_pkcs11.c: set file offset to 0 after ftruncate
+      proxy.c: Clear sensitive data after use
+      Protect cached username, password and token on client
+      Interpret --key and --cert option argument as URI
+      Add a test for loading certificate and key to ssl context
+      Add a test for loading certificate and key using file: URI
+      Initialize before use struct user_pass in ui_reader()
+      Static-challenge concatenation option
+      Add test for static-challenge concatenation option
+      Fix more of uninitialized struct user_pass local vars
+      Do not stop reading from file/uri when OPENSSL_STORE_load() returns =
error
+
+Sergey Korolev (1):
+      dco-linux: fix counter print format
+
+Shubham Mittal (2):
+      Add compatibility to build OpenVPN with AWS-LC.
+      Adding AWS-LC to the OpenVPN CI
+
+Shuji Furukawa (1):
+      Improve shuffling algorithm of connection list
+
+Steffan Karger (2):
+      Fix IPv6 route add/delete message log level
+      Improve data channel crypto error messages
+
+Timo Rothenpieler (1):
+      Don't clear capability bounding set on capng_change_id
+
+corubba (2):
+      Fix IPv6 in port-share journal
+      Fix port-share journal doc
+
+orbea (1):
+      configure: disable engines if OPENSSL_NO_ENGINE is defined
+
+rein.vanbaaren (1):
+      Fix MBEDTLS_DEPRECATED_REMOVED build errors
+
+wellweek (1):
+      remove repetitive words in documentation and comments
+
+yatta (1):
+      fix(ssl): init peer_id when init tls_multi
+
+
diff --git a/Changes.rst b/Changes.rst
index e297334..eb3d65b 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -2,25 +2,58 @@
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
 New features
 ------------
-TLS alerts
-    OpenVPN 2.7 will send out TLS alerts to peers informing them if the TLS
-    session shuts down or when the TLS implementation informs the peer abo=
ut
-    an error in the TLS session (e.g. mismatching TLS versions). This impr=
oves
-    the user experience as the client shows an error instead of running in=
to
-    a timeout when the server just stops responding completely.
+Multi-socket support for servers
+    OpenVPN servers now can listen on multiple sockets at the same time.
+    Multiple ``--local`` statements in the configuration can be used to
+    configure this. This way the same server can e.g. listen for UDP
+    and TCP connections at the same time, or listen on multiple addresses
+    and/or ports.

-Support for tun/tap via unix domain socket and lwipovpn support
-    To allow better testing and emulating a full client with a full
-    network stack OpenVPN now allows a program executed to provide
-    a tun/tap device instead of opening a device.
+Client implementations for DNS options sent by server for Linux/BSD
+    Linux and BSD versions of OpenVPN now ship with a default ``dns-updown=
``
+    script that implements proper handling of DNS configuration sent
+    by the server. The scripts should work on systems that use
+    ``systemd`` or ``resolveconf`` to manage the DNS setup, as well as
+    raw ``/etc/resolv.conf`` files. However, the exact features supported
+    will depend on the configuration method. On Linux this should usually
+    mean that split-DNS configurations are supported out-of-the-box now.

-    The co-developed lwipovpn program based on lwIP stack allows to
-    simulate full IP stack and an OpenVPN client using
-    ``--dev-node unix:/path/to/lwipovpn`` can emulate a full client that
-    can be pinged, can serve a website and more without requiring any
-    elevated permission. This can make testing OpenVPN much easier.
+    Note that this new script will not be used by default if a ``--up``
+    script is already in use to reduce problems with
+    backwards compatibility.

-    For more details see [lwipovpn on Gihtub](https://github.com/OpenVPN/l=
wipovpn).
+    See documentation for ``--dns-updown`` and ``--dns`` for more details.
+
+New client implementation for DNS options sent by server for Windows
+    The Windows client now uses NRPT (Name Resolution Policy Table) to
+    handle DNS configurations. This adds support for split-DNS and DNSSEC
+    and improves the compatbility with local DNS resolvers. Requires the
+    interactive service.
+
+On Windows the ``block-local`` flag is now enforced with WFP filters.
+    The ``block-local`` flag to ``--redirect-gateway`` and
+    ``--redirect-private`` is now also enforced via the Windows Firewall,
+    making sure packets can't be sent to the local network.
+    This provides stronger protection against TunnelCrack-style attacks.
+
+Windows network adapters are now generated on demand
+    This means that on systems that run multiple OpenVPN connections at
+    the same time the users don't need to manually create enough network
+    adapters anymore (in addition to the ones created by the installer).
+
+Windows automatic service now runs as an unpriviledged user
+    All tasks that need privileges are now delegated to the interactive
+    service.
+
+Support for new version of Linux DCO module
+    OpenVPN DCO module is moving upstream and being merged into the
+    main Linux kernel. For this process some API changes were required.
+    OpenVPN 2.7 will only support the new API. The new module is called
+    ``ovpn``. Out-of-tree builds for older kernels are available. Please
+    see the release announcements for futher information.
+
+Support for server mode in win-dco driver
+    On Windows the win-dco driver can now be used in server setups.

 Enforcement of AES-GCM usage limit
     OpenVPN will now enforce the usage limits on AES-GCM with the same
@@ -30,11 +63,6 @@

     https://datatracker.ietf.org/doc/draft-irtf-cfrg-aead-limits/

-Default ciphers in ``--data-ciphers``
-    Ciphers in ``--data-ciphers`` can contain the string DEFAULT that is
-    replaced by the default ciphers used by OpenVPN, making it easier to
-    add an allowed cipher without having to spell out the default ciphers.
-
 Epoch data keys and packet format
     This introduces the epoch data format for AEAD data channel
     ciphers in TLS mode ciphers. This new data format has a number of
@@ -49,15 +77,46 @@
     - IV constructed with XOR instead of concatenation to not have (parts)=
 of
       the real IV on the wire

+Default ciphers in ``--data-ciphers``
+    Ciphers in ``--data-ciphers`` can contain the string DEFAULT that is
+    replaced by the default ciphers used by OpenVPN, making it easier to
+    add an allowed cipher without having to spell out the default ciphers.
+
+TLS alerts
+    OpenVPN 2.7 will send out TLS alerts to peers informing them if the TLS
+    session shuts down or when the TLS implementation informs the peer abo=
ut
+    an error in the TLS session (e.g. mismatching TLS versions). This impr=
oves
+    the user experience as the client shows an error instead of running in=
to
+    a timeout when the server just stops responding completely.
+
+Support for tun/tap via unix domain socket and lwipovpn support
+    To allow better testing and emulating a full client with a full
+    network stack OpenVPN now allows a program executed to provide
+    a tun/tap device instead of opening a device.
+
+    The co-developed lwipovpn program based on lwIP stack allows to
+    simulate full IP stack. An OpenVPN client using
+    ``--dev-node unix:/path/to/lwipovpn`` can emulate a full client that
+    can be pinged, can serve a website and more without requiring any
+    elevated permission. This can make testing OpenVPN much easier.
+
+    For more details see [lwipovpn on Gihtub](https://github.com/OpenVPN/l=
wipovpn).
+
 Allow overriding username with ``--override-username``
     This is intended to allow using auth-gen-token in scenarios where the
     clients use certificates and multi-factor authentication.  This will
     also generate a 'push "auth-token-user newusername"' directives in
     push replies.

+``--port-share`` now properly supports IPv6
+    Issues with logging of IPv6 addresses were fixed. The feature now allo=
ws
+    IPv6 connections towards the proxy receiver.
+
+Support for Haiku OS
+
 Deprecated features
 -------------------
-``secret`` support has been removed by default.
+``secret`` support has been removed (by default).
     static key mode (non-TLS) is no longer considered "good and secure eno=
ugh"
     for today's requirements.  Use TLS mode instead.  If deploying a PKI CA
     is considered "too complicated", using ``--peer-fingerprint`` makes
@@ -67,6 +126,14 @@
     ``--allow-deprecated-insecure-static-crypto`` but will be removed in
     OpenVPN 2.8.

+Support for wintun Windows driver has been removed.
+    OpenVPN 2.6 added support for the new dco-win driver, so it supported
+    three different device drivers: dco-win, wintun, and tap-windows6.
+    OpenVPN 2.7 now drops the support for wintun driver. By default
+    all modern configs should be supported by dco-win driver. In all
+    other cases OpenVPN will fall back automatically to tap-windows6
+    driver.
+
 NTLMv1 authentication support for HTTP proxies has been removed.
     This is considered an insecure method of authentication that uses
     obsolete crypto algorithms.
@@ -78,28 +145,34 @@
 ``persist-key`` option has been enabled by default.
     All the keys will be kept in memory across restart.

-Default for ``--topology`` changed to ``subnet`` for ``--mode server``
-    Previous releases always used ``net30`` as default. This only affects
-    configs with ``--mode server`` or ``--server`` (the latter implies the
-    former), and ``--dev tun``, and only if IPv4 is enabled.
-    Note that this changes the semantics of ``--ifconfig``, so if you have
-    manual settings for that in your config but not set ``--topology``
-    your config might fail to parse with the new version. Just adding
-    ``--topology net30`` to the config should fix the problem.
-    By default ``--topology`` is pushed from server to client.
-
-OpenSSL 1.0.2 support
+OpenSSL 1.0.2 support has been removed.
     Support for building with OpenSSL 1.0.2 has been removed. The minimum
     supported OpenSSL version is now 1.1.0.

-Compression on send
+Support for mbedTLS older than 2.18.0 has been removed.
+    We now require all SSL libraries to have support for exporting
+    keying material. The only previously supported library versions
+    this affects are older mbedTLS releases.
+
+Compression on send has been removed.
     OpenVPN 2.7 will never compress data before sending. Decompression of
     received data is still supported.
     ``--allow-compression yes`` is now an alias for
     ``--allow-compression asym``.

+
 User-visible Changes
 --------------------
+- Default for ``--topology`` changed to ``subnet`` for ``--mode server``.
+  Previous releases always used ``net30`` as default. This only affects
+  configs with ``--mode server`` or ``--server`` (the latter implies the
+  former), and ``--dev tun``, and only if IPv4 is enabled.
+  Note that this changes the semantics of ``--ifconfig``, so if you have
+  manual settings for that in your config but not set ``--topology``
+  your config might fail to parse with the new version. Just adding
+  ``--topology net30`` to the config should fix the problem.
+  By default ``--topology`` is pushed from server to client.
+
 - ``--x509-username-field`` will no longer automatically convert fieldname=
s to
   uppercase. This is deprecated since OpenVPN 2.4, and has now been remove=
d.

@@ -108,6 +181,29 @@
   And finite field Diffie Hellman is in the proces of being deprecated
   (see draft-ietf-tls-deprecate-obsolete-kex)

+- ``--lport 0`` does not imply ``--bind`` anymore.
+
+- ``--redirect--gateway`` now works correctly if the VPN remote is not
+  reachable by the default gateway.
+
+- ``--show-gateway`` now supports querying the gateway for IPv4 addresses.
+
+- ``--static-challenge`` option now has a third parameter ``format`` that
+  can change how password and challenge response should be combined.
+
+- ``--key`` and ``--cert`` now accept URIs implemented in OpenSSL 3 as wel=
l as
+  optional OpenSSL 3 providers loaded using ``--providers`` option.
+
+- ``--cryptoapicert`` now supports issuer name as well as Windows CA templ=
ate
+  name or OID as selector string.
+
+- TLS handshake debugging information contains much more details  now when
+  using recent versions of OpenSSL.
+
+- The ``IV_PLAT_VER`` variable sent by Windows clients now contains the
+  full Windows build version to make it possible to determine the
+  Windows 10 or Windows 11 version used.
+
 Overview of changes in 2.6
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index 471389b..fc47287 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -43,7 +43,7 @@

 argv_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/sr=
c/compat @TEST_CFLAGS@
 argv_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl=
,--wrap=3Dparse_line
-argv_testdriver_SOURCES =3D test_argv.c mock_msg.c mock_msg.h \
+argv_testdriver_SOURCES =3D test_argv.c mock_msg.c mock_msg.h test_common.=
h \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
@@ -52,7 +52,7 @@

 buffer_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/=
src/compat @TEST_CFLAGS@
 buffer_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -=
Wl,--wrap=3Dparse_line
-buffer_testdriver_SOURCES =3D test_buffer.c mock_msg.c mock_msg.h \
+buffer_testdriver_SOURCES =3D test_buffer.c mock_msg.c mock_msg.h test_com=
mon.h \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/platform.c
@@ -61,7 +61,7 @@
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
 	@TEST_CFLAGS@
 crypto_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
-crypto_testdriver_SOURCES =3D test_crypto.c mock_msg.c mock_msg.h \
+crypto_testdriver_SOURCES =3D test_crypto.c mock_msg.c mock_msg.h test_com=
mon.h \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
@@ -78,7 +78,7 @@
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
 	@TEST_CFLAGS@
 ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
-ssl_testdriver_SOURCES =3D test_ssl.c mock_msg.c mock_msg.h \
+ssl_testdriver_SOURCES =3D test_ssl.c mock_msg.c mock_msg.h test_common.h \
 	mock_management.c mock_ssl_dependencies.c mock_win32_execve.c \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
@@ -114,7 +114,7 @@
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
 	@TEST_CFLAGS@
 packet_id_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
-packet_id_testdriver_SOURCES =3D test_packet_id.c mock_msg.c mock_msg.h \
+packet_id_testdriver_SOURCES =3D test_packet_id.c mock_msg.c mock_msg.h te=
st_common.h \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/otime.c \
@@ -128,7 +128,7 @@
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
 	@TEST_CFLAGS@
 pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
-pkt_testdriver_SOURCES =3D test_pkt.c mock_msg.c mock_msg.h mock_win32_exe=
cve.c \
+pkt_testdriver_SOURCES =3D test_pkt.c mock_msg.c mock_msg.h mock_win32_exe=
cve.c test_common.h \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
@@ -156,7 +156,7 @@
 	-Wl,--wrap=3Dbuffer_write_file \
 	-Wl,--wrap=3Dparse_line \
 	-Wl,--wrap=3Drand_bytes
-tls_crypt_testdriver_SOURCES =3D test_tls_crypt.c mock_msg.c mock_msg.h \
+tls_crypt_testdriver_SOURCES =3D test_tls_crypt.c mock_msg.c mock_msg.h te=
st_common.h \
 	mock_win32_execve.c \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
diff --git a/version.m4 b/version.m4
index 091cc5d..4c3b7c8 100644
--- a/version.m4
+++ b/version.m4
@@ -3,7 +3,7 @@
 define([PRODUCT_TARNAME], [openvpn])
 define([PRODUCT_VERSION_MAJOR], [2])
 define([PRODUCT_VERSION_MINOR], [7])
-define([PRODUCT_VERSION_PATCH], [_git])
+define([PRODUCT_VERSION_PATCH], [_alpha1])
 m4_append([PRODUCT_VERSION], [PRODUCT_VERSION_MAJOR])
 m4_append([PRODUCT_VERSION], [PRODUCT_VERSION_MINOR], [[.]])
 m4_append([PRODUCT_VERSION], [PRODUCT_VERSION_PATCH], [[]])

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1032?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I80a14b77fcc2fabf51af9f2d5ea0c36362cccb91
Gerrit-Change-Number: 1032
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: selvanair <selva.nair@...277...>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--Caonh2dBo5A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos, selvanair, stip=
a. </p>
<p>cron2 <strong>uploaded patch set #6</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1032?usp=3Demail">View Change</a></p><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">OpenVPN Release 2.7_alpha1<br><br>vers=
ion.m4, ChangeLog, Changes.rst<br><br>(ChangeLog in &quot;master&quot; will=
 revert to its normal state of &quot;empty&quot;<br>after release/2.7 is fo=
rked off into its own branch)<br><br>Additionally, add test_common.h to tes=
ts/unit_tests/openvpn/Makefile.am<br>(..._SOURCES) so it&#39;s packed into =
the &quot;make dist&quot; tarball<br><br>Change-Id: I80a14b77fcc2fabf51af9f=
2d5ea0c36362cccb91<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...=
&gt;<br>---<br>M ChangeLog<br>M Changes.rst<br>M tests/unit_tests/openvpn/M=
akefile.am<br>M version.m4<br>4 files changed, 894 insertions(+), 46 deleti=
ons(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chang=
es/32/1032/6</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/ChangeLog b/ChangeLog</span><br><span>ind=
ex c26dd2e..c6e626b 100644</span><br><span>--- a/ChangeLog</span><br><span>=
+++ b/ChangeLog</span><br><span>@@ -1,7 +1,759 @@</span><br><span> OpenVPN =
ChangeLog</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Copyright (C=
) 2002-2024 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+Copyright (C) 2002-2025 OpenVPN Inc &lt;sales@...220...=
..515...&gt;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-This file is not maintained in this branch of the OpenVPN git repo=
sitory.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+2025.05.28 -=
- Version 2.7_alpha1</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-Release branches (release/2.5, release/2.4, etc) have indi=
vidual ChangeLog</span><br><span style=3D"color: hsl(0, 100%, 40%);">-files=
 with all changes relevant for these releases.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+5andr0 (1):</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+      Implement server_poll_timeout for socks</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+Alexander von Gluck (4):</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      Haiku: Introduce basic platform / tun =
support</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Haiku:=
 Add calls to manage routing table</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      Haiku: change del to delete in route command. del is u=
ndocumented</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Ha=
iku: Fix short interface path length</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+An=
tonio Quartulli (32):</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+      disable DCO if --secret is specified</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+      dco: properly re-initialize dco_del_peer_rea=
son</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      dco: bail =
out when no peer-specific message is delivered</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      dco: improve comment about hidden debug me=
ssage</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      dco: pri=
nt proper message in case of transport disconnection</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      dco_linux: update license for ovpn_=
dco_linux.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Up=
date issue templates</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+      Avoid warning about missing braces when initialising key struct</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+      dco: don&#39;t use=
 NetLink to exchange control packets</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+      dco: print version to log if available</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      dco-linux: remove M_ERRNO f=
lag when printing netlink error message</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+      multi: don&#39;t call DCO APIs if DCO is disabled=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      dco-freebsd: =
use m-&gt;instances[] instead of m-&gt;hash</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      dco-linux: implement dco_get_peer_stats{, mul=
ti} API</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      config=
ure.ac: fix typ0 in LIBCAPNG_CFALGS</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+      dco: fix crash when --multihome is used with --proto =
tcp</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      dco: mark =
peer as deleted from kernel after receiving CMD_DEL_PEER notification</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+      event/multi: add ev=
ent_arg object to make event handling more generic</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      pass link_socket object to i/o functio=
ns</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      io_work: co=
nvert shift argument to uintptr_t</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+      io_work: pass event_arg object to event handler in case=
 of socket event</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
   sitnl: replace NLMSG_TAIL macro with noinline function</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+      override ai_family if &#39;loca=
l&#39; numeric address was specified</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+      Adapt socket handling to support listening on multip=
le sockets</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      all=
ow user to specify &#39;local&#39; multiple times in config files</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+      dco_linux: extend netli=
nk error cb with extra info</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      man: extend --persist-tun section</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+      dco: pass remoteaddr only for UDP peers</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+      socket: use rem=
ote proto when creating client sockets</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+      dco_linux: fix peer stats parsing with new ovpn ke=
rnel module</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      so=
cket: don&#39;t transfer bind family to socket in case of ANY address</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+      dco_linux: avoid bo=
gus text when netlink message is not parsed</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+Aquila Macedo (1):</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      doc: Correct typos in multiple documentation files</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+Arne Schwabe (190):</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      Fix connection cookie not including address and=
 fix endianness in test</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      Fix unit test of test_pkt on little endian Linux</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      Disable DCO when TLS mode is n=
ot used</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Ignore=
 connection attempts while server is shutting down</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      Improve debug logging of DCO swap key =
message and Linux dco_new_peer</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      Trigger a USR1 if dco_update_keys fails</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      Set DCO_NOT_INSTALLED also for k=
eys not in the get_key_scan range</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+      Ensure that argument to parse_line has always space for=
 final sentinel</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
  Improve documentation on user/password requirement and unicodize function=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Eliminate or =
comment empty blocks and switch fallthrough</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      Remove unused gc_arena</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      Fix corner case that might lead to =
leaked file descriptor</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      Deprecate NTLMv1 proxy auth method.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+      Use include &quot;buffer.h&quot; instead of =
include &lt;buffer.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      Ensure that dco keepalive and mssfix options are also set in pur=
e p2p mode</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Mak=
e management password check constant time</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      Rename TM_UNTRUSTED to TM_INITIAL, always start=
 session in TM_INITIAL rather than TM_ACTIVE or TM_INITIAL</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      Move dco_installed back to lin=
k_socket from link_socket.info.actual</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      Do not set nl socket buffer size</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      Also drop incoming dco packet co=
ntent when dropping the packet</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      Improve logging when seeing a message for an unkown peer</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Ignore OVPN_DEL=
_PEER_REASON_USERSPACE to avoid race conditions</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+      Replace custom min macro and use more C99=
 style in man_remote_entry_get</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      Replace realloc with new gc_realloc function</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      Add connect-freq-initial op=
tion to limit initial connection responses</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+      Log peer-id if loglevel is D_DCO_DEBUG and dco=
 is enabled</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      De=
precate OCC checking</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+      Workaround: make ovpn-dco more reliable</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      Fix unaligned access in auth-token</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+      Update LibreSSL to 3.=
7.0 in Github actions</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+      Add printing USAN stack trace on github actions</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+      Fix LibreSSL not building in Gith=
ub Actions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Add=
 missing stdint.h includes in unit tests files</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      Combine extra_tun/frame parameter of frame=
_calculate_payload_overhead</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      Update the last sections in the man page to a be a bit less o=
utdated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Add bu=
ilding unit tests with mingw to github actions</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      Revise the cipher negotiation info about O=
penVPN3 in the man page</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      Exit if a proper message instead of segfault on Android without m=
anagement</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Use =
proper print format/casting when converting msg_channel handle</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+      Reduce initialisation spam=
 from verb &lt;=3D 3 and print summary instead</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      Dynamic tls-crypt for secure soft_reset/se=
ssion renegotiation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
      Set netlink socket to be non-blocking</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      Ensure n =3D 2 is set in key2 struct in tls_c=
rypt_v2_unwrap_client_key</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+      Fix memory leaks in open_tun_dco()</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      Fix memory leaks in HMAC initial packet ge=
neration</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Use k=
ey_state instead of multi for tls_send_payload parameter</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      Make sending plain text control =
message session aware</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+      Only update frame calculation if we have a valid link sockets</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+      Improve description=
 of compat-mode</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
  Simplify --compress parsing in options.c</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+      Refuse connection if server pushes an option c=
ontradicting allow-compress</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      Add &#39;allow-compression stub-only&#39; internally for DCO<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Parse compress=
ion options and bail out when compression is disabled</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      Remove unused variable line</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+      Add Apache2 linking w=
ith for new commits</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
      Fix compile error on TARGET_ANDROID</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      Fix use-after-free with EVP_CIPHER_free</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+      Remove key_type argum=
ent from generate_key_random</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+      add basic CMake based build</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+      Avoid unused function warning/error on FreeBSD=
 (and potientially others)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+      Do not blindly assume python3 is also the interpreter that run=
s rst2html</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Onl=
y add -Wno-stringop-truncation on supported compilers</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      fix warning with gcc 12.2.0 (compil=
er bug?)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Fix C=
R_RESPONSE mangaement message using wrong key_id</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+      Print a more user-friendly error when tl=
s-crypt-v2 client auth fails</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+      Ignore Ipv6 route delete request on Android and set ipv4 ver=
bosity to 7</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Mo=
ck openvpn_exece on win32 also for test_tls_crypt</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+      Check if the -wrap argument is actually=
 supported by the platform&#39;s ld</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+      Revert commit 423ced962d</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      Implement using --peer-fingerprint without=
 CA certificates</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
   show extra info for OpenSSL errors</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      Remove ability to use configurations without TLS by=
 default</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Add w=
arning for the --show-groups command that some groups are missing</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+      Print peer temporary ke=
y details</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Add =
warning if a p2p NCP client connects to a p2mp server</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      Remove openssl engine method for lo=
ading the key</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
Add undefined and abort on error to clang sanitize builds</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+      Add --enable-werror to all plat=
forms in Github Actions</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      Remove saving initial frame code</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+      Double check that we do not use a freed buffer=
 when freeing a session</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      Fix using to_link buffer after freed</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      Remove CMake custom compiler flags for REL=
EASE and DEBUG build</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+      Do not check key_state buffers that are in S_UNDEF state</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+      Remove unused function pr=
ototype crypto_adjust_frame_parameters</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+      Introduce report_command_status helper function</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+      Log SSL alerts m=
ore prominently</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
  Remove unused/unneeded/add missing defines from configure/cmake</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+      Document tls-exit optio=
n mainly as test option</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      Remove dead remains of extract_x509_field_test</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      Replace character_class_debug wi=
th proper unit test</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
      Remove TEST_GET_DEFAULT_GATEWAY as it duplicates --show-gateway</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+      Fix check_session_b=
uf_not_used using wrong index</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+      Add missing check for nl_socket_alloc failure</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      Add check for nice in cmake=
 config</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Minima=
l Solaris/OpenIndiana support to Cmake and clean up -Werror</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+      Remove compat versionhelpers.=
h and remove cmake/configure check for it</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      Rename state_change to continue_tls_process</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+      Move tls_get_ciph=
er_name_pair and get_num_elements to ssl_utils.c</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+      Fix building mbed TLS with CMake and all=
ow specifying custom directories</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      Extend the error message when TLS 1.0 PRF fails</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+      Fix unaligned access i=
n macOS, FreeBSD, Solaris hwaddr</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      Check PRF availability on initialisation and add --force=
-tls-key-material-export</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      Make it more explicit and visible when pkg-config is not found</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Clarify that th=
e tls-crypt-v2-verify has a very limited env set</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+      Move get_tmp_dir to win32-util.c and err=
or out on failure</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
    Implement the --tls-export-cert feature</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      Use mingw compile definition also to unit tes=
ts</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Add test_ss=
l unit test and test export of PEM to file</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+      Remove conditional text for Apache2 linking ex=
ception</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Fix ss=
l unit tests on OpenSSL 1.0.2</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+      Ensure that all unit tests use unbuffered stdout and stderr=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Allow unit te=
sts to fall back to hard coded location</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+      Add unit test for encrypting/decrypting data chan=
nel</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Print SSL =
peer signature information in handshake debug details</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      Implement generating TLS 1.0 PRF us=
ing new OpenSSL 3.0 APIs</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      Turn dead list test code into unit test</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      Use snprintf instead of sprintf for ge=
t_ssl_library_version</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+      Fix snprintf/swnprintf related compiler warnings</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      Add bracket in fingerprint messa=
ge and do not warn about missing verification</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+      Match ifdef for get_sigtype function with i=
f ifdef of caller</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
    Remove/combine redundant call of EVP_CipherInit before EVP_CipherInit_E=
x</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Add missing =
EVP_KDF_CTX_free in ssl_tls1_PRF</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      Replace macos11 with macos14 in github runners</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+      Remove openvpn_snprintf=
 and similar functions</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      Repeat the unknown command in errors from management interface</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+      Only run coverity=
 scan in OpenVPN/OpenVPN repository</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+      Support OpenBSD with cmake</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+      Workaround issue in LibreSSL crashing wh=
en enumerating digests/ciphers</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      Remove OpenSSL 1.0.2 support</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+      Remove custom TLS 1.0 PRF implementation on=
ly used by LibreSSL/wolfSSL</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      Allow the TLS session to send out TLS alerts</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      Properly handle null bytes and=
 invalid characters in control messages</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+      Allow trailing \r and \n in control channel messa=
ge</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Add Ubuntu =
24.04 runner to Github Actions</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      Implement support for AEAD tag at the end</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      Remove check for anonymous uni=
ons from configure and cmake config</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+      Make read/write_tun_header static</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+      Avoid SIGUSR1 to SIGHUP remapping=
 when the configuration is read from stdin</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+      Move to common backend_driver type in struct t=
untap</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Introduc=
e DRIVER_AFUNIX backend for use with lwipovpn</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+      Change dev null to be a driver type instead=
 of a special mode of tun/tap</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+      Use print_tun_backend_driver instead of custom code to prin=
t type</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Automat=
ically enable ifconfig-exec/route-exec behaviour for afunix tun/tap</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+      Ensure that the AF_UN=
IX socket pair has at least 65k of buffer space</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+      Fix check for CMake not detecting struct =
cmsg</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Remove nu=
ll check after checking for checking for did_open_tun</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      Remove a large number of unused str=
ucts and functions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     Remove unused methods write_key/read_key</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+      Refuse clients if username or password is l=
onger than USER_PASS_LEN</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      Move should_trigger_renegotiation into its own function</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+      Change --reneg-bytes a=
nd --reneg-packets to 64 bit counters</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      Use XOR instead of concatenation for calculation of=
 IV from implicit IV</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+      Trigger renegotiation of data key if getting close to the AEAD usage=
 limit</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Impleme=
nt HKDF expand function based on RFC 8446</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      Split init_key_ctx_bi into send/recv init</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+      Move initialisation=
 of implicit IVs to init_key_ctx_bi methods</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      Change internal id of packet id to uint64</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+      Add small unit te=
st for buf_chomp</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
   Add building/testing with msbuild and the clang compiler</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+      Ensure that Python3 is availa=
ble</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Change API=
 of init_key_ctx to use struct key_parameters</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+      Allow DEFAULT in data-ciphers and report bo=
th expanded and user set option</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      Do not attempt to decrypt packets anymore after 2**36 fai=
led decryptions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
  Add methods to read/write packet ids for epoch data</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      Implement methods to generate and m=
anage OpenVPN Epoch keys</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      Rename aead-tag-at-end to aead-epoch</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+      Improve peer fingerprint documentation</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+      Remove comparing=
 username to NULL in tls_lock_username</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+      Print warnings/errors when numerical parameters ca=
nnot be parsed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
 Add unit tests for atoi parsing options helper</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+      Improve error reporting from AF_UNIX tun/=
tap support</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Fi=
x typo in positive_atoi</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      Fix oversight of link socket code change in Android code path</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+      Implement epoch k=
ey data format</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
 Extend the unit test for data channel packets with aead limit tests</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+      Add (fake) Android c=
make building</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
Add android build to Github Actions</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+      Reconnect when TCP is on use on network-change manage=
ment command</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      I=
mplement override-username</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+      Fix incorrect condition for checking password related check</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+      Directly use _co=
untof in array initialisation</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+      Improve documentation for override-username</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+      Mention address if not unspec=
ific on DNS failure</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
      Do not leave half-initialised key wrap struct when dynamic tls-crypt =
fails</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Allow tl=
s-crypt-v2 to be setup only on initial packet of a session</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      Use SSL_get0_peer_signature_na=
me instead of SSL_get_peer_signature_nid</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+      Use USER_PASS_LEN instead of TLS_USERNAME_LEN fo=
r override-username</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
      Also print key agreement when printing negotiated details</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+      Fix mbed TLS key exporter=
 functionality in 3.6.x and cmake</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+      Make --dh none behaviour default if not specified</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+Ben Boeckel (1):</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+      console_systemd: remove the timeout when =
using &#39;systemd-ask-password&#39;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Ch=
ristoph Schug (1):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     Update documentation references in systemd unit files</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+Corubba Smith (3):</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+      Support IPv6 towards port-share proxy receiver</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+      Document x509-use=
rname-fields oid usage</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      Remove x509-username-fields uppercasing</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+David Sommerseth (4):</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      ssl_verify: Fix memleak if creating deferred auth control=
 files fails</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      n=
tlm: Clarify details on NTLM phase 3 decoding</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+      Remove --tls-export-cert</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      Remove superfluous x509_write_pe=
m()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+Franco Fichtner (1):</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+      Allow to set ifmode for exis=
ting DCO interfaces in FreeBSD</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Frank Li=
chtenheld (174):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
   options.c: fix format security error when compiling without optimization=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      options.c: up=
date usage description of --cipher</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      Update copyright year to 2023</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      xkey_pkcs11h_sign: fix dangling pointe=
r</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      options: Alw=
ays define options-&gt;management_flags</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+      check_engine_keys: make pass with OpenSSL 3</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+      documentation: upda=
te &#39;unsupported options&#39; section</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+      Changes.rst: document removal of --keysize</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+      Windows: fix unused=
 function setenv_foreign_option</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      Windows: fix unused variables in delete_route_ipv6</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+      Windows: fix wrong p=
rintf format in x_check_status</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      Windows: fix unused variable in win32_get_arch</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+      configure: enable DCO by =
default on FreeBSD/Linux</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      Windows: fix signedness errors with recv/send</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      configure: fix formatting of --d=
isable-lz4 and --enable-comp-stub</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+      tests/unit_tests: Fix &#39;make distcheck&#39; with sub=
dir-objects enabled</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
      GHA: remove Ubuntu 18.04 builds</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      vcpkg: request &quot;tools&quot; feature of openssl=
 for MSVC build</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
  Do not include net/in_systm.h</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      version.sh: remove</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+      doc: run rst2* with --strict to catch warnings</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+      man page: Remove cr=
uft from --topology documentation</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+      tests: do not include t_client.sh in dist</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      vcpkg-ports/pkcs11-helper: =
Make compatible with mingw build</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      vcpkg-ports/pkcs11-helper: Convert CONTROL to vcpkg.json=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      vcpkg-ports/p=
kcs11-helper: reference upstream PRs in patches</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+      dco_linux: properly close dco version fil=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      DCO: fix mem=
ory leak in dco_get_peer_stats_multi for Linux</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      Fix two unused assignments</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+      sample-plugins: Fix memleak i=
n client-connect example plugin</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      tests: Allow to override openvpn binary used</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+      test_buffer: add tests for=
 buf_catrunc and its caller format_hex_ex</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      buffer: use memcpy in buf_catrunc</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      options: remove --key-metho=
d from usage message</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+      msvc-generate: include version.m4.in in tarball</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+      dist: add more missing files only =
used in the MSVC build</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      vcpkg-ports/pkcs11-helper: rename patches to make file names short=
er</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      unit_tests:=
 Add missing cert_data.h to source list for unit tests</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+      dist: Include all documentation in=
 distribution</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
CMake: Add complete MinGW and MSVC build</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+      Remove all traces of the previous MSVC build sys=
tem</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      CMake: Add=
 /Brepro to MSVC link options</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+      GHA: update to run-vcpkg@...2735...</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      test_tls_crypt: Improve mock() usag=
e to be more portable</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+      CMake: Throw a clear error when config.h in top-level source direct=
ory</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      CMake: Sup=
port doc builds on Windows machines that do not have .py file association</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Remove old Trav=
is CI related files</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
      README.cmake.md: Add new documentation for CMake buildsystem</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+      GHA: refactor mingw UT=
s and add missing tls_crypt</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      GHA: Add macos-13</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      options: Do not hide variables from parent scope</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+      pkcs11_openssl: Disabl=
e unused code</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
route: Fix overriding return value of add_route3</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+      CMake: various small non-functional impr=
ovements</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      GHA: =
do not trigger builds in openvpn-build anymore</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      Remove --no-replay option</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      GHA: new workflow to submit sc=
an to Coverity Scan service</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      doc: fix argument name in --route-delay documentation</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+      Change type of frame.=
mss_fix to uint16_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
      Remove last uses of inet_ntoa</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+      mss/mtu: make all size calculations use size_t</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+      dev-tools/gerrit-sen=
d-mail.py: tool to send Gerrit patchsets to Patchwork</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      gerrit-send-mail.py: Add patch vers=
ion to subject</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
 Add mbedtls3 GHA build</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      platform.c: Do not depend Windows build on HAVE_CHDIR</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+      sample-keys: renew for th=
e next 10 years</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
  GHA: clean up libressl builds with newer libressl</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      configure.ac: Remove unused AC_TYPE=
_SIGNAL macro</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
documentation: remove reference to removed option --show-proxy-settings</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+      unit_tests: remov=
e includes for mock_msg.h</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+      buffer: add documentation for string_mod and extend related UT<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+      tests: disable=
 automake serial_tests</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      documentation: improve documentation of --x509-track</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      configure: allow to disable=
 NTLM</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      configur=
e: enable silent rules by default</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+      misc: make get_auth_challenge static</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      Remove support for NTLM v1 proxy=
 authentication</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
  GHA: increase verbosity for make check</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+      NTLM: add length check to add_security_buffer</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+      NTLM: increase s=
ize of phase 2 response we can handle</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      Fix various &#39;Uninitialized scalar variable&#39;=
 warnings from Coverity</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      proxy-options.rst: Add proper documentation for --http-proxy-user=
-pass</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      NTLM: wh=
en NTLMv1 is requested, try NTLMv2 instead</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+      buf_string_match_head_str: Fix Coverity issue =
&#39;Unsigned compared against 0&#39;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      --http-proxy-user-pass: allow to specify in either =
order with --http-proxy</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      test_user_pass: new UT for get_user_pass</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      test_user_pass: Add UTs for character =
filtering</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      gerr=
it-send-mail: Make output consistent across systems</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      README.cmake.md: Document minimum r=
equired CMake version for --preset</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      documentation: Update and fix documentation for --push=
-peer-info</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      doc=
umentation: Fixes for previous fixes to --push-peer-info</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      test_user_pass: add basic tests =
for static/dynamic challenges</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+      Fix typo --data-cipher-fallback</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+      samples: Remove tls-*.conf</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+      check_compression_settings_v=
alid: Do not test for LZ4 in LZO check</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+      t_client.sh: Allow to skip tests</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+      gerrit-send-mail: add missing S=
igned-off-by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      U=
pdate Copyright statements to 2024</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      GHA: general update March 2024</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      samples: Update sample configuratio=
ns</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      documentati=
on: make section levels consistent</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      phase2_tcp_server: fix Coverity issue &#39;Dereference=
 after null check&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      script-options.rst: Update ifconfig_* variables</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      crypto_backend: fix type of enc =
parameter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      test=
s: fork default automake test-driver</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+      forked-test-driver: Show test output always</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+      Change default of &quo=
t;topology&quot; to &quot;subnet&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+      Use topology default of &quot;subnet&quot; only fo=
r server mode</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
Fix &#39;binary or&#39; vs &#39;boolean or&#39; related to server_bridge_pr=
oxy_dhcp</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      confi=
gure: update old copy of pkg.m4</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      LZO: do not use lzoutils.h macros</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      test_user_pass: Fix building with -=
-enable-systemd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
  Remove &quot;experimental&quot; denotation for --fast-io</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      t_server_null.sh: Fix failure =
case</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      configure=
: Add -Wstrict-prototypes and -Wold-style-definition</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      configure: Try to detect LZO with p=
kg-config</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      conf=
igure: Switch to C11 by default</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      Fix missing spaces in various messages</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      console_systemd: rename query_us=
er_exec to query_user_systemd</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+      configure: Allow to detect git checkout if .git is not a di=
rectory</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      GHA: C=
onfigure Renovate</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
    configure: Try to use pkg-config to detect mbedTLS</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+      tun: use is_tun_p2p more consisten=
tly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Various fi=
xes for -Wconversion errors</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      generate_auth_token: simplify code</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+      GHA: Update dependency Mbed-TLS/mbedtls =
to v3.6.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      GHA:=
 Enable t_server_null tests</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      configure: Handle libnl-genl and libcap-ng consistent with ot=
her libs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      confi=
gure: Review use of standard AC macros</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+      socket: Change return types of link_socket_write* =
to ssize_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      GHA=
: Pin dependencies</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     GHA: Update macOS runners</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      GHA: Simplify macOS builds</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      Remove support for compression on send</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+      Fix wrong doxygen co=
mments</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Various=
 typo fixes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      ma=
cOS: Assume that net/if_utun.h is always present</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+      Fix some formatting related to if/else a=
nd macros</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Fix =
memory leak in ntlm_support</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      forward: Fix potential unaligned access in drop_if_recursive_=
routing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      GHA: G=
eneral update December 2024</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      Review doxygen warnings</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      Regenerate doxygen config file with doxygen -u</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+      Fix &#39;uninitial=
ized pointer read&#39; in openvpn_decrypt_aead</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      ssl_openssl: Clean up unused functions and=
 add missing &quot;static&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      Fix some trivial sign-compare compiler warnings</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+      tls_crypt_v2_write_clie=
nt_key_file: Fix missing-field-initializers compiler warning</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+      openvpnserv: Fix some incons=
istent usages of TEXT()</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      Fix doxygen warnings in crypto_epoch.h</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+      GHA: Drop Ubuntu 20.04 and other mainten=
ance</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      GHA: Publ=
ish Doxygen documentation to Github Pages</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      Add more &#39;intentional fallthrough&#39; comm=
ents</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Remove va=
rious unused function parameters</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      Remove unused function check_subnet_conflict</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+      options: Cleanup and simp=
lify options_postprocess_verify_ce</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      Apply text-removal.sh script to Windows codebase</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+      openvpnserv: Clean =
up use of TEXT() from DNS patches</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+      Post tchar.h removal cleanup</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+      Fix compatibility with mbedTLS 2.28.10+ =
and 3.6.3+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      t_s=
erver_null_default.rc: Add some tests with --data-ciphers</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+      GHA: Pin version of CMake for a=
ll builds</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      GHA:=
 Dependency and Actions update April 2025</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      GHA: Make sure renovate notifies us about AWS L=
C releases</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Dox=
ygen: Fix obsolete links to OpenSSL documentation</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+      GHA: Use CMake 4.0 and apply required f=
ixes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Doxygen: =
Clean up tls-crypt documentation</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      Doxygen: Remove useless Python information</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      Manually reformat some long=
 trailing comments</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     CMake: Make sure to treat UNIT_TEST_SOURCEDIR as path</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      CMake: Sync list of compiler f=
lags with configure.ac</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      CMake: Reorganize header and symbol tests</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      GHA: Dependency and Actions update May=
 2025</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Doxygen:=
 Fix missing parameter warnings</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      Changes.rst: Collect, fix, and improve entries for 2.7 re=
lease</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+George Pchelkin (1):</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+      fix typo: dhcp-options to =
dhcp-option in vpn-network-options.rst</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
Gert Doering (21):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     Change version.m4 to 2.7_git</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+      bandaid fix for TCP multipoint server crash with Linux-=
DCO</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Undo FreeB=
SD 12.x workaround on IPv6 ifconfig for 12.4 and up</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      Reduce logspam about &#39;dco_updat=
e_keys: peer_id=3D-1&#39; in p2p server mode</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+      Fix OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNEC=
T breakage on FreeBSD+DCO</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+      Repair special-casing of EEXIST for Linux/SITNL route install</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Get rid of unus=
ed &#39;bool tuntap_buffer&#39; arguments.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+      FreeBSD 12.x workaround for IPv6 ifconfig is n=
eeded on 12.4 as well</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+      Make received OCC exit messages more visible in log.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+      OpenBSD: repair --show-gatew=
ay</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      get_default=
_gateway() HWADDR overhaul</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+      make t_server_null &#39;server alive?&#39; check more robust</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+      t_client.sh: co=
nditionally skip ifconfig+route check</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      send uname() release as IV_PLAT_VER=3D on non-windo=
ws versions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      op=
tions: add IPv4 support to &#39;--show-gateway &lt;arg&gt;&#39;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+      get_default_gateway(): im=
plement platform support for Linux/SITNL</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+      get_default_gateway(): implement platform suppor=
t for Linux/IPROUTE2</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+      add missing (void) to win32 function declarations</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      add more (void) to windows speci=
fic function prototypes and declarations</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+      Make &#39;lport 0&#39; no longer sufficient to d=
o &#39;--bind&#39;.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
      Add information-gathering about DNS resolvers configured to t_client.=
sh(.in)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+Gianmarco De Gregori (17):</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+      Persist-key: enabl=
e persist-key option by default</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      Minor fix to process_ip_header</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+      Http-proxy: fix bug preventing proxy cre=
dentials caching</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
   Ensures all params are ready before invoking dco_set_peer()</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+      Route: remove incorrect ro=
utes on exit</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      F=
ix for msbuild/mingw GHA failures</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+      multiproto: move generic event handling code in dedicat=
ed files</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Fix P=
ASS_BY_VALUE issue in options_postprocess_mutate_le()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      mroute: adapt to new protocol handl=
ing and hashing improvements</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+      mroute/management: repair mgmt client-kill for mroute with p=
roto</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Add suppo=
rt for simultaneous use of UDP and TCP sockets</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      Rename occurences of &#39;struct link_sock=
et&#39; from &#39;ls&#39; to &#39;sock&#39;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      Fix FreeBSD-DCO and Multisocket interaction</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+      manpage: fix HT=
ML format for --local</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+      Fix dco_win and multisocket interaction</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+      dco_linux: Introduce new uAPIs</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+      Explicit-exit-notify and=
 multisocket interaction</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Heiko Hund (21=
):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      dns option:=
 allow up to eight addresses per server</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+      work around false positive warning with mingw 12<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+      dns option: re=
move support for exclude-domains</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      cmake: create and link compile_commands.json file</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+      cmake: symlink whole=
 build dir not just .json file</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      Windows: enforce &#39;block-local&#39; with WFP filters</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+      add and send IV_=
PROTO_DNS_OPTION_V2 flag</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      dns: store IPv4 addresses in network byte order</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      dns: clone options via pointer=
 instead of copy</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
   service: add utf8to16 function that takes a size</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      dns: support multiple domains witho=
ut DHCP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      dns: d=
o not use netsh to set name server addresses</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+      win: calculate address string buffer size</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+      win: implement -=
-dns option support with NRPT</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+      dns: apply settings via script on unixoid systems</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+      fix typo in haikuos dns=
-updown script</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
 dns: support running up/down command with privsep</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      dns: don&#39;t publish env vars to non=
-dns scripts</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      d=
ns: fix potential NULL pointer dereference</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+      win: match search domains when creating exclud=
e rules</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      win: f=
ix collecting DNS exclude data</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Heiko Wu=
ndram (1):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Imp=
lement Windows CA template match for Crypto-API selector</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+Ilia Shipitsin (3):</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      src/openvpn/init.c: handle strdup failures</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+      sample/sample-plugins/=
defer/multi-auth.c: handle strdup errors</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+      tests/unit_tests/openvpn/test_auth_token.c: hand=
le strdup errors</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+Ilya Shipitsin (1):</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+      src/openvpn/dco_=
freebsd.c: handle malloc failure</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Julius=
z Sosinowicz (1):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
    Change include order for tests</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Klem=
ens Nanni (1):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
 Fix tmp-dir documentation</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Kristof Prov=
ost (10):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Read=
 DCO traffic stats from the kernel</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      dco: Update counters when a client disconnects</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+      Read the peer deletio=
n reason from the kernel</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      dco: cleanup FreeBSD dco_do_read()</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+      options.c: enforce a minimal fragment size<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+      configure: imp=
rove FreeBSD DCO check</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      dco: define OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT on FreeBSD</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+      dco: print Free=
BSD version</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      DC=
O: support key rotation notifications</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      dco-freebsd: dynamically re-allocate buffer if it&#=
39;s too small</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+Lev Stipakov (63):</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+      Rename dco_get_peer=
_stats to dco_get_peer_stats_multi</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      management: add timer to output BYTECOUNT</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+      Introduce dco_get_peer_sta=
ts API and Windows implementation</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+      git-version.py: proper support for tags</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+      msvc: upgrade to Visual Studi=
o 2022</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      tun: mo=
ve print_windows_driver() out of tun.h</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+      openvpnmsica: remove dco installer custom actions<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+      openvpnmsica: =
remove unused declarations</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+      openvpnmsica: fix adapters discovery logic for DCO</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+      Allow certain DHCP option=
s to be used without DHCP server</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      dco-win: use proper calling convention on x86</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+      Improve format specifier=
 for socket handle in Windows</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+      Disable DCO if proxy is set via management</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      Add logging for windows driver=
 selection process</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     Avoid management log loop with verb &gt;=3D 6</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      Support --inactive option for DCO</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+      Fix &#39;--inactiv=
e &lt;time&gt; 0&#39; behavior for DCO</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+      Print DCO client stats on SIGUSR2</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      Don&#39;t overwrite socket fla=
gs when using DCO on Windows</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+      Support of DNS domain for DHCP-less drivers</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      dco-win: support for --dev-nod=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      tapctl: gene=
rate driver-specific adapter names</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      openvpnmsica: link C runtime statically</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+      tun.c: enclose DNS domain in=
 single quotes in WMIC call</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      manage.c: document missing KID parameter</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+      Set WINS servers via interactice s=
ervice</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      CMake: =
fix broken daemonization and syslog functionality</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+      Warn user if INFO control command is to=
o long</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      CMake: =
fix HAVE_DAEMON detection on Linux</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      dco-win: get driver version</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+      dco: warn if DATA_V1 packets are sent to=
 userspace</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      con=
fig.h: fix incorrect defines for _wopen()</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      Make --dns options apply for tap-windows6 drive=
r</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Warn if push=
ed options require DHCP</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      tun.c: don&#39;t attempt to delete DNS and WINS servers if they&#=
39;re not set</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
win32: Enforce loading of plugins from a trusted directory</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      interactive.c: disable remote =
access to the service pipe</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+      interactive.c: Fix potential stack overflow issue</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+      Disable DCO if proxy is se=
t via management</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
   misc.c: remove unused code</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+      interactive.c: Improve access control for gui&lt;-&gt;servi=
ce pipe</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Use a =
more robust way to get dco-win version</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+      dco: better naming for function parameters</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+      repair DNS address op=
tion</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      dco-win: =
factor out getting dco version</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      dco-win: enable mode server on supported configuration</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+      dco-win: simplify=
 do_close_link_socket()</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      route.c: change the signature of get_default_gateway()</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+      route.c: improve get_def=
ault_gateway() logic on Windows</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      mudp.c: keep offset value when resetting buffer</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+      multi.c: add iroutes af=
ter dco peer is added</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+      dco-win: disable dco in server mode if multiple --local options def=
ined</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      dco-win: =
multipeer support</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
    dco-win: simplify control packets prepend code</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      dco-win: kernel notifications</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+      dco-win: support for i=
routes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      dco-win=
: Fix crash when cancelling pending operation</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+      Remove UINT8_MAX definition</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+      win: allow OpenVPN service ac=
count to use any command-line options</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      ssl_openssl.c: Prevent potential double-free</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+      win: refactor get_wi=
ndows_version()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
  win: create adapter on demand</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      win: remove Wintun support</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+Marc Becker (5):</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      unify code path for adding PKCS#11 providers</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      use new pkcs11-helper interface to =
add providers</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
special handling for PKCS11 providers on win32</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      vcpkg-ports/pkcs11-helper: support loader =
flags</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      vcpkg-po=
rts/pkcs11-helper: bump to version 1.30</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+Marco Baffo (3):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
    tun: removed unnecessary route installations</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+      IPv6 MADDR LOG: Wrap IPv6 addresses in s=
quare brackets and print port when the port is specified</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      get_default_gateway(): Prevent p=
assing IPV4_INVALID_ADDR as a destination</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+Martin Rys (1):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     openvpn-[client|server].service: Remove syslog.target</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+Matthias Andree (1):</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+      make dist: Ship ovpn_dco_freebsd.h, too</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+Max Fillinger (10):</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+      Correct tls-crypt-v2 metadata length in m=
an page</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Fix me=
ssage for too long tls-crypt-v2 metadata</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+      Add support for mbedtls 3.X.Y</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      Update README.mbedtls</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+      Disable TLS 1.3 support =
with mbed TLS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
Enable key export with mbed TLS 3.x.y</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      Remove license warning from README.mbedtls</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+      mbedtls: Remove suppor=
t for old TLS versions</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      mbedtls: Warn if --tls-version-min is too low</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+      Remove HAVE_EXPORT_KEYING_MATERIAL=
 macro</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+Michael Baentsch (1):</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+      using OpenSSL3 API for E=
VP PKEY type name reporting</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Michael Nix=
 (1):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      fix typo=
 in help text: --ignore-unknown-option</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
Qingfang Deng (1):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     dco: fix source IP selection when multihome</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+Ralf Lici (3):</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      Fix check_addr_clash argument order</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      Handle missing DCO peer by restarting the =
session</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Implem=
ent ovpn version detection</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Reynir Bj=C3=
=B6rnsson (2):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
 protocol_dump: tls-crypt support</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+      Only schedule_exit() once</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+R=C3=A9mi Farault (1):</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+      Add calls to nvlist_destroy to avoid leaks</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+Samuli Sepp=C3=A4nen (6):</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+      Add t_server_null test suite</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+      t_server_null: multiple impr=
ovements and fixes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     t_server_null: persist test log files</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+      t_server_null: forcibly kill misbehaving serve=
rs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      t_server_nu=
ll: use wait instead of marker files</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+      Add lwip support to t_server_null</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+Selva Nair (63):</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      Reduce default restart pause to 1 second</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      Do not include auth-token i=
n pulled option digest</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      Persist DCO client data channel traffic stats on restart</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+      Add remote-count and re=
mote-entry query via management</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      Permit unlimited connection entries and remotes</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+      Use a template for &#39=
;unsupported management commands&#39; error</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      Allow skipping multple remotes via management=
 interface</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Pro=
perly unmap ring buffer file-map in interactive service</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+      Use undo_lists for saving ring-bu=
ffer handles in interactive service</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+      Cleanup: Close duplicated handles in interactive serv=
ice</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Preparing =
for better signal handling: some code refactoring</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+      Refactor signal handling in openvpn_get=
addrinfo</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Use I=
PAPI for setting ipv6 routes when iservice not available</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      Fix signal handling on Windows</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Assign and hono=
ur signal priority order</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      Distinguish route addition errors from route already exists</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+      Propagate route er=
ror to initialization_completed()</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+      Include CE_DISABLED status of remote in &quot;remote-en=
try-get&quot; response</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      Define and use macros for route addition status code</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      Warn when pkcs11-id or pkcs=
11-id-management options are ignored</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+      Cleanup route error and debug logging on Windows</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+      Fix one more &#39=
;existing route may get deleted&#39; case</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      block-dns using iservice: fix a potential doubl=
e free</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Conditi=
onally add subdir-objects option to automake</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+      Build unit tests in mingw Windows build</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+      cyryptapi.c: log t=
he selected certificate&#39;s name</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      cryptoapi.c: remove pre OpenSSL-3.01 support</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+      cryptoapi.c: simplify p=
arsing of thumbprint hex string</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      Option --cryptoapicert: support issuer name as a selector=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Add a unit te=
st for functions in cryptoapi.c</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      Do not save pointer to &#39;struct passwd&#39; returned b=
y getpwnam etc.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
  Bugfix: Convert ECDSA signature form pkcs11-helper to DER encoded form</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+      Import some samp=
le certificates into Windows store for testing</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      Add tests for finding certificates in Wind=
ows cert store</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
 Refactor SSL_CTX_use_CryptoAPI_certificate()</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+      Add a test for signing with certificates in=
 Windows store</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
 Unit tests: add test for SSL_CTX_use_Cryptoapi_certificate()</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      Improve error message on sh=
ort read from socks proxy</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+      Make error in setting metric for IPv6 interface non-fatal</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+      Bug-fix: segfault i=
n dco_get_peer_stats()</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      Move digest_sign_verify out of test_cryptoapi.c</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      Unit tests: Test for PKCS#11 usi=
ng a softhsm2 token</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
      Enable pkcs11 an dtest_pkcs11 in github actions</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      Make cert_data.h and test_cryptoapi=
/pkcs11.c MSVC compliant</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      Format Windows error message in Unicode</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      Bugfix: dangling pointer passed to pkc=
s11-helper</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Cor=
rectly handle Unicode names for exit event</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+      Interactive service: do not force a target des=
ktop for openvpn.exe</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+      Improve signal handling using POSIX sigaction</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      signal_reset(): combine check and r=
eset operations</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
  Log OpenSSL errors on failure to set certificate</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      Document that auth-user-pass may be in=
lined</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      test_pkc=
s11.c: set file offset to 0 after ftruncate</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      proxy.c: Clear sensitive data after use</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+      Protect cached user=
name, password and token on client</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      Interpret --key and --cert option argument as URI</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+      Add a test for loa=
ding certificate and key to ssl context</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+      Add a test for loading certificate and key using =
file: URI</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Init=
ialize before use struct user_pass in ui_reader()</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+      Static-challenge concatenation option</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Add test for st=
atic-challenge concatenation option</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+      Fix more of uninitialized struct user_pass local vars=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Do not stop r=
eading from file/uri when OPENSSL_STORE_load() returns error</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+Sergey Korolev (1):</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      dco-linux: fix counter print format</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+Shubham Mittal (2):</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+      Add compatibility to build OpenVPN with AWS-=
LC.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Adding AWS=
-LC to the OpenVPN CI</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Shuji Furukawa (1=
):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Improve shu=
ffling algorithm of connection list</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Ste=
ffan Karger (2):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
   Fix IPv6 route add/delete message log level</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      Improve data channel crypto error messages=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+Timo Rothenpieler (1):</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+      Don&#39;t clear capability bo=
unding set on capng_change_id</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+corubba (=
2):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      Fix IPv6 i=
n port-share journal</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+      Fix port-share journal doc</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+orbea=
 (1):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      configur=
e: disable engines if OPENSSL_NO_ENGINE is defined</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+rein.vanbaaren (1):</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      Fix MBEDTLS_DEPRECATED_REMOVED build errors</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+wellweek (1):</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+      remove repetitive words in documentation and comment=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+yatta (1):</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+      fix(ssl): init peer_id when init tls_mul=
ti</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>diff --git a/Change=
s.rst b/Changes.rst</span><br><span>index e297334..eb3d65b 100644</span><br=
><span>--- a/Changes.rst</span><br><span>+++ b/Changes.rst</span><br><span>=
@@ -2,25 +2,58 @@</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span> New features</span=
><br><span> ------------</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-TLS alerts</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Open=
VPN 2.7 will send out TLS alerts to peers informing them if the TLS</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    session shuts down or whe=
n the TLS implementation informs the peer about</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    an error in the TLS session (e.g. mismatching=
 TLS versions). This improves</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    the user experience as the client shows an error instead of run=
ning into</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    a timeou=
t when the server just stops responding completely.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+Multi-socket support for servers</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    OpenVPN servers now can =
listen on multiple sockets at the same time.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    Multiple ``--local`` statements in the configu=
ration can be used to</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    configure this. This way the same server can e.g. listen for UDP</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    and TCP connections =
at the same time, or listen on multiple addresses</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    and/or ports.</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-Support for tun/tap via unix do=
main socket and lwipovpn support</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    To allow better testing and emulating a full client with a f=
ull</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    network stack =
OpenVPN now allows a program executed to provide</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    a tun/tap device instead of opening a device=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Client implementat=
ions for DNS options sent by server for Linux/BSD</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    Linux and BSD versions of OpenVPN now shi=
p with a default ``dns-updown``</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    script that implements proper handling of DNS configuration=
 sent</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    by the ser=
ver. The scripts should work on systems that use</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ``systemd`` or ``resolveconf`` to manage t=
he DNS setup, as well as</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    raw ``/etc/resolv.conf`` files. However, the exact features suppor=
ted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will depend =
on the configuration method. On Linux this should usually</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    mean that split-DNS configuration=
s are supported out-of-the-box now.</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    The co-developed lwipovpn program based=
 on lwIP stack allows to</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    simulate full IP stack and an OpenVPN client using</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    ``--dev-node unix:/path/to/lwipovpn=
`` can emulate a full client that</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    can be pinged, can serve a website and more without requiri=
ng any</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    elevated pe=
rmission. This can make testing OpenVPN much easier.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    Note that this new script will not be=
 used by default if a ``--up``</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    script is already in use to reduce problems with</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    backwards compatibility.</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Fo=
r more details see [lwipovpn on Gihtub](https://github.com/OpenVPN/lwipovpn=
).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    See documenta=
tion for ``--dns-updown`` and ``--dns`` for more details.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+New client implementation for DNS options sent by server=
 for Windows</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    The=
 Windows client now uses NRPT (Name Resolution Policy Table) to</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    handle DNS configurations. =
This adds support for split-DNS and DNSSEC</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    and improves the compatbility with local DNS res=
olvers. Requires the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    interactive service.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+On Windows th=
e ``block-local`` flag is now enforced with WFP filters.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    The ``block-local`` flag to ``--re=
direct-gateway`` and</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ``--redirect-private`` is now also enforced via the Windows Firewall,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    making sure pack=
ets can&#39;t be sent to the local network.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    This provides stronger protection against Tunne=
lCrack-style attacks.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Windows network a=
dapters are now generated on demand</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    This means that on systems that run multiple OpenVPN co=
nnections at</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    the=
 same time the users don&#39;t need to manually create enough network</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    adapters anymore (in =
addition to the ones created by the installer).</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+Windows automatic service now runs as an unpriviledged user</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    All tasks that need pr=
ivileges are now delegated to the interactive</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    service.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
Support for new version of Linux DCO module</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    OpenVPN DCO module is moving upstream and being=
 merged into the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 main Linux kernel. For this process some API changes were required.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    OpenVPN 2.7 will only =
support the new API. The new module is called</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ``ovpn``. Out-of-tree builds for older kernel=
s are available. Please</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    see the release announcements for futher information.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+Support for server mode in win-dco driver</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    On Windows the win-dco dri=
ver can now be used in server setups.</span><br><span> </span><br><span> En=
forcement of AES-GCM usage limit</span><br><span>     OpenVPN will now enfo=
rce the usage limits on AES-GCM with the same</span><br><span>@@ -30,11 +63=
,6 @@</span><br><span> </span><br><span>     https://datatracker.ietf.org/d=
oc/draft-irtf-cfrg-aead-limits/</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-Default ciphers in ``--data-ciphers``</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    Ciphers in ``--data-ciphers=
`` can contain the string DEFAULT that is</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    replaced by the default ciphers used by OpenVPN, ma=
king it easier to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
add an allowed cipher without having to spell out the default ciphers.</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> Epoch da=
ta keys and packet format</span><br><span>     This introduces the epoch da=
ta format for AEAD data channel</span><br><span>     ciphers in TLS mode ci=
phers. This new data format has a number of</span><br><span>@@ -49,15 +77,4=
6 @@</span><br><span>     - IV constructed with XOR instead of concatenatio=
n to not have (parts) of</span><br><span>       the real IV on the wire</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+Defau=
lt ciphers in ``--data-ciphers``</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    Ciphers in ``--data-ciphers`` can contain the string DEFAU=
LT that is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    repla=
ced by the default ciphers used by OpenVPN, making it easier to</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    add an allowed cipher witho=
ut having to spell out the default ciphers.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+TLS alerts</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
OpenVPN 2.7 will send out TLS alerts to peers informing them if the TLS</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    session shuts down =
or when the TLS implementation informs the peer about</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    an error in the TLS session (e.g. mis=
matching TLS versions). This improves</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    the user experience as the client shows an error inst=
ead of running into</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    a timeout when the server just stops responding completely.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+Support for tun/tap via unix domain socket and lwi=
povpn support</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    To=
 allow better testing and emulating a full client with a full</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    network stack OpenVPN now all=
ows a program executed to provide</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    a tun/tap device instead of opening a device.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    The co-developed lwipovpn program based on lwI=
P stack allows to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  simulate full IP stack. An OpenVPN client using</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ``--dev-node unix:/path/to/lwipovpn`` can=
 emulate a full client that</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    can be pinged, can serve a website and more without requiring a=
ny</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    elevated perm=
ission. This can make testing OpenVPN much easier.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    For more details see [lwipovpn on Gihtub](https://github.co=
m/OpenVPN/lwipovpn).</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> Allow overriding username with ``--override-username``</=
span><br><span>     This is intended to allow using auth-gen-token in scena=
rios where the</span><br><span>     clients use certificates and multi-fact=
or authentication.  This will</span><br><span>     also generate a &#39;pus=
h &quot;auth-token-user newusername&quot;&#39; directives in</span><br><spa=
n>     push replies.</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+``--port-share`` now properly supports IPv6</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    Issues with logging of IPv6 =
addresses were fixed. The feature now allows</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    IPv6 connections towards the proxy receiver.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+Support for Haiku OS</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> Deprecated features</=
span><br><span> -------------------</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-``secret`` support has been removed by default.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+``secret`` support has been remov=
ed (by default).</span><br><span>     static key mode (non-TLS) is no longe=
r considered &quot;good and secure enough&quot;</span><br><span>     for to=
day&#39;s requirements.  Use TLS mode instead.  If deploying a PKI CA</span=
><br><span>     is considered &quot;too complicated&quot;, using ``--peer-f=
ingerprint`` makes</span><br><span>@@ -67,6 +126,14 @@</span><br><span>    =
 ``--allow-deprecated-insecure-static-crypto`` but will be removed in</span=
><br><span>     OpenVPN 2.8.</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+Support for wintun Windows driver has been remov=
ed.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OpenVPN 2.6 =
added support for the new dco-win driver, so it supported</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    three different device drivers: d=
co-win, wintun, and tap-windows6.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    OpenVPN 2.7 now drops the support for wintun driver. By d=
efault</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    all moder=
n configs should be supported by dco-win driver. In all</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    other cases OpenVPN will fall back =
automatically to tap-windows6</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    driver.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> NTLMv1 authentication support for HTTP proxies has been=
 removed.</span><br><span>     This is considered an insecure method of aut=
hentication that uses</span><br><span>     obsolete crypto algorithms.</spa=
n><br><span>@@ -78,28 +145,34 @@</span><br><span> ``persist-key`` option ha=
s been enabled by default.</span><br><span>     All the keys will be kept i=
n memory across restart.</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-Default for ``--topology`` changed to ``subnet`` for `=
`--mode server``</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    P=
revious releases always used ``net30`` as default. This only affects</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    configs with ``--mode se=
rver`` or ``--server`` (the latter implies the</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    former), and ``--dev tun``, and only if IPv4 i=
s enabled.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Note th=
at this changes the semantics of ``--ifconfig``, so if you have</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    manual settings for that in y=
our config but not set ``--topology``</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    your config might fail to parse with the new version. J=
ust adding</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``--top=
ology net30`` to the config should fix the problem.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    By default ``--topology`` is pushed fro=
m server to client.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-OpenSSL 1.0.2 support</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+OpenSSL 1.0.2 support=
 has been removed.</span><br><span>     Support for building with OpenSSL 1=
.0.2 has been removed. The minimum</span><br><span>     supported OpenSSL v=
ersion is now 1.1.0.</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-Compression on send</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+Support for mbedTLS older than 2.18.0 has been removed.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    We now require all=
 SSL libraries to have support for exporting</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    keying material. The only previously supported=
 library versions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  this affects are older mbedTLS releases.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+Compression on send has been removed.</span><br><span>     OpenVPN 2.7 =
will never compress data before sending. Decompression of</span><br><span> =
    received data is still supported.</span><br><span>     ``--allow-compre=
ssion yes`` is now an alias for</span><br><span>     ``--allow-compression =
asym``.</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> User-visible Changes</span><br><span> -------------=
-------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Default fo=
r ``--topology`` changed to ``subnet`` for ``--mode server``.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  Previous releases always used `=
`net30`` as default. This only affects</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  configs with ``--mode server`` or ``--server`` (the la=
tter implies the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  f=
ormer), and ``--dev tun``, and only if IPv4 is enabled.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  Note that this changes the semantics =
of ``--ifconfig``, so if you have</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  manual settings for that in your config but not set ``--top=
ology``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  your confi=
g might fail to parse with the new version. Just adding</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  ``--topology net30`` to the config sh=
ould fix the problem.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  By default ``--topology`` is pushed from server to client.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> - ``--x509-use=
rname-field`` will no longer automatically convert fieldnames to</span><br>=
<span>   uppercase. This is deprecated since OpenVPN 2.4, and has now been =
removed.</span><br><span> </span><br><span>@@ -108,6 +181,29 @@</span><br><=
span>   And finite field Diffie Hellman is in the proces of being deprecate=
d</span><br><span>   (see draft-ietf-tls-deprecate-obsolete-kex)</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+- ``--lport =
0`` does not imply ``--bind`` anymore.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
- ``--redirect--gateway`` now works correctly if the VPN remote is not</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  reachable by the defau=
lt gateway.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+- ``--show-gateway`` now su=
pports querying the gateway for IPv4 addresses.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+- ``--static-challenge`` option now has a third parameter ``format=
`` that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  can change=
 how password and challenge response should be combined.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+- ``--key`` and ``--cert`` now accept URIs implemented in=
 OpenSSL 3 as well as</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  optional OpenSSL 3 providers loaded using ``--providers`` option.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+- ``--cryptoapicert`` now supports issuer na=
me as well as Windows CA template</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  name or OID as selector string.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+- TLS handshake debugging information contains much more details  =
now when</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  using rec=
ent versions of OpenSSL.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- The ``IV_PLA=
T_VER`` variable sent by Windows clients now contains the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  full Windows build version to make =
it possible to determine the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  Windows 10 or Windows 11 version used.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> Overview of changes in 2.6<=
/span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D</span><br><span> </span><br><span>diff --git a/tests/=
unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am</span=
><br><span>index 471389b..fc47287 100644</span><br><span>--- a/tests/unit_t=
ests/openvpn/Makefile.am</span><br><span>+++ b/tests/unit_tests/openvpn/Mak=
efile.am</span><br><span>@@ -43,7 +43,7 @@</span><br><span> </span><br><spa=
n> argv_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/=
src/compat @TEST_CFLAGS@</span><br><span> argv_testdriver_LDFLAGS =3D @TEST=
_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl,--wrap=3Dparse_line</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-argv_testdriver_SOURCES =3D test_ar=
gv.c mock_msg.c mock_msg.h \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+argv_testdriver_SOURCES =3D test_argv.c mock_msg.c mock_msg.h test=
_common.h \</span><br><span> 	mock_get_random.c \</span><br><span> 	$(top_s=
rcdir)/src/openvpn/platform.c \</span><br><span> 	$(top_srcdir)/src/openvpn=
/buffer.c \</span><br><span>@@ -52,7 +52,7 @@</span><br><span> </span><br><=
span> buffer_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_src=
dir)/src/compat @TEST_CFLAGS@</span><br><span> buffer_testdriver_LDFLAGS =
=3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl,--wrap=3Dparse_line</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-buffer_testdriver_SOURCES =
=3D test_buffer.c mock_msg.c mock_msg.h \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+buffer_testdriver_SOURCES =3D test_buffer.c mock_msg.=
c mock_msg.h test_common.h \</span><br><span> 	mock_get_random.c \</span><b=
r><span> 	$(top_srcdir)/src/openvpn/win32-util.c \</span><br><span> 	$(top_=
srcdir)/src/openvpn/platform.c</span><br><span>@@ -61,7 +61,7 @@</span><br>=
<span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/=
src/openvpn \</span><br><span> 	@TEST_CFLAGS@</span><br><span> crypto_testd=
river_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-crypto_testdriver_SOURCES =3D test_crypto.c mock_msg.c mock_msg.=
h \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_testdrive=
r_SOURCES =3D test_crypto.c mock_msg.c mock_msg.h test_common.h \</span><br=
><span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span> 	$(top_srcdi=
r)/src/openvpn/crypto.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypt=
o_mbedtls.c \</span><br><span>@@ -78,7 +78,7 @@</span><br><span> 	-I$(top_s=
rcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</sp=
an><br><span> 	@TEST_CFLAGS@</span><br><span> ssl_testdriver_LDFLAGS =3D @T=
EST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-ssl_testdriver_SOURCES =3D test_ssl.c mock_msg.c mock_msg.h=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_testdriver_SO=
URCES =3D test_ssl.c mock_msg.c mock_msg.h test_common.h \</span><br><span>=
 	mock_management.c mock_ssl_dependencies.c mock_win32_execve.c \</span><br=
><span> 	$(top_srcdir)/src/openvpn/argv.c \</span><br><span> 	$(top_srcdir)=
/src/openvpn/base64.c \</span><br><span>@@ -114,7 +114,7 @@</span><br><span=
> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/o=
penvpn \</span><br><span> 	@TEST_CFLAGS@</span><br><span> packet_id_testdri=
ver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-packet_id_testdriver_SOURCES =3D test_packet_id.c mock_msg.c mock_=
msg.h \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+packet_id_te=
stdriver_SOURCES =3D test_packet_id.c mock_msg.c mock_msg.h test_common.h \=
</span><br><span> 	mock_get_random.c \</span><br><span> 	$(top_srcdir)/src/=
openvpn/buffer.c \</span><br><span> 	$(top_srcdir)/src/openvpn/otime.c \</s=
pan><br><span>@@ -128,7 +128,7 @@</span><br><span> 	-I$(top_srcdir)/include=
 -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span> =
	@TEST_CFLAGS@</span><br><span> pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-pkt_testdriver_SOURCES =
=3D test_pkt.c mock_msg.c mock_msg.h mock_win32_execve.c \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+pkt_testdriver_SOURCES =3D test_pkt.=
c mock_msg.c mock_msg.h mock_win32_execve.c test_common.h \</span><br><span=
> 	$(top_srcdir)/src/openvpn/argv.c \</span><br><span> 	$(top_srcdir)/src/o=
penvpn/base64.c \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer.c \</s=
pan><br><span>@@ -156,7 +156,7 @@</span><br><span> 	-Wl,--wrap=3Dbuffer_wri=
te_file \</span><br><span> 	-Wl,--wrap=3Dparse_line \</span><br><span> 	-Wl=
,--wrap=3Drand_bytes</span><br><span style=3D"color: hsl(0, 100%, 40%);">-t=
ls_crypt_testdriver_SOURCES =3D test_tls_crypt.c mock_msg.c mock_msg.h \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_crypt_testdriver_S=
OURCES =3D test_tls_crypt.c mock_msg.c mock_msg.h test_common.h \</span><br=
><span> 	mock_win32_execve.c \</span><br><span> 	$(top_srcdir)/src/openvpn/=
argv.c \</span><br><span> 	$(top_srcdir)/src/openvpn/base64.c \</span><br><=
span>diff --git a/version.m4 b/version.m4</span><br><span>index 091cc5d..4c=
3b7c8 100644</span><br><span>--- a/version.m4</span><br><span>+++ b/version=
.m4</span><br><span>@@ -3,7 +3,7 @@</span><br><span> define([PRODUCT_TARNAM=
E], [openvpn])</span><br><span> define([PRODUCT_VERSION_MAJOR], [2])</span>=
<br><span> define([PRODUCT_VERSION_MINOR], [7])</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-define([PRODUCT_VERSION_PATCH], [_git])</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+define([PRODUCT_VERSION_PATCH=
], [_alpha1])</span><br><span> m4_append([PRODUCT_VERSION], [PRODUCT_VERSIO=
N_MAJOR])</span><br><span> m4_append([PRODUCT_VERSION], [PRODUCT_VERSION_MI=
NOR], [[.]])</span><br><span> m4_append([PRODUCT_VERSION], [PRODUCT_VERSION=
_PATCH], [[]])</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1032?usp=3Demail">change 1032</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1032?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I80a14b77fcc2fabf51af9f2d5ea=
0c36362cccb91 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1032 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: selvanair &lt;selva.nair@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Caonh2dBo5A=--

