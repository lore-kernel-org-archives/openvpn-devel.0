Message-ID: <4C6869BA.3010309@...41...>
Date: Sun, 15 Aug 2010 16:27:06 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN version 2.1.2 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: OpenVpn-Users <openvpn-users@lists.sourceforge.net>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, openvpn-announce@lists.sourceforge.net

2010.08.09 -- Version 2.1.2

* Windows security issue:
   Fixed potential local privilege escalation vulnerability in
   Windows service. The Windows service did not properly quote the
   executable filename passed to CreateService.  A local attacker
   with write access to the root directory C:\ could create an
   executable that would be run with the same privilege level as
   the OpenVPN Windows service.  However, since non-Administrative
   users normally lack write permission on C:\, this vulnerability
   is generally not exploitable except on older versions of Windows
   (such as Win2K) where the default permissions on C:\ would allow
   any user to create files there.
   Credit:  Scott Laurie, MWR InfoSecurity

* Added Python-based based alternative build system for Windows using
   Visual Studio 2008 (in win directory).

* When aborting in a non-graceful way, try to execute do_close_tun in
   init.c prior to daemon exit to ensure that the tun/tap interface is
   closed and any added routes are deleted.

* Fixed an issue where AUTH_FAILED was not being properly delivered
   to the client when a bad password is given for mid-session reauth,
   causing the connection to fail without an error indication.

* Don't advance to the next connection profile on AUTH_FAILED errors.

* Fixed an issue in the Management Interface that could cause
   a process hang with 100% CPU utilization in --management-client
   mode if the management interface client disconnected at the
   point where credentials are queried.

* Fixed an issue where if reneg-sec was set to 0 on the client,
   so that the server-side value would take precedence,
   the auth_deferred_expire_window function would incorrectly
   return a window period of 0 seconds.  In this case, the
   correct window period should be the handshake window
   period.

* Modified ">PASSWORD:Verification Failed" management interface
   notification to include a client reason string:

     >PASSWORD:Verification Failed: 'AUTH_TYPE' ['REASON_STRING']

* Enable exponential backoff in reliability layer
   retransmits.

* Set socket buffers (SO_SNDBUF and SO_RCVBUF) immediately after
   socket is created rather than waiting until after connect/listen.

* Management interface performance optimizations:

   1. Added env-filter MI command to perform filtering on env vars
      passed through as a part of --management-client-auth

   2. man_write will now try to aggregate output into larger blocks
      (up to 1024 bytes) for more efficient i/o

* Fixed minor issue in Windows TAP driver DEBUG builds
   where non-null-terminated unicode strings were being
   printed incorrectly.

* Fixed issue on Windows with MSVC compiler, where TCP_NODELAY support
   was not being compiled in.

* Proxy improvements:

   Improved the ability of http-auth "auto" flag to dynamically detect
   the auth method required by the proxy.

   Added http-auth "auto-nct" flag to reject weak proxy auth methods.

   Added HTTP proxy digest authentication method.

   Removed extraneous openvpn_sleep calls from proxy.c.

* Implemented http-proxy-override and http-proxy-fallback directives to 
make it
   easier for OpenVPN client UIs to start a pre-existing client config 
file with
   proxy options, or to adaptively fall back to a proxy connection if a 
direct
   connection fails.

* Implemented a key/value auth channel from client to server.

* Fixed issue where bad creds provided by the management interface
   for HTTP Proxy Basic Authentication would go into an infinite
   retry-fail loop instead of requerying the management interface for
   new creds.

* Added support for MSVC debugging of openvpn.exe in settings.in:

   # Build debugging version of openvpn.exe
   !define PRODUCT_OPENVPN_DEBUG

* Implemented multi-address DNS expansion on the network field of route
   commands.

   When only a single IP address is desired from a multi-address DNS
   expansion, use the first address rather than a random selection.

* Added --register-dns option for Windows.

   Fixed some issues on Windows with --log, subprocess creation
   for command execution, and stdout/stderr redirection.

* Fixed an issue where application payload transmissions on the
   TLS control channel (such as AUTH_FAILED) that occur during
   or immediately after a TLS renegotiation might be dropped.

* Added warning about tls-remote option in man page.

