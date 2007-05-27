Message-ID: <46598425.40701@...95...>
Date: Sun, 27 May 2007 15:14:13 +0200
From: Christophe <christophe27@...95...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN-GUI and Tap-Win32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I am using OpenVPN-GUI AND tap-win32 ethernet adaptator on WinXP.
The config is  right, and the system is running. (can ping, ftp...
throught the tunnel)


Only when I stop windows and restart, OpenVPN-GUI doesn't find the
adaptator anymore. There is no mismatch in names btw the adaptator and
the config file.
I then need to stop  OpenVPN-gui, de-install the TAP-Win32 driver,
re-install the TAP-Win32 driver, give it a other and different name form
before, then modify the config file accordingly, and then restart
OpenVPN-gui.
Then it works.

I guess it may have something to do with the registry ?

But I can't find any solution.

Could you give me hint ?

thanks

chris

