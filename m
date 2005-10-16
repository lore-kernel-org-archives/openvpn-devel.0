From: James Yonan <jim@...41...>
Message-ID: <Pine.LNX.4.58.0510160652370.31752@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.1-beta3 released
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
Date: Sun Oct 16 05:59:12 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

Download:

http://openvpn.net/beta/

Change Log since branch from 2.0.2:

2005.10.16 -- Version 2.1-beta3

* Added PKCS#11 support (Alon Bar-Lev).
* Enable the use of --ca together with --pkcs12.  If --ca is
  used at the same time as --pkcs12, the CA certificate is loaded
  from the file specified by --ca regardless if the pkcs12 file
  contains a CA cert or not (Mathias Sundman).
* Merged --capath patch (Thomas Noel).
* Merged --multihome patch.
* Added --bind option for TCP client connections (Ewan Bhamrah Harley).
* NOTE TO PACKAGE MAINTAINERS: Moved "plugin" directory to "plugins".
  This is to work around a strange problem with the "make dist"
  target in the automake-generated makefile, where the target tries to
  do a rather bogus "gcc -g -O2 -I. plugin.c -o plugin".

2005.10.13 -- Version 2.1-beta2

* Made --sndbuf and --rcvbuf pushable.

2005.10.01 -- Version 2.1-beta1

* Made LZO setting pushable.
* Renamed sample-keys/tmp-ca.crt to ca.crt.
* Fixed bug where remove_iroutes_from_push_route_list
  was missing routes if those routes had
  an implied netmask (by omission) of 255.255.255.255. 
* Merged with 2.0.3-rc1
* easy-rsa/2.0 moved to easy-rsa
* old easy-rsa moved to easy-rsa/1.0

2005.09.23 -- Version 2.0.2-TO4

* Added feature to TAP-Win32 adapter to allow it to be
  opened from non-administrator mode.  This feature
  is enabled by default, and can be enabled/disabled
  in the adapter advanced properties dialog.
* Added --allow-nonadmin standalone option for Windows to
  set TAP adapter to allow non-admin access.  This
  is a user-mode version of the code, and duplicates
  the same feature as the above entry.
* Added fix that attempts to solve corner case of tunnel not
  forwarding packets when system clock is reset to an earlier time.
* Added --redirect-gateway bypass-dns option.  (Developers:
  To add bypass-dhcp or bypass-dns support to other OSes,
  add a get_bypass_addresses function to route.c for
  your OS.)
* Added OPENVPN_PLUGIN_CLIENT_CONNECT_V2 plugin callback, which
  allows a client-connect plugin to return configuration text
  in memory, rather than via a file.
* Fixed a bug where --mode server --proto tcp-server --cipher none
  operation could cause tunnel packet truncation.
* openvpn --version will show [LZO1] or [LZO2], depending on
  version that was linked.

2005.09.07 -- Version 2.0.2-TO1

* Added --topology directive.  See man page.
* Added --redirect-gateway bypass-dhcp option to add a route
  allowing DHCP packets to bypass the tunnel, when the
  DHCP server is non-local.  Currently only implemented
  on Windows clients.
* Modified OpenVPN Service on Windows to declare the DHCP
  client service as a dependency.
* Extended the plugin interface to allow plugins to declare
  per-client constructor and destructor functions, to make
  it simpler for plugins to maintain per-client state.

James


