Message-ID: <4F4CE4FE.3010009@...515...>
Date: Tue, 28 Feb 2012 16:30:22 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070809040806020800020906"
Subject: [Openvpn-devel] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, "openvpn-announce@lists.sourceforge.net" <openvpn-announce@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------070809040806020800020906
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN
2.3-alpha1. It can be downloaded from here:

<http://openvpn.net/index.php/open-source/downloads.html>

This release includes a few new major features:

 * Complete IPv6 support, both transport and payload
 * Optional PolarSSL support (build time configuration)
 * Improved plug-in API (v3) which can more easily be expanded in the
   future: includes support for direct access to X.509 certificate data in
   plug-ins
 * Several improvements to the management interface
 * One-to-one NAT to circumvent IP address conflicts between local and
   remote networks
 * New OpenVPN-GUI

Note that a few changes have been made which may affect existing
installations. A list of new features and the changelog are available here:

<https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn23>

The changelog is also attached to this email.

For generic help use these support channels:

- Official documentation:
<http://openvpn.net/index.php/open-source/documentation/howto.html>
- Wiki: <https://community.openvpn.net>
- Forums: <https://forums.openvpn.net>
- User mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
- User IRC channel: #openvpn at irc.freenode.net

Please report bugs and ask development questions here:

- Bug tracker and Wiki: <https://community.openvpn.net>
- Developer mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
- Developer IRC channel: #openvpn-devel at irc.freenode.net (requires
  Freenode registration)

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock





--------------070809040806020800020906
Content-Type: text/plain;
 name="changelog-2.3-alpha1.txt"
Content-Disposition: attachment;
 filename="changelog-2.3-alpha1.txt"
Content-Transfer-Encoding: quoted-printable

2012.02.21 -- Version 2.3-alpha1
Adriaan de Jong (127):
      Added Doxygen doxyfile
      Changed configure to accept --with-ssl-type=3Dopenssl
      Refactored to rand_bytes for OpenSSL-independency
      Refactored OpenSSL-specific constants
      Refactored maximum cipher and hmac length constants
      Refactored show_available_* functions
      Refactored SSL_clear_error()
      Refactored crypto initialisation functions
      Refactored DES key manipulation functions
      Refactored NTLM DES key generation
      Refactored message digest type functions
      Refactored message digest functions
      Refactored HMAC functions
      Refactored cipher key types
      Refactored cipher functions
      Added PRNG doxygen
      Refactored: Moved crypto.h inline functions to end of file
      Removed stale OpenSSL defines from crypto.h
      Added a check for Openssl or PolarSSL defines
      Refactored: Added stubs for new files
      Refactored SSL initialisation functions
      Refactored TLS_PRF to new hmac and md primitives
      Refactored tls_show_available_ciphers
      Refactored get_highest_preference_tls_cipher
      Refactored root SSL context initialisation
      Refactored new external key code
      Refactored DH paramater loading
      Refactored root TLS option settings
      Refactored PKCS#12 key loading
      Refactored PKCS#11 loading
      Refactored windows cert loading
      Refactored load certificate functions
      Refactored private key loading code
      Refactored external key loading from management
      Refactored CA and extra certs code
      Refactored cipher restriction code
      Refactored tls_options, key_state, and key_source data structures
      Refactored initalisation of key_states
      Refactored key_state free code
      Refactored print_details
      Refactored key_state read code (including bio_read())
      Refactored key_state write functions
      Refactored: Moved BIO debug functions to OpenSSL backend
      Refactored: removed ks and ks_lame macro for clarity
      Refactored: moved write_empty_string function back
      Refactored Doxygen for tls_multi functions
      Migrated data structures needed by verification functions to ssl_co=
