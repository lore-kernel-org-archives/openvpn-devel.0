References: <1cfa91c6-2c77-1d82-812b-269c941eba4d@...2489...>
 <289bfe02fdabee00b91b555e7e5759f9.squirrel@...2260...>
From: Jonathan Tooker <jonathan@...2489...>
Message-ID: <14dd534e-1ef3-8fa0-977e-8cbfff6a84ea@...2489...>
Date: Tue, 22 Jan 2019 23:15:37 -0600
MIME-Version: 1.0
In-Reply-To: <289bfe02fdabee00b91b555e7e5759f9.squirrel@...2260...>
Content-Type: multipart/alternative;
 boundary="------------BB7CAB6D03F6089F98A9C6D0"
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Fix various spelling mistakes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------BB7CAB6D03F6089F98A9C6D0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Looks like I missed that and a few others! I fixed some more spelling
errors across other things. Follow up patch/commit below. If I just need
to re-make the original patch let me know.

From: Jonathan Tooker <jonathan@...2489...>
Date: Tue, 22 Jan 2019 23:10:33 -0600
Subject: [PATCH] Another set of spelling fixes

---
 COPYING                          |   6 +-
 ChangeLog                        | 140 +++++++++++++++----------------
 Changes.rst                      |   6 +-
 INSTALL                          |   2 +-
 TODO.IPv6                        |   6 +-
 configure.ac                     |   2 +-
 m4/pkg.m4                        |   2 +-
 src/openvpn/console.h            |   2 +-
 src/openvpn/ssl_verify_backend.h |   2 +-
 9 files changed, 84 insertions(+), 84 deletions(-)

diff --git a/COPYING b/COPYING
index 9c21c177..54cc9f24 100644
--- a/COPYING
+++ b/COPYING
@@ -157,7 +157,7 @@ OpenSSL License:
  * The implementation was written so as to conform with Netscapes SSL.
  * 
  * This library is free for commercial and non-commercial use as long as
- * the following conditions are aheared to.  The following conditions
+ * the following conditions are adhered to.  The following conditions
  * apply to all code found in this distribution, be it the RC4, RSA,
  * lhash, DES, etc., code; not just the SSL code.  The SSL documentation
  * included with this distribution is covered by the same copyright terms
@@ -182,7 +182,7 @@ OpenSSL License:
  *    must display the following acknowledgement:
  *    "This product includes cryptographic software written by
  *     Eric Young (eay@...2490...)"
- *    The word 'cryptographic' can be left out if the rouines from the library
+ *    The word 'cryptographic' can be left out if the routines from the library
  *    being used are not cryptographic related :-).
  * 4. If you include any Windows specific code (or a derivative thereof) from 
  *    the apps directory (application code) you must include an acknowledgement:
@@ -200,7 +200,7 @@ OpenSSL License:
  * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
  * SUCH DAMAGE.
  * 
- * The licence and distribution terms for any publically available version or
+ * The licence and distribution terms for any publicly available version or
  * derivative of this code cannot be changed.  i.e. this code cannot simply be
  * copied and put under another distribution licence
  * [including the GNU Public Licence.]
diff --git a/ChangeLog b/ChangeLog
index 1c06c7f1..077d7063 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -128,7 +128,7 @@ Gert Doering (10):
 
 Heiko Hund (4):
       put argv_* functions into own file, add unit tests
-      Remove unused and unecessary argv interfaces
+      Remove unused and unnecessary argv interfaces
       remove unused system_str from struct argv
       Factor out %sc handling from argv_printf()
 
@@ -230,7 +230,7 @@ Arne Schwabe (100):
       Split the PROTO_UDP_xx options into AF_INET/AF_INET6 and PROTO_TCP/PROTO_UDP part.
       Fix two instances of asserting AF_INET
       Fix assertion when SIGUSR1 is received while getaddrinfo is successful
-      Split link_socket_init_phase1 and link_socket_init_phase2 into smaller more managable/readable functions. No functional changes
+      Split link_socket_init_phase1 and link_socket_init_phase2 into smaller more manageable/readable functions. No functional changes
       Change proto_remote() function to return a constant string
       Remove the ip-remote-hint option.
       change the type of 'remote' to addrinfo*, and rename to 'remote_list'.
@@ -252,7 +252,7 @@ Arne Schwabe (100):
       Add gateway and device to android control messages
       Clean up of socket code.
       Fix assert when using port-share
-      Work around Solaris getaddrinfo() returing ai_protocol=0
+      Work around Solaris getaddrinfo() returning ai_protocol=0
       Fix man page and OSCP script: tls_serial_{n} is decimal
       Remove ENABLE_BUFFER_LIST
       Fix server routes not working in topology subnet with --server [v3]
@@ -335,7 +335,7 @@ David Sommerseth (44):
       autoconf: Fix typo
       t_client.sh: Check for fping/fping6 availability
       t_client.sh: Write errors to stderr and document requirements
-      t_client.sh: Add prepare/cleanup possibilties for each test case
+      t_client.sh: Add prepare/cleanup possibilities for each test case
       Fix file checks when --chroot is being used
       Adjusted autotools files to build more cleanly on newer autoconf/automake versions
       Improve error reporting on file access to --client-config-dir and --ccd-exclusive
@@ -382,7 +382,7 @@ Dorian Harmans (1):
       Add CHACHA20-POLY1305 ciphersuite IANA name translations.
 
 Felix Janda (1):
-      Use OPENVPN_ETH_P_* so that <netinet/if_ether.h> is unecessary
+      Use OPENVPN_ETH_P_* so that <netinet/if_ether.h> is unnecessary
 
 Fish (1):
       Add lz4 support to MSVC.
@@ -531,7 +531,7 @@ Holger Kummert (1):
       Del ipv6 addr on close of linux tun interface
 
 Hubert Kario (2):
-      ocsp_check - signature verification and cert staus results are separate
+      ocsp_check - signature verification and cert status results are separate
       ocsp_check - double check if ocsp didn't report any errors in execution
 
 Ilya Shipitsin (3):
@@ -796,7 +796,7 @@ Steffan Karger (180):
       Don't exit daemon if opening or parsing the CRL fails.
       Define dummy SSL_OP_NO_TICKET flag if not present in OpenSSL.
       Fix typo in cipher_kt_mode_{cbc, ofb_cfb}() doxygen.
-      Fix some unintialized variable warnings
+      Fix some uninitialized variable warnings
       Fix clang warning in options.c
       Fix compiler warnings in ssl_polarssl.c.
       Fix regression with password protected private keys (polarssl)
@@ -1181,7 +1181,7 @@ Adriaan de Jong (127):
       Refactored get_highest_preference_tls_cipher
       Refactored root SSL context initialisation
       Refactored new external key code
-      Refactored DH paramater loading
+      Refactored DH parameter loading
       Refactored root TLS option settings
       Refactored PKCS#12 key loading
       Refactored PKCS#11 loading
@@ -1192,7 +1192,7 @@ Adriaan de Jong (127):
       Refactored CA and extra certs code
       Refactored cipher restriction code
       Refactored tls_options, key_state, and key_source data structures
-      Refactored initalisation of key_states
+      Refactored initialisation of key_states
       Refactored key_state free code
       Refactored print_details
       Refactored key_state read code (including bio_read())
@@ -1275,7 +1275,7 @@ Adriaan de Jong (127):
       Moved out of memory prototype to error.h, as the definition is in error.c
       Removed support for calling gc_malloc with a NULL gc_arena struct
 
