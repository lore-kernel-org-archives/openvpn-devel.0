From: "James Yonan" <jim@...41...>
Message-ID: <twig.1081582648.9602@...41...>
Subject: [Openvpn-devel] OpenVPN 2.0-test20 released
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
Date: Sat Apr 10 00:38:02 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

This latest 2.0 beta has some cool new features including tap interface
support and customization of configuration based on the client certificate
common name.

The man page on the web site now shows all new 2.0 options, and the release
notes on the web site shows sample config files for tap-style tunnels.

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

James


