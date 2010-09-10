Message-ID: <4C89DE5A.7090002@...515...>
Date: Fri, 10 Sep 2010 10:29:30 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.2-beta3 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

The OpenVPN community project team is proud to release OpenVPN
2.2-beta3. It can be downloaded from here:

<http://openvpn.net/index.php/open-source/downloads.html>

This release contains a number of important new features:
=20
 - Added IPv6 support to Windows TAP driver
 - auth-pam plugin update: Support DOMAIN+USERNAME in config
 - Added support for passing over SSL certificate fingerprint/digest to
plugins
 - Improved the logic which gives a filename to the script hooks for
exchanging data between OpenVPN and the script. OpenVPN will now create
the file and not just return a supposed to be unique filename.
 - Added an improved example script for doing OCSP checks
 - Enhanced client-up and client-down example scripts
 - Added support for --x509-username-field, defaults to CN but can be
set to use other X509 certificate elments as username instead.
 - Allow --lport 0, to allow random port binding
 - Implemented http-proxy-override and http-proxy-fallback directives
 - Implemented multi-address DNS expansion on the network field of route
commands.
 - Added --register-dns option for Windows.
 - Handle non standard subnets in PF grammar
=20
In addition there are a large number of new features and bugfixes (see
below).
=20
If you find a bug in this release, please file a bug report to our Trac
bug tracker (https://community.openvpn.net). In uncertain cases please
contact our developers first, either using the openvpn-devel mailinglist
(https://lists.sourceforge.net/mailman/listinfo/openvpn-devel) or the
developer IRC channel (#openvpn-devel@...1334...).
=20
---
=20
Full list of features and bug fixes included in this release:
=20
-
Alberto Gonzalez Iniesta (1):
      Debian patch: Fix spelling in log message

Chantra (3):
      Fixes openssl-1.0.0 compilation warning
      Handle non standard subnets in PF grammar
      Fix errors in openvpn-plugin.h documentation
=20
Dan Nelson (1):
      bash->bourne script cleanup
=20
Daniel Johnson (1):
      auth-pam plugin update: Support DOMAIN+USERNAME in config=20=20
=20
David Sommerseth (24):
      Test framework improvement - Do not FAIL if t_client.rc is missing
      More t_client.sh updates - exit with SKIP when we want to skip
      Reworked the eurephia patch for inclusion to the openvpn-testing tree
      Added mapping files from SVN commit ID to more descriptive commit
IDs.
      verb 5 logging wrongly reports received bytes
      On TARGET_LINUX define _GNU_SOURCE if not defined
      Fix autotools cross-compiling support
      Add comile time information/settings from ./configure to --version
      Make use of counter_type instead of int when counting bytes and
network packets
      Updated the man page to reflect the behavioural change of
create_temp_file()
      Removed no longer needed delete_file() call
      Fixed potential NULL pointer issue
      Fix dependency checking for configure.h (v2)
      Make use of automake CLEANFILES variable instead of clean-local rule
      Don't add compile time information if --enable-small is used
      Harden create_temp_filename() (version 2)
      Renamed all calls to create_temp_filename()
      Updated the man page to reflect the behavioural change of
create_temp_file()
      Removed no longer needed delete_file() call
      Avoid repetition of "this config may cache passwords in memory" (v2)
      Revamped the script-security warning logging (version 2)
      Fixed client hang when server don't PUSH (aka the NO_SOUP_FOR_YOU
patch)
      Solved hidden merge conflict between changes in feat_misc and
bugfix2.1
      Fix multiple configured scripts conflicts issue (version 2)
=20
Davide Brini (6):
      OCSP_check.sh: new check logic
      The man page does not mention that the default value of "mssfix"
is 1450.
      Enhance contrib/pull-resolv-conf/client.{up,down} scripts
      Fix missing /bin/bash -> /bin/sh
      Fix certificate serial number export
      Exclude ping and control packets from activity
=20
Emilien Mantel (2):
      Choose a different field in X509 to be username
      Fixed static defined length check to use sizeof()
=20
Enrico Scholz (1):
      Allow 'lport 0' setup for random port binding
=20
Fabian Knittel (1):
      ssl.c: fix use of openvpn_run_script()'s return value
=20
Gert Doering (7):
      Fix compile problems on NetBSD and OpenBSD
      Fix <net/if.h> compile time problems on OpenBSD for good
      Full "VPN client connect" test framework for OpenVPN
      Build t_client.sh by configure at run-time.
      Remove duplicate code in FREEBSD+DRAGONFLY system-dependent ifconfig
      Implement IPv6 in TUN mode for Windows TAP driver.
      Fix date format mistake in PRODUCT_TAP_RELDATE (Peter Stuge)
=20
James Yonan (33):
      Fixed potential local privilege escalation vulnerability in
Windows service. Reported by Scott Laurie, MWR InfoSecurity.
      Added Python-based based alternative build system for Windows
using Visual Studio 2008 (in win directory).
      Fixed compiler warning in ssl.c when compiling with --enable-strict
      Attempt to fix issue where domake-win build system was not
properly signing drivers and .exe files.
      Added win/tap_span.py for building multiple versions of the TAP
driver and tapinstall binaries using different DDK versions to span from
Win2K to Win7 and beyond.
      When aborting in a non-graceful way, try to execute do_close_tun
in init.c prior to daemon exit
      Fixed an issue where AUTH_FAILED was not being properly
delivered     to the client when a bad password is given for mid-session
reauth.
      Don't advance the connection list on AUTH_FAILED errors.
      Fixed an issue in the Management Interface that could cause a
process hang=20
      Fixed an issue where if reneg-sec was set to 0 on the client, so
that the server-side value would take precedence,=20
      Trivial fix to proxy.c -- #define proxy auth type as UP_TYPE_PROXY.
      Added stub directive "remote-ip-hint".
      Modified ">PASSWORD:Verification Failed" management interface
notification
      Set socket buffers (SO_SNDBUF and SO_RCVBUF) immediately after
socket is created
      Updated MSVC build scripts to Visual Studio 2008
      Management interface performance optimizations:
      Minor change to doclean script
      Added Python-based build system for Windows in win directory.
      Updated copyright date to 2010.
      Fixed issue on Windows with MSVC compiler, where TCP_NODELAY
support was not being compiled in.
      Proxy improvements
      Minor fixes to recent HTTP proxy changes
      Implemented http-proxy-override and http-proxy-fallback directives
      Implemented a key/value auth channel from client to server.
      Fixed issue where bad creds provided by the management interface
or HTTP Proxy Basic Authentication would go into an infinite retry-fail
loop
      Added support for MSVC debugging of openvpn.exe in settings.in
      Fixed bug in proxy fallback capability
      Implemented multi-address DNS expansion on the network field of
route commands.
      Added --register-dns option for Windows.
      Added win/build_exe.py script
      Fixed typo: missing comment close.
      Fixed an issue with transmissions on the TLS control channel
      Added "net stop dnscache" and "net start dnscache" in front of
existing --register-dns commands.
=20
Jan Brinkmann (1):
      The man page needs dash escaping in UTF-8 environments
=20
Karl O. Pinc (2):
      Change verify-cn so cn is no longer hardcoded in openvpn's config
file
      Several updates to openvpn.8 (man page updates)
=20
Mathieu GIANNECCHINI (1):
      enhance tls-verify possibility
=20
Wil Cooley (1):
      pkitool lacks expected option "--help"

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


