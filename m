From: "James Yonan" <jim@...41...>
Message-ID: <twig.1071822818.2548@...41...>
Subject: [Openvpn-devel] IMPORTANT: TAP-Win32 install/uninstall issue on Win2K
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
Date: Fri Dec 19 00:34:04 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

I've received two reports of registry corruption on Win2K when the TAP-Win32
driver is uninstalled and then reinstalled without an intervening reboot.  In
one of the cases, someone attempted to uninstall the driver using the driver
manager, then they attempted to reinstall without rebooting first.  They
reported that this caused the TCP/IP bindings to be corrupted, and rebooting
did not fix the problem.

This issue only exists on Win2K, not XP, and appears to be a Windows bug. 
Apparently when Windows uninstalls the TAP-Win32 driver on Win2K, the
uninstall is not finalized until reboot.  If you then try to reinstall before
rebooting, the network bindings can be corrupted.

This bug appears to be fixed on XP, as you can install, upgrade, and uninstall
the driver multiple times without needing to reboot.

The safest approach is to always reboot after an install, upgrade, or
uninstall of the TAP-Win32 driver.

James


