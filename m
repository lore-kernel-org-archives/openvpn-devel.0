From: "James Yonan" <jim@...41...>
Message-ID: <twig.1084170443.63814@...41...>
Subject: [Openvpn-devel] OpenVPN 2.0-beta1 released
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun May  9 23:27:16 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

This is part of a version number shuffle.  1.6-rc4 has now been promoted from
beta to stable (1.6.0), and 2.0-test29 has been promoted from alpha to beta
(2.0-beta1).

What that basically means is that 2.0 is starting to be ready for more
widespread usage.  And remember that even if you're not interested in the new
point-to-multipoint features of 2.0, in many respects, 2.0 is also a better 1.x.

2004.05.09 -- Version 2.0-beta1

* Unchanged from test29 except for version number
  upgrade.

2004.05.08 -- Version 2.0-test29

* Modified --dev-node on Windows to accept a TAP-Win32
  GUID name.  In addition, --show-adapters will now
  display the high-level name and GUID of each adapter.
  This is an attempt to work around an issue in Windows
  where sometimes the TAP-Win32 adapter installs correctly
  but has no icon in the network connections control
  panel.  In such cases, being able to specify
  --dev-node {TAP-GUID} can work around the missing icon.

2004.05.07 -- Version 2.0-test28

* Fixed bug which could cause segfault on program
  shutdown if --route and --persist-tun are used
  together.

2004.05.06 -- Version 2.0-test27

* Fixed bug in close_instance() which might cause
  memory to be accessed after it had already been freed.
* Fixed bug in verify_callback() that might have
  caused uninitialized data to be referenced.
* --iroute now allows full CIDR subnet routing.
* In "--mode server --dev tun" usage, source addresses
  on VPN packets coming from a particular client must
  be associated with that client in the OpenVPN internal
  routing table.
	
2004.04.28 -- Version 2.0-test26

* Optimized broadcast path in multi-client mode.
* Added socket buffer size options --rcvbuf & --sndbuf.
* Configure Linux tun/tap driver to use a more sensible
  txqueuelen default.  Also allow explicit setting
  via --txqueuelen option (Harald Roelle).
* The --remote option now allows the port number
  to be specified as the second parameter.  If
  unspecified, the port number defaults to the
  --rport value.
* Multiple --remote options on the client can now be
  specified for load balancing and failover.  The
  --remote-random flag can be used to initially randomize
  the --remote list for basic load balancing.
* If a remote DNS name resolves to multiple DNS addresses,
  one will be chosen by random as a kind of basic
  load-balancing feature if --remote-random is used.
* Added --connect-freq option to control maximum
  new connection frequency in multi-client mode.
* In multi-client mode, all syslog messages associated
  with a specific client now include a client-ID prefix.
* For Windows, use a gettimeofday() function based
  on QueryPerformanceCounter (Derek Burdick).
* Fixed bug in interaction between --key-method 2
  and DES ciphers, where dynamic keys would be generated
  with bad parity and then be rejected.

2004.04.17 -- Version 2.0-test24

* Reworked multi-client broadcast handling.

2004.04.13 -- Version 2.0-test23
	
* Fixed bug in --dev tun --client-to-client routing.
* Fixed a potential deadlock in --pull.
* Fixed a problem with select() usage which could
  cause a repeating sequence of "select : Invalid
  argument (code=22)"

2004.04.11 -- Version 2.0-test22

* Fixed bug where --mode server + --daemon was
  prematurely closing syslog connection.
* Added support for --redirect-gateway on Mac OS X
  (Jeremy Apple).
* Minor changes to TAP-Win32 driver based on feedback
  from the NDISTest tool.
	
2004.04.11 -- Version 2.0-test21

* Optimizations in multi-client server event loop.

2004.04.10 -- Version 2.0-test20

* --mode server capability now works with either tun
  or tap interfaces.  When used with tap interfaces,
  OpenVPN will internally bridge all client tap
  interfaces with the server tap interface.
* Connecting clients can now have a client-specific
  configuration on the server, based on the client
  common name embedded in the client certificate.
  See --client-config-dir and --client-connect.
  These options can be used to configure client-specific
  routes.
* Added an option --client-to-client that enables
  internal client-to-client routing or bridging.
  Otherwise, clients will only "see" the server,
  not other connected clients.