mmon.h
      Refactored client_config_dir_exclusive function
      Refactored certificate hash lock checks
      Refactored common name locking functions
      Refactored username and password authentication code
      Add some extra comments
      Refactored: split verify_callback into two parts
      Added function to extract and verify the subject from a certificate
      Added function to verify and extract the username
      Refactored: removed global x509_username_field
      Refactored: separated environment setup during verification
      Refactored: Netscape certificate type verification
      Refactored key usage verification code
      Refactored EKU verification
      Refactored tls-remote checking
      Refactored tls-verify-plugin code
      Refactored tls-verify script code
      Refactored CRL checks
      Minor cleanup in verify_cert:
      Refactored: Moved verify_cert to ssl_verify
      Cleaned up ssl.h
      Refactored: made M_SSL dependent on USE_OPENSSL
      Refactored: renamed X509 functions from verify_*
      Separated OpenSSL-specific parts of the PKCS#11 driver
      Modified base64 code in preparation for PolarSSL merge
      Final cleanup before PolarSSL addition:
      Refactored X509 track feature to be contained within the openssl ba=
ckend
      Added PolarSSL support:
      Fixed a missing include in ssl_backend.h
      Fixed a bug in the hash generation in ssl_verify_openssl.c
      Added SHA_DIGEST_SIZE definition
      Changed PolarSSL crypto backend to support v0.99-pre5
      Updated ssl_polarssl.c to work with 0.99-pre5
      Fixed a compilation warning for size_t key sizes
      Added a warning that the PolarSSL library does not support pkcs12 f=
iles.
      Added warning that --capath is not available with PolarSSL
      Disable CryptoAPI when not using OpenSSL, and document that fact.
      Removed support for management external keys in PolarSSL
      Removed stray X509_free from ssl.c
      Refactored (and disabled for PolarSSL) support for writing external=
 cert files in scripts
      Added an extra define to allow building without PKCS#11
      Added SSL library to title string
      Disabled X.509 track and username selection for PolarSSL
      Hardening: periodically reset the PRNG's nonce value
      Fixes for the plugin system:
      Further improvements to plugin support:
      Fixed an unintentional change in the options calculated key size.
      Moved print messages back to generic crypto.c from cipher backends
      Moved HMAC prints back to main crypto module
      Added back checks for ks->authenticated in verify_user_pass
      Moved gc_new and gc_free to begin end of function
      Fixed a bug in the return value of ssl_verify when pre_verify faile=
d
      Unified verification function return values:
      Removed a stray Fox-IT tag
      Fixed a typo: print the subject instead of the serial for verificat=
ion errors
      Made SSL_CIPHER const in print_details, to fix warning
      Moved to PolarSSL 1.0.0:
      Added missing #ifdef to allow --disable-managent to work again
      Fixed disabling crypto and SSL
      Got rid of a few magic numbers in ntlm.c
      Removed obsolete des_cblock and des_keyschedule
      Further removal of des_old.h based calls
      Fixed missing comma in plugin.h
      Moved prng_uninit out of crypto_uninit_lib
      Moved CryptoAPI header include to the ssl_openssl.c
      Reordered functions to ensure warning-free Windows build
      Added options to switch between OpenSSL and PolarSSL and PKCS11...
      Moved from strsep to strtok, for Windows compatibility
      Minor cleanup to enable warning-free Windows build:
      Fixed a typo when initialising cryptoapi certs
      Minor code cleanup: cleaned up error handling in verify_cert.
      Moved out of memory prototype to error.h, as the definition is in e=
rror.c
      Removed support for calling gc_malloc with a NULL gc_arena struct

      (The follwing patches from Adriaan was mistakenly merged with
       the wrong commit author in the git tree)
      Doxygen: Added data channel crypto docs
      Added control channel crypto docs
      Added compression docs
      Added reliability layer documentation
      Added memory management documentation
      Added data channel fragmentation docs
      Added main/control docs
      Moved doxygen-specific files to a separate directory

Byron Ellacott (1):
      autoconf fixes for building on OSX

David Sommerseth (50):
      Provide 'dev_type' environment variable to plug-ins and script hook=
