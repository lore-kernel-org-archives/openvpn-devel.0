From: "James Yonan" <jim@...41...>
Message-ID: <twig.1078266159.60914@...41...>
Subject: [Openvpn-devel] OpenVPN 1.6-rc1 released
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
Date: Tue Mar  2 14:28:30 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

This is a release candidate for 1.6.0.

The main change from 1.6-beta7 is that the Windows version now uses --ip-win32
dynamic by default.

Change Log:

2004.03.02 -- Version 1.6-rc1

* For Windows, make "--ip-win32 dynamic" the default.
* For Windows, make "--route-delay 10" the default
  unless --ip-win32 dynamic is not used or --route-delay
  is explicitly specified.
* L_TLS mutex could have been left in a locked state
  for certain kinds of TLS errors.


James