* Fixed bug in route scheduling which would have caused
  --mode server to not work on Windows in test18
  and test19 with the sample config file.
* Man page is up to date with all new options.
* OpenVPN 2.0 release notes on web site updated
  with tap-style tunnel examples.

2004.04.02 -- Version 2.0-test19

* Fixed bug where routes pushed from server were
  not working correctly on Windows clients.
* Added Mac OS X route patch (Jeremy Apple).

2004.03.30 -- Version 2.0-test18

* Minor fixes + Windows self-install modified
  to use OpenSSL 0.9.7d.

2004.03.29 -- Version 2.0-test17

* Fixed some bugs related to instance timeout and deletion.
* Extended --push/--pull option to support additional
  option classes.

2004.03.28 -- Version 2.0-test16

* Successful test of --mode udp-server, --push,
  --pull, and --ifconfig-pool with server on
  Linux 2.4 and clients on Linux and Windows.

2004.03.25 -- Version 2.0-test15
	
* Implemented hash-table lookup of client instances
  based either on remote UDP address/port or remote
  ifconfig endpoint.
* Implemented a randomized binary tree based
  scheduler for scalably scheduling a large number
  of client instance events.  Uses the treap
  data structure and node rotation algorithm
  to keep the tree balanced.
* Initial implementation of ifconfig-pool.

2004.03.20 -- Version 2.0-test14

* Implemented --push and --pull.

2004.03.20 -- Version 2.0-test13

* Reduced struct tls_multi and --single-session
  memory footprint.
* Modified --single-session flag to be used
  in multi-client UDP server client instances.

2004.03.19 -- Version 2.0-test12

* Added the key multi-client UDP server options,
  --mode, --push, --pull, and --ifconfig-pool.
* Revamped GC (garbage collection) code to not rely
  on any global data.
* Modifications to thread.[ch] to allow a more
  flexible thread model.

2004.03.16 -- Version 2.0-test11

* Moved all timer code to interval.h, added new file
  interval.c.
* Fixed missing include.

2004.03.16 -- Version 2.0-test10

* More TAP-Win32 fixes.
* Initial debugging and testing of multi.[ch].

2004.03.14 -- Version 2.0-test9

* Branch merge with 1.6-rc3
* More point-to-multipoint work in multi.[ch].
* Major TAP-Win32 driver restructuring to use
  NdisMRegisterDevice instead of
  IoCreateDevice/IoCreateSymbolicLink.
* Changed TAP-Win32 symbolic links to use \DosDevices\Global\
  pathname prefix.
* In the majority of cases, TAP-Win32 should now be
  able to install and uninstall on Win2K without requiring
  a reboot.
* TAP-Win32 MAC address can now be explicitly set in the
  adapter advanced properties page.

2004.03.04 -- Version 2.0-test8

* Branch merge with 1.6-rc2.

2004.03.03 -- Version 2.0-test7

* Branch merge with 1.6-rc1.2.

2004.03.02 -- Version 2.0-test6

* Branch merge with 1.6-rc1.

2004.03.02 -- Version 2.0-test5

* Move Socks5 UDP header append/remove to socks.c, and is
  called from forward.c.
* Moved verify statics from ssl.c into struct tls_session.
* Wrote multi.[ch] to handle top level of point-to-multipoint
  mode.
* Wrote some code to allow a struct link_socket in a child context
  to be slaved to the parent context.
* Broke up packet read and process functions in forward.c
  (from socket or tuntap) into separate functions for read
  and process, so that point-to-point and point-to-multipoint can
  share the same code.
* Expand TLS control channel to allow the passing of configuration
  commands.
* Wrote mroute.[ch] to handle internal packet routing for
  point-to-multipoint mode.

2004.02.22 -- Version 2.0-test3

* Initial work on UDP multi-client server.
* Branch merge of 1.6-beta7
	
2004.02.14 -- Version 2.0-test2

* Refactorization of openvpn.c into openvpn.[ch]
  init.[ch] forward.[ch] forward-inline.h
  occ.[ch] occ-inline.h  ping.[ch] ping-inline.h
  sig.[ch].  Created a master per-tunnel
  struct context in openvpn.h.
* Branch merge of 1.6-beta6.2

2003.11.06 -- Version 2.0-test1

* Initial testbed for 2.0.