s
      Define the new openvpn_plugin_{open,func}_v3() API
      Implement the core v3 plug-in function calls.
      Extend the v3 plug-in API to send over X509 certificates
      Added a simple plug-in demonstrating the v3 plug-in API.
      Separate the general plug-in version constant and v3 plug-in struct=
s version
      Use a version-less version identifier on the master branch
      Fix the --client-cert-not-required feature
      Change the default --tmp-dir path to a more suitable path
      Improve the mysprintf() issue in openvpnserv.c
      Add a simple comment regarding openvpn_snprintf() is duplicated
      Merge branch 'feat_ipv6_transport'
      Merge branch 'feat_ipv6_payload'
      Merge branch 'svn-branch-2.1' into merge
      Solved hidden merge conflicts between master and svn-branch-2.1
      Fix const declarations in plug-in v3 structs
      Merge remote-tracking branch 'cron2/feat_ipv6_payload_2.3'
      Don't define ENABLE_PUSH_PEER_INFO if SSL is not available
      Fix compiling issues with pkcs11 when --disable-management is confi=
gured
      Remove support for Linux 2.2 configuration fallback
      Revert "Add new openssl.cnf to easy-rsa/Windows"
      Merge remote branch SVN 2.1 into the git tree
      Merge branch 'svn-merger'
      Fix Microsoft Visual Studio incompatibility in plugin.c
      Fixed compile issues on FreeBSD and Solaris
      Fix PolarSSL and --pkcs12 option issues
      Fix FreeBSD/OpenBSD/NetBSD compiler warnings in get_default_gateway=
()
      Make '--win-sys env' default
      Do some file/directory tests before really starting openvpn
      Fix bug after removing Linux 2.2 support
      Don't look for 'stdin' file when using --auth-user-pass
      Fix compiling with --disable-crypto and/or --disable-ssl
      Fix a couple of issues in openvpn_execve()
      Move away from openvpn_basename() over to platform provided basenam=
e()
      Enable access() when building in Visual Studio
      New Windows build fixes
      Fix compilation errors on Linux platforms without SO_MARK
      autotools ./configure don't like compat.h
      Fix pool logging when IPv6 is not enabled
      Don't check for file presence on inline files
      Add --route-pre-down/OPENVPN_PLUGIN_ROUTE_PREDOWN script/plug-in ho=
ok
      Enhance the error handling in _openssl_get_subject()
      Fix assert() situations where gc_malloc() is called without a gc_ar=
ena object
      Fix compile issues when plug-ins are disabled.
      Remove --show-gateway if debug info is not enabled (--disable-debug=
)
      Fix compile issues with status.c
      Connection entry {tun,link}_mtu_defined not set correctly
      Makefile.am referenced a now non-existing config-win32.h
      Makefile.am was missing ssl_common.h
      Revamp check_file_access() checks in stdin scenarios

Davide Guerri (1):
      New feauture: Add --stale-routes-check

Frank de Brabander (1):
      Fixed wrong return type of cipher_kt_mode

Frederic Crozat (1):
      Add support to forward console query to systemd

Gert Doering (45):
      Add more detailed explanation regarding the function of "--rdns-int=
ernal"
      Enable IPv6 Payload in OpenVPN p2mp tun server mode.  20100104-1 re=
lease.
      remove NOTES file from commit - private scribbling
      NetBSD fixes - on 4.0 and up, use multi-af mode.
      new feature: "ifconfig-ipv6-push" (from ccd/ config)
      add some TODOs to TODO.IPv6
      undo accidential duplication of existing "--iroute" line in the hel=
p text
      basic documentation of IPv6 related options and their syntax
      Enable IPv6 Payload in OpenVPN p2mp tun server mode.
      remove NOTES file from commit - private scribbling
      env_block(): if PATH is not set, add standard PATH setting to env
      add IPv6 route add / route delete code for windows (using "netsh")
      - Win32 IPv6 ifconfig support, using "netsh" calls
      drop "book ipv6" from open_tun() and tuncfg() prototypes
      document recent changes and open TODOs, adapt --version info, tag r=
