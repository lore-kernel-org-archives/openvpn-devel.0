Message-ID: <00c001c228a5$d3218760$1000000a@...4...>
From: "James Yonan" <jim@...3...>
MIME-Version: 1.0
Subject: [Openvpn-devel] 1.3.1 released due to oops
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Wed Jul 10 23:39:03 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

1.3.0 had a small bug in openvpn.spec and openvpn.init that caused an RPM
upgrade failure.

This bug is fixed in 1.3.1.

1.3.1 Release Notes:

If you are trying to upgrade OpenVPN via an RPM package, there is a bug in
the RPM uninstall script from 1.2.1 that doesn't handle RPM upgrades
properly. The fix is to uninstall and reinstall using rpm -e and rpm -i.
Once the 1.3.1 RPM is installed, then future RPM upgrades will work
correctly, including the automatic restart logic that will shut down open
tunnels and reopen them with the new version (using the openvpn.init
script).

James