-      (The follwing patches from Adriaan was mistakenly merged with
+      (The following patches from Adriaan was mistakenly merged with
        the wrong commit author in the git tree)
       Doxygen: Added data channel crypto docs
       Added control channel crypto docs
@@ -1342,7 +1342,7 @@ David Sommerseth (50):
       Revamp check_file_access() checks in stdin scenarios
 
 Davide Guerri (1):
-      New feauture: Add --stale-routes-check
+      New feature: Add --stale-routes-check
 
 Frank de Brabander (1):
       Fixed wrong return type of cipher_kt_mode
@@ -1357,7 +1357,7 @@ Gert Doering (45):
       NetBSD fixes - on 4.0 and up, use multi-af mode.
       new feature: "ifconfig-ipv6-push" (from ccd/ config)
       add some TODOs to TODO.IPv6
-      undo accidential duplication of existing "--iroute" line in the help text
+      undo accidental duplication of existing "--iroute" line in the help text
       basic documentation of IPv6 related options and their syntax
       Enable IPv6 Payload in OpenVPN p2mp tun server mode.
       remove NOTES file from commit - private scribbling
@@ -1502,7 +1502,7 @@ JuanJo Ciarlante (40):
       * document ipv6 milestone status
       * doc update w/unittests results
       * make possible to x-compile openvpn/win32 in Linux
-      * correctly setup hints.ai_socktype for getaddrinfo(), althought sorta hacky, see TODO.ipv6.
+      * correctly setup hints.ai_socktype for getaddrinfo(), although sorta hacky, see TODO.ipv6.
       * renamed README.ipv6{.txt,}
       * updated {README,TODO}.ipv6 from feedback at openvpn-devel mlist
       * init.c: document the ENABLE_MANAGEMENT place to work on
@@ -1645,7 +1645,7 @@ Samuli Seppänen (15):
       Added a nmake makefile for openvpnserv.exe building
       Moved TAP-driver version info to version.m4. Cleaned up win/settings.in.
       Added helper functionality to win/wb.py
-      Added support for viewing config-win32.h paramters to win/show.py
+      Added support for viewing config-win32.h parameters to win/show.py
       Added comments and made small modifications to win/msvc.mak.in
       Added command-line switch to win/build_all.py to skip TAP driver building
       Added configure.h and version.m4 variable parsing to win/config.py
@@ -1712,7 +1712,7 @@ Samuli Seppänen (2):
 
 * Community patches
   David Sommerseth (2):
-      Test framework improvment - Do not FAIL if t_client.rc is missing
+      Test framework improvement - Do not FAIL if t_client.rc is missing
       More t_client.sh updates - exit with SKIP when we want to skip
 
   Gert Doering (4):
@@ -1872,7 +1872,7 @@ Samuli Seppänen (2):
   renegotiation capabilities that are built into the SSL/TLS protocol,
   therefore the fix in OpenSSL 0.9.8l (disable SSL/TLS renegotiation
   completely) will not adversely affect OpenVPN mid-session SSL/TLS
-  renegotation or any other OpenVPN capabilities.
+  renegotiation or any other OpenVPN capabilities.
 
 * Added additional session renegotiation hardening.  OpenVPN has always
   required that mid-session renegotiations build up a new SSL/TLS
@@ -1921,7 +1921,7 @@ Samuli Seppänen (2):
 
 * Added the ability for the server to provide a custom reason string
   when an AUTH_FAILED message is returned to the client.  This
-  string can be set by the server-side managment interface and read
+  string can be set by the server-side management interface and read
   by the client-side management interface.
 
 * client-kill management interface command, when issued on server, will
@@ -1966,7 +1966,7 @@ Samuli Seppänen (2):
 * Minor tweaks to Windows build system.
 
 * Added "redirect-private" option which allows private subnets
-  to be pushed to the client in such a way that they don't accidently
+  to be pushed to the client in such a way that they don't accidentally
   obscure critical local addresses such as the DHCP server address and
   DNS server addresses.
 
@@ -1993,7 +1993,7 @@ Samuli Seppänen (2):
   functionality (Alon Bar-Lev).
 
 * Fixed bug where the remote_X environmental variables were not being
-  set correctly when the 'local' option is specifed.
+  set correctly when the 'local' option is specified.
 
 2009.05.17 -- Version 2.1_rc16
 
@@ -2396,7 +2396,7 @@ Samuli Seppänen (2):
   files might elicit the error: "Options error: Parameter pkcs11_private_mode
   can only be specified in TLS-mode, i.e. where --tls-server or --tls-client
   is also specified."
-	
+      
 2008.01.23 -- Version 2.1_rc5
 
 * Fixed Win2K TAP driver bug that was introduced by Vista fixes,
@@ -2469,7 +2469,7 @@ Samuli Seppänen (2):
 
 * Added --management-forget-disconnect option -- forget
   passwords when management session disconnects (Alon Bar-Lev).
-	
+      
 2007.04.25 -- Version 2.1_rc4
 
 * Worked out remaining issues with TAP driver signing
@@ -2484,7 +2484,7 @@ Samuli Seppänen (2):
 * Additional fixes to TAP driver for Windows x64.  Driver
   now runs successfully on Vista x64 if driver signing
   enforcement is disabled.
-	
+      
 * The Windows Installer and TAP driver are now signed by
   OpenVPN Solutions LLC (in addition to the usual GnuPG
   signatures).
@@ -2502,7 +2502,7 @@ Samuli Seppänen (2):
   with password-protected keys; also add -extensions server
   option when generating server cert via
   build-key-server-pass.bat (Daniel Zauft).
-	
+      
 2007.02.27 -- Version 2.1_rc2
 
 * auth-pam change:  link with -lpam rather
@@ -2581,10 +2581,10 @@ Samuli Seppänen (2):
 
 * Fixed TAP-Win32 bug that caused BSOD on Windows Vista
   (Henry Nestler).
-	
+      
 * Autodetect 32/64 bit Windows in installer and install
   appropriate TAP driver (Mathias Sundman, Hypherion).
-	
+      
 * Fixed bug in loopback self-test introduced
   in 2.1-beta15 where self test as invoked by
   "make check" would not properly exit after
@@ -2608,7 +2608,7 @@ Samuli Seppänen (2):
 * PKCS#11 changes: (Alon Bar-Lev) 
   - Modified ssl.c to not FATAL and return to init.c
     so auth-retry will work.
-  - Modifed pkcs11-helper.c to fix some problem with
+  - Modified pkcs11-helper.c to fix some problem with
     multiple providers.
   - Added retry counter to PKCS#11 PIN hook.
   - Modified PKCS#11 PIN retry loop to return correct error
@@ -2645,10 +2645,10 @@ Samuli Seppänen (2):
 
 * Fixed Windows server bug in time backtrack handling code which
   could cause TLS negotiation failures on legitimate clients.
-	
+      
 * Rewrote gettimeofday function for Windows to be
   simpler and more efficient.
-	
+      
 * Merged PKCS#11 extensions to easy-rsa/2.0  (Alon Bar-Lev).
 
 * Added --route-metric option to set a default route metric
@@ -2662,7 +2662,7 @@ Samuli Seppänen (2):
 * Code added in 2.1-beta7 and 2.0.6-rc1 to extend byte counters
   to 64 bits caused a bug in the Windows version which has now
   been fixed.  The bug could cause intermittent crashes.
-	
+      
 2006.04.05 -- Version 2.1-beta12
 
 * Security Vulnerability -- An OpenVPN client connecting to a
@@ -2674,7 +2674,7 @@ Samuli Seppänen (2):
   directives to it by including "pull" or the macro "client" in
   its configuration file, (b) the client configuration file uses
   a scripting directive such as "up" or "down", (c) the client
-  succesfully authenticates the server, (d) the server is
+  successfully authenticates the server, (d) the server is
   malicious or has been compromised and is under the control of
   the attacker, and (e) the attacker has at least some level of
   pre-existing control over files on the client (this might be
@@ -2691,7 +2691,7 @@ Samuli Seppänen (2):
 
 * PKCS11 fixes (Alon Bar-Lev).  For full description:
   svn log -r990 http://svn.openvpn.net/projects/openvpn/branches/BETA21
-	
+      
 * When deleting routes under Linux, use the route metric
   as a differentiator to ensure that the route teardown
   process only deletes the identical route which was originally
@@ -2759,7 +2759,7 @@ Samuli Seppänen (2):
   which tries IP helper API first, then falls back to
   route.exe.
 * Made --route-method adaptive the default.
-	
+      
 2005.11.12 -- Version 2.1-beta7
 
 * Allow blank passwords to be passed via the management
@@ -2783,7 +2783,7 @@ Samuli Seppänen (2):
   reference an explicit file.
   For example:
   <ca>
-	data here...
+      data here...
   </ca>
 * Allow plugin and push directives to have multi-line
   parameter lists such as:
@@ -2801,7 +2801,7 @@ Samuli Seppänen (2):
   attributes (Alon Bar-Lev).
 * For Windows, reverted --ip-win32 default back to "dynamic".
   To use new adaptive mode, set explicitly.
-	
+      
 2005.11.01 -- Version 2.1-beta6
 
 * Security fix (merged from 2.0.4) -- Affects non-Windows
@@ -2860,7 +2860,7 @@ Samuli Seppänen (2):
 * Added ".PHONY: plugin" to Makefile.am, reverted
   location of "plugin" directory (thanks to
   Matthias Andree for figuring this out).
-	
+      
 2005.10.16 -- Version 2.1-beta3
 
 * Added PKCS#11 support (Alon Bar-Lev).
@@ -2928,7 +2928,7 @@ Samuli Seppänen (2):
   per-client constructor and destructor functions, to make
   it simpler for plugins to maintain per-client state.
 
-2005.09.25 -- Version 2.0.3-rc1	
+2005.09.25 -- Version 2.0.3-rc1     
 
 * openvpn_plugin_abort_v1 function wasn't being properly
   registered on Windows.
@@ -2956,7 +2956,7 @@ Samuli Seppänen (2):
 * Modified pkitool script to be /bin/sh compatible (Johnny Lam).
 
 2005.08.16 -- Version 2.0.1
-	
+      
 * Security Fix -- DoS attack against server when run with "verb 0" and
   without "tls-auth".  If a client connection to the server fails
   certificate verification, the OpenSSL error queue is not properly
@@ -3130,7 +3130,7 @@ Samuli Seppänen (2):
   ifconfig-push static addresses for some subset of clients
   which directly reference the server IP address as the
   remote endpoint.
-	
+      
 2005.03.28 -- Version 2.0-rc18
 
 * Packaged Windows installer with OpenSSL 0.9.7f.
@@ -3152,7 +3152,7 @@ Samuli Seppänen (2):
   Require the appropriately named 'lzo' (liblzo1 / lzo).
   (Tom Walsh - http://openhardware.net)
 
-	
+      
 2005.02.20 -- Version 2.0-rc16
 
 * Fixed bug introduced in rc13 where Windows service wrapper
@@ -3183,7 +3183,7 @@ Samuli Seppänen (2):
   (c) verify that revocation succeeded.
 * Renamed easy-rsa/Windows/revoke-key to revoke-full so
   that both *nix and Windows scripts are equivalent.
-	
+      
 2005.02.11 -- Version 2.0-rc13
 
 * Improve human-readability of local/remote options
@@ -3269,7 +3269,7 @@ Samuli Seppänen (2):
 * To increase the push list capacity (must be done on both
   client and server), increase TLS_CHANNEL_BUF_SIZE in
   common.h (default=1024).
-	
+      
 2005.01.15 -- Version 2.0-rc8
 
 * Fixed bug introduced in rc7 where options error
@@ -3288,7 +3288,7 @@ Samuli Seppänen (2):
   option or missing parameter" error message.
 * Added "-extensions server" to "openssl req" command
   in easy-rsa/build-key-server (Nir Yeffet).
-	
+      
 2005.01.10 -- Version 2.0-rc7
 
 * Fixed bug in management interface which could cause
@@ -3400,7 +3400,7 @@ Samuli Seppänen (2):
   in a hibernating state until released by the
   management interface.  Also added "hold" command
   to the management interface.
- 	
+      
 2004.12.07 -- Version 2.0-rc1
 
 * openvpn.spec workaround for SuSE confusion regarding
@@ -3421,7 +3421,7 @@ Samuli Seppänen (2):
   are now prepended with an integer unix timestamp.
 * Added --http-proxy-timeout option, previously
   the timeout was hardcoded to 5 seconds.
-	
+      
 2004.12.02 -- Version 2.0-beta19
 
 * Fixed bug in management interface line termination
@@ -3611,7 +3611,7 @@ Samuli Seppänen (2):
   daemon instantiations.
 * --user and --group privilege downgrades as well as
   --chroot now also work in client mode (the
-  dowgrade/chroot will be delayed until the initialization
+  downgrade/chroot will be delayed until the initialization
   sequence is completed).
 * Added --show-engines standalone directive to show
   available OpenSSL crypto accelerator engine support.
@@ -3677,7 +3677,7 @@ Samuli Seppänen (2):
   (Peter 'Luna' Runestig).
 * Added experimental --fast-io flag which optimizes
   TUN/TAP/UDP writes on non-Windows systems.
-	
+      
 2004.08.18 -- Version 2.0-beta11
 
 * Added --server, --server-bridge, --client, and
@@ -3907,7 +3907,7 @@ Samuli Seppänen (2):
 * Fixed bug in event timer queue which could cause
   recurring timer events such as --ping to not
   correctly schedule again after firing.  This in
-  turn would cause spurrious ping restarts and possible
+  turn would cause spurious ping restarts and possible
   connection outages.  Thanks to Denis Vlasenko for
   tracking this down.
 * Possible fix to reported bug where --daemon argument
@@ -3977,7 +3977,7 @@ Samuli Seppänen (2):
   on VPN packets coming from a particular client must
   be associated with that client in the OpenVPN internal
   routing table.
-	
+      
 2004.04.28 -- Version 2.0-test26
 
 * Optimized broadcast path in multi-client mode.
@@ -4011,7 +4011,7 @@ Samuli Seppänen (2):
 * Reworked multi-client broadcast handling.
 
 2004.04.13 -- Version 2.0-test23
-	
+      
 * Fixed bug in --dev tun --client-to-client routing.
 * Fixed a potential deadlock in --pull.
 * Fixed a problem with select() usage which could
@@ -4026,7 +4026,7 @@ Samuli Seppänen (2):
   (Jeremy Apple).
 * Minor changes to TAP-Win32 driver based on feedback
   from the NDISTest tool.
-	
+      
 2004.04.11 -- Version 2.0-test21
 
 * Optimizations in multi-client server event loop.
@@ -4078,7 +4078,7 @@ Samuli Seppänen (2):
   Linux 2.4 and clients on Linux and Windows.
 
 2004.03.25 -- Version 2.0-test15
-	
+      
 * Implemented hash-table lookup of client instances
   based either on remote UDP address/port or remote
   ifconfig endpoint.
@@ -4170,7 +4170,7 @@ Samuli Seppänen (2):
 
 * Initial work on UDP multi-client server.
 * Branch merge of 1.6-beta7
-	
+      
 2004.02.14 -- Version 2.0-test2
 
 * Refactorization of openvpn.c into openvpn.[ch]
@@ -4185,7 +4185,7 @@ Samuli Seppänen (2):
 * Initial testbed for 2.0.
 
 2004.05.09 -- Version 1.6.0
-	
+      
 * Unchanged from 1.6-rc4 except for version number
   upgrade.
 
@@ -4196,7 +4196,7 @@ Samuli Seppänen (2):
 * Fixed "storage size of `iv' isn't known" build
   problem on FreeBSD.
 * OpenSSL 0.9.7d bundled with Windows self-install.
-	
+      
 2004.03.13 -- Version 1.6-rc3
 
 * Minor Windows fixes for --ip-win32 dynamic, relating to
@@ -4207,7 +4207,7 @@ Samuli Seppänen (2):
 * Added code to determine the default gateway on FreeBSD,
   allowing the --redirect-gateway option to work
   (Juan Rodriguez Hervella).
-	
+      
 2004.03.04 -- Version 1.6-rc2
 
 * Fixed bug in Windows version where the NetBIOS node-type
@@ -4226,9 +4226,9 @@ Samuli Seppänen (2):
   is explicitly specified.
 * L_TLS mutex could have been left in a locked state
   for certain kinds of TLS errors.
-	
+      
 2004.02.22 -- Version 1.6-beta7
-	
+      
 * Allow scheduling priority increase (--nice) together
   with UID/GID downgrade (--user/--group).
 * Code that causes SIGUSR1 restart on TLS errors in TCP
@@ -4243,7 +4243,7 @@ Samuli Seppänen (2):
 * Bug fix in new FreeBSD IPv6 over TUN code which was
   originally added in 1.6-beta5 (Nathanael Rensen).
 * More Socks5 fixes -- extended the struct frame
-  infrastructure to accomodate proxy-based encapsulation
+  infrastructure to accommodate proxy-based encapsulation
   overhead.
 * Added --dhcp-option to Windows version for setting
   adapter properties such as WINS & DNS servers.
@@ -4258,7 +4258,7 @@ Samuli Seppänen (2):
 
 2004.02.05 -- Version 1.6-beta6
 
-* UDP over Socks5 fix to accomodate Socks5 encapsulation
+* UDP over Socks5 fix to accommodate Socks5 encapsulation
   overhead (Christof Meerwald).
 * Minor --ip-win32 dynamic tweaks (use long lease time,
   invalidate existing lease with DHCPNAK).
@@ -4298,7 +4298,7 @@ Samuli Seppänen (2):
 * Added renewal-time and rebind-time to set of
   DHCP options returned by the TAP-Win32 driver when
   "--ip-win32 dynamic" is used.
-	
+      
 2004.01.14 -- Version 1.6-beta1
 
 * Fixed --proxy bug that sometimes caused plaintext
@@ -4365,7 +4365,7 @@ Samuli Seppänen (2):
   and backward compatibility is maintained.  See --secret option
   documentation on the man page for more info.
 * Added --tls-remote option (Teemu Kiviniemi).
-* Fixed --tls-cipher documention regarding correct delimiter
+* Fixed --tls-cipher documentation regarding correct delimiter
   usage (Teemu Kiviniemi).
 * Added --key-method option for selecting alternative data
   channel key negotiation methods.  Method 1 is the default.
@@ -4385,7 +4385,7 @@ Samuli Seppänen (2):
   the pre-existing default gateway address from the routing table
   (there's no standard API for getting the default gateway, so
   right now this feature only works on Windows or Linux).
-* Renamed the "route_default_gateway" enviromental variable to
+* Renamed the "route_default_gateway" environmental variable to
   "route_vpn_gateway" -- this is the remote VPN endpoint.
 * The special keywords vpn_gateway, net_gateway, and remote_host
   can now be used for the network or gateway components of the
@@ -4408,7 +4408,7 @@ Samuli Seppänen (2):
   message reordering when in TCP mode.
 * Changed beta naming convention to use '_' (underscore)
   rather than '-' (dash) to pacify rpmbuild.
-	
+      
 2003.10.08 -- Version 1.5-beta11
 
 * Modified code in the Windows version which sets the IP address
@@ -4509,7 +4509,7 @@ Samuli Seppänen (2):
   immediately after tun/tap device open.  When --route-delay is
   specified, routes will be added n seconds after connection
   initiation, where n is the --route-delay parameter (which
-  can be set to 0).	
+  can be set to 0).     
 * Made TCP framing error into a non-fatal error that triggers a
   connection reset.
 
@@ -4555,9 +4555,9 @@ Samuli Seppänen (2):
 
 * Extra refinements and error checking added to Windows
   NSIS install script.
-	
+      
 2003.08.05 -- Version 1.5-beta3
-	
+      
 * Added md5.h include to crypto.c to fix build problem on
   OpenBSD.
 * Created a Win32 installer using NSIS.
@@ -4568,7 +4568,7 @@ Samuli Seppänen (2):
   files to add and delete TAP-Win32 adapter instances.
 
 2003.07.31 -- Version 1.5-beta2
-	
+      
 * Renamed INSTALL.w32 to INSTALL-win32.txt and reformatted
   in Windows ASCII so it's easier to click and view.
 * Added postscript and PDF versions of the HOWTO to the web
@@ -4586,7 +4586,7 @@ Samuli Seppänen (2):
   version, see the window title bar for descriptions.
 
 2003.07.24 -- Version 1.5-beta1
-	
+      
 * Added TCP support via the new --proto option.
 * Renamed udp-centric options such as --udp-mtu to
   --link-mtu (old option names preserved for compatibility).
@@ -4656,7 +4656,7 @@ Samuli Seppänen (2):
   OpenBSD build.
 * Added --enable-mtu-dynamic configure option
   to enable --mtu-dynamic experimental option.
-	
+      
 2003.05.07 -- Version 1.4.0
 
 * Added --replay-persist feature to allow replay
@@ -4924,7 +4924,7 @@ Samuli Seppänen (2):
   with 1.1.1 and 1.1.0.
 
 2002.04.22 -- Version 1.1.1
-	
+      
 * Added --ifconfig option to automatically configure
   TUN device.
 * Added inactivity disconnect (--inactive
diff --git a/Changes.rst b/Changes.rst
index a7429b11..00dd6ed8 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -26,7 +26,7 @@ Seamless client IP/port floating
     the new format. When a data packet arrives, the server identifies peer
     by peer-id. If peer's ip/port has changed, server assumes that
     client has floated, verifies HMAC and updates ip/port in internal structs.
-    This allows the connection to be immediatly restored, instead of requiring
+    This allows the connection to be immediately restored, instead of requiring
     a TLS handshake before the server accepts packets from the new client
     ip/port.
 
@@ -223,7 +223,7 @@ User-visible Changes
   of a field get _$N appended to it's field name, starting at N=1.  For the
   example above, that would result in e.g. X509_0_OU=one, X509_0_OU_1=two.
   Note that this breaks setups that rely on the fact that OpenVPN would
-  previously (incorrectly) only export the last occurence of a field.
+  previously (incorrectly) only export the last occurrence of a field.
 
 - ``proto udp`` and ``proto tcp`` now use both IPv4 and IPv6. The new
   options ``proto udp4`` and ``proto tcp4`` use IPv4 only.
@@ -371,7 +371,7 @@ Security
 
 - CVE-2017-7521: Fix post-authentication remote-triggerable memory leaks
   A client could cause a server to leak a few bytes each time it connects to the
-  server.  That can eventuall cause the server to run out of memory, and thereby
+  server.  That can eventually cause the server to run out of memory, and thereby
   causing the server process to terminate. Discovered and reported to the
   OpenVPN security team by Guido Vranken.  (OpenSSL builds only.)
 
diff --git a/INSTALL b/INSTALL
index 0f12a636..d0c7dfa6 100644
--- a/INSTALL
+++ b/INSTALL
@@ -200,7 +200,7 @@ OPTIONS for ./configure:
   --enable-strict-options enable strict options check between peers (debugging
                           option) [default=no]
   --enable-selinux        enable SELinux support [default=no]
-  --enable-systemd        enable systemd suppport [default=no]
+  --enable-systemd        enable systemd support [default=no]
 
 ENVIRONMENT for ./configure:
 
diff --git a/TODO.IPv6 b/TODO.IPv6
index 24bf865a..465eaa66 100644
--- a/TODO.IPv6
+++ b/TODO.IPv6
@@ -21,7 +21,7 @@ TODO for IPv6 payload support
 
 4.) do "ifconfig tun0 inet6 unplumb"  or "ifconfig tun0 destroy" for
     Solaris, *BSD, ... at program termination time, to clean up leftovers
-    (unless tunnel persistance is desired).
+    (unless tunnel persistence is desired).
 
     For Solaris, only the "ipv6 tun0" is affected, for the *BSDs all tun0
     stay around.
@@ -47,7 +47,7 @@ tun0: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 1500
 4b.) verify this - on FreeBSD, tun0 is auto-destroyed if created by
      opening /dev/tun (and lingers if created by "ifconfig tun0 create")
 
-     -> use for persistant tunnels on not-linux?
+     -> use for persistent tunnels on not-linux?
 
     * 2012-06-10 tun interface behaviour is documented in "man tun(4)"
 
@@ -201,7 +201,7 @@ TODO for IPv6 transport support
     downstream.
     - Still done by flags, seems clean enough.
 
-  o implement comparison for mapped addesses: server in dual stack
+  o implement comparison for mapped addresses: server in dual stack
     listening IPv6 must permit incoming streams from allowed IPv4 peer,
     currently you need to pass eg:  --remote ffff::1.2.3.4
     - OpenVPN will compare all address of a remote
diff --git a/configure.ac b/configure.ac
index 192c15c5..84f12edc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -244,7 +244,7 @@ AC_ARG_ENABLE(
 
 AC_ARG_ENABLE(
 	[systemd],
-	[AS_HELP_STRING([--enable-systemd], [enable systemd suppport @<:@default=no@:>@])],
+	[AS_HELP_STRING([--enable-systemd], [enable systemd support @<:@default=no@:>@])],
 	,
 	[enable_systemd="no"]
 )
diff --git a/m4/pkg.m4 b/m4/pkg.m4
index 12d2a587..cca47a71 100644
--- a/m4/pkg.m4
+++ b/m4/pkg.m4
@@ -53,7 +53,7 @@ fi[]dnl
 # to PKG_CHECK_MODULES(), but does not set variables or print errors.
 #
 # Please remember that m4 expands AC_REQUIRE([PKG_PROG_PKG_CONFIG])
-# only at the first occurence in configure.ac, so if the first place
+# only at the first occurrence in configure.ac, so if the first place
 # it's called might be skipped (such as if it is within an "if", you
 # have to call PKG_CHECK_EXISTS manually
 # --------------------------------------------------------------
diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 62beacae..f9481684 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -35,7 +35,7 @@ struct _query_user {
     char *prompt;             /**< Prompt to present to the user */
     size_t prompt_len;        /**< Length of the prompt string */
     char *response;           /**< The user's response */
-    size_t response_len;      /**< Length the of the user reposone */
+    size_t response_len;      /**< Length the of the user response */
     bool echo;                /**< True: The user should see what is being typed, otherwise mask it */
 };
 
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index f4cc2c54..d6b31bfa 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -176,7 +176,7 @@ void x509_setenv(struct env_set *es, int cert_depth, openvpn_x509_cert_t *cert);
  *
  * The tracked attributes are stored in ll_head.
  *
- * @param ll_head       The x509_track to store tracked atttributes in
+ * @param ll_head       The x509_track to store tracked attributes in
  * @param name          Name of the attribute to track
  * @param msglevel      Message level for errors
  * @param gc            Garbage collection arena for temp data
-- 
2.20.1.windows.1



On 1/22/2019 9:51 PM, Simon Matter wrote:
> Hi,
>
>> diff --git a/src/openvpn/console.h b/src/openvpn/console.h
>> index 0ffd6683..62beacae 100644
>> --- a/src/openvpn/console.h
>> +++ b/src/openvpn/console.h
>> @@ -33,9 +33,9 @@
>>   */
>> struct _query_user {
>>      char *prompt;             /**< Prompt to present to the user */
>> -    size_t prompt_len;        /**< Lenght of the prompt string */
>> +    size_t prompt_len;        /**< Length of the prompt string */
>>      char *response;           /**< The user's response */
>> -    size_t response_len;      /**< Lenght the of the user reposone */
>> +    size_t response_len;      /**< Length the of the user reposone */
>                                                              ^^^^^^^^
> response
>
> Regards,
> Simon



--------------BB7CAB6D03F6089F98A9C6D0
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Looks like I missed that and a few
      others! I fixed some more spelling errors across other things.
      Follow up patch/commit below. If I just need to re-make the
      original patch let me know. <br>
    </div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">
      <pre>From: Jonathan Tooker <a class="moz-txt-link-rfc2396E" href="mailto:jonathan@...2489...">&lt;jonathan@...2489...&gt;</a>
Date: Tue, 22 Jan 2019 23:10:33 -0600
Subject: [PATCH] Another set of spelling fixes

---
 COPYING                          |   6 +-
 ChangeLog                        | 140 +++++++++++++++----------------
 Changes.rst                      |   6 +-
 INSTALL                          |   2 +-
 TODO.IPv6                        |   6 +-
 configure.ac                     |   2 +-
 m4/pkg.m4                        |   2 +-
 src/openvpn/console.h            |   2 +-
 src/openvpn/ssl_verify_backend.h |   2 +-
 9 files changed, 84 insertions(+), 84 deletions(-)

diff --git a/COPYING b/COPYING
index 9c21c177..54cc9f24 100644
--- a/COPYING
+++ b/COPYING
@@ -157,7 +157,7 @@ OpenSSL License:
  * The implementation was written so as to conform with Netscapes SSL.
  * 
  * This library is free for commercial and non-commercial use as long as
- * the following conditions are aheared to.  The following conditions
+ * the following conditions are adhered to.  The following conditions
  * apply to all code found in this distribution, be it the RC4, RSA,
  * lhash, DES, etc., code; not just the SSL code.  The SSL documentation
  * included with this distribution is covered by the same copyright terms
@@ -182,7 +182,7 @@ OpenSSL License:
  *    must display the following acknowledgement:
  *    "This product includes cryptographic software written by
  *     Eric Young (<a class="moz-txt-link-abbreviated" href="mailto:eay@...2490...">eay@...2490...</a>)"
- *    The word 'cryptographic' can be left out if the rouines from the library
+ *    The word 'cryptographic' can be left out if the routines from the library
  *    being used are not cryptographic related :-).
  * 4. If you include any Windows specific code (or a derivative thereof) from 
  *    the apps directory (application code) you must include an acknowledgement:
@@ -200,7 +200,7 @@ OpenSSL License:
  * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
  * SUCH DAMAGE.
  * 
- * The licence and distribution terms for any publically available version or
+ * The licence and distribution terms for any publicly available version or
  * derivative of this code cannot be changed.  i.e. this code cannot simply be
  * copied and put under another distribution licence
  * [including the GNU Public Licence.]
diff --git a/ChangeLog b/ChangeLog
index 1c06c7f1..077d7063 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -128,7 +128,7 @@ Gert Doering (10):
 
 Heiko Hund (4):
       put argv_* functions into own file, add unit tests
-      Remove unused and unecessary argv interfaces
+      Remove unused and unnecessary argv interfaces
       remove unused system_str from struct argv
       Factor out %sc handling from argv_printf()
 
@@ -230,7 +230,7 @@ Arne Schwabe (100):
       Split the PROTO_UDP_xx options into AF_INET/AF_INET6 and PROTO_TCP/PROTO_UDP part.
       Fix two instances of asserting AF_INET
       Fix assertion when SIGUSR1 is received while getaddrinfo is successful
-      Split link_socket_init_phase1 and link_socket_init_phase2 into smaller more managable/readable functions. No functional changes
+      Split link_socket_init_phase1 and link_socket_init_phase2 into smaller more manageable/readable functions. No functional changes
       Change proto_remote() function to return a constant string
       Remove the ip-remote-hint option.
       change the type of 'remote' to addrinfo*, and rename to 'remote_list'.
@@ -252,7 +252,7 @@ Arne Schwabe (100):
       Add gateway and device to android control messages
       Clean up of socket code.
       Fix assert when using port-share
-      Work around Solaris getaddrinfo() returing ai_protocol=0
+      Work around Solaris getaddrinfo() returning ai_protocol=0
       Fix man page and OSCP script: tls_serial_{n} is decimal
       Remove ENABLE_BUFFER_LIST
       Fix server routes not working in topology subnet with --server [v3]
@@ -335,7 +335,7 @@ David Sommerseth (44):
       autoconf: Fix typo
       t_client.sh: Check for fping/fping6 availability
       t_client.sh: Write errors to stderr and document requirements
-      t_client.sh: Add prepare/cleanup possibilties for each test case
+      t_client.sh: Add prepare/cleanup possibilities for each test case
       Fix file checks when --chroot is being used
       Adjusted autotools files to build more cleanly on newer autoconf/automake versions
       Improve error reporting on file access to --client-config-dir and --ccd-exclusive
@@ -382,7 +382,7 @@ Dorian Harmans (1):
       Add CHACHA20-POLY1305 ciphersuite IANA name translations.
 
 Felix Janda (1):
-      Use OPENVPN_ETH_P_* so that &lt;netinet/if_ether.h&gt; is unecessary
+      Use OPENVPN_ETH_P_* so that &lt;netinet/if_ether.h&gt; is unnecessary
 
 Fish (1):
       Add lz4 support to MSVC.
@@ -531,7 +531,7 @@ Holger Kummert (1):
       Del ipv6 addr on close of linux tun interface
 
 Hubert Kario (2):
-      ocsp_check - signature verification and cert staus results are separate
+      ocsp_check - signature verification and cert status results are separate
       ocsp_check - double check if ocsp didn't report any errors in execution
 
 Ilya Shipitsin (3):
@@ -796,7 +796,7 @@ Steffan Karger (180):
       Don't exit daemon if opening or parsing the CRL fails.
       Define dummy SSL_OP_NO_TICKET flag if not present in OpenSSL.
       Fix typo in cipher_kt_mode_{cbc, ofb_cfb}() doxygen.
-      Fix some unintialized variable warnings
+      Fix some uninitialized variable warnings
       Fix clang warning in options.c
       Fix compiler warnings in ssl_polarssl.c.
       Fix regression with password protected private keys (polarssl)
@@ -1181,7 +1181,7 @@ Adriaan de Jong (127):
       Refactored get_highest_preference_tls_cipher
       Refactored root SSL context initialisation
       Refactored new external key code
-      Refactored DH paramater loading
+      Refactored DH parameter loading
       Refactored root TLS option settings
       Refactored PKCS#12 key loading
       Refactored PKCS#11 loading
@@ -1192,7 +1192,7 @@ Adriaan de Jong (127):
       Refactored CA and extra certs code
       Refactored cipher restriction code
       Refactored tls_options, key_state, and key_source data structures
-      Refactored initalisation of key_states
+      Refactored initialisation of key_states
       Refactored key_state free code
       Refactored print_details
       Refactored key_state read code (including bio_read())
@@ -1275,7 +1275,7 @@ Adriaan de Jong (127):
       Moved out of memory prototype to error.h, as the definition is in error.c
       Removed support for calling gc_malloc with a NULL gc_arena struct
 
-      (The follwing patches from Adriaan was mistakenly merged with
+      (The following patches from Adriaan was mistakenly merged with
        the wrong commit author in the git tree)
       Doxygen: Added data channel crypto docs
       Added control channel crypto docs
@@ -1342,7 +1342,7 @@ David Sommerseth (50):
       Revamp check_file_access() checks in stdin scenarios
 
 Davide Guerri (1):
-      New feauture: Add --stale-routes-check
+      New feature: Add --stale-routes-check
 
 Frank de Brabander (1):
       Fixed wrong return type of cipher_kt_mode
@@ -1357,7 +1357,7 @@ Gert Doering (45):
       NetBSD fixes - on 4.0 and up, use multi-af mode.
       new feature: "ifconfig-ipv6-push" (from ccd/ config)
       add some TODOs to TODO.IPv6
-      undo accidential duplication of existing "--iroute" line in the help text
+      undo accidental duplication of existing "--iroute" line in the help text
       basic documentation of IPv6 related options and their syntax
       Enable IPv6 Payload in OpenVPN p2mp tun server mode.
       remove NOTES file from commit - private scribbling
@@ -1502,7 +1502,7 @@ JuanJo Ciarlante (40):
       * document ipv6 milestone status
       * doc update w/unittests results
       * make possible to x-compile openvpn/win32 in Linux
-      * correctly setup hints.ai_socktype for getaddrinfo(), althought sorta hacky, see TODO.ipv6.
+      * correctly setup hints.ai_socktype for getaddrinfo(), although sorta hacky, see TODO.ipv6.
       * renamed README.ipv6{.txt,}
       * updated {README,TODO}.ipv6 from feedback at openvpn-devel mlist
       * init.c: document the ENABLE_MANAGEMENT place to work on
@@ -1645,7 +1645,7 @@ Samuli Seppänen (15):
       Added a nmake makefile for openvpnserv.exe building
       Moved TAP-driver version info to version.m4. Cleaned up win/settings.in.
       Added helper functionality to win/wb.py
-      Added support for viewing config-win32.h paramters to win/show.py
+      Added support for viewing config-win32.h parameters to win/show.py
       Added comments and made small modifications to win/msvc.mak.in
       Added command-line switch to win/build_all.py to skip TAP driver building
       Added configure.h and version.m4 variable parsing to win/config.py
@@ -1712,7 +1712,7 @@ Samuli Seppänen (2):
 
 * Community patches
   David Sommerseth (2):
-      Test framework improvment - Do not FAIL if t_client.rc is missing
+      Test framework improvement - Do not FAIL if t_client.rc is missing
       More t_client.sh updates - exit with SKIP when we want to skip
 
   Gert Doering (4):
@@ -1872,7 +1872,7 @@ Samuli Seppänen (2):
   renegotiation capabilities that are built into the SSL/TLS protocol,
   therefore the fix in OpenSSL 0.9.8l (disable SSL/TLS renegotiation
   completely) will not adversely affect OpenVPN mid-session SSL/TLS
-  renegotation or any other OpenVPN capabilities.
+  renegotiation or any other OpenVPN capabilities.
 
 * Added additional session renegotiation hardening.  OpenVPN has always
   required that mid-session renegotiations build up a new SSL/TLS
@@ -1921,7 +1921,7 @@ Samuli Seppänen (2):
 
 * Added the ability for the server to provide a custom reason string
   when an AUTH_FAILED message is returned to the client.  This
-  string can be set by the server-side managment interface and read
+  string can be set by the server-side management interface and read
   by the client-side management interface.
 
 * client-kill management interface command, when issued on server, will
@@ -1966,7 +1966,7 @@ Samuli Seppänen (2):
 * Minor tweaks to Windows build system.
 
 * Added "redirect-private" option which allows private subnets
-  to be pushed to the client in such a way that they don't accidently
+  to be pushed to the client in such a way that they don't accidentally
   obscure critical local addresses such as the DHCP server address and
   DNS server addresses.
 
@@ -1993,7 +1993,7 @@ Samuli Seppänen (2):
   functionality (Alon Bar-Lev).
 
 * Fixed bug where the remote_X environmental variables were not being
-  set correctly when the 'local' option is specifed.
+  set correctly when the 'local' option is specified.
 
 2009.05.17 -- Version 2.1_rc16
 
@@ -2396,7 +2396,7 @@ Samuli Seppänen (2):
   files might elicit the error: "Options error: Parameter pkcs11_private_mode
   can only be specified in TLS-mode, i.e. where --tls-server or --tls-client
   is also specified."
-	
+      
 2008.01.23 -- Version 2.1_rc5
 
 * Fixed Win2K TAP driver bug that was introduced by Vista fixes,
@@ -2469,7 +2469,7 @@ Samuli Seppänen (2):
 
 * Added --management-forget-disconnect option -- forget
   passwords when management session disconnects (Alon Bar-Lev).
-	
+      
 2007.04.25 -- Version 2.1_rc4
 
 * Worked out remaining issues with TAP driver signing
@@ -2484,7 +2484,7 @@ Samuli Seppänen (2):
 * Additional fixes to TAP driver for Windows x64.  Driver
   now runs successfully on Vista x64 if driver signing
   enforcement is disabled.
-	
+      
 * The Windows Installer and TAP driver are now signed by
   OpenVPN Solutions LLC (in addition to the usual GnuPG
   signatures).
@@ -2502,7 +2502,7 @@ Samuli Seppänen (2):
   with password-protected keys; also add -extensions server
   option when generating server cert via
   build-key-server-pass.bat (Daniel Zauft).
-	
+      
 2007.02.27 -- Version 2.1_rc2
 
 * auth-pam change:  link with -lpam rather
@@ -2581,10 +2581,10 @@ Samuli Seppänen (2):
 
 * Fixed TAP-Win32 bug that caused BSOD on Windows Vista
   (Henry Nestler).
-	
+      
 * Autodetect 32/64 bit Windows in installer and install
   appropriate TAP driver (Mathias Sundman, Hypherion).
-	
+      
 * Fixed bug in loopback self-test introduced
   in 2.1-beta15 where self test as invoked by
   "make check" would not properly exit after
@@ -2608,7 +2608,7 @@ Samuli Seppänen (2):
 * PKCS#11 changes: (Alon Bar-Lev) 
   - Modified ssl.c to not FATAL and return to init.c
     so auth-retry will work.
-  - Modifed pkcs11-helper.c to fix some problem with
+  - Modified pkcs11-helper.c to fix some problem with
     multiple providers.
   - Added retry counter to PKCS#11 PIN hook.
   - Modified PKCS#11 PIN retry loop to return correct error
@@ -2645,10 +2645,10 @@ Samuli Seppänen (2):
 
 * Fixed Windows server bug in time backtrack handling code which
   could cause TLS negotiation failures on legitimate clients.
-	
+      
 * Rewrote gettimeofday function for Windows to be
   simpler and more efficient.
-	
+      
 * Merged PKCS#11 extensions to easy-rsa/2.0  (Alon Bar-Lev).
 
 * Added --route-metric option to set a default route metric
@@ -2662,7 +2662,7 @@ Samuli Seppänen (2):
 * Code added in 2.1-beta7 and 2.0.6-rc1 to extend byte counters
   to 64 bits caused a bug in the Windows version which has now
   been fixed.  The bug could cause intermittent crashes.
-	
+      
 2006.04.05 -- Version 2.1-beta12
 
 * Security Vulnerability -- An OpenVPN client connecting to a
@@ -2674,7 +2674,7 @@ Samuli Seppänen (2):
   directives to it by including "pull" or the macro "client" in
   its configuration file, (b) the client configuration file uses
   a scripting directive such as "up" or "down", (c) the client
-  succesfully authenticates the server, (d) the server is
+  successfully authenticates the server, (d) the server is
   malicious or has been compromised and is under the control of
   the attacker, and (e) the attacker has at least some level of
   pre-existing control over files on the client (this might be
@@ -2691,7 +2691,7 @@ Samuli Seppänen (2):
 
 * PKCS11 fixes (Alon Bar-Lev).  For full description:
   svn log -r990 <a class="moz-txt-link-freetext" href="http://svn.openvpn.net/projects/openvpn/branches/BETA21">http://svn.openvpn.net/projects/openvpn/branches/BETA21</a>
-	
+      
 * When deleting routes under Linux, use the route metric
   as a differentiator to ensure that the route teardown
   process only deletes the identical route which was originally
@@ -2759,7 +2759,7 @@ Samuli Seppänen (2):
   which tries IP helper API first, then falls back to
   route.exe.
 * Made --route-method adaptive the default.
-	
+      
 2005.11.12 -- Version 2.1-beta7
 
 * Allow blank passwords to be passed via the management
@@ -2783,7 +2783,7 @@ Samuli Seppänen (2):
   reference an explicit file.
   For example:
   &lt;ca&gt;
-	data here...
+      data here...
   &lt;/ca&gt;
 * Allow plugin and push directives to have multi-line
   parameter lists such as:
@@ -2801,7 +2801,7 @@ Samuli Seppänen (2):
   attributes (Alon Bar-Lev).
 * For Windows, reverted --ip-win32 default back to "dynamic".
   To use new adaptive mode, set explicitly.
-	
+      
 2005.11.01 -- Version 2.1-beta6
 
 * Security fix (merged from 2.0.4) -- Affects non-Windows
@@ -2860,7 +2860,7 @@ Samuli Seppänen (2):
 * Added ".PHONY: plugin" to Makefile.am, reverted
   location of "plugin" directory (thanks to
   Matthias Andree for figuring this out).
-	
+      
 2005.10.16 -- Version 2.1-beta3
 
 * Added PKCS#11 support (Alon Bar-Lev).
@@ -2928,7 +2928,7 @@ Samuli Seppänen (2):
   per-client constructor and destructor functions, to make
   it simpler for plugins to maintain per-client state.
 
-2005.09.25 -- Version 2.0.3-rc1	
+2005.09.25 -- Version 2.0.3-rc1     
 
 * openvpn_plugin_abort_v1 function wasn't being properly
   registered on Windows.
@@ -2956,7 +2956,7 @@ Samuli Seppänen (2):
 * Modified pkitool script to be /bin/sh compatible (Johnny Lam).
 
 2005.08.16 -- Version 2.0.1
-	
+      
 * Security Fix -- DoS attack against server when run with "verb 0" and
   without "tls-auth".  If a client connection to the server fails
   certificate verification, the OpenSSL error queue is not properly
@@ -3130,7 +3130,7 @@ Samuli Seppänen (2):
   ifconfig-push static addresses for some subset of clients
   which directly reference the server IP address as the
   remote endpoint.
-	
+      
 2005.03.28 -- Version 2.0-rc18
 
 * Packaged Windows installer with OpenSSL 0.9.7f.
@@ -3152,7 +3152,7 @@ Samuli Seppänen (2):
   Require the appropriately named 'lzo' (liblzo1 / lzo).
   (Tom Walsh - <a class="moz-txt-link-freetext" href="http://openhardware.net">http://openhardware.net</a>)
 
-	
+      
 2005.02.20 -- Version 2.0-rc16
 
 * Fixed bug introduced in rc13 where Windows service wrapper
@@ -3183,7 +3183,7 @@ Samuli Seppänen (2):
   (c) verify that revocation succeeded.
 * Renamed easy-rsa/Windows/revoke-key to revoke-full so
   that both *nix and Windows scripts are equivalent.
-	
+      
 2005.02.11 -- Version 2.0-rc13
 
 * Improve human-readability of local/remote options
@@ -3269,7 +3269,7 @@ Samuli Seppänen (2):
 * To increase the push list capacity (must be done on both
   client and server), increase TLS_CHANNEL_BUF_SIZE in
   common.h (default=1024).
-	
+      
 2005.01.15 -- Version 2.0-rc8
 
 * Fixed bug introduced in rc7 where options error
@@ -3288,7 +3288,7 @@ Samuli Seppänen (2):
   option or missing parameter" error message.
 * Added "-extensions server" to "openssl req" command
   in easy-rsa/build-key-server (Nir Yeffet).
-	
+      
 2005.01.10 -- Version 2.0-rc7
 
 * Fixed bug in management interface which could cause
@@ -3400,7 +3400,7 @@ Samuli Seppänen (2):
   in a hibernating state until released by the
   management interface.  Also added "hold" command
   to the management interface.
- 	
+      
 2004.12.07 -- Version 2.0-rc1
 
 * openvpn.spec workaround for SuSE confusion regarding
@@ -3421,7 +3421,7 @@ Samuli Seppänen (2):
   are now prepended with an integer unix timestamp.
 * Added --http-proxy-timeout option, previously
   the timeout was hardcoded to 5 seconds.
-	
+      
 2004.12.02 -- Version 2.0-beta19
 
 * Fixed bug in management interface line termination
@@ -3611,7 +3611,7 @@ Samuli Seppänen (2):
   daemon instantiations.
 * --user and --group privilege downgrades as well as
   --chroot now also work in client mode (the
-  dowgrade/chroot will be delayed until the initialization
+  downgrade/chroot will be delayed until the initialization
   sequence is completed).
 * Added --show-engines standalone directive to show
   available OpenSSL crypto accelerator engine support.
@@ -3677,7 +3677,7 @@ Samuli Seppänen (2):
   (Peter 'Luna' Runestig).
 * Added experimental --fast-io flag which optimizes
   TUN/TAP/UDP writes on non-Windows systems.
-	
+      
 2004.08.18 -- Version 2.0-beta11
 
 * Added --server, --server-bridge, --client, and
@@ -3907,7 +3907,7 @@ Samuli Seppänen (2):
 * Fixed bug in event timer queue which could cause
   recurring timer events such as --ping to not
   correctly schedule again after firing.  This in
-  turn would cause spurrious ping restarts and possible
+  turn would cause spurious ping restarts and possible
   connection outages.  Thanks to Denis Vlasenko for
   tracking this down.
 * Possible fix to reported bug where --daemon argument
@@ -3977,7 +3977,7 @@ Samuli Seppänen (2):
   on VPN packets coming from a particular client must
   be associated with that client in the OpenVPN internal
   routing table.
-	
+      
 2004.04.28 -- Version 2.0-test26
 
 * Optimized broadcast path in multi-client mode.
@@ -4011,7 +4011,7 @@ Samuli Seppänen (2):
 * Reworked multi-client broadcast handling.
 
 2004.04.13 -- Version 2.0-test23
-	
+      
 * Fixed bug in --dev tun --client-to-client routing.
 * Fixed a potential deadlock in --pull.
 * Fixed a problem with select() usage which could
@@ -4026,7 +4026,7 @@ Samuli Seppänen (2):
   (Jeremy Apple).
 * Minor changes to TAP-Win32 driver based on feedback
   from the NDISTest tool.
-	
+      
 2004.04.11 -- Version 2.0-test21
 
 * Optimizations in multi-client server event loop.
@@ -4078,7 +4078,7 @@ Samuli Seppänen (2):
   Linux 2.4 and clients on Linux and Windows.
 
 2004.03.25 -- Version 2.0-test15
-	
+      
 * Implemented hash-table lookup of client instances
   based either on remote UDP address/port or remote
   ifconfig endpoint.
@@ -4170,7 +4170,7 @@ Samuli Seppänen (2):
 
 * Initial work on UDP multi-client server.
 * Branch merge of 1.6-beta7
-	
+      
 2004.02.14 -- Version 2.0-test2
 
 * Refactorization of openvpn.c into openvpn.[ch]
@@ -4185,7 +4185,7 @@ Samuli Seppänen (2):
 * Initial testbed for 2.0.
 
 2004.05.09 -- Version 1.6.0
-	
+      
 * Unchanged from 1.6-rc4 except for version number
   upgrade.
 
@@ -4196,7 +4196,7 @@ Samuli Seppänen (2):
 * Fixed "storage size of `iv' isn't known" build
   problem on FreeBSD.
 * OpenSSL 0.9.7d bundled with Windows self-install.
-	
+      
 2004.03.13 -- Version 1.6-rc3
 
 * Minor Windows fixes for --ip-win32 dynamic, relating to
@@ -4207,7 +4207,7 @@ Samuli Seppänen (2):
 * Added code to determine the default gateway on FreeBSD,
   allowing the --redirect-gateway option to work
   (Juan Rodriguez Hervella).
-	
+      
 2004.03.04 -- Version 1.6-rc2
 
 * Fixed bug in Windows version where the NetBIOS node-type
@@ -4226,9 +4226,9 @@ Samuli Seppänen (2):
   is explicitly specified.
 * L_TLS mutex could have been left in a locked state
   for certain kinds of TLS errors.
-	
+      
 2004.02.22 -- Version 1.6-beta7
-	
+      
 * Allow scheduling priority increase (--nice) together
   with UID/GID downgrade (--user/--group).
 * Code that causes SIGUSR1 restart on TLS errors in TCP
@@ -4243,7 +4243,7 @@ Samuli Seppänen (2):
 * Bug fix in new FreeBSD IPv6 over TUN code which was
   originally added in 1.6-beta5 (Nathanael Rensen).
 * More Socks5 fixes -- extended the struct frame
-  infrastructure to accomodate proxy-based encapsulation
+  infrastructure to accommodate proxy-based encapsulation
   overhead.
 * Added --dhcp-option to Windows version for setting
   adapter properties such as WINS &amp; DNS servers.
@@ -4258,7 +4258,7 @@ Samuli Seppänen (2):
 
 2004.02.05 -- Version 1.6-beta6
 
-* UDP over Socks5 fix to accomodate Socks5 encapsulation
+* UDP over Socks5 fix to accommodate Socks5 encapsulation
   overhead (Christof Meerwald).
 * Minor --ip-win32 dynamic tweaks (use long lease time,
   invalidate existing lease with DHCPNAK).
@@ -4298,7 +4298,7 @@ Samuli Seppänen (2):
 * Added renewal-time and rebind-time to set of
   DHCP options returned by the TAP-Win32 driver when
   "--ip-win32 dynamic" is used.
-	
+      
 2004.01.14 -- Version 1.6-beta1
 
 * Fixed --proxy bug that sometimes caused plaintext
@@ -4365,7 +4365,7 @@ Samuli Seppänen (2):
   and backward compatibility is maintained.  See --secret option
   documentation on the man page for more info.
 * Added --tls-remote option (Teemu Kiviniemi).
-* Fixed --tls-cipher documention regarding correct delimiter
+* Fixed --tls-cipher documentation regarding correct delimiter
   usage (Teemu Kiviniemi).
 * Added --key-method option for selecting alternative data
   channel key negotiation methods.  Method 1 is the default.
@@ -4385,7 +4385,7 @@ Samuli Seppänen (2):
   the pre-existing default gateway address from the routing table
   (there's no standard API for getting the default gateway, so
   right now this feature only works on Windows or Linux).
-* Renamed the "route_default_gateway" enviromental variable to
+* Renamed the "route_default_gateway" environmental variable to
   "route_vpn_gateway" -- this is the remote VPN endpoint.
 * The special keywords vpn_gateway, net_gateway, and remote_host
   can now be used for the network or gateway components of the
@@ -4408,7 +4408,7 @@ Samuli Seppänen (2):
   message reordering when in TCP mode.
 * Changed beta naming convention to use '_' (underscore)
   rather than '-' (dash) to pacify rpmbuild.
-	
+      
 2003.10.08 -- Version 1.5-beta11
 
 * Modified code in the Windows version which sets the IP address
@@ -4509,7 +4509,7 @@ Samuli Seppänen (2):
   immediately after tun/tap device open.  When --route-delay is
   specified, routes will be added n seconds after connection
   initiation, where n is the --route-delay parameter (which
-  can be set to 0).	
+  can be set to 0).     
 * Made TCP framing error into a non-fatal error that triggers a
   connection reset.
 
@@ -4555,9 +4555,9 @@ Samuli Seppänen (2):
 
 * Extra refinements and error checking added to Windows
   NSIS install script.
-	
+      
 2003.08.05 -- Version 1.5-beta3
-	
+      
 * Added md5.h include to crypto.c to fix build problem on
   OpenBSD.
 * Created a Win32 installer using NSIS.
@@ -4568,7 +4568,7 @@ Samuli Seppänen (2):
   files to add and delete TAP-Win32 adapter instances.
 
 2003.07.31 -- Version 1.5-beta2
-	
+      
 * Renamed INSTALL.w32 to INSTALL-win32.txt and reformatted
   in Windows ASCII so it's easier to click and view.
 * Added postscript and PDF versions of the HOWTO to the web
@@ -4586,7 +4586,7 @@ Samuli Seppänen (2):
   version, see the window title bar for descriptions.
 
 2003.07.24 -- Version 1.5-beta1
-	
+      
 * Added TCP support via the new --proto option.
 * Renamed udp-centric options such as --udp-mtu to
   --link-mtu (old option names preserved for compatibility).
@@ -4656,7 +4656,7 @@ Samuli Seppänen (2):
   OpenBSD build.
 * Added --enable-mtu-dynamic configure option
   to enable --mtu-dynamic experimental option.
-	
+      
 2003.05.07 -- Version 1.4.0
 
 * Added --replay-persist feature to allow replay
@@ -4924,7 +4924,7 @@ Samuli Seppänen (2):
   with 1.1.1 and 1.1.0.
 
 2002.04.22 -- Version 1.1.1
-	
+      
 * Added --ifconfig option to automatically configure
   TUN device.
 * Added inactivity disconnect (--inactive
diff --git a/Changes.rst b/Changes.rst
index a7429b11..00dd6ed8 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -26,7 +26,7 @@ Seamless client IP/port floating
     the new format. When a data packet arrives, the server identifies peer
     by peer-id. If peer's ip/port has changed, server assumes that
     client has floated, verifies HMAC and updates ip/port in internal structs.
-    This allows the connection to be immediatly restored, instead of requiring
+    This allows the connection to be immediately restored, instead of requiring
     a TLS handshake before the server accepts packets from the new client
     ip/port.
 
@@ -223,7 +223,7 @@ User-visible Changes
   of a field get _$N appended to it's field name, starting at N=1.  For the
   example above, that would result in e.g. X509_0_OU=one, X509_0_OU_1=two.
   Note that this breaks setups that rely on the fact that OpenVPN would
-  previously (incorrectly) only export the last occurence of a field.
+  previously (incorrectly) only export the last occurrence of a field.
 
 - ``proto udp`` and ``proto tcp`` now use both IPv4 and IPv6. The new
   options ``proto udp4`` and ``proto tcp4`` use IPv4 only.
@@ -371,7 +371,7 @@ Security
 
 - CVE-2017-7521: Fix post-authentication remote-triggerable memory leaks
   A client could cause a server to leak a few bytes each time it connects to the
-  server.  That can eventuall cause the server to run out of memory, and thereby
+  server.  That can eventually cause the server to run out of memory, and thereby
   causing the server process to terminate. Discovered and reported to the
   OpenVPN security team by Guido Vranken.  (OpenSSL builds only.)
 
diff --git a/INSTALL b/INSTALL
index 0f12a636..d0c7dfa6 100644
--- a/INSTALL
+++ b/INSTALL
@@ -200,7 +200,7 @@ OPTIONS for ./configure:
   --enable-strict-options enable strict options check between peers (debugging
                           option) [default=no]
   --enable-selinux        enable SELinux support [default=no]
-  --enable-systemd        enable systemd suppport [default=no]
+  --enable-systemd        enable systemd support [default=no]
 
 ENVIRONMENT for ./configure:
 
diff --git a/TODO.IPv6 b/TODO.IPv6
index 24bf865a..465eaa66 100644
--- a/TODO.IPv6
+++ b/TODO.IPv6
@@ -21,7 +21,7 @@ TODO for IPv6 payload support
 
 4.) do "ifconfig tun0 inet6 unplumb"  or "ifconfig tun0 destroy" for
     Solaris, *BSD, ... at program termination time, to clean up leftovers
-    (unless tunnel persistance is desired).
+    (unless tunnel persistence is desired).
 
     For Solaris, only the "ipv6 tun0" is affected, for the *BSDs all tun0
     stay around.
@@ -47,7 +47,7 @@ tun0: flags=8051&lt;UP,POINTOPOINT,RUNNING,MULTICAST&gt; mtu 1500
 4b.) verify this - on FreeBSD, tun0 is auto-destroyed if created by
      opening /dev/tun (and lingers if created by "ifconfig tun0 create")
 
-     -&gt; use for persistant tunnels on not-linux?
+     -&gt; use for persistent tunnels on not-linux?
 
     * 2012-06-10 tun interface behaviour is documented in "man tun(4)"
 
@@ -201,7 +201,7 @@ TODO for IPv6 transport support
     downstream.
     - Still done by flags, seems clean enough.
 
-  o implement comparison for mapped addesses: server in dual stack
+  o implement comparison for mapped addresses: server in dual stack
     listening IPv6 must permit incoming streams from allowed IPv4 peer,
     currently you need to pass eg:  --remote ffff::1.2.3.4
     - OpenVPN will compare all address of a remote
diff --git a/configure.ac b/configure.ac
index 192c15c5..84f12edc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -244,7 +244,7 @@ AC_ARG_ENABLE(
 
 AC_ARG_ENABLE(
 	[systemd],
-	[AS_HELP_STRING([--enable-systemd], [enable systemd suppport @&lt;:@default=no@:&gt;@])],
+	[AS_HELP_STRING([--enable-systemd], [enable systemd support @&lt;:@default=no@:&gt;@])],
 	,
 	[enable_systemd="no"]
 )
diff --git a/m4/pkg.m4 b/m4/pkg.m4
index 12d2a587..cca47a71 100644
--- a/m4/pkg.m4
+++ b/m4/pkg.m4
@@ -53,7 +53,7 @@ fi[]dnl
 # to PKG_CHECK_MODULES(), but does not set variables or print errors.
 #
 # Please remember that m4 expands AC_REQUIRE([PKG_PROG_PKG_CONFIG])
-# only at the first occurence in configure.ac, so if the first place
+# only at the first occurrence in configure.ac, so if the first place
 # it's called might be skipped (such as if it is within an "if", you
 # have to call PKG_CHECK_EXISTS manually
 # --------------------------------------------------------------
diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 62beacae..f9481684 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -35,7 +35,7 @@ struct _query_user {
     char *prompt;             /**&lt; Prompt to present to the user */
     size_t prompt_len;        /**&lt; Length of the prompt string */
     char *response;           /**&lt; The user's response */
-    size_t response_len;      /**&lt; Length the of the user reposone */
+    size_t response_len;      /**&lt; Length the of the user response */
     bool echo;                /**&lt; True: The user should see what is being typed, otherwise mask it */
 };
 
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index f4cc2c54..d6b31bfa 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -176,7 +176,7 @@ void x509_setenv(struct env_set *es, int cert_depth, openvpn_x509_cert_t *cert);
  *
  * The tracked attributes are stored in ll_head.
  *
- * @param ll_head       The x509_track to store tracked atttributes in
+ * @param ll_head       The x509_track to store tracked attributes in
  * @param name          Name of the attribute to track
  * @param msglevel      Message level for errors
  * @param gc            Garbage collection arena for temp data
-- 
2.20.1.windows.1


</pre>
    </div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">On 1/22/2019 9:51 PM, Simon Matter
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:289bfe02fdabee00b91b555e7e5759f9.squirrel@...2260...">
      <pre class="moz-quote-pre" wrap="">Hi,

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 0ffd6683..62beacae 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -33,9 +33,9 @@
  */
struct _query_user {
     char *prompt;             /**&lt; Prompt to present to the user */
-    size_t prompt_len;        /**&lt; Lenght of the prompt string */
+    size_t prompt_len;        /**&lt; Length of the prompt string */
     char *response;           /**&lt; The user's response */
-    size_t response_len;      /**&lt; Lenght the of the user reposone */
+    size_t response_len;      /**&lt; Length the of the user reposone */
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">                                                             ^^^^^^^^
response

Regards,
Simon
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------BB7CAB6D03F6089F98A9C6D0--