elease
      Win32: set next-hop for IPv6 routes according to TUN/TAP mode
      when deleting a route on win32, also add gateway address
      WIN32: if IPv6 requested in TUN mode, check if TUN/TAP driver < 9.7
      revert unconditionally-enabling of setenv_es() logging
      implement IPv6 ifconfig + route setup/deletion on OpenBSD
      full "VPN client connect" test framework for OpenVPN t_client.rc-sa=
mple
      renamed t_client.sh to t_client.sh.in
      2.2-beta3 has a signed TAP driver with the IPv6 code - test for 9.8
      correct URL for "more information about IPv6 patch is *here*"
      bugfix for linux/iproute2: IPv6 ifconfig code block was not called =
for "dev tun"+"topology subnet"
      bump IPv6 version number (openvpn --version) to 20100922-1
      Implement "ipv6 ifconfig" for TAP interfaces on Solaris interfaces
      rebased to 2.2RC2 (beta 2.2 branch)
      Windows IPv6 cleanup - properly remove IPv6 routes and interface co=
nfig
      For all accesses to "struct route_list * rl", check first that rl i=
s non-NULL
      Replace 32-bit-based add_in6_addr() implementation by an 8-bit base=
d one
      Platform cleanup for NetBSD
      Move block for "stale-routes-check" config inside #ifdef P2MP_SERVE=
R block
      add missing break between "case IPv4" and "case IPv6"
      bump tap driver version from 9.8 to 9.9
      log error message and exit for "win32, tun mode, tap driver version=
 9.8"
      work around inet_ntop/inet_pton problems for MSVC builds on WinXP
      Fix build-up of duplicate IPv6 routes on reconnect.
      Fix list-overrun checks in copy_route_[ipv6_]option_list()
      add "print test titles" and "use sudo" functionality to t_client.rc
      Platform cleanup for FreeBSD
      Implement IPv6 interface config with non-/64 prefix lengths.
      Fix RUN_SUDO functionality for t_client.sh
      Document IPv6-related environment variables.
      Platform cleanup for OpenBSD

Gisle Vanem (1):
      Avoid re-defining uint32_t when using mingw compiler

Gustavo Zacarias (1):
      Fix compile issues when using --enable-small and --disable-ssl/--di=
sable-crypto

Heiko Hund (16):
      add .gitignore to official repository
      remove function is_proto_tcp()
      remove legacy code to query IE proxy information
      lowercase include header name in syshead.h
      define IN6_ARE_ADDR_EQUAL macro for WIN32
      add --mark option to set SO_MARK sockopt
      Windows UTF-8 input/output
      UTF-8 X.509 distinguished names
      set Windows environment variables as UCS-2
      handle Windows unicode paths
      replace check for TARGET_WIN32 with WIN32
      do not use mode_t on Windows
      use the underscore version of stat on Windows
      make MSVC link against shell32 as well
      move variable declaration to top of function
      define access mode flag X_OK as 0 on Windows

Igor Novgorodov (1):
      The code blocks enabled by ENABLE_CLIENT_CR depends on management

James Yonan (57):
      Added "management-external-key" option.
      Minor addition of logging info before and after execution of Window=
s net commands.
      Misc fixes to r6708.
      Added --x509-track option.
      * added --management-up-down option to allow management interface t=
o be notified of tunnel up/down events.
      Fixed minor compile issue triggered on builds where MANAGEMENT_DEF_=
AUTH is not enabled.
      Implemented get_default_gateway_mac_addr for Mac OS X
      Fixes to r6925.
      Properly handle certificate serial numbers > 32 bits.
      Added "client-nat" option for stateless, one-to-one NAT on the clie=
