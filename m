From: "James Yonan" <jim@...41...>
Message-ID: <twig.1064914485.1447@...41...>
Subject: [Openvpn-devel] OpenVPN 1.5-beta8 released
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Sep 30 02:36:02 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

OpenVPN 1.5-beta8 is now available, and has some significant new features.

* The major addition is "tun" device support for Windows, making OpenVPN on
Windows now capable of connecting with OpenVPN running on any other platform.

* A set of --route options have been added to ease route management for routes
which are tied to VPN tunnels.

* The --ifconfig option has been extended to work with both tun or tap
interfaces, and now also works on Windows.

* Diagnostic capabilities have been improved with the new --mtu-test option
and a better options consistency check that now works in all crypto
configurations.

* Due to the problem of "PMTU Black holes" or routers which interfere with
Path MTU discovery or packet fragmentation, two workarounds are presented:
--fragment and --mssfix.  --fragment fragments packets internally, and
--mssfix implements the "CLAMP MSS" capability which is found in some
firewalls to set an upper bound on TCP segment size.

* The Windows driver has been upgraded to be SMP safe.

Still to do:  I don't have access to a NetBSD or Mac OS X box, so I did not
have a chance to code and test the --route command semantics for those platforms.

James



