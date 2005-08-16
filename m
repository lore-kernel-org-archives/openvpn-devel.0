From: James Yonan <jim@...41...>
Message-ID: <Pine.LNX.4.58.0508161354420.10152@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.0.1 released -- note security fixes
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
Date: Tue Aug 16 13:22:52 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

This release fixes a number of bugs in OpenVPN 2.0, including several bugs 
in the server which might be used to mount a DoS attack.

Download:

http://openvpn.net/download.html

Change Log since 2.0:

2005.08.16 -- Version 2.0.1

* Security Fix -- DoS attack against server when run with "verb 0" and
  without "tls-auth".  If a client connection to the server fails
  certificate verification, the OpenSSL error queue is not properly
  flushed, which can result in another unrelated client instance on the
  server seeing the error and responding to it, resulting in disconnection
  of the unrelated client (CAN-2005-2531).
* Security Fix -- DoS attack against server by authenticated client.
  This bug presents a potential DoS attack vector against the server
  which can only be initiated by a connected and authenticated client.
  If the client sends a packet which fails to decrypt on the server,
  the OpenSSL error queue is not properly flushed, which can result in
  another unrelated client instance on the server seeing the error and
  responding to it, resulting in disconnection of the unrelated client
  (CAN-2005-2532).
* Security Fix -- DoS attack against server by authenticated client.
  A malicious client in "dev tap" ethernet bridging mode could
  theoretically flood the server with packets appearing to come from
  hundreds of thousands of different MAC addresses, causing the OpenVPN
  process to deplete system virtual memory as it expands its internal
  routing table.  A --max-routes-per-client directive has been added
  (default=256) to limit the maximum number of routes in OpenVPN's
  internal routing table which can be associated with a given client
  (CAN-2005-2533).
* Security Fix -- DoS attack against server by authenticated client.
  If two or more client machines try to connect to the server at the
  same time via TCP, using the same client certificate, and when
  --duplicate-cn is not enabled on the server, a race condition can
  crash the server with "Assertion failed at mtcp.c:411"
  (CAN-2005-2534).
* Fixed server bug where under certain circumstances, the client instance
  object deletion function would try to delete iroutes which had never been
  added in the first place, triggering "Assertion failed at mroute.c:349".
* Added --auth-retry option to prevent auth errors from being fatal
  on the client side, and to permit username/password requeries in case
  of error.  Also controllable via new "auth-retry" management interface
  command.  See man page for more info.
* Added easy-rsa 2.0 scripts to the tarball in easy-rsa/2.0
* Fixed bug in openvpn.spec where rpmbuild --define 'without_pam 1'
  would fail to build.
* Implement "make check" to perform loopback tests (Matthias Andree).

2005.07.21 -- Version 2.0.1-rc7

* Support LZO 2.01 which renamed its library to lzo2 (Matthias Andree).
* Include linux/types.h before checking for linux/errqueue.h (Matthias
  Andree).

2005.07.15 -- Version 2.0.1-rc6

* Commented out "user nobody" and "group nobody" in sample
  client/server config files.
* Allow '@' character to be used in --client-config-dir
  file names.

2005.07.04 -- Version 2.0.1-rc5

* Windows version will log a for-further-info URL when
  initialization sequence is completed with errors.
* Added DLOPEN_PAM parameter to plugin/auth-pam/Makefile
  to control whether auth-pam plugin links to PAM via
  dlopen or -lpam.  By default, DLOPEN_PAM=1 so pre-existing
  behavior should be preserved.  DLOPEN_PAM=0 is the preferred
  setting to link via -lpam, but DLOPEN_PAM=1 works around
  a bug in SuSE 9.1 (and possibly other distros as well)
  where the PAM modules are not linked with -lpam.  See
  thread on openvpn-devel for more discussion about this
  patch (Simon Perreault).

2005.06.15 -- Version 2.0.1-rc4

* Support LZO 2.00, including changes to configure script to
  autodetect LZO version.

2005.06.12 -- Version 2.0.1-rc3

* Fixed a bug which caused standard file handles to not be closed
  after daemonization when --plugin and --daemon are used together,
  and if the plugin initialization function forks (as does auth-pam
  and down-root) (Simon Perreault).
* Added client-side up/down scripts in contrib/pull-resolv-conf
  for accepting server-pushed "dhcp-option DOMAIN" and "dhcp-option DNS"
  on Linux/Unix systems (Jesse Adelman).
* Fixed bug where if client-connect scripts/plugins were cascaded,
  and one (but not all) of them returned an error status, there might
  be cases where for an individual script/plugin, client-connect was
  called but not client-disconnect.  The goal of this fix is to
  ensure that if client-connect is called on a given client instance,
  then client-disconnect will definitely be called.  A potential
  complication of this fix is that when client-connect functions are
  cascaded, it's possible that the client-disconnect function would
  be called in cases where the related client-connect function returned
  an error status.  This fix should not alter OpenVPN behavior when
  scripts/plugins are not cascaded.
* Changed the hard-to-reproduce "Assertion failed at fragment.c:312"
  fatal error to a warning: "FRAG: outgoing buffer is not empty".
  Need more info on how to reproduce this one.
* When --duplicate-cn is used, the --ifconfig-pool allocation
  algorithm will now allocate the first available IP address.
* When --daemon and --management-hold are used together,
  OpenVPN will daemonize before it enters the management hold state.

2005.05.16 -- Version 2.0.1-rc2

* Modified vendor test in openvpn.spec file to match against
  "Mandrakesoft" in addition to "MandrakeSoft".
* Using --iroute in a --client-config-dir file while in --dev tap
  mode is not currently supported and will produce a warning
  message. Fixed bug where in certain cases, in addition to
  generating a warning message, this combination of options
  would also produce a fatal assertion in mroute.c.
* Pass --auth-user-pass username to server-side plugin without
  performing any string remapping (plugins, unlike scripts,
  don't get any security benefit from string remapping).
  This is intended to fix an issue with openvpn-auth-pam/pam_winbind
  where backslash characters in a username ('\') were being remapped
  to underscore ('_').
* Updated OpenSSL DLLs in Windows build to 0.9.7g.
* Documented --explicit-exit-notify in man page.
* --explicit-exit-notify seconds parameter defaults to 1 if
  unspecified.

2005.04.30 -- Version 2.0.1-rc1

* Fixed bug where certain kinds of fatal errors after
  initialization (such as port in use) would leave plugin
  processes (such as openvpn-auth-pam) still running.
* Added optional openvpn_plugin_abort_v1 plugin function for
  closing initialized plugin objects in the event of a fatal
  error by main OpenVPN process.
* When the --remote list is > 1, and --resolv-retry is not
  specified (meaning that it defaults to "infinite"), apply the
  infinite timeout to the --remote list as a whole, but try each
  list item only once before moving on to the next item.
* Added new --syslog directive which redirects output
  to syslog without requiring the use of the --daemon or --inetd
  directives.
* Added openvpn.spec option to allow RPM to be built with support
  for passwords read from a file:
  rpmbuild -tb [openvpn.x.tar.gz] --define 'with_password_save 1'

James