nt side.
      Renamed branch to reflect that it is no longer beta.
      env_filter_match now includes the serial number of all certs
      Fixed issue where a client might receive multiple push replies from=
 a server
      Fixed bug introduced in r7031 that might cause this error message:
      Extended "client-kill" management interface command (server-side)
      Client will now try to reconnect if no push reply received within h=
andshake-window seconds.
      Version 2.1.3n
      Fixed compiling issues when using --disable-crypto
      Added "management-external-key" option.
      Misc fixes to r6708.
      win/sign.py now accepts an optional tap-dir argument.
      Added "auth-token" client directive
      Added ./configure --enable-osxipconfig option for Mac OS X
      Added more packet ID debug info at debug level 3 for debugging fals=
e positive packet replays.
      Fixed bug that incorrectly placed stricter TCP packet replay rules =
on UDP sessions
      Fixed bug in port-share that could cause port share process to cras=
h
      For Mac OSX, when DARWIN_USE_IPCONFIG is defined, retry ipconfig co=
mmand on failure
      Version 2.1.3t
      Revert r7092 and r7151, i.e. remove --enable-osxipconfig configure =
option.
      Added 'dir' flag to "crl-verify" (see man page for info).
      Added new "extra-certs" and "verify-hash" options
      Fixed compile issues on Windows.
      Added --enable-lzo-stub configure option to build an OpenVPN client=
 without LZO
      Added optional journal directory argument to "port-share" directive
      Reduce log verbosity at level 3, with a focus on removing excessive=
 log verbosity generated by port-share activity.
      env_filter_match now includes the serial number of all certs in cha=
in
      Added support for static challenge/response protocol.
      r7316 fixes.
      Added redirect-gateway block-local flag, with support for Linux, Ma=
c OS X
      Extended x509-track to allow SHA1 certificate hash to be extracted
      Added "management-query-remote" directive (client) to allow the man=
agement interface to override the "remote" directive.
      Version 2.1.5.
      Fixed MSVC compile error related to r7408.
      Redact "echo" directive strings from log, since these strings (goin=
g forward) could conceivably contain security-sensitive data.
      Modified sanitize_control_message to remove redacted data from cont=
rol string rather than blotting it out with "_" chars.
      Changed CC_PRINT character class to allow UTF-8 chars.
      Increased the --verb threshold for "PID_ERR replay" messages to 4 f=
rom 3.
      Fixed issue where redirect-gateway block-local code was not correct=
ly calculating...
      CC_PRINT character class now allows any 8-bit character value >=3D =
32.
      "status" management interface command (version >=3D 2) will now inc=
lude the username for each connected user.
      Minor fix to CC_PRINT char class
      Fixed management interface bug where >FATAL notifications were not =
being output properly
      Raised D_PID_DEBUG_LOW from level 3 to 4 to reduce replay error ver=
bosity at level 3.
      Added "memstats" option to maintain real-time operating stats in a =
memory-mapped file.
      Fixed client issues with DHCP Router option extraction/deletion whe=
n using layer 2 with DHCP proxy:
      Allow "tap-win32 dynamic <offset>" to be used in topology subnet mo=
de.
      Added support for "on-link" routes on Linux client

Jan Just Keijser (1):
      Made some options connection-entry specific

Joe Patterson (1):
      common_name passing in auth_pam plugin

JuanJo Ciarlante (40):
      * rebased openvpn-2.1_rc1b.jjo.20061206.d.patch
      * created getaddr6(), use it from resolve_remote()
      * migrated all getaddrinfo() to getaddr6
      * socket.c: use USE_PF_INET6 in switch constructs to actually toss =
them out,
      * support --disable-ipv6 build properly:
      * important fix for tcp6 reconnection was incorrectly creating a PF=
_INET socket
      * added README.ipv6.txt
      * fixed win32 non-ipv6 build
      * ipv6 on win32 "milestone": 1st snapshot that passes all unittests
      * document ipv6 milestone status
      * doc update w/unittests results
      * make possible to x-compile openvpn/win32 in Linux
      * correctly setup hints.ai_socktype for getaddrinfo(), althought so=
rta hacky, see TODO.ipv6.
      * renamed README.ipv6{.txt,}
      * updated {README,TODO}.ipv6 from feedback at openvpn-devel mlist
      * init.c: document the ENABLE_MANAGEMENT place to work on
      * init.c: small in-doc tweaks
      * fix multi-tcp crash (corrected assertion)
      * TODO.ipv6 update
      * socket.c: better buf logic in print_sockaddr_ex
      * fixed segfault for undef address family in print_sockaddr_ex (tha=
nks Marcel!)
      * doc updates
      * openbsd: no IFF_MULTICAST, #ifdef around it
      * no new funcionality, just small cleanups
      * (prototype) fix for supporting "redirect-gateway" for tunneled ip=
v4 over ipv6 endpoints
      * polished redirect-gateway (ipv4 on ipv6 endpoints) support
      * updated doc
      * fix --disable-ipv6 build
      * doc updates
      * rebased to v2.1.1 release
      * undo mroute.c changes related to ipv6 payload
      * fix --multihome for ipv4
      * fix --multihome for ipv6
      * ipv6-0.4.14: fix xinetd usage
      * ipv6-0.4.15: add --multihome support to xBSD
      * ipv6-0.4.15b: rebase over openvpn-testing-master
      * ipv6-0.4.16: fix mingw32 build
      * make ipv6_payload compile under windowze
      USE_PF_INET6 by default for v2.3
      fix ipv6 compilation under macosx >=3D 1070 - v3

Markus Koetter (1):
      Add extv3 X509 field support to --x509-username-field

Matthew L. Creech (1):
      Fix 2.2.0 build failure when management interface disabled

Matthias Andree (1):
      Skip rather than fail test in addressless FreeBSD jails.

Robert Fischer (8):
      Update man page with info about --capath
      Update man page with info about --connect-timeout
      Added info about --show-proxy-settings
      Documented --x509-username-field option
      Documented --errors-to-stderr option
      Documented --push-peer-info option
      Update man page with info about --remote-random-hostname
      Added man page entry for --management-client

Samuli Sepp=C3=A4nen (19):
      Add man page entry for --redirect-private
      Change all CRLF linefeeds to LF linefeeds
      Fix a bug in devcon source code handling
      Removed Win2k from supported platforms list in INSTALL and win/open=
vpn.nsi
      Fixed copying of tapinstall.exe to dist/bin when using prebuilt TAP=
-drivers
      Fixed a bug with GUI icon deletion on upgrade from 2.2-RC or earlie=
r
      Fix a build-ca issue on Windows
      Add new openssl.cnf to easy-rsa/Windows
      Updated "easy-rsa" for OpenSSL 1.0.0
      Made domake-win builds to use easy-rsa/2.0/openssl-1.0.0.cnf
      Fixes to easy-rsa/2.0
      Merged TODO.IPv6 with TODO.ipv6 and README.IPv6 with README.ipv6
      Fixed a number of fatal build errors on Visual Studio 2008
      Fix a Visual Studio 2008 build issue in socket.c
      Additional Visual Studio 2008 build fixes to tun.c
      Fixed a typo in win32.h that prevented building with Visual Studio
      Fixed a regression causing VS2008/Python build failure
      Fix a Visual Studio 2008 build error in tun.c
      Fix a Visual Studio 2008 build error in options.c

Simon Matter (1):
      Fix issues with some older GCC compilers

Stefan Hellermann (2):
      plugin.h: update prototype of plugin_call dummy in !ENABLE_PLUGIN c=
ase
      Fixed typo in plugin.h

chantra (1):
      Clarify --tmp-dir option

smos (1):
      Change the netsh.exe command from "add" to "set".



--------------070809040806020800020906--

